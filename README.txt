# Dogslife Labrador Mortality

R code for survival analysis of early-life factors associated with all-cause mortality in UK Labrador Retrievers.

## Early-life factors associated with all-cause mortality in UK Labrador Retrievers

This repository contains R code for the statistical analysis of the Dogslife longitudinal cohort. 
The analysis investigates associations between characteristics measured during the first two years of 
life and subsequent all-cause mortality. The workflow includes data preparation, Cox proportional hazards
modelling with time-dependent covariates, survival curve generation, and results summarisation.
Three Quarto documents are provided with R code for the analysis, the anonymous dataset containing 2540 dogs, 
R functions included in the analysis, and a data dictionary describing the data in each column.


The code accompanies the paper:

Fielding H. et al. 2026. Early-life factors associated with all-cause mortality in UK Labrador Retrievers: analysis of the Dogslife longitudinal cohort. [Journal details to be added].


## Analysis Structure

The analysis pipeline includes:

*   Data loading and preprocessing (factor conversion, colour coding);
*   Multivariate Cox proportional hazards modelling;
*   Time-dependent covariate handling (e.g., BMI effects over time);
*   Inverse probability of censoring weighting (IPCW);
*   Survival curve generation (Kaplan-Meier and model-based);
*   Results cleaning and table preparation for publication.

## Requirements

The code is written in R and uses Quarto for dynamic document generation.

Main R packages used include:

*   tidyverse
*   survival
*   lme4
*   broom.mixed
*   ggsurvfit
*   kableExtra
*   performance

## Running the Code

To run the analysis, ensure the required data file (`coxph_death_publish.csv`) and helper functions (`functions.R`) are available in the expected location.

Execute the Quarto documents in the following order:

1.  01_fit_coxph_models.qmd

2.  02_generate_survival_curves.qmd

3.  03_prepare_figs_tables.qmd


## Key Analysis Outputs

The code generates:

*   Hazard ratios (HR) and 95% confidence intervals for early-life predictors;
*   Survival curves stratified by key variables (e.g., sex);
*   Tables summarising model coefficients and IPCW adjustments;
*   Estimates of population-level impact for modifiable risk factors.

## Citation

If you use this code, analysis workflow, or outputs in academic work, please cite the associated paper:

Fielding H. et al. Early-life factors associated with all-cause mortality in UK Labrador Retrievers: analysis of the Dogslife longitudinal cohort. *Plos One* [Year, DOI to be added].

Please also cite this repository:

Fielding H. [2026]. LabradorMortality. GitHub. [Repository URL or DOI to be added].

## Licence

This code is released under the GNU General Public License v3.0.

You are free to use, modify, and redistribute the code under the terms of the GPL-3.0 licence. Any redistributed modified versions must also be made available under the GPL-3.0, and copyright and licence notices must be retained.

Please note that GPL-3.0 does not prohibit commercial use. However, it does require that redistributed derivative software remains open under the same licence.

## Acknowledgement Request

If you use or adapt this code, please acknowledge the original authors and cite the associated paper and repository. This helps make the work discoverable and supports transparent reuse of scientific code.

Suggested acknowledgement:

This work used code from Fielding et al.'s Labrador Retriever mortality analysis, developed for the study Early-life factors associated with all-cause mortality in UK Labrador Retrievers: analysis of the Dogslife longitudinal cohort.

## Disclaimer

This code is provided for research and educational purposes. It represents a specific statistical workflow applied to the Dogslife cohort. Outputs depend on the parameter values, assumptions, and weighting strategies used. Users should review the model assumptions carefully before applying the code to new datasets or policy decisions. Observational associations do not establish causality.

## Data Availability

The anonymised analysis dataset (`coxph_death_publish.csv`) included in this repository is sufficient to reproduce the results. 

## Contact

For questions about the code or analysis, please contact:

Dr Helen Fielding helen.fielding@ed.ac.uk Veterinary Epidemiologist 
Professor Dylan Clements dylan.clements@ed.ac.uk

University of Edinburgh
