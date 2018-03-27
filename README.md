## Kozich Re-Analysis Project

**Scaling up.** The advantage of the dual-index approach is that a large number of samples
can be sequenced using a number of primers equal to only twice the square root of the
number of samples. To fully evaluate this approach, we resequenced the V4 region of 360
samples that were previously described by sequencing the distal end of the V35 region on
the 454 GS-FLX Titanium platform (18). In that study, we observed a clear separation
between murine fecal samples obtained from 8 C57BL/6 mice at 0 to 9 (early) and 141 to 150
(late) days after weaning, and there was significantly less variation between the late
samples than the early samples. In addition to the mouse fecal samples, we allocated 2
pairs of indices to resequence our mock community. We generated 4.3 million pairs of
sequence reads from the 16S rRNA gene with an average coverage of 9,913 pairs of reads per
sample (95% of the samples had more than 2,454 pairs of sequences) using a new collection
of 8-nt indices (see the supplemental material). Although individual samples were expected
to have various amplification efficiencies, analysis of the number of reads per index did
not suggest a systematic positive or negative amplification bias that could be attributed
to the indices. The combined error rate for the two mock communities was 0.07% before
preclustering and 0.01% after (n = 14,094 sequences). When we used UCHIME to remove
chimeras and rarefied to 5,000 sequences, there was an average of 30.4 OTUs (i.e., 10.4
spurious OTUs). Similar to our previous results, ordination of the mouse fecal samples
again showed the separation between the early and late periods and increased stabilization
with age (Fig. 4) (Mantel test coefficient, 0.81; P < 0.001). These results clearly
indicate that our approach can be scaled to multiplex large numbers of samples.




### Overview

	project
	|- README          # the top level description of content (this doc)
	|- CONTRIBUTING    # instructions for how to contribute to your project
	|- LICENSE         # the license for this project
	|
	|- submission/
	| |- study.Rmd    # executable Rmarkdown for this study, if applicable
	| |- study.md     # Markdown (GitHub) version of the *.Rmd file
	| |- study.tex    # TeX version of *.Rmd file
	| |- study.pdf    # PDF version of *.Rmd file
	| |- header.tex   # LaTeX header file to format pdf version of manuscript
	| |- references.bib # BibTeX formatted references
	| |- XXXX.csl     # csl file to format references for journal XXX
	|
	|- data           # raw and primary data, are not changed once created
	| |- references/  # reference files to be used in analysis
	| |- raw/         # raw data, will not be altered
	| |- mothur/      # mothur processed data
	| +- process/     # cleaned data, will not be altered once created;
	|                 # will be committed to repo
	|
	|- code/          # any programmatic code
	|
	|- results        # all output from workflows and analyses
	| |- tables/      # text version of tables to be rendered with kable in R
	| |- figures/     # graphs, likely designated for manuscript figures
	| +- pictures/    # diagrams, images, and other non-graph graphics
	|
	|- exploratory/   # exploratory data analysis for study
	| |- notebook/    # preliminary analyses
	| +- scratch/     # temporary files that can be safely deleted or lost
	|
	+- Makefile       # executable Makefile for this study, if applicable


### How to regenerate this repository

#### Dependencies and locations
* Gnu Make should be located in the user's PATH
* mothur (v1.XX.0) should be located in the user's PATH
* R (v. 3.X.X) should be located in the user's PATH
* R packages:
  * `knitr`
  * `rmarkdown`
* etc


#### Running analysis

```
git clone https://github.com/SchlossLab/LastName_BriefDescription_Journal_Year.git
make write.paper
```
