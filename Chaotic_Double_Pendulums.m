% Set up parameters
g = 9.81; % Gravity
L1 = 1; % Length of first pendulum
L2 = 1; % Length of second pendulum
m1 = 1; % Mass of first pendulum
m2 = 1; % Mass of second pendulum
t = 0:0.01:30; % Time vector
N = length(t); % Number of time steps

% Set initial conditions
theta1 = 0.1;
theta2 = 0.1;
omega1 = 0;
omega2 = 0;

% Initialize position vectors
x1 = L1*sin(theta1);
y1 = -L1*cos(theta1);
x2 = x1 + L2*sin(theta2);
y2 = y1 - L2*cos(theta2);

% Create animation
figure;
for i = 1:N
    % Update positions and velocities
    alpha = m2/(m1 + m2)*L1;
    beta = m2/(m1 + m2)*L2;
    gamma = m2*L2/(m1 + m2)*omega1*omega2*sin(theta1-theta2);
    omega1dot = (m2*g*sin(theta2)*cos(theta1-theta2)-beta*omega2^2*sin(theta1-theta2)-gamma)/(L1*(m1+m2*(sin(theta1-theta2))^2));
    omega2dot = (alpha*g*sin(theta1)*cos(theta1-theta2)+alpha*omega1^2*sin(theta1-theta2)-m2*g*sin(theta2))/(L2*(m1+m2*(sin(theta1-theta2))^2));
    omega1 = omega1 + omega1dot*0.01;
    omega2 = omega2 + omega2dot*0.01;
    theta1 = theta1 + omega1*0.01;
    theta2 = theta2 + omega2*0.01;
    x1 = L1*sin(theta1);
    y1 = -L1*cos(theta1);
    x2 = x1 + L2*sin(theta2);
    y2 = y1 - L2*cos(theta2);
    
    % Plot double pendulum
    plot([0 x1],[0 y1],'r','LineWidth',2);
    hold on;
    plot([x1 x2],[y1 y2],'b','LineWidth',2);
    xlim([-2 2]);
    ylim([-2 2]);
    title('Chaotic Butterfly Effect in Double Pendulums');
    xlabel('X');
    ylabel('Y');
    hold off;
    
    % Update plot
    drawnow;
end
