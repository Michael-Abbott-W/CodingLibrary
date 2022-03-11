// this code is used in the dynare lecture. Like dynareExample.mod, but edited to do estimation

var c k z y y_growth_rate; // endogenous variables
varexo epsilon; // exogenous variables
parameters beta eta alpha delta rho z_mean;

beta = 0.98;
eta = 0.5;
alpha = 0.3;
delta = 0.1;
rho = 0.5;
z_mean = 0;

model; // model block. For loglinear solution, wrap all endogenous variables in exponents
    exp(c)^(-eta) = beta * exp(c(+1))^(-eta) * (alpha * exp(z(+1)) * exp(k)^(alpha-1) + 1-delta);
    exp(c) + exp(k) = exp(z) * exp(k(-1))^alpha + (1-delta) * exp(k(-1));
    z = (1-rho) * z_mean + rho*z(-1) + epsilon;
    exp(y) = exp(z) * exp(k(-1))^alpha;
    y_growth_rate = (exp(y)/exp(y(-1)) - 1)*100;
end;


initval; // define the initial guess for Dynare's s.s. finder. Can omit if steady_state_model is defined below explicitly
    c = log(1);
    k = log(1);
    z = log(1);
    y = log(1);
    y_growth_rate = 0;
end;

// shocks block gone for estimation (can't define epsilon_sigma since it will be estimated).

steady_state_model; // can define the s.s. explicitly. If this block is omitted, "steady;" will compute the s.s. numerically
    z = z_mean;
    tempVal = (1/(exp(z_mean)*alpha) * (1/beta - (1-delta))); // can use temporary values in this block
    k = log(tempVal ^ (1/(alpha-1))); // remember to wrap in logs
    c = log(exp(z)*exp(k)^alpha - delta*exp(k)); // remember to wrap other endogenous vars in exponents
    y = log(exp(z)*exp(k)^alpha);
    y_growth_rate = 0;
end;

varobs y_growth_rate;

steady; // if steady_state_model is defined above, this line will simply display the s.s. values calculated from that block. Otherwise, this line will find the s.s. numerically

estimated_params;
    stderr epsilon, inv_gamma_pdf, 0.01, 0.5;
    rho, beta_pdf, 0.5, 0.25;
end;


estimation(datafile = 'y_growth_rate.mat', prefilter = 1); // prefilter demeans the data series

stoch_simul(order=1, irf=20, hp_filter=1600); // order 1 for loglinear approximation
//stoch_simul(order=2, irf=20, hp_filter=1600); // alternatively, order 2 + pruning