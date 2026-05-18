%% TSRT14, Lab 2: Orientation
% _This lab report describes the experiences made while working with lab 2
% in TSRT14 Sensor Fusion._
%
%% *Group members:*
%
% # NN1 (001208-NNNN), simma047
% # NN2 (YYMMDD-NNNN), andno773
%
%% _Usage_
% _This file is intended to be a template for reporting the results on lab
% 2. Use the function names as indicated in the preparatory lab work (these
% are included at appropriate places), and copy filterTempate.m into
% ekfFilter.m before starting to make your changes (it will be included at
% the end of the report for reference)._
%
% _There is no need to be talkative when answering the questions, assume
% that the person reading the report has read the lab instructions. The
% purpose is to show that you have been able to observe and experience the
% important aspects of the lab and do not miss out on anything important._
%
% _Use the different cells in this file to collect data for the plots you
% are asked for in each steps of the lab. Running the cells interactively
% will collect a dataset, which is then saved in |DATAFILE.mat|. The
% collection of datasets are then extracted when publishing this file,
% to make a report you can hand in._
%
% _Before publishing, remove any and all text in italic (lines starting and
% ending with an underscore (_)) to minimize the report length. Make sure to
% publish to pdf._

if inpublish  % Load saved data when publishing.
  load DATAFILE
end


%% 1. Connect the phone with your lab computer
% *No need to document this step.*

%% 2. Get to know your data
% *Shortly describe your observations?*

if ~inpublish  % Don't recollect data during publish
  [xhat2, meas2] = ekfFilter();
  save DATAFILE -append xhat2 meas2
end
%%
[xhat, meas] = filterTemplate();

%% 
acc = meas.acc;
gyr = meas.gyr;
mag = meas.mag;
t = meas.t;

start_cut=520;
end_cut=100;

acc = acc(1:3, start_cut:end-end_cut);
mag = mag(1:3, start_cut:end-end_cut);
gyr = gyr(1:3, start_cut:end-end_cut);
t = t(1,start_cut:end-end_cut);

% Accleration
acc_mean = mean(acc(:, ~any(isnan(acc), 1)), 2)
acc_cov = cov(acc(:, ~any(isnan(acc), 1))')

% acc_mean(1) = 0;
% acc_mean(2) = 0;
% acc_mean

figure(1);
subplot(3,2,1);
histfit(acc(1,:), 20);
title('Acc X');

subplot(3,2,3);
histfit(acc(2,:), 20);
title('Acc Y');

subplot(3,2,5);
histfit(acc(3,:), 20);
title('Acc Z');

subplot(3,2,2);
plot(t, acc(1,:));
title('Acc X - Time');

subplot(3,2,4);
plot(t, acc(2,:));
title('Acc Y - Time');

subplot(3,2,6);
plot(t, acc(3,:));
title('Acc Z - Time');
pause;

% Magnetometer
mag_mean = mean(mag(:, ~any(isnan(mag), 1)), 2)
mag_cov = cov(mag(:, ~any(isnan(mag), 1))')

close();
figure(2);
subplot(3,2,1);
histfit(mag(1,:), 20);
title('Mag X');

subplot(3,2,3);
histfit(mag(2,:), 20);
title('Mag Y');

subplot(3,2,5);
histfit(mag(3,:), 20);
title('Mag Z');

subplot(3,2,2);
plot(t, mag(1,:));
title('Mag X - Time');

subplot(3,2,4);
plot(t, mag(2,:));
title('Mag Y - Time');

subplot(3,2,6);
plot(t, mag(3,:));
title('Mag Z - Time');
pause;

% Gyroscope
gyr_mean = mean(gyr(:, ~any(isnan(gyr), 1)), 2)
gyr_cov = cov(gyr(:, ~any(isnan(gyr), 1))')

close();
figure(3);
subplot(3,2,1);
histfit(gyr(1,:), 20);
title('Gyr X');

subplot(3,2,3);
histfit(gyr(2,:), 20);
title('Gyr Y');

subplot(3,2,5);
histfit(gyr(3,:), 20);
title('Gyr Z');

subplot(3,2,2);
plot(t, gyr(1,:));
title('Gyr X - Time');

subplot(3,2,4);
plot(t, gyr(2,:));
title('Gyr Y - Time');

subplot(3,2,6);
plot(t, gyr(3,:));
title('Gyr Z - Time');

pause;
close();

% Create structs
calAcc = struct('m', acc_mean, 'R', acc_cov)
calMag = struct('m', mag_mean, 'R', mag_cov)
calGyr = struct('m', gyr_mean, 'R', gyr_cov)

%%
% *Result*
%
% * _A histogram of the measurements for each sensor and axis._
% * _A plot of the signals over time. If there are trends figure out a way
% to deal with these._
% * _The determined average acceleration vector, angular velocity vector,
% and magnetic field, and their respective covariance matrices._
%
% acc_mean =
% 
%     0.2491
%    -0.2820
%     8.9914
% 
% acc_cov =
% 
%    1.0e-03 *
% 
%     0.3428    0.0055   -0.0116
%     0.0055    0.2618    0.0036
%    -0.0116    0.0036    0.7062
% 
% mag_mean =
% 
%    -7.3477
%    15.1101
%   -38.4385
% 
% mag_cov =
% 
%     0.5096   -0.0013   -0.0036
%    -0.0013    0.4177   -0.0172
%    -0.0036   -0.0172    0.4707
% 
% gyr_mean =
% 
%    1.0e-03 *
% 
%     0.2577
%    -0.4331
%    -0.3889
% 
% gyr_cov =
% 
%    1.0e-06 *
% 
%     0.6142    0.0100   -0.0321
%     0.0100    0.6279    0.0519
%    -0.0321    0.0519    0.6424

%% 3. Add the EKF time update step
% _*Include your time update function* from the
% preparations here:_
%
% _For simplicity, use the same function for the case with and without gyro
% support and differentiate the two, eg, by checking for empty gyro input._
%
% <include>tu_qw.m</include>
%
%%
% _*Motivate parameter choices:*_
% We want to use the measured gyro bias and covariance in
% the motion model
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat3, meas3] = ekfFilter('', calAcc, calMag, calGyr);
  save DATAFILE -append xhat3 meas3
end
%%
figure
visDiff(xhat3, meas3);
%%
% *_Shortly describe your observations:_*
%
% * _What has gyroscope measurements added?_
% * _What is the difference between starting the program with the phone flat
%   on the desk and in a random pose?  Why?_
%
% That the phone orientation updates because of the gyroscope based
% motion model. Becomes less accurate over time or when shaking the phone. 
% Assumes the phone lays down flat in calibration position when starting.
%
% When starting flat, like in the calibration, the pose is correctly
% predicted, but drifts over time. If it starts in another pose it will
% be wrong from the start.

%% 4. Add the EKF accelerometer measurement update step
% _*Include your accelerometer measurement update function* from the
% preparations here:_
%
% <include>mu_g.m</include>
%
%%
% _*Motivate parameter choices:*_
% We want to use the measured accelerometer bias and covariance in
% the measurement model
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat4, meas4] = ekfFilter('', calAcc, calMag, calGyr);
  save DATAFILE -append xhat4 meas4
end
%%
figure
visDiff(xhat4, meas4);
%%
% _*Shortly describe your observations:*_
%
% * _What has the accelerometer added?_
% * _What happens when you shake or quickly slide the phone on a surface?
%   Why?_
%
% The accelerometer has added better orientation correction since it 
% knows where where the gravity vector is pointing. 
% When sliding on table, a force component is generated horizontally which
% creates an artificial gravity which will make the phone tip a bit,
% which will disappear when the phone is still again. Therefore starts
% to wobble a lot but then resets when still.

%% 5. Add accelerometer outlier rejection
% _*Describe your accelerometer outlier rejection:*_
%
% * _What is considered an outlier?_
% * _What do you do when you encounter an outlier?_
%
% We check the norm of the resulting acceleration vector. When having
% "artificial gravity", the length will increase since we introduce
% values in other directions. We therefore check if the length
% is withing reasonable bounds near the gravity constant.
%%
% _*How did you implement the outlier rejection?*_
%%
% When encountering an outlier, we simply do not
% perform the measurement update step, and insted set the visualization
% flag to 0 to indicate a disturbance and outlier.
%
% if accValue < 10 && accValue > 9.7
%   [x, P] = mu_g(x, P, acc, calAcc.R, calAcc.m);
%   ownView.setAccDist(1);
% else
%   ownView.setAccDist(0);
% end
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat5, meas5] = ekfFilter('', calAcc, calMag, calGyr);
  save DATAFILE -append xhat5 meas5
end
%%
figure
visDiff(xhat5, meas5);
%%
% _*Shortly describe your observations:*_
%
% * _What happens when you shake or quickly slide the phone on surface?
%   Why?_

%% 6. Add the EKF magnetometer measurement update step
% _*Include your magnetometer measurement update function* from the
% preparations here:_
%
% <include>mu_m.m</include>
%
%%
% _*Motivate parameter choices:*_
%
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat6, meas6] = ekfFilter('', calAcc, calMag, calGyr);
  save DATAFILE -append xhat6 meas6
end
%%
figure
visDiff(xhat6, meas6);
%%
% _*Shortly describe your observations:*_
%
% * _What has the magnetometer added?_
% * _What happens when you put the phone close to a magnet?  (Use a
%   refridgerator magnet, or hold the phone close to, eg, the keyboard
%   which is usually magnetic.)  Why?_
%
% The magnetormeter has added better orientation in the horizontal plane.
% 

%% 7. Add magnetometer outlier rejection
% 
% _*Describe your magnetometer outlier rejection:*_
%
% * _What is considered an outlier?_
% * _What do you do when you encounter an outlier?_
%
% We check the norm of the resulting magnetic field vector. We assume
% that the norm of the magnetometer should be close the norm of the
% magnetic field measured during calibration. This should work since
% the magnetic field strength should not depend on orientation.
% In this way, we can somewhat detect if disturbances are present and then
% not perform the measurement update.
%%
% _*How did you implement the outlier rejection?*_
%%
%
% m0 = [0 sqrt(calMag.m(1)^2 + calMag.m(2)^2) calMag.m(3)]';
% m0Norm = norm(m0);
% 
% magNorm = norm(mag);
% magDev = abs(magNorm - m0Norm);
% 
% if magDev < 0.20 * m0Norm
%     [x, P] = mu_m(x, P, mag, calMag.R, m0);
%     ownView.setMagDist(1);
% else
%     ownView.setMagDist(0);
% end
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot.  Save the
% resulting matrices in a mat-file, just in case you have to restart matlab
% before compiling the report._
if ~inpublish  % Don't recollect data during publish
  [xhat7, meas7] = ekfFilter('', calAcc, calMag, calGyr);
  save DATAFILE -append xhat7 meas7
end
%%
figure
visDiff(xhat7, meas7);
%%
% _*Shortly describe your observations:*_
%
% * _What happens when you put the phone close to a magnet?  Why?_

%% 8. Test your filter without gyroscope measurements
% _The easiest way to do this is to run your full filter implementation and
% switch gyro measurements on and off in the app._
%
%%
% *Result*
%
% _Run the indicated code below to generate results to plot._
if ~inpublish  % Don't recollect data during publish
  [xhat8, meas8] = ekfFilter('', calAcc, calMag, calGyr);
  save DATAFILE -append xhat8 meas8
end
%% 
figure
visDiff(xhat8, meas8);
%%
% _*Shortly describe your observations:*_
%
% * _How does the behavor differ when using and not the gyroscope?_
% * _Some phones has no gyroscope, to reduce the production cost and
%   preserve battery.  How does that affect their ability to estimate
%   orientation?_

%% 9. If you are interested and have time
% _No need to report back if you did this, but feel free if you did._

%% APPENDIX: Main loop
%
% <include>ekfFilter.m</include>
%
