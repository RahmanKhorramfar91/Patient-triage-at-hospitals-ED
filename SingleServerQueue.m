% This program simulates a single server queue with Poisson
% arrivals and exponential service times, up to the time when
% the Nth customer departs

clear all;
clc; clf;
tic;
N = 500; % Length of simulation

lambda = 1; % Arrival rate
mu = 10/9; % Service rate

NSim = 2000; % Number of simulation runs

W = zeros(N,1); % Initialize waiting times vector

for k = 1:NSim
    
    % Initialize simulation
    
    t = 0;
    NA = 0;
    ND = 0;
    n0 = 10;  % Initial number of customers
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

totTime = toc

figure
plot((1:1:N),EW)
title(('Expected Waiting Time'))
xlabel('i')
ylabel('EW_i')


