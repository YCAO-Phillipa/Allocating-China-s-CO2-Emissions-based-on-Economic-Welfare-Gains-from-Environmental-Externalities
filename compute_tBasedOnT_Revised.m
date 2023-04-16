%%
clear; clc;

%% load sample data which can be substituted by your own data
load('T_MTX.mat');
load('sigmaMTX.mat');
load('deltaMTX.mat');

%size of variables
N_sigma = size(sigmaMTX,1);
N_delta = size(deltaMTX,2);
N_T = length(T_MTX);
% Build matrices for model outputs
t = zeros(N_sigma,N_delta);
Change_PS = zeros(N_sigma,N_delta);
Change_CS = zeros(N_sigma,N_delta);
%calculate price increasing rate t from T
for a = 1:N_sigma
    for b = 1:N_delta
        delta = deltaMTX(a, b);
        sigma = sigmaMTX(a, b);
        T = T_MTX(a,b);
        [~,~,temp] = ShareEmissionBasedOnEcon(sigma,delta,T);
        t(a,b) = temp;
    end
end
%with t,we can calculate consumer and producer share
%convert delta into negatives in accordance with the article
deltaMTX = -deltaMTX;
%Change of consumer and producer surplus
for m = 1:N_sigma
    for n = 1:N_delta
        Change_PS(m,n) = (1-(1+t(m,n))^(deltaMTX(m,n)*(1+sigmaMTX(m,n))/(sigmaMTX(m,n)-deltaMTX(m,n))))/(sigmaMTX(m,n));
        Change_CS(m,n) = ((1+t(m,n))^(sigmaMTX(m,n)*(1+deltaMTX(m,n))/(sigmaMTX(m,n)-deltaMTX(m,n)))-1)/(1+deltaMTX(m,n));
    end
end
%The percentage share of both sided for each flow of emission
ShareProducer = Change_PS ./ (Change_PS + Change_CS+eps);
ShareConsumer = 1 - ShareProducer;