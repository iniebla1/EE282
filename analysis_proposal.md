# Project Analysis Proposal

## Spatial Positioning of CD8⁺ T Cells as a Biomarker of Narrowband UVB Response in Vitiligo

## Introduction

Vitiligo is an autoimmune disease in which CD8⁺ T cells destroy epidermal melanocytes. Narrowband UVB (nbUVB) phototherapy is the most widely used treatment, yet patients' response is variable, and clinicians have no tissue biomarker that predicts who will repigment. In my Topic Proposal I am interested in: whether baseline cellular composition predicts response, whether CD8⁺ T-cell positioning relative to the epidermis changes with treatment and tracks clinical response, and which genes are differentially expressed between responders and non-responders. I will use the R statistical analysis packages and bash scripting on the HPC cluster to run analyses of compositional, spatial, and transcriptional components of the data set. The dataset has already been generated, segmented, and annotated, so the remaining work is downstream statistical analyses.

## Dataset and Acquisition

The dataset comes from our ongoing prospective clinical study, in which patients with vitiligo received nbUVB for 24 weeks and were scored with the Vitiligo Area Scoring Index (VASI; Komen et al. 2015). Responders are defined as achieving ≥50% improvement in total VASI at week 24. Currently, seven patients are classified as responders and five as non-responders. Four-millimeter punch biopsies of lesional skin were collected at weeks 0, 12, and 24, together with matched nonlesional skin, and profiled on the 10x Genomics Xenium platform (Janesick et al. 2023). As described in the Topic Proposal, cells were re-segmented with Cellpose (Stringer et al. 2021), quality-filtered, integrated with Harmony (Korsunsky et al. 2019), clustered with the Leiden algorithm (Traag et al. 2019), and annotated by cell type. The analysis input is therefore a single annotated Seurat object (Hao et al. 2024). It contains, for every cell, its gene counts, its x–y centroid in microns, its cell-type label, and sample metadata (patient, week, lesional status, and response group).

## Proposed Analyses

### Question 1: Does baseline composition predict response?

For each biopsy, I will calculate the proportion of every annotated cell type, focusing on melanocytes, CD8⁺ T cells, regulatory T cells (Tregs), and tissue-resident memory T (TRM) cells. At baseline, I will compare responders and non-responders using propeller from the *speckle* package (Phipson et al. 2022). Propeller applies a logit transformation and moderated t-tests that are suited to small numbers of samples. I will also compare lesional and nonlesional skin within each patient as a control. To describe trends over time, I will fit linear mixed-effects models with *lme4* (Bates et al. 2015), modeling proportion as a function of week, response group, and their interaction, with a random intercept for each patient. The random intercept accounts for repeated biopsies from the same person.

### Question 2: Does CD8⁺ T-cell positioning track response?

I will define the dermal–epidermal junction (DEJ) by manually segmenting out the epidermis in Xenium Explorer. I will then calculate the distance from every T cell to the nearest point on the DEJ. From these distances I will compute the median distance and the fraction of CD8⁺ T cells located within the epidermis. I will test them with the same mixed model to ask whether CD8⁺ T cells move away from the epidermis in responders over time. Repeating the analysis for Tregs and TRM cells will show whether any retreat is specific to cytotoxic cells. To describe spatial relationships between cell types, I will use *spatstat* (Baddeley and Turner 2005) to look at neighborhood-enrichment scores, for example to test whether CD8⁺ T cells cluster near melanocytes.

### Question 3: Which genes distinguish responders?

For differential expression I will sum counts by cell type within each sample to create pseudobulk profiles and test them with DESeq2 (Love et al. 2014). Comparisons will include responders versus non-responders at baseline and changes over time within patients. Second, I will use C-SIDE from the *spacexr* package (Cable et al. 2022) to test whether gene expression within a given cell type changes with its spatial position. For example, I will ask whether CD8⁺ T cells near or inside the epidermis express more cytotoxic or IFN-γ–response genes, such as *GZMB* and *CXCL10*, than T cells deeper in the dermis. P-values will be corrected for multiple testing with the Benjamini–Hochberg procedure.

## Feasibility

I have already completed the preliminary analysis of the data, for example biopsy collection, Xenium profiling, segmentation, integration, and cell-type annotation. Additionally, every analysis uses an established R package (Seurat, speckle, lme4, RANN, spatstat, DESeq2, and spacexr), and these are installed in my HPC environment. I will utilize bash scripts to submit jobs for the large analyses. My timeline is about 1 week for cell compositional analyses, weeks 3–4 for spatial analyses, weeks 5–6 for differential expression, and the remaining time for visualizing and writing up the project.

## Conclusion

These analyses are designed to investigate whether the location and transcriptional state of CD8⁺ T cells within the skin can predict and track response to nbUVB. By combining cell-type proportions, distance-to-epidermis measurements, spatial-association statistics, and pseudobulk and spatially aware differential expression, the project addresses each of my three research questions. Because the samples were collected before and during treatment, the analyses can separate baseline features, which are candidate predictive biomarkers, from changes during therapy, which may reflect how nbUVB restores pigmentation. Since the data already exist and the tools are established and available on the HPC cluster, this plan can realistically be completed within the course.

## References

Baddeley A, Turner R. 2005. spatstat: an R package for analyzing spatial point patterns. *J Stat Softw* 12: 1–42.

Bates D, Mächler M, Bolker B, Walker S. 2015. Fitting linear mixed-effects models using lme4. *J Stat Softw* 67: 1–48.

Cable DM, Murray E, Shanmugam V, Zhang S, Zou LS, Diao M, Chen H, Macosko EZ, Irizarry RA, Chen F. 2022. Cell type-specific inference of differential expression in spatial transcriptomics. *Nat Methods* 19: 1076–1087.

Hao Y, Stuart T, Kowalski MH, Choudhary S, Hoffman P, Hartman A, Srivastava A, Molla G, Madad S, Fernandez-Granda C, Satija R. 2024. Dictionary learning for integrative, multimodal and scalable single-cell analysis. *Nat Biotechnol* 42: 293–304.

Janesick A, Shelansky R, Gottscho AD, Wagner F, Williams SR, Rouault M, Beliakoff G, Morrison CA, Oliveira MF, Sicherman JT, et al. 2023. High resolution mapping of the tumor microenvironment using integrated single-cell, spatial and in situ analysis. *Nat Commun* 14: 8353.

Komen L, da Graça V, Wolkerstorfer A, de Rie MA, Terwee CB, van der Veen JPW. 2015. Vitiligo Area Scoring Index and Vitiligo European Task Force assessment: reliable and responsive instruments to measure the degree of depigmentation in vitiligo. *Br J Dermatol* 172: 437–443.

Korsunsky I, Millard N, Fan J, Slowikowski K, Zhang F, Wei K, Baglaenko Y, Brenner M, Loh PR, Raychaudhuri S. 2019. Fast, sensitive and accurate integration of single-cell data with Harmony. *Nat Methods* 16: 1289–1296.

Love MI, Huber W, Anders S. 2014. Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. *Genome Biol* 15: 550.

Phipson B, Sim CB, Porrello ER, Hewitt AW, Powell J, Oshlack A. 2022. propeller: testing for differences in cell type proportions in single cell data. *Bioinformatics* 38: 4720–4726.

Ripley BD. 1977. Modelling spatial patterns. *J R Stat Soc Series B Stat Methodol* 39: 172–212.

Squair JW, Gautier M, Kathe C, Anderson MA, James ND, Hutson TH, Hudelle R, Qaiser T, Matson KJE, Barraud Q, et al. 2021. Confronting false discoveries in single-cell differential expression. *Nat Commun* 12: 5692.

Stringer C, Wang T, Michaelos M, Pachitariu M. 2021. Cellpose: a generalist algorithm for cellular segmentation. *Nat Methods* 18: 100–106.

Traag VA, Waltman L, van Eck NJ. 2019. From Louvain to Leiden: guaranteeing well-connected communities. *Sci Rep* 9: 5233.
