function [scale_efms,scale_ratio] = EFMs_scale(efms,flux)
    scale_efms=efms;
    K = size(efms,2);
    scale_ratio=zeros(K,1);
    
    for k=1:K
        l=find(efms(:,k)~=0);
        scale_ratio(k)=min(flux(l)./efms(l,k));
        if scale_ratio(k)~=0
            scale_efms(:,k)=scale_efms(:,k)*scale_ratio(k);
        end     
    end
	
end