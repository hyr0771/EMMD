function enzyme_cost_vector = cal_enzyme_cost_vector(model)
% Calculate enzyme cost vector enzyme_cost_vector, formula q = ﹉_i MW_i﹞E_i, E_i = a_j﹞﹉_j(f(e_nj(i))/次(e_nj(i))), 1℅K
% enzyme_cost_vector = ﹉_i MW_i ﹞ ﹉_j(f(e_nj(i))/次(e_nj(i)))
 
% input
% model: A metabolic model that only includes internal reactions, and each part is the original data, that is, it has not been modified according to the flux distribution flux or EFM matrix

% output
% enzyme_cost_vector: enzyme cost vector enzyme_cost_vector

	addpath('.\code');

    % Calculate the protein molar mass matrix protein_molar_weight_matrix, the formula is MW_i, rx℅K
    protein_molar_weight_matrix = cal_protein_molar_weight_matrix(model.cut_all_efms,model.enzyme_mass);
    
    %rx℅K
    % Calculate omega term 次(e_n℅j(i)) = (k_cat,i^+) (1-exp(-成)) (﹊_i(S_i/KM_i)^mi / D(S_1,S_2, ...,P_1,P_2,...))
    omega_item_matrix = cal_omega_item_matrix(model);
    omega_item_matrix(find(omega_item_matrix == 0)) = 1;

    % Calculate enzyme cost vector enzyme_cost_vector, formula q = ﹉_i MW_i﹞E_i, E_i = a_j﹞﹉_j(f(e_nj(i))/次(e_nj(i))), 1℅K
    % enzyme_cost_vector = ﹉_i MW_i ﹞ ﹉_j(f(e_nj(i))/次(e_nj(i)))
    enzyme_cost_vector = model.cut_all_efms .* protein_molar_weight_matrix ./ omega_item_matrix;
    
end