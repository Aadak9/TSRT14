function [x_new, P_new]=mu_g(x, P, yacc, Ra, g0)
    % Calculate h(x) and h'(x)
    h_x = Qq(x)*g0;
    h_dx = dQqdq(x)*g0;

    % Use EKF1 measurement update equations
    S = Ra + h_dx*P*h_dx';
    S_inv = inv(S);

    K = P*h_dx'*S_inv;
    e = yacc - h_x;

    x_new = x + K*e;
    P_new = P - P*h_dx'*S_inv*h_dx*P;

    % Normalize
    [x_new, P_new] = mu_normalizeQ(x_new, P_new);
end