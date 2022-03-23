%% Batch-normalization
%% 2018.01.04 ByeongKeun Kang

%input: data_point by filter number
%gamma: batch-normalization gamma value
%beta: batch-normalization beta value
%batch_m: batch-normalization population mean
%batch_v: batch-normalization population variance
function batch_conv=batch_norm_2d(conv_out,gamma,beta,batch_m,batch_v)
    esp=0.001; %epsilon
    
    for i=1:length(batch_m)
        bm(:,:,i)=repmat(batch_m(i),size(conv_out,1),size(conv_out,2));
        bv(:,:,i)=repmat(batch_v(i),size(conv_out,1),size(conv_out,2));
        bg(:,:,i)=repmat(gamma(i),size(conv_out,1),size(conv_out,2));
        bb(:,:,i)=repmat(beta(i),size(conv_out,1),size(conv_out,2));
    end

    %Subtract mean vector
    xmu=conv_out-bm;
    
    %Variance(add epsilon for numerical stability)
    conv_sqrtvar=sqrt(bv+esp);
    
    %Normalize
    xhat=xmu./conv_sqrtvar;
    
    %Transformation
        
    batch_conv=bg.*xhat+bb;
end