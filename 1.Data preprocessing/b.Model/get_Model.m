filename_data = '.\Model input\e_coli_core_EMMD_data.tsv';
filename_ref = '.\Model input\e_coli_core_EMMD_ref.tsv'

model = data_input(filename_data, filename_ref);
model.kinetics.type = 'D_CM';
clear filename_data filename_ref;

mnet = generate_EFMs();
model.all_efms = mnet.efms;
clear mnet;

model = extract_subEFMs(model, model.all_efms);