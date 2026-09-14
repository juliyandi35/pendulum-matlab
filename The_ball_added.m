% Set up parameters
g = 9.81; % Gravity
L = 1; % Length of pendulums
m = 1; % Mass of pendulums
tspan = linspace(0,5,4000); % Time vector
N = length(tspan); % Number of time steps
num_pendulums = 100; % Number of double pendulums

% Set initial conditions for each pendulum
theta1 = 0.1*ones(1,num_pendulums);
theta2 = 0.1*ones(1,num_pendulums);
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
    alpha = m/(2*m)*L;
    beta = m/(2*m)*L;
    dt = tspan(i+1)-tspan(i); % calculate time step

    for j = 1:num_pendulums
        for k = 1:num_pendulums
            if k ~= j
                gamma = m*L/(2*m)*omega1(j)*omega2(k)*sin(theta1(j)-theta1(k));
            else
                gamma = 0;
            end
            omega1dot(j) = (m*g*sin(theta2(j))*cos(theta1(j)-theta2(j))-beta*omega2(j)^2*sin(theta1(j)-theta2(j))-gamma)/(L*(m+(sin(theta1(j)-theta2(j)))^2));
            omega2dot(j) = (alpha*g*sin(theta1(j))*cos(theta1(j)-theta2(j))+alpha*omega1(j)^2*sin(theta1(j)-theta2(j))-m*g*sin(theta2(j)))/(L*(m+(sin(theta1(j)-theta2(j)))^2));
            omega1(j) = omega1(j) + omega1dot(j)*dt;
            omega2(j) = omega2(j) + omega2dot(j)*dt;
            theta1(j) = theta1(j) + omega1(j)*dt;
            theta2(j) = theta2(j) + omega2(j)*dt;
            x1(j) = L*sin(theta1(j));
            y1(j) = -L*cos(theta1(j));
            x2(j) = x1(j) + L*sin(theta2(j));
            y2(j) = y1(j) - L*cos(theta2(j));
        end
    end
    
    % Plot double pendulums with ball
    clf;
    for j = 1:num_pendulums
        plot([0 x1(j)],[0 y1(j)],'r','LineWidth',2);
        hold on;
        plot([x1(j) x2(j)],[y1(j) y2(j)],'b','LineWidth',2);
        plot(x2(j), y2(j), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 10);
    end
    xlim([-3 3]);
    ylim([-3 3]);
    title('Chaotic Butterfly Effect in Double Pendulums with Ball');
    xlabel('X');
    ylabel('Y');
    hold off;
    
    % Update plot
    drawnow;
end
