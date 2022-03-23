
function [result, conv_out]=CNN_feedforward(data,dila_opt) % Outlier 결과 출력위해 ER, ER2 부분 추가
%% 1. Data load & preprocessing
%load weight & bias & batch values
load('weight')

%data preprocessing
tep=temperature;
if size(data,2)==1
    data=data';
end

%% input Sampling 선택
[data_rc]=input_reconstruction_2d_3(data); % 1d signal을 2d 형태로 재배치
% [data_rc]=input_reconstruction_2sam(data); % 1d signal을 1/2 down sampling

%% 2. Convolution Layer
% input type (1d, 2d)에 따라 convolution layer 선택
conv_out=convolution_layers_2D(data_rc,weight,bias,batch,tep,dila_opt);
% conv_out=convolution_layers_1D(data_rc,weight,bias,batch,tep,dila_opt);


%% 3. Fully-connected Layers
result=fully_connected_layers(conv_out,weight,bias,batch);








