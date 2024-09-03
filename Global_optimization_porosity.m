function RMSE = Global_optimization(optimiseMe)
global one_composite_trace Model_composite Wavelet
Phi = optimiseMe';
len = length(Phi);
for i=1:(len-1)
  r_phi(i) = 0.5.*((log10(Phi (i+1)/(1-Phi (i+1))))-log10(Phi (i)/(1-Phi (i))));
end

r_phi = r_phi';
r_phi = [r_phi; 0];
synth_modeled = conv(r_phi,Wavelet,'same');
synth_observed = one_composite_trace;
Z_mod = Phi;
 Z_pri = Model_composite;
   RMSE = sum((synth_modeled-synth_observed).^2)/len;
%   RMSE = sqrt(sum((synth_modeled-synth_observed).^2))/101+sqrt(sum((Z_mod-Z_pri).^2))/101;
%   RMSE = (sum(abs(synth_observed-synth_modeled))/sum(abs(synth_observed)))+(sum(abs(Z_pri-Z_mod))/(sum(abs(Z_pri))));
diary('GA_porosity_error.txt');
