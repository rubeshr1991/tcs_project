% This  function defines the ode's described by model equation 

function [ dx ] = model_tcs3(t,x,par)
%% Parameters

K_E          = 1.7 * 10^-6;
k_p1         = 0.27;
k_fa1        = 0.06;

K_D1         = 444;
K_D2         = 83;
K_D1_HK         = 936;
K_D2_HK         = 402;

% K_D1         = 268;
% K_D2         = 80;
% K_D1_HK         = 2183;
% K_D2_HK         = 2283;

% k_f1         = 0.06; k_f2         = 0.06;
% k_fc         = 100;

% K_c          = 10^par(1);
% k_pt11       = 10^par(2);
% k_ps11       = 10^par(3);
% k_dp11       = 10^par(4);
% k_ps12       = 10^par(5);
% k_deg        = 0;
% k_deRR       = 2.4*10^(-4)*60;

k_pRR = 10^par(1); 
k_dRR = 10^par(2); 
k_dRRnc = 10^par(3); 


%% ODEs
N = 7; % N is number of species (or) odes

dx = zeros(N,1); % Differential of populations

HK1             = x(1);
HK1s            = x(2);
RR1             = x(3);
RR1s            = x(4);
RR2             = x(5);
ATP             = x(6);
HK1_ATP         = x(7);

dx(1) = - k_fa1*HK1*ATP + k_fa1/K_E*HK1_ATP + k_pRR*HK1s*RR1;

dx(2) = k_p1*HK1_ATP - k_pRR*HK1s*RR1 - k_dRRnc*HK1s*RR2;

dx(3) = - k_pRR*HK1s*RR1 - k_dRR*HK1*RR1s;

dx(4) =  k_pRR*HK1s*RR1 - k_dRR*HK1*RR1s;

dx(5) = 0;

dx(6)= - k_fa1*HK1*ATP + k_fa1*K_E*HK1_ATP;

dx(7) = k_fa1*HK1*ATP - k_fa1/K_E*HK1_ATP - k_p1*HK1_ATP;


end
