% Parameters
num_pendulums = 10;             % Number of double pendulums
num_steps = 1000;               % Number of time steps
dt = 0.01;                      % Time step size
L1 = 1;                         % Length of first pendulum
L2 = 0.5;                       % Length of second pendulum
m1 = 1;                         % Mass of first pendulum
m2 = 0.5;                       % Mass of second pendulum
g = 9.81;                       % Gravity

% Define the Lagrangian
syms th1(t) th2(t)             % Define symbolic variables
L = 0.5*m1*L1^2*(diff(th1(t), t))^2 + 0.5*m2*((L1*diff(th1(t), t))^2 + ...
    L2^2*(diff(th2(t), t))^2 + 2*L1*L2*diff(th1(t), t)*diff(th2(t), t)*cos(th1(t)-th2(t))) ...
    - m1*g*L1*cos(th1(t)) - m2*g*(L1*cos(th1(t)) + L2*cos(th2(t)));

% Derive the equations of motion using the Euler-Lagrange equation
eq1 = diff(diff(L, diff(th1(t), t)), t) - diff(L, th1(t));
eq2 = diff(diff(L, diff(th2(t), t)), t) - diff(L, th2(t));

% Convert the symbolic equations to MATLAB function handles
f1 = matlabFunction(subs(eq1, [diff(th1(t), t, 2), diff(th2(t), t, 2)], ['th1dd', 'th2dd']));
f2 = matlabFunction(subs(eq2, [diff(th1(t), t, 2), diff(th2(t), t, 2)], ['th1dd', 'th2dd']));

% Initialize arrays
th1 = zeros(num_steps, num_pendulums);
th2 = zeros(num_steps, num_pendulums);
th1(1, :) = 0.2 + 0.1*randn(1, num_pendulums);
th2(1, :) = -0.3 + 0.1*randn(1, num_pendulums);
th1dot = zeros(num_steps, num_pendulums);
th2dot = zeros(num_steps, num_pendulums);

% Iterate using the equations of motion
for i = 2:num_steps
    for j = 1:num_pendulums
        th1dd = f1(th1(i-1,j), th2(i-1,j), th1dot(i-1,j), th2dot(i-1,j));
        th2dd = f2(th1(i-1,j), th2(i-1,j), th1dot(i-1,j), th2dot(i-1,j));
        
        th1(i,j) = th1(i-1,j) + th1dot(i-1,j)*dt + 0.5*th1dd*dt^2;
        th2(i,j) = th2(i-1,j) + th2dot(i-1,j)*dt + 0.5*th2dd*dt^2;
        
        th1dot(i-1,j) = th1dot(i-1,j) + 0.5*(f1(th1(i,j), th2(i,j), th1dot(i-1,j), th2dot(i-1,j)) + th1dd)*dt;
        th2dot(i,j) = th2dot(i-1,j) + 0.5*(f2(th1(i,j), th2(i,j), th1dot(i-1,j), th2dot(i-1,j)) + th2dd)*dt;
    end
end

% Convert pendulum coordinates to Cartesian coordinates
x1 = L1*sin(th1);
y1 = -L1*cos(th1);
x2 = x1 + L2*sin(th2);
y2 = y1 - L2*cos(th2);

% Plot the simulation
for i = 1:num_steps
    plot([0 x1(i,1)], [0 y1(i,1)], 'b', 'LineWidth', 2); % Plot first pendulum
    hold on;
    for j = 2:num_pendulums
        plot([x2(i,j-1) x1(i,j)], [y2(i,j-1) y1(i,j)], 'r', 'LineWidth', 2); % Plot subsequent pendulums
    end
    axis equal;
    axis([-1.5*L1 1.5*L1 -1.5*L1 1.5*L1]);
    title(sprintf('Double Pendulum Simulation: Step %d', i));
    xlabel('x');
    ylabel('y');
    drawnow;
    hold off;
end

