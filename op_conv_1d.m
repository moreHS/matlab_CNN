function [conv_output]=op_conv(input,weight,bias,dil_opt)
    %parameters
    length_input=size(input,1);
    num_feature_map=size(input,2);
    kernel_size=size(weight,1);
    conv_stride=1; %Set this value
    dilaRate=3;
    
    %Zero-padding "option: SAME"
    pad_size=kernel_size-1;
    pad_input=zeros(length_input+kernel_size-1,num_feature_map);
    pad_input((pad_size/2)+1:length_input+(pad_size/2),:)=input(:,1:num_feature_map);
    
    %Convolution Matrix calculation
    for i=1:size(pad_input,1)-(kernel_size-1)
        if dil_opt==1
            if kernel_size==1
                temp_input=pad_input(1+(i-1):kernel_size+(i-1),:);
            else           
                temp_input=pad_input(1+(i-1):dilaRate:kernel_size+(i-1)+dilaRate+1,:);
            end
        else
            temp_input=pad_input(1+(i-1):kernel_size+(i-1),:);
        end
        conv_output(i,:,:)=sum(sum(repmat(temp_input,1,1,length(bias)).*weight),2)+reshape(bias,1,1,length(bias));
        %conv_input(i,:,:)=sum(repmat(temp_input,1,1,length(bias)).*weight)+reshape(bias,1,1,length(bias));
    end
    
end