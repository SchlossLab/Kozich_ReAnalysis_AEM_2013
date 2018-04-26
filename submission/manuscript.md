---
title: "**NAME OF THIS STUDY**"
bibliography: references.bib
output:
  pdf_document:
    keep_tex: true
    includes:
      in_header: header.tex
csl: mbio.csl #Get themes at https://github.com/citation-style-language/styles
fontsize: 11pt
geometry: margin=1.0in
---






\vspace{35mm}

Running title: INSERT RUNNING TITLE HERE

\vspace{35mm}


Your Name Here^1, Joeseph P. Schmo^2, Sally J. Rivers^1, Patrick D. Schloss^1$\dagger$^

\vspace{40mm}

$\dagger$ To whom correspondence should be addressed: pschloss@umich.edu

1\. Department of Microbiology and Immunology, University of Michigan, Ann Arbor, MI 48109

2\. Other department contact information


\newpage
\linenumbers


## Abstract


\newpage

## Introduction


## Results and Discussion



**Scaling up.** The advantage of the dual-index approach is that a large number of samples
can be sequenced using a number of primers equal to only twice the square root of the
number of samples. To fully evaluate this approach, we resequenced the V4 region of 360
samples that were previously described by sequencing the distal end of the V35 region on
the 454 GS-FLX Titanium platform [@Schloss2012]. In that study, we observed a clear separation
between murine fecal samples obtained from 8 C57BL/6 mice at 0 to 9 (early) and 141 to 150
(late) days after weaning, and there was significantly less variation between the late
samples than the early samples. In addition to the mouse fecal samples, we allocated 2
pairs of indices to resequence our mock community. We generated 3.9 million pairs of
sequence reads from the 16S rRNA gene with an average coverage of 10,752.4 pairs of reads per
sample (95% of the samples had more than 2,788.9 pairs of sequences) using a new collection
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


## Conclusions


## Materials and Methods


\newpage

**FIG 4** Principal coordinate ordination of YC values [@Yue2001] relating the
community structures of the fecal microbiota from 12 mice collected on days
0 through 9 (Early) and days 141 through 150 (Late) after weaning.

![](../results/figures/pcoa_figure.png)

\newpage

## References
