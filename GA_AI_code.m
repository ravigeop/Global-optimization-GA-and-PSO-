clc; clear; close all;
for i = 1:50
    global one_composite_trace Model_composite Wavelet
    FitnessFcn = @Global_optimization;  % Objective function
    numberOfVariables = 101;            
     Seismic = load('observed.txt');     % Seismic data
     one_composite_trace = Seismic(:,i);
     Model = load('model.txt');          % Initial Impedance model
     Model_composite = Model(:,i);
     wavelet = read_segy_file('statistical_wavelet.sgy');
     Wavelet = wavelet.traces;
    Generations_Data = 400;

    % Genetic Algorithm options
    options = gaoptimset;
    options = gaoptimset(options, 'MigrationDirection', 'both');
    options = gaoptimset(options, 'Generations', Generations_Data);
    options = gaoptimset(options, 'CreationFcn', @gacreationuniform);
    options = gaoptimset(options, 'SelectionFcn', @selectionuniform);
    options = gaoptimset(options, 'CrossoverFcn', {@crossoverheuristic, []});
    options = gaoptimset(options, 'MutationFcn', @mutationadaptfeasible);
    options = gaoptimset(options, 'Display', 'iter'); 
    
    % Define variable bounds
    LB = Model_composite - 1500;   % Lower bound
    UB = Model_composite + 1500;
    [x, fval, exitflag, output, population, score] = ga(FitnessFcn, numberOfVariables, [], [], [], [], LB, UB, [], [], options);
    % Save the inverted impedance values
    AI_inverted(:, i) = x;
    Traces = i + 1
    save GA_Inverted_impedance.txt AI_inverted -ascii;
end
