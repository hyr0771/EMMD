## EMMD

1. `model` in `2.EMMD\EMMD input` comes from `model` in `1.Data preprocessing\d.Calculate Enzyme Mass\Calculate Enzyme masss output`

1. Run the following command to execute EMMD to decompose the flux distribution calculated by FBA at a fructose uptake rate of 2mmol/gCDW/h

   ```matlab
   load('.\EMMD input\flux_fru\FBAsolution_fru_2.mat');
   load('.\EMMD input\model.mat');
   load('.\EMMD input\e_coli_core.mat');
   EMMDsolution = EMMD(FBAsolution_fru_2.x / 12, model, e_coli_core);%Divide by 12 to convert flux unit mmol/gCDW/h to mM/s
   ```