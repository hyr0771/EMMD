## Calculate Enzyme Mass

1. `model` in `d.Calculate Enzyme Mass\Calculate Enzyme masss input` comes from `model` in `c.The Max-min Driving Force (MDF)\MDF output`

2. Execute the following command to calculate the enzyme mass of each EFM

   ```matlab
   model.enzyme_cost_vector = cal_enzyme_cost_vector(model);
   ```

   