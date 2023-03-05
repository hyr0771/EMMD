function therm_item_matrix = cal_therm_item_matrix(delta_r_G_matrix)
% Calculate the thermodynamic term 1-exp(-��), where 1-exp(-��) = 1-exp(��rG/RT), �� = -��rG/RT, rx��K
% 1-exp(-��) -----> therm_item
% ��rG -----> delta_r_G, Gibbs free energy of reaction
% therm_item_matrix = 1 - exp(delta_r_G_matrix / RT)

% input
% delta_r_G_matrix: Gibbs free energy matrix of the reaction, which can be obtained by the MDF algorithm or calculated by the cal_delta_r_G_matrix.m function

% output
% therm_item_matrix: thermodynamic item

    therm_item_matrix = 1 - exp(delta_r_G_matrix / RT);

end

