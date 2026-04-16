

    v = 343; % speed of sound
    tphat = tphat(:, 7:end);
    rhat = tphat * v;

    
    mean_val = mean(rhat, 1);

    % Preallocate
    [num_sensors, ~] = size(rhat);
    e = zeros(size(rhat));

    figure;

    for sensor = 1:num_sensors

        % Error per sensor
        e(sensor,:) = rhat(sensor,:) - mean_val;

        bias(sensor) = mean(e(sensor,:));
        variance(sensor) = var(e(sensor,:));
        std_dev(sensor) = std(e(sensor,:));

        subplot(2,4,sensor);
        histfit(e(sensor,:), 20);
        title(['Sensor ', num2str(sensor)]);

    end
    save('variance_data.mat', 'variance');


