% Set up parameters
g = 9.81; % Gravity
L = 1; % Length of pendulums
m = 1; % Mass of pendulums
tspan = linspace(0,5,300); % Time vector
N = length(tspan); % Number of time steps
num_pendulums = 100; % Number of double pendulums

% Set initial conditions for each pendulum
theta1 = pi/2*ones(1,num_pendulums);
theta2 = pi/2*ones(1,num_pendulums);
omega1 = zeros(1,num_pendulums);
omega2 = zeros(1,num_pendulums);

% Initialize position vectors
x1 = L*sin(theta1);
y1 = -L*cos(theta1);
x2 = x1 + L*sin(theta2);
y2 = y1 - L*cos(theta2);

% Create animation
figure;
for i = 1:N
    % Update positions and velocities
    dt = tspan(i+1)-tspan(i); % calculate time step

    for j = 1:num_pendulums
        % Calculate Lagrange's equations for theta1 and theta2
        alpha = m/(2*m)*L;
        beta = m/(2*m)*L;
        dtheta1dt = omega1(j);
        dtheta2dt = omega2(j);
        domega1dt = (-m*L*sin(theta1(j)-theta2(j))*(omega2(j)^2*sin(theta1(j)-theta2(j))-g*cos(theta1(j)-theta2(j))))/(2*m*L^2*(1/2+sin(theta1(j)-theta2(j))^2));
        domega2dt = (m*L*(omega1(j)^2*sin(theta1(j)-theta2(j))-g*sin(theta2(j))*cos(theta1(j)-theta2(j))))/(2*m*L^2*(1/2+sin(theta1(j)-theta2(j))^2));

        % Update positions and velocities
        theta1(j) = theta1(j) + dtheta1dt*dt;
        theta2(j) = theta2(j) + dtheta2dt*dt;
        omega1(j) = omega1(j) + domega1dt*dt;
        omega2(j) = omega2(j) + domega2dt*dt;
        x1(j) = L*sin(theta1(j));
        y1(j) = -L*cos(theta1(j));
        x2(j) = x1(j) + L*sin(theta2(j));
        y2(j) = y1(j) - L*cos(theta2(j));
    end
    
    % Plot double pendulums
    clf;
    for j = 1:num_pendulums
        plot([0 x1(j)],[0 y1(j)],'r','LineWidth',2);
        hold on;
        plot([x1(j) x2(j)],[y1(j) y2(j)],'b','LineWidth',2);
    end
    xlim([-3 3]);
    ylim([-3 3]);
    title('Chaotic Butterfly Effect in Double Pendulums');
    xlabel('X');
    ylabel('Y');
    hold off;
    
    % Update plot
    drawnow;
end
