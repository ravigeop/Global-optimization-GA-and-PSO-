clc; clear; close all;
global one_composite_trace Model_composite Wavelet
 for i=1:50
FitnessFcn = @Global_optimization; % Objective function
numberOfVariables = 101;
 Seismic = load('observed.txt');     % Seismic data
one_composite_trace = Seismic(:,i);
Model = load('model.txt');           % Initial Impedance model
Model_composite = Model(:,i);
wavelet = read_segy_file('statistical_wavelet.sgy');
Wavelet = wavelet.traces;

 % Define variable bounds 
LB = Model_composite-1500;   % Lower bound
UB = Model_composite+1500;   % Upper bound
MaxIter_Data = 400;

% Particle swarm optimization options
options = optimoptions('particleswarm','MaxIter',MaxIter_Data);
 options = optimoptions(options,'CreationFcn', @pswcreationuniform);
options = optimoptions(options,'Display','iter');
%  options = optimoptions(@particleswarm,'PlotFcn','pswplotbestf')
[x,fval] = particleswarm(FitnessFcn,numberOfVariables,LB,UB,options);

% Save the inverted impedance values
AI_inverted(:, i) = x;
Traces = i+1
save Inverted_AI_PSO.txt AI_inverted -ascii
 end