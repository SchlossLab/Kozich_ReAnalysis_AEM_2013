REFS = data/references
FIGS = results/figures
TABLES = results/tables
PROC = data/process
FINAL = submission/
MOTHUR = code/mothur/mothur

# utility function to print various variables. For example, running the
# following at the command line:
#
#	make print-BAM
#
# will generate:
#	BAM=data/raw_june/V1V3_0001.bam data/raw_june/V1V3_0002.bam ...
print-%:
	@echo '$*=$($*)'


# Obtained the Linux version of mothur (v1.39.5) from the mothur GitHub repository
$(MOTHUR) :
	wget --no-check-certificate https://github.com/mothur/mothur/releases/download/v1.39.5/Mothur.linux_64.zip
	unzip Mothur.linux_64.zip
	mv mothur code/
	rm Mothur.linux_64.zip
	rm -rf __MACOSX

################################################################################
#
# Part 1: Get the references
#
# We will need several reference files to complete the analyses including the
# SILVA reference alignment and RDP reference taxonomy.
#
################################################################################

# We want the latest greatest reference alignment and the SILVA reference
# alignment is the best reference alignment on the market. This version is from
# v123 and described at http://blog.mothur.org/2015/12/03/SILVA-v123-reference-files/
# We will use the SEED v. 123, which contain 12,083 bacterial sequences. This
# also contains the reference taxonomy. We will limit the databases to only
# include bacterial sequences.

$(REFS)/silva.seed.align : $(MOTHUR)
	wget -N http://mothur.org/w/images/1/15/Silva.seed_v123.tgz
	tar xvzf Silva.seed_v123.tgz silva.seed_v123.align silva.seed_v123.tax
	$(MOTHUR) "#get.lineage(fasta=silva.seed_v123.align, taxonomy=silva.seed_v123.tax, taxon=Bacteria);degap.seqs(fasta=silva.seed_v123.pick.align, processors=8)"
	mv silva.seed_v123.pick.align $(REFS)/silva.seed.align
	rm Silva.seed_v123.tgz silva.seed_v123.*

$(REFS)/silva.v4.align : $(REFS)/silva.seed.align $(MOTHUR)
	$(MOTHUR) "#pcr.seqs(fasta=$(REFS)/silva.seed.align, start=11894, end=25319, keepdots=F, processors=8)"
	mv $(REFS)/silva.seed.pcr.align $(REFS)/silva.v4.align

# Next, we want the RDP reference taxonomy. The current version is v10 and we
# use a "special" pds version of the database files, which are described at
# http://blog.mothur.org/2014/10/28/RDP-v10-reference-files/

$(REFS)/trainset14_032015.% :
	wget -N http://www.mothur.org/w/images/8/88/Trainset14_032015.pds.tgz
	tar xvzf Trainset14_032015.pds.tgz
	mv trainset14_032015.pds/* $(REFS)/
	rm -rf trainset14_032015.pds
	rm Trainset14_032015.pds.tgz

################################################################################
#
# Part 2: Run data through mothur
#
#	Process fastq data through the generation of files that will be used in the
# overall analysis.
#
################################################################################


# Obtained the raw `fastq.gz` files from https://www.mothur.org/MiSeqDevelopmentData.html
# * Downloaded https://www.mothur.org/MiSeqDevelopmentData/StabilityWMetaG.tar
# * Ran the following from the project's root directory

data/raw/StabilityWMetaG.tar :
	wget --no-check-certificate https://www.mothur.org/MiSeqDevelopmentData/StabilityWMetaG.tar
	tar xvf StabilityWMetaG.tar -C data/raw/
	mv StabilityWMetaG.tar data/raw/


# Change stability to the * part of your *.files file that lives in data/raw/
BASIC_STEM = data/mothur/stability.trim.contigs.good.unique.good.filter.unique.precluster


# here we go from the raw fastq files and the files file to generate a fasta,
# taxonomy, and count_table file that has had the chimeras removed as well as
# any non bacterial sequences.

# Edit code/get_good_seqs.batch to include the proper name of your *files file
$(BASIC_STEM).denovo.uchime.pick.pick.count_table $(BASIC_STEM).pick.pick.fasta $(BASIC_STEM).pick.pds.wang.pick.taxonomy : code/get_good_seqs.batch\
					data/references/silva.v4.align\
					data/references/trainset14_032015.pds.fasta\
					data/references/trainset14_032015.pds.tax\
					data/raw/StabilityWMetaG.tar\
					$(MOTHUR)
	$(MOTHUR) code/get_good_seqs.batch;\
	rm data/mothur/*.map



# here we go from the good sequences and generate a shared file and a
# cons.taxonomy file based on OTU data

# Edit code/get_shared_otus.batch to include the proper root name of your files file
# Edit code/get_shared_otus.batch to include the proper group names to remove

$(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.shared $(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.0.03.cons.taxonomy : code/get_shared_otus.batch\
					$(BASIC_STEM).denovo.uchime.pick.pick.count_table\
					$(BASIC_STEM).pick.pick.fasta\
					$(BASIC_STEM).pick.pds.wang.pick.taxonomy\
					$(MOTHUR)
	$(MOTHUR) code/get_shared_otus.batch
	rm $(BASIC_STEM).denovo.uchime.pick.pick.pick.count_table
	rm $(BASIC_STEM).pick.pick.pick.fasta
	rm $(BASIC_STEM).pick.pds.wang.pick.pick.taxonomy;


# now we want to get the sequencing error as seen in the mock community samples

# Edit code/get_error.batch to include the proper root name of your files file
# Edit code/get_error.batch to include the proper group names for your mocks

$(BASIC_STEM).pick.pick.pick.error.summary : code/get_error.batch\
					$(BASIC_STEM).denovo.uchime.pick.pick.count_table\
					$(BASIC_STEM).pick.pick.fasta\
					$(REFS)/HMP_MOCK.v4.fasta\
					$(MOTHUR)
	$(MOTHUR) code/get_error.batch





################################################################################
#
# Part 3: Figure and table generation
#
#	Run scripts to generate figures and tables
#
################################################################################


# Generate data to plot PCoA ordination
$(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.thetayc.0.03.lt.ave.pcoa.axes: $(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.shared $(MOTHUR)
	$(MOTHUR) code/get_pcoa_data.batch


# Construct PCoA png file
results/figures/pcoa_figure.png : code/plot_pcoa.R\
				$(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.thetayc.0.03.lt.ave.pcoa.axes
	R -e "source('code/plot_pcoa.R'); plot_pcoa('$(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.thetayc.0.03.lt.ave.pcoa.axes')"

################################################################################
#
# Part 4: Pull it all together
#
# Render the manuscript
#
################################################################################

$(FINAL)/manuscript.% : results/figures/pcoa_figure.png\
						$(BASIC_STEM).pick.pick.pick.opti_mcc.unique_list.shared\
						$(FINAL)/mbio.csl\
						$(FINAL)/references.bib\
						$(FINAL)/manuscript.Rmd
	R -e 'render("$(FINAL)/manuscript.Rmd", clean=FALSE)'
	mv $(FINAL)/manuscript.knit.md submission/manuscript.md
	rm $(FINAL)/manuscript.utf8.md

write.paper : results/figures/pcoa_figure.png\
				$(FINAL)/manuscript.Rmd $(FINAL)/manuscript.md\
				$(FINAL)/manuscript.tex $(FINAL)/manuscript.pdf
