function protein_molar_weight_matrix = cal_protein_molar_weight_matrix(efms,pMW)
% Calculate the protein molar mass matrix protein_molar_weight_matrix, the formula is MW_i, rx¡ÁK
% According to the EFM matrix, the response is not zero and the treatment is 1, and the calculation is based on the protein molar mass pMW

% input
% (may or may not be scaled)
% efms version 1: An EFM matrix that only contains internal reactions and is scaled according to the flux distribution. Compared with the original EFM matrix, only scaling (scaling) is performed
% efms version 2: raw EFM matrix with internal reactions only (no scaling)
% What are the effects of the unscaled EFM matrix and the scaled EFM matrix on various calculations and results?
% pMW: Reactive enzyme protein molar mass

% output
% weight_matrix: The weight matrix of the point product of protein molar mass and flux (1), consistent with the EFM matrix where it is not 0 and greater than 0

    % According to the EFM matrix, the response is not zero disposition 1
    efms = sign(efms);

    % Calculate protein molar mass matrix
    protein_molar_weight_matrix = efms(:,1:end) .* pMW;

end

