function kcat_forward_item_matrix = cal_kcat_forward_item_matrix(S,KM,KV,Keq,efms)
% Calculate the forward catalytic constant matrix k_cat, i^+, rx¡ÁK
% Calculate according to the EFM matrix, if the EFM matrix is positive, then take the corresponding Kcat_plus value;
% If the EFM matrix is negative, take the corresponding Kcat_minus value

% input
% S: The original stoichiometric matrix, without transformation according to the positive or negative of the flux distribution flux or EFM matrix
% KM: original Michaelis constant matrix, 54¡Á53
% KV: the arithmetic square root of the forward catalytic constant column vector and the reverse catalytic constant column vector
% Keq: Equilibrium constant column vector
% efms: The original EFM matrix, not transformed according to the positive and negative of the flux distribution flux (maybe scaled or unscaled)

% output
% kcat_forward_item_matrix: forward catalytic constant matrix

    % Calculate the forward catalytic constant column vector Kcat_plus and the reverse catalytic constant column vector Kcat_minus according to S, KM, KV, Keq
    [Kcat_plus, Kcat_minus]   = ms_compute_Kcat(S,KM,KV,Keq);

    % Calculate according to the EFM matrix, if the EFM matrix is positive, then take the corresponding Kcat_plus value;
    EFMs_positive = sign(efms);
    K_positive = EFMs_positive(:,1:end) .* Kcat_plus;
    K_positive(find(K_positive < 0)) = 0;% Set the catalytic constants less than 0 to zero, and only keep the positive catalytic constants greater than zero
    
    % If the EFM matrix is negative, take the corresponding Kcat_minus value
    EFMs_negative = -sign(efms);
    K_negative = EFMs_negative(:,1:end) .* Kcat_minus;
    K_negative(find(K_negative < 0)) = 0;% Set the catalytic constants greater than 0 to zero, and only keep the positive catalytic constants that are less than zero (EFM is negative, negative and negative are positive)
    
    % The forward catalytic constant matrix and the reverse catalytic constant matrix are added to obtain the forward catalytic constant matrix conforming to the EFM matrix
    kcat_forward_item_matrix = K_positive + K_negative;
    
end