
%%First 8 measurments in mic_location are x and y positions for the "good"
%%setup
clc; clear; close all;


load('dataset_1_calibration.mat');  


[bias, std_dev, variance] = task1(tphat);

disp('Bias for each sensor:');
disp(bias);
disp('Standard deviation for each sensor:');
disp(std_dev);
disp('Variance for each sensor:');
disp(variance);

load('dataset_1_exp2.mat');

