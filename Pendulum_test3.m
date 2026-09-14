% Define parameters
sigma = 10;
beta = 8/3;
rho = 28;

% Define simulation time
tspan = [0, 100];

% Define function for solving differential equations
f = @(t, y) lorenz_ode(t, y, sigma, beta, rho);

% Generate random initial conditions
y0 = [rand()*20-10; rand()*20-10; rand()*20-10];

% Solve differential equations
[t, y] = ode45(f, tspan, y0);

% Create figure
fig = figure;
set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');

% Animate Lorenz system
for i = 1:length(t)
    plot3(y(1:i, 1), y(1:i, 2), y(1:i, 3), 'LineWidth', 1);
    title(sprintf('Lorenz System, Time: %.2f s', t(i)));
    xlabel('x');
    ylabel('y');
    zlabel('z');
    drawnow;
    F(i) = getframe(fig);
end

% Play animation
movie(F, 10);

function dydt = lorenz_ode(t, y, sigma, beta, rho)
% Lorenz system ODE function

% Extract variables from solution vector
x = y(1);
y = y(2);
z = y(3);

% Define derivative vector
dydt = [sigma*(y-x); x*(rho-z)-y; x*y-beta*z];
end
