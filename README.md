# zhou-et-al
Repository for the code used to generate figures for Zhou et al. and running the BEAN-FUSE pipeline.

`crispr-BEAN-FUSE` is a submodule that can be used to run the BEAN-FUSE pipeline. Please see the following links to learn more about the [BEAN](https://github.com/pinellolab/crispr-bean) and [FUSE](https://github.com/TYTYBU/FUSE-pipeline) pipeline respectively. 

Note that the code and data used to generate Figure 4 or S4 are not made available on this Github as these figures use confidential data from the UK Biobank. Controlled access, patient-level data from the UK Biobank may be requested at https://ams.ukbiobank.ac.uk/ams/. 

`Figure_Plots_Zhou_et_al` contains the data, scripts, and outputs relevant to rendering all of the figures in the paper, which are located in the directories `data`, `scripts`, and `output` respectively. 

`LDLR_alphagenome_analysis` contains the analysis scripts used to nominate candidate coding variants that mediate decreased LDL uptake through altering RNA splicing. `LDLR_coding_variant_splicing` was used to measure the effect of variants assayed in our screen on splicing usage at a given locus, and  `LDLR_splicing_ism_full` was used to measure the effect of making individual nucleotide mutations across the exonic region of human LDLR.

`ldlr_fl_analysis` contains scripts for analyzing LDLR-FL raw reporter data (.fastq files).  `reporter_information_reference.csv` is the input file for analysis, `editing_analysis_version1.py` is for analyzing shorter NGS reads, and `editing_analysis_version2.py` is for analyzing longer reads.  

**Description of figures:**  

**Figure 1.** Activity-normalized prime editing screening (ANPE) pipeline and benchmarking.  
**Figure 2.** LDLR137-219 screen functional scores reflect domain conservation and computational pathogenicity scores.  
**Figure 3.** Analysis of correlates of prime editing efficiency and functional scores from LDLR-FL screen.  
**Figure 4.** LDLR prime editing functional scores enhance clinical variant interpretation.  
**Figure 5.** LDLR class A repeat 5 harbors LDL uptake-increasing variants that functionally complement pathogenic variants.   
**Figure 6.** Strong LDLR GOF variants generate novel LDLR-APOB inter-atom contacts.  
**Figure 7.** Comparison of LDLR variant effect data from CRISPR screening and cDNA deep mutational scanning.  
  
**Figure S1.** LDLR prime editing library design.  
**Figure S2.** Benchmarking the ANPE pipeline with LDLR137-219.  
**Figure S3.** Assessing reproducibility, and concordance, and off-target effects of LDLR-FL data.  
**Figure S4.** Comparison of LDLR-FL FUSE data to UK BioBank LDL-C levels.    
**Figure S5.** In silico stability and affinity analysis of LDLR variants.   
**Figure S6.** LDLR-mCherry expression and LDL binding versus uptake tests.  
**Figure S7.** Variant effect characterization on LDLR splicing.  

## Installation

``` git clone https://github.com/pzhou1729/zhou-et-al.git ```

## Citation

Zhou, P., Velimirovic, M., Yu, T. et al. LDLR variant classification through activity-normalized prime editing screening. _bioRxiv_ (2025). [https://www.biorxiv.org/content/10.64898/2025.12.16.694467v1.abstract](https://www.biorxiv.org/content/10.64898/2025.12.16.694467v1)

## Contributing
Questions and PRs welcome — please open an issue.

