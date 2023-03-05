function EMMDsolution = EMMD(flux, model, e_coli_core)
	addpath('.\code');

    model_emmd.enzyme_cost_vector = model.enzyme_cost_vector;
    model_emmd.all_efms = model.all_efms;

    model_emmd.neg_flux = flux;
    index_neg = find(flux < 0);
    flux(index_neg) = -flux(index_neg);
    model_emmd.flux = flux;
    S = e_coli_core.S;
    S(:,index_neg) = -S(:,index_neg);
    rev = zeros(size(S, 2),1);

    currcent = pwd;
    cd('.\efmtool');
    mnet = CalculateFluxModes(S,rev);
    cd(currcent);
    model_emmd.specific_efms = mnet.efms;
    
    ind_zero = find(flux == 0);
    for i = 1:size(ind_zero)
        index = find(model_emmd.specific_efms(ind_zero(i), :) ~= 0);
        model_emmd.specific_efms(:, index) = [];
    end
    
    [model_emmd.scale_specific_efms,model_emmd.scale_ratio] = EFMs_scale(model_emmd.specific_efms,model_emmd.flux);
    model_emmd.neg_scale_specific_efms = model_emmd.scale_specific_efms;
    model_emmd.neg_scale_specific_efms(index_neg,:) = -model_emmd.neg_scale_specific_efms(index_neg,:);
    [~, index_efms] = ismember(sign(model_emmd.neg_scale_specific_efms(:, 1:end))', sign(model_emmd.all_efms)', 'rows');

    EMMDsolution = cell(3,1);
    model_emmd = rmfield(model_emmd, 'all_efms');
    EMMDsolution{1,1} = model_emmd;
    problem.sol0 = [];
    for i=1:2
        sol = linear_programming(model_emmd.scale_specific_efms, model_emmd.flux, sum(model_emmd.enzyme_cost_vector(:,index_efms),1) .* model_emmd.scale_ratio', problem);
        problem.sol0 = [problem.sol0; logical(sol.cont)'];
        EMMDsolution{i+1, 1} = sol;
    end
    
end