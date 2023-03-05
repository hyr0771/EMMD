function model = data_input(filename_data, filename_ref)
    [model, ~, ~, ~, conc_min, conc_max] = load_model_and_data_sbtab(filename_data, filename_ref);
    model.conc_min = conc_min;
    model.conc_max = conc_max;
end