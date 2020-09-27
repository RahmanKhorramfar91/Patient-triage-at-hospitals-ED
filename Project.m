clc;clear;close all;

%% Problem Data

nSource = 6; % number of patinet types (sources)
nHIM = 11; % number of service departments
Lh = cell(nSource,1);

% Arrival Rates for each set of sources (NHPP)
Lh{1} = @(t) 0.5+0.8*sin(t).^2;
Lh{2} = @(t) 2-0.4*sin(t);
Lh{3} = @(t) 1+0.6*cos(t);
Lh{4} = @(t) 3-0.2*sin(t);
Lh{5} = @(t) 3+0.4*cos(t);
Lh{6} = @(t) 4+0.7*cos(t);

Lbar = [3.3 2.4 1.6 3.2 3.4 5.7];
% Weight of each source for every type of provider
w = [1 3 6 9 13 19]/2;

% Service rate of each source
Sr = [6 5 4 3 2 1]*2;
N = 200;
%% Pre-Processing
nD = 30;
%% Main Loop
WL1 = zeros(nD,nHIM); WL2 = zeros(nD,nHIM);

for d=1:nD       
    A = cell(6,1);
    for i=1:nSource
        A{i} = zeros(N,1);
        A{i} = NHPP(Lbar(i), Lh{i}, A{i});
    end
    
    Ar = zeros(2,nSource*N);
    for i=1:nSource
        Ar(1,(i-1)*N+1:(i)*N) = A{i};
        Ar(2,(i-1)*N+1:(i)*N) = i;
    end
    
    [~,so] = sort(Ar(1,:));
    Ar(1,:) = Ar(1,so);
    Ar(2,:) = Ar(2,so);
    
    Empty_HIM = struct('A',[],'S',[],'N',0,'W',0);
    HIM1 = repmat(Empty_HIM,nHIM,1);
    HIM2 = repmat(Empty_HIM,nHIM,1);
    HIM1 = NumberTriage(HIM1,Ar,w);
    HIM2 = WeightTriage(HIM2,Ar,w);
    
    for h=1:nHIM
        We = MM1(HIM1(h).A,HIM1(h).S,Sr,w);
        WL1(d,h) = We;
        
        We = MM1(HIM2(h).A,HIM2(h).S,Sr,w);
        WL2(d,h) = We;
    end
    HIM1 = [];
    HIM2 = [];
    A = []; Ar = [];
end

%a1 = sum(WL1,1);
%a2 = sum(WL2,1);
for i=1:30
   a1(i) = var(WL1(i,:)); 
   a2(i) = var(WL2(i,:));
end
y = 1:30;
plot(y,a1); hold on;
plot(y,a2);
disp(a1);
disp(a2);
disp(a1>a2);
