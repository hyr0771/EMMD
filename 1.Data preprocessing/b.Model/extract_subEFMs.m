function model_new = extract_subEFMs(model, all_efms)
    % Get subscript indices for exchange and transport reactions and biomass reactions
    not_c_reaction = [0;0;0;0;0;0;1;0;1;0;...
                      1;0;0;0;0;0;0;1;0;0;...
                      0;1;0;0;1;1;1;0;0;0;...
                      1;1;1;0;1;1;0;0;0;1;...
                      0;0;0;1;1;1;1;1;1;1;...
                      1;1;1;1;1;1;1;1;1;1;...
                      1;1;1;0;0;1;1;0;1;0;...
                      1;0;0;1;0;1;0;0;0;1;...
                      0;1;0;0;0;0;1;0;0;0;...
                      1;0;1;1;0];
    ind_r = find(not_c_reaction);
    all_efms(ind_r, :) = [];
    
    model_new = model;
    model_new.cut_all_efms = all_efms;

end