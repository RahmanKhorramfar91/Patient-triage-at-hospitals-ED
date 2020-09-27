function t = MM1(A,S,Sr,w)

%A = A(1:15);
%S = S(1:15);
N = numel(A); % Length of simulation

NSim = 1; % Number of simulation runs
t = 0;
NA = 0;
ND = 0;
n0 = 0;  % Initial number of customers
n = n0;
tD = inf;
tA = A(ND+1);
Output = []; % Output data (i A(i) D(i))

% Main algorithm
while ND < N-3
    
    if tA <= tD
        t = tA;
        NA = NA + 1;
        n = n+1;
        tA = A(NA);
        if n == 1
            mu = Sr(S(NA));
            Y = -log(rand)/mu;
            Y = Y*w(S(NA));
            tD = t + Y;
        end
        Output = [Output; NA t 0];
        
    else
        t = tD;
        ND = ND +1;
        n = n-1;
        if n == 0
            tD = Inf;
        else
            mu = Sr(S(ND));
            Y = -log(rand)/mu;
            Y = Y*w(S(ND));
            tD = t + Y;
        end
        Output(ND,3) = t;
    end
    if NA==N
        while ND<N
           ND = ND+1;
            mu = Sr(S(ND));
            Y = -log(rand)/mu;
            Y = Y*w(S(ND));
            t = t+Y;
        end
       break; 
    end
end

% Compute the waiting times
w = Output(1:end,3) - Output(1:end,2);
w = w';

%
% figure
% plot((1:1:N),EW)
% title(('Expected Waiting Time'))
% xlabel('i')
% ylabel('EW_i')
%

