% Set up parameters
a = 10;    % Constant
dt = 0.01; % Time step
t = 0:dt:50; % Time vector
N = length(t); % Number of time steps
x = zeros(N,1); % Initialize x vector
y = zeros(N,1); % Initialize y vector
z = zeros(N,1); % Initialize z vector

% Set initial conditions
x(1) = 0.1;
y(1) = 0.1;
z(1) = 0.1;

% Iterate using chaotic Lorenz equations
for i = 2:N
    dx = a*(y(i-1)-x(i-1));
    dy = x(i-1)*(a-z(i-1))-y(i-1);
    dz = x(i-1)*y(i-1)-(a+1)*z(i-1);
    x(i) = x(i-1) + dt*dx;
    y(i) = y(i-1) + dt*dy;
    z(i) = z(i-1) + dt*dz;
end

% Create animation
figure;
for i = 1:N
    plot3(x(1:i),y(1:i),z(1:i),'b','LineWidth',1.5);
    xlim([-20 20]);
    ylim([-30 30]);
    zlim([0 50]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Chaotic Butterfly Effect');
    drawnow;
end
