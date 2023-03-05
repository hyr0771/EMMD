function sol = linear_programming(scale_specific_efms, flux, enzyme_cost_vector, problem)
	[n, K] = size(scale_specific_efms);
    ind_neg = find(flux<0);
    flux(ind_neg) = -flux(ind_neg);
    scale_specific_efms(ind_neg,:) = -scale_specific_efms(ind_neg,:);
    solver = 'cobra';
	switch solver
		case 'cobra'		
            if isfield(problem,'sol0')
                if ~isempty(problem.sol0)
                    A2=zeros(size(problem.sol0,1),2*K);
                    b2=zeros(size(problem.sol0,1),1);
                    for j=1:size(problem.sol0,1)
                        A2(j,K+1:2*K)=problem.sol0(j,:);
                        b2(j)=sum(problem.sol0(j,:))-1;
                    end
                else
                    A2=[];
                    b2=[];
                end
            else
                A2=[];
                b2=[];
            end
            
            param.printLevel = 3;
            param.solver = 'gurobi';
            param.timeLimit = 450;
			
			EYES=sparse((1:K)',(1:K)',ones(K,1),K,K);
			A=[[sparse([scale_specific_efms;-scale_specific_efms]) sparse([],[],[],2*n,K)];[EYES -EYES];sparse(A2)];
			b=[[flux;-flux];zeros(K,1);b2];
			c=[enzyme_cost_vector';zeros(K,1)];
			lb=zeros(2*K,1);
			ub=ones(2*K,1);
			osense=1;
            if isfield(problem,'sol0')
                if ~isempty(problem.sol0)
                    csense=char([ones(1,2*n)*'L' ones(1,K+size(problem.sol0,1))*'L']);
                else
                    csense=char([ones(1,2*n)*'L' ones(1,K)*'L']);
                end
            else
                csense=char([ones(1,2*n)*'L' ones(1,K)*'L']);
            end
			x0=[];
			vartype=char([ones(1,K)*'C' ones(1,K)*'B']);
			
			MILPproblem=struct();
			MILPproblem.A=A;
            MILPproblem.b=b;
            MILPproblem.c=c;
            MILPproblem.lb=lb;
            MILPproblem.ub=ub;
            MILPproblem.osense=osense;
            MILPproblem.csense=csense;
            MILPproblem.x0=x0;
            MILPproblem.vartype=vartype;
            if exist('param','var')
                info= solveCobraMILP(MILPproblem,param);
            else
                info= solveCobraMILP(MILPproblem);
            end
            sol = info;
		case 'gurobi'
			A = scale_specific_efms;
			b = flux;
			c = enzyme_cost_vector';
			lb=zeros(K,1);
			ub=ones(K,1);
			osense = 1;
			csense = char('E'*ones(size(scale_specific_efms,1),1));
			
			LPproblem=struct();
			LPproblem.A = A;
			LPproblem.b = b;
			LPproblem.c = c;
			LPproblem.lb=lb;
			LPproblem.ub=ub;
			LPproblem.osense=osense;
			LPproblem.csense=csense;

            param.solver = 'gurobi';
            param.printLevel = 3;
			info= solveCobraLP(LPproblem, param);
            sol = info;	
	end
end