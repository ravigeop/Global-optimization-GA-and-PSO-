clc; clear; close all;
%% composite_trace
wlog_01_08 = read_las_file('01-08_logs.las');
rho_01_08 =  wlog_01_08.curves(1054:1434,2);
Imp_01_08=rho_01_08.*wlog_01_08.curves(1054:1434,3);
Porosity_new = (2.65-rho_01_08)/(2.65-1.1);
% wlog_09_08 = read_las_file('09-08_logs.las');
%   rho_09_08 =  wlog_09_08.curves(1015:1373,2);
%   Imp_09_08=rho_09_08.*wlog_09_08.curves(1015:1373,3);
  
for i=1:380
 r_phi(i) = 0.5.*((log10(Porosity_new(i+1)/(1-Porosity_new(i+1))))-log10(Porosity_new(i)/(1-Porosity_new(i))));
end
 r_phi= r_phi';

Imp=rho_01_08.*wlog_01_08.curves(1054:1434,3);
for i=1:380
r_z(i)=0.5.*(log10(Imp(i+1))-log10(Imp(i)));
end
r_z=r_z';
Time = linspace(900,1100,381)';
figure
subplot(1,2,1)
plot(Imp,Time)
set(gca,'YDir','reverse')
ylabel('Time (ms)')
xlabel('Impedance')
subplot(1,2,2)
plot(Porosity_new,Time)
set(gca,'YDir','reverse')
ylabel('Time (ms)')
xlabel('Porosity')
figure
scatter(r_phi,r_z);
ylabel('Acoustic reflectivity')
xlabel('Porosity reflectivity')
% wavelet plot
 %%
Inverted_AI_GA =  load('GA_Inverted_impedance.txt');
Inverted_AI_GA_final = Inverted_AI_GA(1:101, 42:42);
wlog = read_las_file('01-08_logs.las');
Time = linspace(900,1100,101)';
AI_Model = load('model.txt'); 
figure;
subplot(1,4,1)
plot(AI_Model(:,42:42), Time,'b')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
hold on
Aimp_2142 = (wlog.curves(1054:1434,2).*wlog.curves(1054:1434,3));
plot(Aimp_2142,wlog.curves(1054:1434,4),'k')
hold on
plot(Inverted_AI_GA_final, Time,'r','LineWidth',1.0)
ylim([900 1100])
hold on
plot(AI_Model(:,42:42)-2000, Time,':b', 'LineWidth', 1)
hold on
plot(AI_Model(:,42:42)+2000, Time,':b', 'LineWidth', 1)
ylabel('Time (ms)')
xlabel('Impedance')
legend('Model', 'Well log','Inverted')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
grid on
grid minor
hold on
title('GA');
subplot(1,4,2)
Inverted_AI_PSO =  load('Inverted_AI_PSO.txt');
Inverted_AI_PSO_final = Inverted_AI_PSO(1:101, 42:42);
wlog = read_las_file('01-08_logs.las');
Time = linspace(900,1100,101)';
AI_Model = AI_Model(:,42:42);
plot(AI_Model, Time,'b')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
hold on
Aimp_2142 = (wlog.curves(1054:1434,2).*wlog.curves(1054:1434,3));
plot(Aimp_2142,wlog.curves(1054:1434,4),'k')
hold on
plot(Inverted_AI_PSO_final, Time,'r','LineWidth',1.0)
ylim([900 1100])
hold on
plot(AI_Model-2000, Time,':b', 'LineWidth', 1)
hold on
plot(AI_Model+2000, Time,':b', 'LineWidth', 1)
ylabel('Time (ms)')
xlabel('Impedance')
legend('Model', 'Well log','Inverted')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
grid on
grid minor
title('PSO');
Inverted_Porosity_1_50 =  load('GA_inverted_porosity.txt');
porosity=Inverted_Porosity_1_50; 
Inverted_Porosity = porosity(1:101, 42:42);
wlog = read_las_file('01-08_logs.las');
Time = linspace(900,1100,101)';
porosity_model = load('model_porosity.txt');    
Porosity_model=porosity_model./100;
Porosity_Model=Porosity_model(1:101, 42:42);
subplot(1,4,3)
plot(Porosity_Model, Time,'b')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
hold on
Aimp_2142 = (wlog.curves(1054:1434,2).*wlog.curves(1054:1434,3));
plot( Porosity_new,wlog.curves(1054:1434,4),'k')
hold on
plot(Inverted_Porosity, Time,'r','LineWidth',1.0)
ylim([900 1100])
hold on
plot(Porosity_Model-0.15, Time,':b', 'LineWidth', 1)
hold on
plot(Porosity_Model+0.15, Time,':b', 'LineWidth', 1)
ylabel('Time (ms)')
xlabel('Porosity')
legend('Model', 'Well log','Inverted')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
grid on
grid minor
subplot(1,4,4)
Inverted_Porosity_1_50 =  load('Inverted_porosity_PSO.txt');
porosity=Inverted_Porosity_1_50; 
Inverted_Porosity = porosity(1:101, 42:42);
wlog = read_las_file('01-08_logs.las');
Time = linspace(900,1100,101)';
plot(Porosity_Model, Time,'b')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
hold on
Aimp_2142 = (wlog.curves(1054:1434,2).*wlog.curves(1054:1434,3));
plot( Porosity_new,wlog.curves(1054:1434,4),'k')
hold on
plot(Inverted_Porosity, Time,'r','LineWidth',1.0)
ylim([900 1100])
hold on
plot(Porosity_Model-0.15, Time,':b', 'LineWidth', 1)
hold on
plot(Porosity_Model+0.15, Time,':b', 'LineWidth', 1)
ylabel('Time (ms)')
xlabel('Porosity')
legend('Model', 'Well log','Inverted')
set(findobj(gcf,'type','axes'),'FontName','Times New Roman','FontSize',11,'FontWeight','Normal', 'LineWidth', 0.80);
set(gca,'YDir','reverse')
set(gca,'XAxisLocation','top')
grid on
grid minor