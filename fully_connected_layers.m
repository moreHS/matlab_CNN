%% Fully-connected layers
%% 2018.04.18 Byeong Keun Kang
%%
%% Input: conv_out [1(3 types of models) x 32(features)]
%%        weight
%%        bias
%%        batch
%% Output: Blood algorithm value (1 x 3(3 types of models))


function fc_out_m1=fully_connected_layers(conv_out,weight,bias,batch)
%% Network Information
fc_layer_num=3; %number of fc_layers

%% 1. Fully_Connected layer for original signal
fc_input=conv_out(1,:);
for fci=1:fc_layer_num
    exp_weight=['temp_weight=weight.fc' num2str(fci) ';'];
    exp_bias=['temp_bias=bias.fc' num2str(fci) ';'];
    eval(exp_weight);
    eval(exp_bias);
    
    
    if fci~=fc_layer_num
        exp_batch_g=['temp_batch_g=batch.fc' num2str(fci) '_gamma;'];
        exp_batch_b=['temp_batch_b=batch.fc' num2str(fci) '_beta;'];
        exp_batch_m=['temp_batch_m=batch.fc' num2str(fci) '_m;'];
        exp_batch_v=['temp_batch_v=batch.fc' num2str(fci) '_v;'];
        eval(exp_batch_g);
        eval(exp_batch_b);
        eval(exp_batch_m);
        eval(exp_batch_v);
        [layer_output]=op_fc(fc_input,temp_weight,temp_bias,temp_batch_g,temp_batch_b,temp_batch_m,temp_batch_v);
    else
        [layer_output]=op_fc(fc_input,temp_weight,temp_bias);
    end
    fc_input=layer_output;
    clear layer_output temp_weight temp_bias
end

fc_out_m1=fc_input;


end