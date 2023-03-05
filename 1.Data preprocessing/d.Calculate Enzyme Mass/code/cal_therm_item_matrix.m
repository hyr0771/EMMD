function therm_item_matrix = cal_therm_item_matrix(delta_r_G_matrix)
% Calculate the thermodynamic term 1-exp(-成), where 1-exp(-成) = 1-exp(忖rG/RT), 成 = -忖rG/RT, rx℅K
% 1-exp(-成) -----> therm_item
% 忖rG -----> delta_r_G, Gibbs free energy of reaction
% therm_item_matrix = 1 - exp(delta_r_G_matrix / RT)

% input
% delta_r_G_matrix: Gibbs free energy matrix of the reaction, which can be obtained by the MDF algorithm or calculated by the cal_delta_r_G_matrix.m function

% output
% therm_item_matrix: thermodynamic item

    therm_item_matrix = 1 - exp(delta_r_G_matrix / RT);

end

