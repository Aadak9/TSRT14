function [x_new, P_new]=mu_m(x, P, ymag, Rm, m0)
    % Calculate h(x) and h'(x)
    [q0, q1, q2, q3] = dQqdq(x);

    h_x = Qq(x)'*m0;
    h_dx = [q0'*m0, q1'*m0, q2'*m0, q3'*m0];
    
    % Use EKF1 measurement update equations
    S = Rm + h_dx*P*h_dx';
    S_inv = inv(S);

    K = P*h_dx'*S_inv;
    e = ymag - h_x;

    x_new = x + K*e;
    P_new = P - P*h_dx'*S_inv*h_dx*P;

    % Normalize
    [x_new, P_new] = mu_normalizeQ(x_new, P_new);
end