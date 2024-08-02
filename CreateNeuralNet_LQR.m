function [w1, b1] = CreateNeuralNet_LQR(InputData, OutputData,TrainingIters)

% Initialize w1, b1
w1 = ;
b1 = ;

for i=1:TrainingIters
for k = 1:length(InputData)
%% 1. Forward Propogation
z1 = ;

%% 2. Backward Propogation
dC_dw1 = ;
dC_db1 = ;

%% 3. Update Weights and Biases
alpha = ; % learning rate

w1 = ;
b1 = ;

end
end