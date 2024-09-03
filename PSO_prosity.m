 clc; clear; close all;
 global one_composite_trace Model_composite Wavelet
 for i=1:50
FitnessFcn = @Global_optimization_porosity;
numberOfVariables = 101;
FitnessFcn = @Global_optimization_porosity; % Objective function
 Seismic = load('observed.txt');            % Seismic data
 one_composite_trace = Seismic(:,i);
    Model = load('model_porosity.txt');          % Initial poristy model
     Model_composite = Model(:,i)./100;
AI_wavelet = read_segy_file('statistical_wavelet.sgy');
AI_wavelet_final = AI_wavelet.traces;
porosity_wavelet= AI_wavelet_final.*(-0.14);
Wavelet=porosity_wavelet;

LB = Model_composite-0.06;
UB = Model_composite+0.15;
MaxIter_Data = 400;

% Particle swarm optimization options
options = optimoptions('particleswarm','MaxIter',MaxIter_Data)
 options = optimoptions(options,'CreationFcn', @pswcreationuniform);
options = optimoptions(options,'Display','iter')
% options = optimoptions(@particleswarm,'PlotFcn','pswplotbestf')
options = optimoptions(options,'FunValCheck', 'on');
%  options = optimoptions('Stop',true);
[x,fval] = particleswarm(FitnessFcn,numberOfVariables,LB,UB,options);

% Save the inverted Porosity values
AI_inverted(:, i) = x;
layer = i+1
save Inverted_porosity_PSO.txt AI_inverted -ascii
 end