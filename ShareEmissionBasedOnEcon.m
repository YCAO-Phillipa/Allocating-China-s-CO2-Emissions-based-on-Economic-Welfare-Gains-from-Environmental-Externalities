function [ShareProducer,ShareConsumer,t] = ShareEmissionBasedOnEcon(sigma,delta,T)
% Caculate the shares of producer and consumer responsibilities given
% environmental externalities, based on economic theory.
% INPUT:
% sigma(>0): Supply elesticity.
% delta(>0): Demand elesticity.
% T(>=0): (Value of externality) / (Value of Product).
% OUTPUT:
% ShareProducer(in [0,1]): Share of producer responsibility.
% ShareConsumer(in [0,1]): Share of consumer responsibility.
% t: (Externality tax) / (Price faced by the supplier), if the externality were internalized.

% From the paper:
% "Sharing responsibility for trade-related emissions based on economic benefits",
% Global Environmental Chagne, 2021.

delta = -delta; % Convert it to the delta in the paper.
if delta==-1
    delta = delta + 10^(-7);
end

% Solve for t in the paper's theory.
fun1 = @(t,T,x) T-t/(1+t)^x;
x = -delta/(sigma-delta);
fun2 = @(t) fun1(t,T,x);

% Now we solve for t. First we must define the starting value t0.
if T<1 % T smaller then 1.
    t0 = T;
elseif T==1 % T equal to 1.
    t0 = T;
else % T larger than 1.
    t0 = T^(1/(1-x));
end

% Solving the implict function equation!
options = optimset('Display','off');
t = fsolve(fun2,t0,options); 

% % Solving the implict function equation!
% t = fzero(fun2,t0); 

% Changes in producer surplus and consumer surplus
% if the externality were internalized by a tax.
Change_PS = 1/(1+sigma) * (1 - (1+t)^(delta*(1+sigma)/(sigma-delta)));
Chagne_CS = 1/(1+delta) * ((1+t)^(sigma*(1+delta)/(sigma-delta)) - 1);
if t==0
    ShareProducer = 0;
    ShareConsumer = 0;
%     disp('No responsiblity on both sides, since externalities have been internalized!')
else
    ShareProducer = Change_PS / (Change_PS + Chagne_CS);
    ShareConsumer = 1 - ShareProducer;
end

end