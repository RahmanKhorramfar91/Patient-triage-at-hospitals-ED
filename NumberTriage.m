function HIM = NumberTriage(HIM,Ar,w)


nHIM = numel(HIM);
for i=1:nHIM
    HIM(i).A = [HIM(i).A Ar(1,1)];
    HIM(i).S = [HIM(i).S Ar(2,1)];
    HIM(i).N = HIM(i).N+1;
    HIM(i).W = HIM(i).W + w(Ar(2,1));
    Ar(:,1) = []; 
end

N = size(Ar,2);

for i=1:N
    
    Ns = [HIM.N];
    [~,n] = min(Ns); 
        
    HIM(n).A = [HIM(n).A Ar(1,1)];
    HIM(n).S = [HIM(n).S Ar(2,1)];
    HIM(n).N = HIM(n).N+1;
    HIM(n).W = HIM(n).W + sum(w(Ar(2,1)));
    Ar(:,1) = [];     
end




