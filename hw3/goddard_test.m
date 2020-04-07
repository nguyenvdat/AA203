% Goddard Model - AA203
C = 100000;

%% Grid: generate a box-type grid of lower corner 'grid_min' and upper corner 'grid_max'

grid_min = [0; 0; 250]; % Lower corner of computation domain
grid_max = [150500/C; 30/C; 500]; % Upper corner of computation domain
N = [20; 20; 50]; % Number of grid points per dimension
pdDims = 3; % 3rd dimension is periodic
grid = createGrid(grid_min, grid_max, N); % Generate the grid


%% Target set

% toler = [500/C; 2.8/C; 125];
toler = [0; 0; 125];
goal = [150000/C; 28/C; 375];
lower = goal - toler;
upper = goal + toler;
data0 = shapeRectangleByCorners(grid, lower, upper);


%% Time vector

t0 = -1;
tMax = 0;
dt = 0.05;
tau = t0:dt:tMax;


%% Problem parameters
b = C*1e-4;
g = 9.81/C;
uMax = 10000/C; % Control bound
dMax = 1/C; 
uMode = 'min'; % Minimize on controls
dMode = 'max'; % Maximize on disturbances


%% Pack problem parameters

% Define dynamic system
x0 = [0;0;500]; % Starting point
dGoddard = Goddard(x0, g, b, uMax, dMax);

% Put grid and dynamic systems into schemeData
schemeData.grid = grid;
schemeData.dynSys = dGoddard;
schemeData.accuracy = 'veryHigh'; %set accuracy
schemeData.uMode = uMode;
schemeData.dMode = dMode;


%% Compute value function

HJIextraArgs.visualize = true; %show plot
HJIextraArgs.fig_num = 1; %set figure number
HJIextraArgs.deleteLastPlot = true; %delete previous plot as you update
% data = HJIPDE_solve(data0, tau, schemeData, 'minVWithTarget', HJIextraArgs);
data = HJIPDE_solve(data0, tau, schemeData, 'none', HJIextraArgs);
save('goddardAA203.mat', 'tau', 'g', 'data')


%% Visualize slices

load('goddardAA203.mat')

% Section for J(t=-4.5)
figure;
ind = find(tau==-4.5);
visSetIm(grid, data(:,:,:,ind));

% Section for J(t=-5.5)
figure;
ind = find(tau==-5.5);
visSetIm(grid, data(:,:,:,ind));
