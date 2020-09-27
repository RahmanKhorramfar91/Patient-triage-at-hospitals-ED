function mat = NHPP(Lbar,Lh,mat)

N = numel(mat);
t = 0;i = 0;

while i<N
    t = t-(1/Lbar)*log(rand)/5;
    
    p = Lh(t)/Lbar;
    
    if rand<= p
        i = i+1;
        mat(i) = t;        
    end
end




