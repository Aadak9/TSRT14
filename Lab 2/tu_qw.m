function [x_new, P_new]=tu_qw(x, P, omega, T, Rw)
  fv = T/2*Sq(x);

  if nargin < 5
    % Missing omega, do not update state
    x_new = x;
    P_new = P + fv*Rw*fv';
  else
    % Use EKF1 time update equations
    fx = 1/2 * Somega(omega)*x;
    
    I = eye(length(x));
    F = (I + fx*T);

    x_new = F*x;
    P_new = fv*Rw*fv' + F*P*F';
  end

  % Normalize to keep unit vector to one
  [x_new, P_new] = mu_normalizeQ(x_new, P_new);
end