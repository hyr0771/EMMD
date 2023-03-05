## The Max-min Driving Force (MDF)

1. `model` in `c.The Max-min Driving Force (MDF)\MDF input` comes from `model` in `b.Model\Model output`

2. Execute the command to convert the EFM in array format to EFM in sbtab format

   ```matlab
   EFMs_to_sbtab(model);
   ```

3. Use the converted EFM in sbtab format as the input of [MDF](https://gitlab.com/equilibrator/equilibrator-pathway)

4. Execute the following  command to obtain the absolute concentration of metabolites  and the Gibbs free energy of the reaction in each EFM

   ```matlab
   [model.conc_matrix,model.delta_r_G_matrix] = get_MDF_conc_and_therm_matrix(model);
   ```
