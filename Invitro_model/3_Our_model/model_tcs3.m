% This  function defines the ode's described by model equation 

function [ dx ] = model_tcs3(t,x,par)
%% Parameters

K_E          = 1.7 * 10^-6;
k_p1         = 0.27;

K_D1         = 444;
K_D2         = 83;
K_D1_HK         = 936;
K_D2_HK         = 402;

% K_D1         = 268;
% K_D2         = 80;
% K_D1_HK         = 2183;
% K_D2_HK         = 2283;


k_f1         = 0.06;
k_fc         = 100;

K_c          = 10^par(1);
k_pt11       = 10^par(2);
k_ps11       = 10^par(3);
k_dp11       = 10^par(4);

k_f2         = 0.06;
k_ps12       = 10^par(5);

k_deg        = 0;
k_deRR       = 2.4*10^(-4)*60;

k_fa1        = 0.06;

%% ODEs
N = 12; % N is number of species (or) odes

dx = zeros(N,1); % Differential of populations

HK1             = x(1);
HK1s            = x(2);
RR1             = x(3);
RR1s            = x(4);
RR2             = x(5);
RR2s            = x(6);
HK1s_RR1        = x(7);
HK1_RR1s        = x(8);
HK1s_RR2        = x(9);
HK1_RR2s        = x(10);
ATP             = x(11);
HK1_ATP         = x(12);
iP              = x(13);
HK1_RR1         = x(14);
HK1_RR2         = x(15);

dx(1) = - k_fa1*HK1*ATP + k_fa1/K_E*HK1_ATP + k_pt11*HK1_RR1s - k_dp11*HK1*RR1s + k_ps11*HK1_RR1s + k_ps12*HK1_RR2s...
    - k_deg*HK1 - k_f1*HK1*RR1 + k_f1*K_D1_HK*HK1_RR1 - k_f2*HK1*RR2 + k_f2*K_D2_HK*HK1_RR2;

dx(2) = k_p1*HK1_ATP - k_f1*HK1s*RR1 + k_f1*K_D1*HK1s_RR1 - k_f2*HK1s*RR2 + k_f2*K_D2*HK1s_RR2...
    - k_deg*HK1s;

dx(3) = - k_f1*HK1s*RR1 + k_f1*K_D1*HK1s_RR1 + k_ps11*HK1_RR1s + k_deRR*RR1s...
    - k_deg*RR1 - k_f1*HK1*RR1 + k_f1*K_D1_HK*HK1_RR1;

dx(4) = k_pt11*HK1_RR1s - k_dp11*HK1*RR1s - k_deRR*RR1s...
    - k_deg*RR1s;

dx(5) = - k_f2*HK1s*RR2 + k_f2*K_D2*HK1s_RR2 + k_ps12*HK1_RR2s + k_deRR*RR2s...
    - k_deg*RR2 - k_f2*HK1*RR2 + k_f2*K_D2_HK*HK1_RR2;

dx(6) = - k_deRR*RR1s...
    - k_deg*RR1s;

dx(7) = k_f1*HK1s*RR1 - k_f1*K_D1*HK1s_RR1 - k_fc*HK1s_RR1 + k_fc*K_c*HK1_RR1s...
    - k_deg*HK1s_RR1;

dx(8) = k_fc*HK1s_RR1 - k_fc*K_c*HK1_RR1s - k_pt11*HK1_RR1s + k_dp11*HK1*RR1s - k_ps11*HK1_RR1s...
    - k_deg*HK1_RR1s;

dx(9) = k_f2*HK1s*RR2 - k_f2*K_D2*HK1s_RR2 - k_fc*HK1s_RR2 + k_fc*K_c*HK1_RR2s...
    - k_deg*HK1s_RR2;

dx(10)= k_fc*HK1s_RR2 - k_fc*K_c*HK1_RR2s - k_ps12*HK1_RR2s...
    - k_deg*HK1_RR2s;

dx(11)= - k_fa1*HK1*ATP + k_fa1*K_E*HK1_ATP;

dx(12) = k_fa1*HK1*ATP - k_fa1/K_E*HK1_ATP - k_p1*HK1_ATP;

dx(13) = k_ps11*HK1_RR1s + k_ps12*HK1_RR2s;

dx(14) = k_f1*HK1*RR1 - k_f1*K_D1_HK*HK1_RR1;

dx(15) = k_f2*HK1*RR2 - k_f2*K_D2_HK*HK1_RR2;

end
