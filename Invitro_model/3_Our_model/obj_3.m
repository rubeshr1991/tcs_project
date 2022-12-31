function y=obj_3(par,x_data)

warning('off')
par = real(par);

% INITIAL CONDITION FOR THE ODE MODEL
HK1         = 0;
HK1s        = 700;
RR1         = par(end);
RR1s        = 0;
RR2         = par(end);
RR2s        = 0;
HK1sRR1     = 0;
HK1RR1s     = 0;
HK1sRR2     = 0;
HK1RR2s     = 0;
ATP         = 100000-700;
HK1_ATP     = 0;
iP          = 0;
HK1RR1     = 0;
HK1RR2     = 0;

x_init0 = [HK1, HK1s, RR1, RR1s, 0, RR2s, HK1sRR1, HK1RR1s, HK1sRR2, HK1RR2s,HK1RR1,HK1RR2,...
        ATP, HK1_ATP, iP]; % initial condition

[~,y1]=ode15s(@model_tcs3,[0 2 4 8 16],x_init0,[],par);

HK1s_y1 = y1(:,2)+y1(:,7)+y1(:,9);
RR1s_y1 = y1(:,4);

x_init0 = [HK1, HK1s, RR1, RR1s, RR2, RR2s, HK1sRR1, HK1RR1s, HK1sRR2, HK1RR2s,HK1RR1,HK1RR2,...
        ATP, HK1_ATP, iP]; % initial condition

[~,y1]=ode15s(@model_tcs3,[0 2 4 8 16],x_init0,[],par);

HK1s_y2 = y1(:,2)+y1(:,7)+y1(:,9);
RR1s_y2 = y1(:,4);

x_init0 = [HK1, HK1s, 0, RR1s, RR2, RR2s, HK1sRR1, HK1RR1s, HK1sRR2, HK1RR2s,HK1RR1,HK1RR2,...
        ATP, HK1_ATP, iP]; % initial condition

[~,y1]=ode15s(@model_tcs3,[0 2 4 8 16],x_init0,[],par);

HK1s_y3 = y1(:,2)+y1(:,7)+y1(:,9);

y = [HK1s_y1;RR1s_y1;HK1s_y2;RR1s_y2;HK1s_y3];


end
