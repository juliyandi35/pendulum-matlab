% Define parameters
m1 = 1;  % Mass of first pendulum bob
m2 = 1;  % Mass of second pendulum bob
l1 = 1;  % Length of first pendulum arm
l2 = 1;  % Length of second pendulum arm
g = 9.81;  % Gravitational acceleration

% Define initial conditions
theta1 = pi/2;   % Initial angle of first pendulum arm
theta2 = pi/2;   % Initial angle of second pendulum arm
omega1 = 0;      % Initial angular velocity of first pendulum arm
omega2 = 0;      % Initial angular velocity of second pendulum arm

% Define simulation time
tspan = [0, 20];

% Define function for solving differential equations
f = @(t, y) double_pendulum_ode(t, y, m1, m2, l1, l2, g);

% Solve differential equations
y0 = [theta1; omega1; theta2; omega2];
[t, y] = ode45(f, tspan, y0);

% Extract angles from solution
theta1 = y(:, 1);
theta2 = y(:, 3);

% Define x and y coordinates of pendulum bobs
x1 = l1*sin(theta1);
y1 = -l1*cos(theta1);
x2 = x1 + l2*sin(theta2);
y2 = y1 - l2*cos(theta2);

% Animate the double pendulum
figure;
for i = 1:length(t)
    plot([0, x1(i), x2(i)], [0, y1(i), y2(i)], '-o', 'LineWidth', 2);
    axis equal;
    axis([-2*l1, 2*l1, -2*l1, 0]);
    title(sprintf('Time: %.2f s', t(i)));
    drawnow;
end

% Define function for solving differential equations
function dydt = double_pendulum_ode(t, y, m1, m2, l1, l2, g)
    theta1 = y(1);
    omega1 = y(2);
    theta2 = y(3);
    omega2 = y(4);

    % Compute accelerations
    dtheta1dt = omega1;
    dtheta2dt = omega2;
    domega1dt = (-g*(2*m1 + m2)*sin(theta1) - m2*g*sin(theta1 - 2*theta2) - 2*sin(theta1 - theta2)*m2*(omega2^2*l2 + omega1^2*l1*cos(theta1 - theta2))) / (l1*(2*m1 + m2 - m2*cos(2*theta1 - 2*theta2)));
    domega2dt = (2*sin(theta1 - theta2)*(omega1^2*l1*(m1 + m2) + g*(m1 + m2)*cos(theta1) + omega2^2*l2*m2*cos(theta1 - theta2))) / (l2*(2*m1 + m2 - m2*cos(2*theta1 - 2*theta2)));

    dydt = [dtheta1dt; domega1dt; dtheta2dt; domega2dt];
end
