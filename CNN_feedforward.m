
function [result, conv_out]=CNN_feedforward(data,dila_opt) % Outlier ��� ������� ER, ER2 �κ� �߰�
%% 1. Data load & preprocessing
%load weight & bias & batch values
load('weight')

%data preprocessing
tep=temperature;
if size(data,2)==1
    data=data';
end

%% input Sampling ����
[data_rc]=input_reconstruction_2d_3(data); % 1d signal�� 2d ���·� ���ġ
% [data_rc]=input_reconstruction_2sam(data); % 1d signal�� 1/2 down sampling

%% 2. Convolution Layer
% input type (1d, 2d)�� ���� convolution layer ����
conv_out=convolution_layers_2D(data_rc,weight,bias,batch,tep,dila_opt);
% conv_out=convolution_layers_1D(data_rc,weight,bias,batch,tep,dila_opt);


%% 3. Fully-connected Layers
result=fully_connected_layers(conv_out,weight,bias,batch);








