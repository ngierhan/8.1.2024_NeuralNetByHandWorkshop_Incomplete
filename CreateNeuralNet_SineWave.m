function [W, B] = CreateNeuralNet_SineWave(InputData, OutputData, h,TrainingIters)

% Initialize weights and biases
w1 = ;
b1 = ;
w2 = ;
b2 = ;
w3 = ;
b3 = ;

for i = 1:TrainingIters
for k = 1:length(InputData)
%% 1. Forward Propogation
z1 = ;
H1 = ;
z2 = ;
H2 = ;
z3 = ;
o = ;

%% 2. Backward Propogation
% Error = (o - OutputValue)^2
dC_dw3 = ;

diffH1 = [];
diffH2 = [];
for j = 1:length(H1)
if H1(j) == 0
    diffH1(j,1) = ;
else 
    diffH1(j,1) = ;
end
if H2(j) == 0
    diffH2(j,1) = ;
else 
    diffH2(j,1) = ;
end
end
dC_dw2 = ;
dC_dw1 = ;

dC_db3 = ;
dC_db2 = ;
dC_db1 = ;

%% 3. Update Weights and Biases
alpha = ; % learning rate

w1 = ;
w2 = ;
w3 = ;
b1 = ;
b2 = ;
b3 = ;

end
end
W = {w1,w2,w3};
B = {b1,b2,b3};

