function mnet = generate_EFMs()
    load('.\Model input\e_coli_core.mat');
    currcent = pwd;
    cd('.\efmtool');
    mnet = CalculateFluxModes(e_coli_core.S,e_coli_core.rev);
    cd(currcent);
    clear e_coli_core currcent;
    
    % Exclude EFMs that do not conform to a predefined orientation
    find(mnet.efms(1,:) < 0)
    find(mnet.efms(2,:) ~= 0)
    find(mnet.efms(5,:) < 0)
    find(mnet.efms(6:7,:) ~= 0)
    find(mnet.efms(9,:) < 0)
    find(mnet.efms(10:11,:) ~= 0)
    find(mnet.efms(13:17,:) < 0)
    find(mnet.efms(19:22,:) < 0)
    find(mnet.efms(24:26,:) < 0)
    find(mnet.efms(27,:) > 0)
    mnet.efms(:,find(mnet.efms(27,:) > 0)) = []
    find(mnet.efms(28:29,:) < 0)
    find(mnet.efms(30,:) > 0)
    find(mnet.efms(31:32,:) < 0)
    find(mnet.efms(33,:) > 0)
    find(mnet.efms(35,:) ~= 0)
    mnet.efms(:, find(mnet.efms(35,:) ~= 0)) = []
    find(mnet.efms(36,:) ~= 0)
    find(mnet.efms(37,:) < 0)
    find(mnet.efms(38,:) > 0)
    find(mnet.efms(39:42,:) < 0)
    find(mnet.efms(45:46,:) ~= 0)
    find(mnet.efms(47,:) < 0)
    find(mnet.efms(48:49,:) ~= 0)
    find(mnet.efms(50,:) > 0)
    find(mnet.efms(51,:) < 0)
    find(mnet.efms(52,:) > 0)
    find(mnet.efms(53:54,:) ~= 0)
    find(mnet.efms(56:57,:) < 0)
    find(mnet.efms(58,:) ~= 0)
    find(mnet.efms(59:63,:) > 0)
    find(mnet.efms(65,:) < 0)
    find(mnet.efms(66:67,:) ~= 0)
    find(mnet.efms(68:70,:) < 0)
    find(mnet.efms(71,:) > 0)
    find(mnet.efms(72,:) < 0)
    find(mnet.efms(74:75,:) < 0)
    find(mnet.efms(76,:) ~= 0)
    find(mnet.efms(77,:) ~= 0)
    mnet.efms(:, find(mnet.efms(77,:) ~= 0)) = []
    find(mnet.efms(78,:) ~= 0)
    mnet.efms(:, find(mnet.efms(78,:) ~= 0)) = []
    find(mnet.efms(79,:) < 0)
    find(mnet.efms(80,:) ~= 0)
    find(mnet.efms(81,:) < 0)
    find(mnet.efms(82,:) > 0)
    find(mnet.efms(83:84,:) < 0)
    find(mnet.efms(85,:) > 0)
    find(mnet.efms(86,:) < 0)
    find(mnet.efms(87,:) ~= 0)
    find(mnet.efms(88:95,:) < 0)
    
end