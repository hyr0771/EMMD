function omega_item_matrix = cal_omega_item_matrix(model)
%rx℅K
% Calculate omega term 次(e_n℅j(i)) = (k_cat,i^+) (1-exp(-成)) (﹊_i(S_i/KM_i)^mi / D(S_1,S_2, ...,P_1,P_2,...))

% input
% model: A metabolic model that only includes internal reactions, and each part is the original data, that is, it has not been modified according to the flux distribution flux or EFM matrix

% output
% omega_item_matrix: Omega item 次(e_n℅j(i)) matrix

    kinetics = model.kinetics;

    % Calculate the forward catalytic constant matrix k_cat,i^+,
    kcat_forward_item_matrix = cal_kcat_forward_item_matrix(full(model.N),kinetics.KM,kinetics.KV,kinetics.Keq,model.cut_all_efms);

    % Calculate the thermodynamic term 1-exp(-成), where 1-exp(-成) = 1-exp(忖rG/RT), 成 = -忖rG/RT
    therm_item_matrix = cal_therm_item_matrix(model.delta_r_G_matrix);
    
    % Solve the saturation term ﹊_i(S_i/KM_i)^mi / D(S_1,S_2,...,P_1,P_2,...)
    saturation_matrix = cal_saturation_item_matrix(full(model.N),model.regulation_matrix,model.external,kinetics.KM,model.conc_matrix,kinetics.type);
    
    % Calculate the omega term 次(e_n℅j(i))
    omega_item_matrix = kcat_forward_item_matrix .* therm_item_matrix .* saturation_matrix;
    
end