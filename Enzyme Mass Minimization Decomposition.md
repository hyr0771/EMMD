Enzyme Mass Minimization Decomposition 
------------------------

Enzyme mass minimization decomposition (EMMD) is a method for decomposing flux distributions to identify active elementary flux modes by incorporating thermodynamic and enzymatic constraints into stoichiometric metabolic network models. This repository contains MATLAB code for EMMD, implemented in Matlab 2018b.

## Matlab dependencies

For some of the MATLAB functions, the following MATLAB toolboxes must be installed
- Clone the following [GitHub](https://github.com/liebermeister) repositories
    - [`matlab-utils`](https://github.com/liebermeister/matlab-utils) - Utility functions

    - [`metabolic-network-toolbox`](https://github.com/liebermeister/metabolic-network-toolbox) - Metabolic Network Toolbox

    - [`sbtab-matlab`](https://github.com/liebermeister/sbtab-matlab) - SBtab toolbox

- [efmtool](http://www.csb.ethz.ch/tools/efmtool)

- [cobratoolbox](https://github.com/opencobra/cobratoolbox)

- [SBML toolbox](http://sbml.org/Software/SBMLToolbox) (optional - needed only if SBML files are used)

    Make sure all the directories and subdirectories are included in your Matlab path

## Step
1. **Data preprocessing**
   - **Parameter Balance** - By running the parameter balance tool Parameter Balancing, the obtained enzyme kinetic parameters are generated with a complete and consistent parameter set
   - **Model** - Read the parameter-balanced data, calculate the EFM of the model and convert the calculated EFM to the MDF input format
   - **The Max-min Driving Force (MDF)** - Calculate the absolute concentration of metabolites and the Gibbs free energy of reaction for each EFM using the MDF method
   - **Calculate Enzyme Mass** - According to the thermodynamic and enzymatic data calculated in a, b, c, calculate the enzyme mass of each EFM
2. **EMMD** - Decomposition of flux distribution calculated by FBA into EFM combinations

## Contact
If you have any questions or suggestions with the code, please let us know. Contact Yiran Huang at hyr@gxu.edu.cn
