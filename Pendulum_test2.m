% Define parameters
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
g = 9.81;

% Define simulation time
tspan = [0, 20];

% Define function for solving differential equations
f = @(t, y) double_pendulum_ode(t, y, m1, m2, l1, l2, g);

% Create figure
fig = figure;
axis equal;
axis([-3*l1, 3*l1, -3*l1, l1]);
set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');

% Simulate and animate 10 double pendulums with random initial conditions
for i = 1:10
    % Generate random initial conditions
    theta1 = rand()*pi;
    theta2 = rand()*pi;
    omega1 = rand()*5-2.5;
    omega2 = rand()*5-2.5;

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

    % Animate double pendulum
    for j = 1:length(t)
        plot([0, x1(j), x2(j)], [0, y1(j), y2(j)], '-o', 'LineWidth', 2);
        title(sprintf('Double Pendulum %d, Time: %.2f s', i, t(j)));
        drawnow;
        F(j) = getframe(fig);
    end
end

% Play animation
movie(F, 2);

function dydt = double_pendulum_ode(t, y, m1, m2, l1, l2, g)
% Double pendulum ODE function

% Extract variables from solution vector
theta1 = y(1);
omega1 = y(2);
theta2 = y(3);
omega2 = y(4);

% Compute sin and cos values
c1 = cos(theta1);
s1 = sin(theta1);
c2 = cos(theta2);
s2 = sin(theta2);

% Compute accelerations
num1 = -g*(2*m1+m2)*s1 - m2*g*s1-2*m2*l1*s2*(omega2^2+omega1^2*c2);
den1 = l1*(2*m1+m2-m2*c2^2);
num2 = 2*s2*(omega1^2*l1*(m1+m2) + g*(m1+m2)*c1 + omega2^2*l2*m2*c2);
den2 = l2*(2*m1+m2-m2*c2^2);
alpha1 = num1/den1;
alpha2 = num2/den2;

% Define derivative vector
dydt = [omega1; alpha1; omega2; alpha2];
end

