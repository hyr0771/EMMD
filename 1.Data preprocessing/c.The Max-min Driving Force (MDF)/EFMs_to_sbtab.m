function statue = EFMs_to_sbtab(model) 
    dir = '.\MDF input\';
    K = size(model.cut_all_efms, 2);
    for k = 1:K
        filename = dir + string(k) + '.tsv';
        EFM_to_sbtab(model,model.cut_all_efms(:, k), filename);
    end
    
    statue = 1;
    
end

function statue = EFM_to_sbtab(model, scale_efm, filename)
% Convert an EFM path into a tsv file, the EFM must be consistent with the metabolic model,
% This tsv file contains configuration table 'Configuration', reactant table 'Reaction', metabolite table 'Compound',
% Concentration range table 'ConcentrationConstraint' and flux table 'Flux'

% input
% model: a metabolic model containing only internal reactions
% efm: An EFM containing only internal reactions
% filename: The save path of the generated tsv file

% output
% status: Code running status, 1 means success

    % Set up and create a configuration table (Configuration table)
    s.p_h = '7.0 dimensionless';
    s.p_mg = '3.0 dimensionless';
    s.ionic_strength = '0.15 molar';
    s.temperature = '310.15 kelvin';
    s.algorithm = 'MDF';
    s.stdev_factor = '1.96';

    options.TableName = 'Configuration';
    options.TableID = 'Configuration';
    options.document_name = 'Model';

    config_table = options_to_sbtab(s,options);
    clear options;

    % Create reactant table, metabolite table, concentration range table and flux table
    options.c_min = model.conc_min;
    options.c_max = model.conc_max;
    options.v = scale_efm;
    options.graphics_positions = 0;
    options.modular_rate_law_table = 0;% None of the data related to enzyme rate law kinetics is written to the sbtab table
    options.modular_rate_law_kinetics = 0;
    options.write_enzyme_concentrations = 0;

    sbtab_document = network_to_sbtab(model, options);
    clear options;
    
    % Add the Unit attribute to the concentration range table, set the Unit's 'M'->'mM' and add the Unit attribute to the flux table, set the Unit's 'M/s'->'mM/s'
    sbtab_document.tables.ConcentrationConstraint = sbtab_table_add_attribute(sbtab_document.tables.ConcentrationConstraint,'Unit', 'mM');
    sbtab_document.tables.Flux = sbtab_table_add_attribute(sbtab_document.tables.Flux,'Unit', 'mM/s');

    % Add a configuration table to the document
    sbtab_document = sbtab_document_add_table(sbtab_document, 'Configuration', config_table);

    % save as tsv file
    sbtab_document_save_to_one(sbtab_document, filename);
    
    statue = 1;
    
end