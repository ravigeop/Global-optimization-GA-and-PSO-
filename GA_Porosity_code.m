clc; clear; close all;
global one_composite_trace Model_composite Wavelet
for i=1:50
FitnessFcn = @Global_optimization_porosity; % Objective function
 Seismic = load('observed.txt');            % Seismic data
 one_composite_trace = Seismic(:,i);
    Model = load('model_porosity.txt');          % Initial poristy model
     Model_composite = Model(:,i)./100;
AI_wavelet = read_segy_file('statistical_wavelet.sgy');
AI_wavelet_final = AI_wavelet.traces;
porosity_wavelet= AI_wavelet_final.*(-0.14);
Wavelet=porosity_wavelet;
Generations_Data=400;
  % Genetic Algorithm options
options = gaoptimset;
options = gaoptimset(options,'MigrationDirection', 'both');
options = gaoptimset(options,'Generations', Generations_Data);
 options = gaoptimset(options,'CreationFcn', @gacreationuniform);
 options = gaoptimset(options,'SelectionFcn', @selectionuniform);
 options = gaoptimset(options,'CrossoverFcn', {  @crossoverheuristic [] });
 options = gaoptimset(options,'MutationFcn', @mutationadaptfeasible);
options = gaoptimset(options,'Display', 'iter');
% options = gaoptimset(options,'PlotFcn', {@gaplotbestf @gaplotstopping});
nvars = 101;
numberOfVariables = nvars;
LB = Model_composite-0.06;
UB = Model_composite+0.15;
[x,fval,exitflag,output,population,score] = ga(FitnessFcn,numberOfVariables,[],[],[],[],LB,UB,[],[],options);

% Save the inverted Porosity values
AI_inverted(:, i) = x;
Traces = i+1
save GA_inverted_porosity.txt AI_inverted -ascii
end