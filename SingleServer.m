function ms = SingleServer(N,lambda,mu)

NSim = 1; % Number of simulation runs

W = zeros(N,1); % Initialize waiting times vector

for k = 1:NSim
    
    % Initialize simulation

    t = 0;
    NA = 0;
    ND = 0;
    n0 = 0;  % Initial number of customers
    n = n0;  
    if n > 0
        tD = -log(rand)/mu;
    else
        tD = Inf;
    end
    tA = -log(rand)/lambda; 
    Output = []; % Output data (i A(i) D(i))

    % Main algorithm

    while ND < N + n0
        
        if tA <= tD 
            t = tA;
            NA = NA + 1;
            n = n+1;
            tA = t - log(rand)/lambda;   
            if n == 1
                Y = -log(rand)/mu;
                tD = t + Y;
            end
            Output = [Output; NA t 0];
    
        else 
            t = tD;
            ND = ND + 1;
            n = n-1;
            if n == 0
                tD = Inf;
            else
                Y = -log(rand)/mu;
                tD = t + Y;
            end
            Output(ND,3) = t;
        end
    end
    
    % Compute the waiting times
        
    w = Output(n0+1:n0+N,3) - Output(n0+1:n0+N,2);
    W = W + w;
    
end

EW = W/NSim;
sojourn = Output(:,3) - Output(:,2);
sojourn = sojourn(1:N);
ms = sum(sojourn);






    