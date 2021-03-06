%% Convolution layers
%% 2018.04.18 Byeong Keun Kang
%%
%% Input: data_rc [1 x 105(input length) x 1]
%%        weight
%%        bias
%%        batch
%% Output: conv_out [3(3 types of models) x 32(features)]


function conv_out=convolution_layers_1D(data_rc,weight,bias,batch,tep,dila_opt)

%% Network Information
conv_layer_num=5; %number of conv_layers

%% 1. Conv layers for original signal

conv1_input=data_rc';
for convi=1:conv_layer_num
    eval(['temp_weight=weight.conv' num2str(convi) ';']);
    eval(['temp_bias=bias.conv' num2str(convi) ';']);
    eval(['temp_batch_g=batch.conv' num2str(convi) '_gamma;']);
    eval(['temp_batch_b=batch.conv' num2str(convi) '_beta;']);
    eval(['temp_batch_m=batch.conv' num2str(convi) '_m;']);
    eval(['temp_batch_v=batch.conv' num2str(convi) '_v;']);

    if dila_opt==1
        conv_out=op_conv_1d(conv1_input,temp_weight,temp_bias,dila_opt);
    else
        conv_out=op_conv_1d(conv1_input,temp_weight,temp_bias,dila_opt);
    end
    % Batch Normalization
    batch_conv=batch_norm(conv_out,temp_batch_g,temp_batch_b,temp_batch_m,temp_batch_v);
    % Activation function: ReLU
    conv_input=max(batch_conv,0);

    if convi~=conv_layer_num
        length_input=size(conv_input,1);
        pooling_stride=2;
        %Max-pooling
        if rem(length_input,pooling_stride)==0
            conv1_input=max(conv_input(1:pooling_stride:end,:),conv_input(2:pooling_stride:end,:));
        else
            conv_input(end+1,:)=0;
            conv1_input=max(conv_input(1:pooling_stride:end,:),conv_input(2:pooling_stride:end,:));
        end
    else
        % Average pooling
        conv1_input=mean(conv_input);
    end
            
end

conv_out1=[];
for i=1:size(conv1_input,1)
    for j=1:size(conv1_input,2)
        for k=1:size(conv1_input,3)
            conv_out1=[conv_out1 conv1_input(i,j,k)];
        end
    end
end

% conv_out1=reshape(conv1_input,1,size(conv1_input,2)*size(conv1_input,3));
clear conv1_input

conv_out=[conv_out1 tep];%[[conv_out1 tep];[conv_out2 tep];[conv_out3 tep]];
end