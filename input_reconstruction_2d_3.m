%% Reconstruction of input signal - GDH-Flat type
%% 2018.04.18 ByeongKeun Kang

%[Output]
% 1. Origianl signal
function [data_rc]=input_reconstruction_2d_3(input)
    vref=input(2587);
    %remove offset
    if input(1300)>32500
        input(1:2250)=((input(1:2250)-32500));
    else
        input(1:2250)=((input(1:2250)+268));
    end
    
    %original signal
    input_1=input([344:30:1302]);
    input_2=input([344:30:1302]+2);
    input_3=input([344:30:1302]+4);
    input_4=input([344:30:1302]+6);
    input_5=input([344:30:1302]+8);
    input_6=input([344:30:1302]+10);
    input_7=input([344:30:1302]+12);
    input_8=input([344:30:1302]+14);
    input_9=input([344:30:1302]+16);
    input_10=input([344:30:1302]+18);
    input_11=input([344:30:1302]+20);
    input_12=input([344:30:1302]+22);
    input_13=input([344:30:1302]+24);
    input_14=input([344:30:1302]+26);
    input_15=input([344:30:1302]+28);

    %reconstructed signal
    data_rc=[input_2; input_3; input_4; input_5; input_6; input_7; input_8; input_9; input_10; input_11; input_12; input_13; input_14; input_15];
end