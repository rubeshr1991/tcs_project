clear all
clc
close all
% parpool(28)

%% 
par_data = {...
%     'log k_fa1'     ,-6         ,0           ,4     ;...
%     'log k_f1'   	,-6         ,0           ,4     ;...
%     'log k_fc'      ,-6         ,0           ,4     ;...
%     'log k_p'    	,-6         ,0           ,4     ;...
    'log k_pRR'   	,-6         ,0           ,4     ;...
    'log k_dRR'    ,-6         ,0           ,4     ;...
    'log k_dpRRnc'  	,-6         ,0           ,4     ;...
%     'log k_f 2'    	,-6         ,0           ,4     ;...
%     'log k_ps12'    ,-6         ,0           ,4     ;...
%     'log K_D1_HK'    	,-6         ,0           ,4     ;...
%     'HK_0'          ,0          ,3000        ,5000  ;...
    'RR_0'      	,100        ,700         ,10000 };

    
par_name = par_data(:,1);

b0 = cell2mat(par_data(:,3));
lb = cell2mat(par_data(:,2));
ub = cell2mat(par_data(:,4));

b1 = b0;
% load('Fit_all_1.mat','par2');b1 = par2; clear par2;
lb1 = lb+(b1-lb)*0;
ub1 = ub+(b1-ub)*0;

%%
HK1s_0 = 700;

load('Fit1_data_new')
x_data1 = [t_data; t_data+20];
HK1s_data_fit1 = HK1s_data;
RR1s_data_fit1 = RR1s_data;
y_data1 = [HK1s_data; RR1s_data]*HK1s_0;

load('Fit2_data_new')
x_data2 = [t_data+40; t_data+60];
HK1s_data_fit2 = HK1s_data;
RR1s_data_fit2 = RR1s_data;
y_data2 = [HK1s_data; RR1s_data]*HK1s_0;

load('Fit3_data_new')
x_data3 = [t_data+80];
HK1s_data_fit3 = HK1s_data;
y_data3 = [HK1s_data]*HK1s_0;

x_data = [x_data1; x_data2; x_data3];
y_data = [y_data1; y_data2; y_data3];


for mm = 1:10
    ms = MultiStart('UseParallel',true,'Display','iter');

    problem = createOptimProblem('lsqcurvefit','x0',b1,'objective',...
     @(param,kk)obj_3(param,kk),...
     'lb',lb1,'ub',ub1,'xdata',x_data,'ydata',(y_data));

    [par,errormulti] = run(ms,problem,200);

    par = real(par);
    
    [par2,resnorm,resid,exitflag,output,lambda,J] = ...
        lsqcurvefit(@(param,kk)obj_3(param,kk)...
        ,par,x_data,y_data,lb1,ub1);
    ci_J = nlparci(par2,resid,'Jacobian',J,'alpha',0.05); % 95% CI, CI level = 1-alpha

    
    save(['Fit_all_' num2str(mm) '.mat'])
    %% 
     % INITIAL CONDITION FOR THE ODE MODEL
    HK1         = 0;
    HK1s        = 700;
    RR1         = par(end);
    RR1s        = 0;
    RR2         = par(end);
    ATP         = 100000-700;
    HK1_ATP     = 0;

    x_init0 = [HK1, HK1s, RR1, RR1s, 0, ...
            ATP, HK1_ATP]; % initial condition

    [t1,y1]=ode15s(@model_tcs3,[0 20],x_init0,[],par2);

    x_init0 = [HK1, HK1s, RR1, RR1s, RR2,...
            ATP, HK1_ATP]; % initial condition

    [t2,y2]=ode15s(@model_tcs3,[0 20],x_init0,[],par2); 

    x_init0 = [HK1, HK1s, 0, RR1s, RR2,...
            ATP, HK1_ATP]; % initial condition

    [t3,y3]=ode15s(@model_tcs3,[0 20],x_init0,[],par2); 
    
  
    
    figure('position',[50 50 1400 500])
    subplot(1,3,1)
    hold on
    plot(t_data,HK1s_data_fit1,'bs')
    plot(t1,(y1(:,2))/HK1s_0,'b');
    plot(t_data,RR1s_data_fit1,'rs')
    plot(t1,(y1(:,4))/HK1s_0,'r');
    ylim([0 1])
    
    subplot(1,3,2)
    hold on
    plot(t_data,HK1s_data_fit2,'bs')
    plot(t2,(y2(:,2))/HK1s_0,'b');
    plot(t_data,RR1s_data_fit2,'rs')
    plot(t2,(y2(:,4))/HK1s_0,'r');
    ylim([0 1])
    
    subplot(1,3,3)
    hold on
    plot(t_data,HK1s_data_fit3,'bs')
    plot(t3,(y3(:,2))/HK1s_0,'b');
    plot(t3,(y3(:,4))/HK1s_0,'r');
    ylim([0 1])


    b1 = par;clear par;
end

%%


