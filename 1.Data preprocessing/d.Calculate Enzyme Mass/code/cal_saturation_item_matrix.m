function saturation_matrix = cal_saturation_item_matrix(S,regulation_matrix,external,KM,conc_matrix,kinetic_law)
% Solve the saturation term กว_i(S_i/KM_i)^mi / D(S_1,S_2,...,P_1,P_2,...), rxกมK
% D(S_1,S_2,...,P_1,P_2,...) = กว_i(S_i/KM_i)^mi + กว_j(P_j/KM_j)^mj - 1

% Mplus = mi
% Mminus = mj

% theta_plus = กว_i(S_i/KM_i)^mi
% theta_minus = กว_j(P_j/KM_j)^mj

% psi_plus = กว_i(1+S_i/KM_i)^mi
% psi_minus = กว_j(1+P_j/KM_j)^mj

% input
% S: The original stoichiometric matrix, without transformation according to the positive or negative of the flux distribution flux or EFM matrix
% regulation_matrix: original regulatory rule matrix, all zero sparse matrix: 54กม53
% external: external metabolite index subscript, column vector of all zeros
% KM: original Michaelis constant matrix, 54กม53
% conc_matrix: Concentration matrix, which can be obtained by MDF algorithm according to EFM matrix
% kinetic_law: enzyme rate law, including D_S, D_SP, D_1S, D_1SP, D_CM

    [~, rx] = size(S);
    [~, K] = size(conc_matrix);
    
    saturation_matrix_tmp = zeros(rx,K);

    % Mplus    nr x nm matrix of forward molecularities (ie |N|, but only for substrate elements)
    % Mminus   nr x nm matrix of reverse molecularities (ie N, but only for product elements)
    [Mplus, Mminus] = make_structure_matrices(S,regulation_matrix,find(external));

    for i = 1:K
    
        % KM_matrix_r_mones: KM_matrix_r_m matrix, with missing elements replaces by 1
        KM_matrix_r_mones           = ones(size(KM)); 
        KM_matrix_r_mones(find(KM)) = KM(find(KM));
        log_c_by_k       = log(1./KM_matrix_r_mones * diag(conc_matrix(:,i)));
        
        % theta_plus = กว_i(S_i/KM_i)^mi, theta_minus = กว_j(P_j/KM_j)^mj
        theta_plus  = exp( sum( Mplus  .* log_c_by_k, 2) );
        theta_minus = exp( sum( Mminus .* log_c_by_k, 2) );

        switch kinetic_law  
            case 'D_CM' % psi_plus = กว_i(1+S_i/KM_i)^mi, psi_minus = กว_j(1+P_j/KM_j)^mj
                psi_plus    = exp( sum( Mplus  .* log(1+exp(log_c_by_k)) , 2) );
                psi_minus   = exp( sum( Mminus .* log(1+exp(log_c_by_k)) , 2) );    
        end

        switch kinetic_law  
            case 'D_S', D = theta_plus;
            case 'D_SP', D = theta_plus + theta_minus;
            case 'D_1S', D = theta_plus + 1;
            case 'D_1SP', D = theta_plus + theta_minus + 1;
            case 'D_CM', D = psi_plus + psi_minus - 1;  
        end

        saturation_matrix_tmp(:,i) = theta_plus ./ D;
        
    end
    
    saturation_matrix = saturation_matrix_tmp;
    
end

