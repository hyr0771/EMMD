function [conc_matrix,delta_r_G_matrix] = get_MDF_conc_and_therm_matrix(model)
% The EFM matrix is converted to a tsv file through the EFMs_to_sbtab function,
% Use these tsv files as input to the MDF algorithm in python,
% Obtain the concentration matrix and Gibbs free energy matrix and save them as tsv files,
% This function is to parse the tsv file of the concentration and free energy matrix into a matlab matrix.

% input
% model: both the metabolic model and the EFM matrix contain only internal reactions

% output
% conc_matrix: Concentration matrix about EFM matrix, mx * K
% therm_matrix: Gibbs free energy matrix about the EFM matrix, rx * K

    % initialization
    [mx, ~] = size(full(model.N));
    [rx, K] = size(model.cut_all_efms);
    
    conc_data = cell(K,1);% Store the concentration data of each EFM
    met_data = cell(K,1);% Store the metabolite data of each EFM
    therm_data = zeros(rx, K);

    for k=1:K
        
        % Read the tsv file of the kth EFM output as the MDF algorithm, which contains the concentration and free energy matrix represented by the kth EFM
        filename_validation_data = '.\MDF output\mdf_results_' + string(k) + '.tsv';
        my_sbtab_validation = sbtab_document_load_from_one(filename_validation_data);
        
        % Get the concentration and free energy matrix of the kth EFM
        % Since the metabolite subscripts of the concentration data obtained from tsv are inconsistent with the model metabolic model subscripts, the concentration matrix data requires additional mapping
        conc_data{k,1} = my_sbtab_validation.tables.Predictedconcentrations.column.column.Value;% Auxiliary Concentration Matrix Mapping of Metabolite Subscripts
        met_data{k,1} = my_sbtab_validation.tables.Predictedconcentrations.column.column.Compound;
        
        therm_data(:,k) = str2double(my_sbtab_validation.tables.PredictedGibbsenergies.column.column.Value);
        
    end
    
    % Additional mappings for concentration matrix data
    conc = zeros(mx,K);
    for i=1:K
        length = size(met_data{i,1},1);
        for j =1:length
            index = find( strcmp( model.metabolites , met_data{i,1}{j,1}));% Find the subscript position of the metabolite in the tsv file in the model metabolism model
            conc(index, i) = str2double(conc_data{i,1}{j,1});% Assign the corresponding concentration data to the corresponding value
        end
    end
    
    conc_matrix = conc;
    delta_r_G_matrix = therm_data;
    
end