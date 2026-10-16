**Spatial Positioning of CD8⁺ T Cells as a Biomarker of Narrowband UVB Response in Vitiligo**

Introduction 

Vitiligo is a chronic autoimmune disease affecting approximately 1–2% of the global population, in which autoreactive CD8⁺ T cells destroy epidermal melanocytes and produce depigmented patches of skin (Rodrigues et al. 2017). Although often regarded as cosmetic, vitiligo imposes a quality-of-life burden comparable to that of psoriasis (Ongenae et al. 2005; Picardo et al. 2022). Melanocyte oxidative stress releases danger signals such as HSP70 and HMGB1 (Mosenson et al. 2014; Cui et al. 2019), and the ensuing IFN-γ–CXCL9/CXCL10–CXCR3 axis recruits cytotoxic T cells into the epidermis (Frisoli et al. 2020; Liu et al. 2024). Once established, a subset of these cells persists as tissue-resident memory T cells that remain in the skin after clinical stabilization and can reinitiate disease, contributing to relapse after treatment is stopped (Richmond et al. 2019; Ryan et al. 2021). However, how melanocyte stress progresses to sustained autoimmune destruction remains poorly understood, because these interactions occur at the single-cell level and require spatial context to resolve. 

 
Vitiligo resolution requires both suppression of inflammation and regeneration of melanocytes, which must proliferate from hair follicles and then, migrate into the interfollicular epidermis, and differentiate (Goldstein et al. 2015; Birlea et al. 2017a,b). Narrowband UVB (nbUVB) addresses both requirements of suppressing inflammation and regeneration of melanocytes (Mohammad et al. 2017), yet responses vary widely in the amount of repgimention for patients. Although topical and oral JAK inhibitors have recently expanded treatment options (Rosmarin et al. 2022), nbUVB remains widely used because of its accessibility, safety, and low cost, making it critical to identify which patients are most likely to benefit. Lesions that responded to nbUVB plus tacrolimus shared a baseline 68-gene signature enriched for CXCL10, FCRL3, and T-cell receptor genes (Yang et al. 2021), but bulk profiling discards spatial context. Spatial transcriptomic platforms such as 10x Genomics Xenium overcome this limitation by measuring gene expression in individual cells while preserving each cell's precise location within intact tissue (Janesick et al. 2023). Because cytotoxic T cells must physically reach the epidermis to kill melanocytes, and because lesional T cells are sparse and fluctuate with disease activity (Ryan et al. 2021; Ouwerkerk et al. 2026), T cell location may be more informative than how many are present. We therefore propose using single-cell spatial transcriptomics to test whether the spatial organization and transcriptional state of CD8⁺ T cells relative to the epidermis predict and track response to nbUVB. 

Data

This project uses an existing dataset from a prospective study at the University of California, Irvine where we recruited Twenty patients with vitiligo and treated them with nbUVB for 24 weeks, and disease severity was scored with the Vitiligo Area Scoring Index (VASI), which measures  the amount of depigmentation and repigmentation (Komen et al. 2015).Responders were defined as achieving ≥50% improvement in total VASI (T-VASI) at week 24; and we so far have identified, seven responders and five were non-responders (study is still ongoing). Four-millimeter punch biopsies were collected from within the treated lesion at baseline, week 12, and week 24, together with  matched nonlesional skin. Biospy sections were profiled on the 10x Genomics Xenium platform, which localizes transcripts from a targeted gene panel at subcellular resolution (Janesick et al. 2023).  

Research Questions 

We aim to address three questions. First, does baseline cellular composition predict response? We will compare the proportions of melanocytes, CD8⁺ T cells, regulatory T cells, and tissue-resident memory T (TRM) cells in baseline lesional biopsies from responders and non-responders. Second, does CD8⁺ T-cell positioning relative to the epidermis change with treatment, and does this change track with clinical response? We hypothesize that improvement is accompanied by CD8⁺ T-cell retreat from the epidermis, and we will test whether this pattern is specific to cytotoxic cells or shared by regulatory and TRM populations. Third, is to identify differently expressed genes between responders and non-responders, with hopes to identify predictive biomarkers for patients that regimented with nbUVB phototherapy.  

Feasibility 

 This project is feasible because the data and initial processing has already been completed. All biopsies have been collected, profiled on the Xenium platform, and linked to clinical outcomes.  Samples have undergone standard spatial processing platforms by initially segmenting out cells using Cellpose (Stringer et al. 2021), filtered for quality, integrated across samples with Harmony (Korsunsky et al. 2019), and clustered with the Leiden algorithm (Traag et al. 2019) to produce an annotated annotations of each cell type.
 <img width="646" height="337" alt="Screenshot 2026-10-15 at 10 18 16 PM" src="https://github.com/user-attachments/assets/c6acc387-83dc-4245-b4ab-230587a36c85" />
Figure 1. Cell type annotations for 2370 patients   

Conclusion 

Effective vitiligo treatment requires both suppressing autoimmunity and regenerating melanocytes, yet clinicians currently lack tissue biomarkers that predict which patients will benefit from nbUVB phototherapy. As a result, patients often undergo months of weekly treatment before it becomes clear whether they will respond. Bulk transcriptomic studies have suggested immune endotypes associated with response, but by averaging signals across thousands of cells, they cannot reveal which cells express these genes or where in the skin effector cells act.This project addresses that gap by applying single-cell spatial transcriptomics to longitudinal collected biopsies from a prospectively treated cohort. By measuring cellular composition, the position of CD8⁺ T cells relative to the epidermis, and differentially expressed genes between responders and non-responders, we will test whether the spatial organization and transcriptional state of lesional cells. Because each patient was sampled before and during treatment, these analyses can distinguish features present at baseline, which could serve as predictive biomarkers, from those that change with therapy, which may reflect the mechanisms through which nbUVB restores pigmentation. 

Since biopsies have already been collected, and preliminary cell-type annotations have been validated downstream analysis is feasible in the given timeline of 6-8 weeks. Its findings could help clinicians identify likely responders before treatment begins, spare  non-responders from prolonged ineffective therapy, and guide the rational selection of combination approaches, such as pairing nbUVB with JAK inhibitors, for patients whose lesions show persistent epidermal T-cell activity. More broadly, this study will establish a spatial framework for studying how immune and pigment cells interact during regimentation in vitiligo. 

References 
Birlea SA, Costin GE, Roop DR, Norris DA. 2017a. Trends in regenerative medicine: repigmentation in vitiligo through melanocyte stem cell mobilization. Med Res Rev 37: 907–935. 

Birlea SA, Goldstein NB, Norris DA. 2017b. Repigmentation through melanocyte regeneration in vitiligo. Dermatol Clin 35: 205–218. 

Cui T, Zhang W, Li S, Chen X, Chang Y, Yi X, Kang P, Yang Y, Chen J, Liu L, et al. 2019. Oxidative stress-induced HMGB1 release from melanocytes: a paracrine mechanism underlying the cutaneous inflammation in vitiligo. J Invest Dermatol 139: 2174–2184.e4. 

Frisoli ML, Essien K, Harris JE. 2020. Vitiligo: mechanisms of pathogenesis and treatment. Annu Rev Immunol 38: 621–648. 

Goldstein NB, Koster MI, Hoaglin LG, Spoelstra NS, Kechris KJ, Robinson SE, Robinson WA, Roop DR, Norris DA, Birlea SA. 2015. Narrow band ultraviolet B treatment for human vitiligo is associated with proliferation, migration, and differentiation of melanocyte precursors. J Invest Dermatol 135: 2068–2076. 

Janesick A, Shelansky R, Gottscho AD, Wagner F, Williams SR, Rouault M, Beliakoff G, Morrison CA, Oliveira MF, Sicherman JT, et al. 2023. High resolution mapping of the tumor microenvironment using integrated single-cell, spatial and in situ analysis. Nat Commun 14: 8353. 

Komen L, da Graça V, Wolkerstorfer A, de Rie MA, Terwee CB, van der Veen JPW. 2015. Vitiligo Area Scoring Index and Vitiligo European Task Force assessment: reliable and responsive instruments to measure the degree of depigmentation in vitiligo. Br J Dermatol 172: 437–443. 

Korsunsky I, Millard N, Fan J, Slowikowski K, Zhang F, Wei K, Baglaenko Y, Brenner M, Loh PR, Raychaudhuri S. 2019. Fast, sensitive and accurate integration of single-cell data with Harmony. Nat Methods 16: 1289–1296. 

Liu H, Wang Y, Le Q, Tong J, Wang H. 2024. The IFN-γ-CXCL9/CXCL10-CXCR3 axis in vitiligo: pathological mechanism and treatment. Eur J Immunol 54: e2250281. 

Mohammad TF, Al-Jamal M, Hamzavi IH, Harris JE, Leone G, Cabrera R, Lim HW, Pandya AG, Esmat SM. 2017. The Vitiligo Working Group recommendations for narrowband ultraviolet B light phototherapy treatment of vitiligo. J Am Acad Dermatol 76: 879–888. 

Mosenson JA, Flood K, Klarquist J, Eby JM, Koshoffer A, Boissy RE, Overbeck A, Tung RC, Le Poole IC. 2014. Preferential secretion of inducible HSP70 by vitiligo melanocytes under stress. Pigment Cell Melanoma Res 27: 209–220. 

Ongenae K, Van Geel N, De Schepper S, Naeyaert JM. 2005. Effect of vitiligo on self-reported health-related quality of life. Br J Dermatol 152: 1165–1172. 

Ouwerkerk W, Narayan VS, Chielie S, van Uden NOP, Schneider MA, Hillenbrand R, Gaulis S, Kjellerup RB, Loesche C, Hanser M, et al. 2026. Immune and biological changes during treatment in patients with nonsegmental vitiligo and their relation to repigmentation. J Invest Dermatol 146: 699–710. 

Picardo M, Huggins RH, Jones H, Marino R, Ogunsola M, Seneschal J. 2022. The humanistic burden of vitiligo: a systematic literature review of quality-of-life outcomes. J Eur Acad Dermatol Venereol 36: 1507–1523. 

Richmond JM, Strassner JP, Rashighi M, Agarwal P, Garg M, Essien KI, Pell LS, Harris JE. 2019. Resident memory and recirculating memory T cells cooperate to maintain disease in a mouse model of vitiligo. J Invest Dermatol 139: 769–778. 

Ripley BD. 1977. Modelling spatial patterns. J R Stat Soc Series B Stat Methodol 39: 172–212. 





