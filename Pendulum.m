% Parameters of the double pendulum system
m1 = 1; % mass of pendulum 1
m2 = 1; % mass of pendulum 2
L1 = 1; % length of pendulum 1
L2 = 1; % length of pendulum 2
g = 9.81; % gravitational acceleration

% Time vector
tspan = linspace(0,10,1000); % from 0 to 10 seconds with 1000 time steps

% Initial conditions
theta1_0 = 0; % initial angle of pendulum 1
theta2_0 = 0; % initial angle of pendulum 2
omega1_0 = 0; % initial angular velocity of pendulum 1
omega2_0 = 0; % initial angular velocity of pendulum 2

% Combine initial conditions into a single vector
y0 = [theta1_0; theta2_0; omega1_0; omega2_0];

% Solve the ODE using ode45
[t,y] = ode45(@(t,y) double_pendulum_ode(t,y,m1,m2,L1,L2,g), tspan, y0);

% Extract the angles and angular velocities from the solution
theta1 = y(:,1);
theta2 = y(:,2);
omega1 = y(:,3);
omega2 = y(:,4);

% Plot the angles and angular velocities
figure;
subplot(2,1,1);
plot(t,theta1,'b',t,theta2,'r');
legend('Pendulum 1','Pendulum 2');
xlabel('Time (s)');
ylabel('Angle (rad)');
title('Double Pendulum Angles');
subplot(2,1,2);
plot(t,omega1,'b',t,omega2,'r');
legend('Pendulum 1','Pendulum 2');
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
title('Double Pendulum Angular Velocities');

% Function defining the ODE for the double pendulum system
function dydt = double_pendulum_ode(t,y,m1,m2,L1,L2,g)
    theta1 = y(1);
    theta2 = y(2);
    omega1 = y(3);
    omega2 = y(4);
    dydt = [omega1;
            omega2;
            (-g*(2*m1+m2)*sin(theta1)-m2*g*sin(theta1-2*theta2)-2*sin(theta1-theta2)*m2*(omega2^2*L2+omega1^2*L1*cos(theta1-theta2)))/(L1*(2*m1+m2-m2*cos(2*theta1-2*theta2)));
            (2*sin(theta1-theta2)*((omega1^2*L1*(m1+m2)+g*(m1+m2)*cos(theta1)+omega2^2*L2*m2*cos(theta1-theta2)))/(L2*(2*m1+m2-m2*cos(2*theta1-2*theta2))))];
end
