function [conv_output]=op_conv_2d(input,weight,bias,dil_opt)
    %parameters
    length_input=size(input,1);
    length_input2=size(input,2);
    num_feature_map=size(input,3);
    kernel_size=size(weight,1);
    dilaRate=3;
    
    %Zero-padding "option: SAME"
    pad_size1=kernel_size-1;
    pad_size2=3*(kernel_size-1);
    pad_input=zeros(length_input+pad_size1,length_input2+pad_size2,num_feature_map);
    pad_input((pad_size1/2)+1:length_input+(pad_size1/2),(pad_size2/2)+1:length_input2+(pad_size2/2),:)=input(:,:,1:num_feature_map);
    
    %Convolution Matrix calculation
    for i=1:size(pad_input,1)-pad_size1
        for j=1:size(pad_input,2)-pad_size2
            if dil_opt==1
                if kernel_size==1
                    temp_input=pad_input(1+(i-1):kernel_size+(i-1),1+(j-1):kernel_size+(j-1),:);
                else
                    temp_input=pad_input(1+(i-1):kernel_size+(i-1),1+(j-1):dilaRate:kernel_size+(j-1)+dilaRate+1,:);
                end
            else
                temp_input=pad_input(1+(i-1):kernel_size+(i-1),1+(j-1):kernel_size+(j-1),:);
            end

            conv_output(i,j,:,:)=reshape(sum(sum(sum(repmat(temp_input,1,1,1,length(bias)).*weight),2),3),1,1,length(bias))+reshape(bias,1,1,length(bias));
            %conv_input(i,:,:)=sum(repmat(temp_input,1,1,length(bias)).*weight)+reshape(bias,1,1,length(bias));
        end
    end
    
end