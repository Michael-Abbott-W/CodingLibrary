// this code is used in the dynare lecture 
var c k z y; // endogenous variables
varexo epsilon; // exogenous variables
parameters beta eta alpha delta rho z_mean epsilon_sigma;

beta = 0.98;
eta = 0.5;
alpha = 0.3;
delta = 0.1;
rho = 0.5;
z_mean = 0;
epsilon_sigma = 0.1;

model; // model block. For loglinear solution, wrap all endogenous variables in exponents
    exp(c)^(-eta) = beta * exp(c(+1))^(-eta) * (alpha * exp(z(+1)) * exp(k)^(alpha-1) + 1-delta);
    exp(c) + exp(k) = exp(z) * exp(k(-1))^alpha + (1-delta) * exp(k(-1));
    z = (1-rho) * z_mean + rho*z(-1) + epsilon;
    exp(y) = exp(z) * exp(k(-1))^alpha;
end;


initval; // define the initial guess for Dynare's s.s. finder. Can omit if steady_state_model is defined below explicitly
    c = log(1);
    k = log(1);
    z = z_mean;
    y = log(1);
end;


shocks; // variance of shocks
    var epsilon = epsilon_sigma^2;
end;


steady_state_model; // can define the s.s. explicitly. If this block is omitted, "steady;" will compute the s.s. numerically
    z = z_mean;
    tempVal = (1/(exp(z_mean)*alpha) * (1/beta - (1-delta))); // can use temporary values in this block
    k = log(tempVal ^ (1/(alpha-1))); // remember to wrap in logs
    c = log(exp(z)*exp(k)^alpha - delta*exp(k)); // remember to wrap other endogenous vars in exponents
    y = log(exp(z)*exp(k)^alpha);
end;

steady; // if steady_state_model is defined above, this line will simply display the s.s. values calculated from that block. Otherwise, this line will find the s.s. numerically

stoch_simul(order=1, irf=20, hp_filter=1600); // order 1 for loglinear approximation
//stoch_simul(order=2, irf=20, hp_filter=1600); // alternatively, order 2 (add pruning if explosive)