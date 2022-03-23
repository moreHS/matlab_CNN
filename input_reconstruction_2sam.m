%% Reconstruction of input signal - GDH-Flat type
%% 2018.04.18 ByeongKeun Kang

%[Output]
% 1. Origianl signal
function [data_rc]=input_reconstruction_2sam(input)
    vref=input(2587);
    %remove offset
    if input(1300)>32500
        input(1:2250)=((input(1:2250)-32500));
    else
        input(1:2250)=((input(1:2250)+268));
    end
    
    %original signal
    input_1=input([346:2:1302]);

    %reconstructed signal
    data_rc=input_1;
end