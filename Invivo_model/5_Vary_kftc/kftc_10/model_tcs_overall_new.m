% This  function defines the ode's described by model equation 

function [ dx ] = model_tcs_overall_new(t,x,par,k_deg_I,k_pstase)
%% Parameters

k_unact      = 1000*60;
k_act_I      = 100*60;
k_fa1        = 0.06;
K_E          = 1.7 * 10^-6;
k_p1         = 0.27;

k_f1         = 0.06;
k_f2         = k_f1;

K_D1         = 444;
K_D2         = 83;
K_D1_HK         = 936;
K_D2_HK         = 402;

k_fc         = 10;

K_c          = 10^par(1);
k_pt11       = 10^par(2);
k_ps11       = 10^par(3);
k_dp11       = 10^par(4);
k_ps12       = 10^par(5);

k_deRR       = 2.4*10^(-4)*60;

alpha        = 10;
beta         = 6*10^(-3)*60;
lambda       = 0.1;
K1           = 5*10^5;
PT           = 1;

% k_deg        = 3.6*10^(-3);
k_deg        = 4.17*10^(-4); % 2.5% per hour

ATP          = 5*10^6;

% K_D1         = 1000;
% K_D2         = K_D1*KD_ratio;
%% ODEs
N = 16; % N is number of species (or) odes

dx = zeros(N,1); % Differential of populations


HK1_unact       = x(1);
HK1             = x(2);
HK1_ATP         = x(3);
HK1s            = x(4);
RR1             = x(5);
RR1s            = x(6);
RR2             = x(7);
RR2s            = x(8);
HK1s_RR1        = x(9);
HK1_RR1s        = x(10);
HK1s_RR2        = x(11);
HK1_RR2s        = x(12);
HK1_RR1         = x(14);
HK1_RR2         = x(15);

HK1_unact_ATP         = x(16);
HK1s_unact            = x(17);
HK1s_unact_RR1        = x(18);
HK1_unact_RR1s        = x(19);
HK1s_unact_RR2        = x(20);
HK1_unact_RR2s        = x(21);
HK1_unact_RR1         = x(22);
HK1_unact_RR2         = x(23);

Input           = x(24);

dx(1) = k_unact*HK1 - k_act_I*HK1_unact*Input + lambda*beta*PT*(1+alpha*RR1s^2/K1)/(1+RR1s^2/K1)  - k_deg*HK1_unact -k_dp11*RR1s*HK1_unact + k_ps11*HK1_unact_RR1s + k_ps12*HK1_unact_RR2s; 

dx(2) = - k_fa1*HK1*ATP + k_fa1/K_E*HK1_ATP - k_unact*HK1 + k_act_I*HK1_unact*Input + k_pt11*HK1_RR1s - k_dp11*HK1*RR1s + k_ps11*HK1_RR1s + k_ps12*HK1_RR2s...
    - k_f1*HK1*RR1 + k_f1*K_D1_HK*HK1_RR1 - k_f2*HK1*RR2 + k_f2*K_D2_HK*HK1_RR2- k_deg*HK1;

dx(3) = k_fa1*HK1*ATP - k_fa1/K_E*HK1_ATP - k_p1*HK1_ATP  - k_deg*HK1_ATP - k_unact*HK1_ATP + k_act_I*HK1_unact_ATP*Input;

dx(4) = k_p1*HK1_ATP - k_f1*HK1s*RR1 + k_f1*K_D1*HK1s_RR1 - k_f2*HK1s*RR2 + k_f2*K_D2*HK1s_RR2 - k_unact*HK1s + k_act_I*HK1s_unact*Input - k_deg*HK1s;

dx(5) = - k_f1*HK1s*RR1 + k_f1*K_D1*HK1s_RR1 + k_ps11*HK1_RR1s + k_deRR*RR1s  + beta*PT*(1+alpha*RR1s^2/K1)/(1+RR1s^2/K1)...
    - k_f1*HK1*RR1 + k_f1*K_D1_HK*HK1_RR1- k_deg*RR1 + k_ps11*HK1_unact_RR1s;

dx(6) = k_pt11*HK1_RR1s - k_dp11*HK1*RR1s - k_deRR*RR1s - k_deg*RR1s  - k_dp11*RR1s*HK1_unact;% - 2*k_pbind*RR1s^2*P1 + 2*k_punbind*RR1s2_P1;

dx(7) = - k_f2*HK1s*RR2 + k_f2*K_D2*HK1s_RR2 + k_ps12*HK1_RR2s + k_deRR*RR2s  ...
    - k_f2*HK1*RR2 + k_f2*K_D2_HK*HK1_RR2- k_deg*RR2 + k_ps12*HK1_unact_RR2s;

dx(8) = - k_deRR*RR2s  - k_deg*RR2s ;

dx(9) = k_f1*HK1s*RR1 - k_f1*K_D1*HK1s_RR1 - k_fc*HK1s_RR1 + k_fc*K_c*HK1_RR1s - k_unact*HK1s_RR1 + k_act_I*HK1s_unact_RR1*Input  - k_deg*HK1s_RR1;

dx(10) = k_fc*HK1s_RR1 - k_fc*K_c*HK1_RR1s - k_pt11*HK1_RR1s + k_dp11*HK1*RR1s - k_ps11*HK1_RR1s - k_unact*HK1_RR1s + k_act_I*HK1_unact_RR1s*Input - k_deg*HK1_RR1s;

dx(11) = k_f2*HK1s*RR2 - k_f2*K_D2*HK1s_RR2 - k_fc*HK1s_RR2 + k_fc*K_c*HK1_RR2s -k_unact*HK1s_RR2 + k_act_I*HK1s_unact_RR2*Input - k_deg*HK1s_RR2;

dx(12) = k_fc*HK1s_RR2 - k_fc*K_c*HK1_RR2s - k_ps12*HK1_RR2s - k_unact*HK1_RR2s + k_act_I*HK1_unact_RR2s*Input - k_deg*HK1_RR2s;

dx(14) = k_f1*HK1*RR1 - k_f1*K_D1_HK*HK1_RR1 - k_unact*HK1_RR1 + k_act_I*HK1_unact_RR1*Input - k_deg*HK1_RR1;

dx(15) = k_f2*HK1*RR2 - k_f2*K_D2_HK*HK1_RR2 - k_unact*HK1_RR2 + k_act_I*HK1_unact_RR2*Input - k_deg*HK1_RR2;

dx(16) = k_unact*HK1_ATP - k_act_I*HK1_unact_ATP*Input - k_deg*HK1_unact_ATP;

dx(17) = k_unact*HK1s - k_act_I*HK1s_unact*Input - k_deg*HK1s_unact;

dx(18) = k_unact*HK1s_RR1 - k_act_I*HK1s_unact_RR1*Input - k_deg*HK1s_unact_RR1;

dx(19) = k_unact*HK1_RR1s - k_act_I*HK1_unact_RR1s*Input + k_dp11*RR1s*HK1_unact - k_ps11*HK1_unact_RR1s  - k_deg*HK1_unact_RR1s;

dx(20) = k_unact*HK1s_RR2 - k_act_I*HK1s_unact_RR2*Input - k_deg*HK1s_unact_RR2;

dx(21) = k_unact*HK1_RR2s - k_act_I*HK1_unact_RR2s*Input  - k_ps12*HK1_unact_RR2s  - k_deg*HK1_unact_RR2s;

dx(22) = k_unact*HK1_RR1 - k_act_I*HK1_unact_RR1*Input - k_deg*HK1_unact_RR1;

dx(23) = k_unact*HK1_RR2 - k_act_I*HK1_unact_RR2*Input - k_deg*HK1_unact_RR2;

dx(24) = -k_deg_I*Input;
end
