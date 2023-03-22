%% This is demo file of antidote_MATLAB.
%
% Copyright (C) 2022-2023 Huohuansong huohuansong@outlook.com
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
% Only consider the readability and not the operating efficiency. This code can be optimized
% by yourself.

%% configuration and starting
clc;
clear;
close all;

[mypath, myname] = fileparts(mfilename('fullpath'));
[
    g_figure_dir, ...
    g_logger, ...
    g_progress_bar, ...
    g_start, ...
    g_end ...
] = config('output', myname, 'hour');
g_start();

%% parameter settings
g_logger('Initialization parameters.');

num_of_node = 4;
x = 5 * rand(num_of_node, 1);
x_store(:, 1) = x;

A = [
    0, 1, 0, 0;
    1, 0, 1, 0;
    0, 1, 0, 1;
    0, 0, 1, 0;
];
D = diag(sum(A));
L = D - A;

%% iteration
g_logger('Iteration start.');
tic

t_begin = 0;
t_end = 20;
dt = 0.01;
times = (t_end - t_begin) / dt;
timestamp = t_begin:dt:t_end;
t = 0;
for i = 1:times
    x = - dt * L * x + x;

    x_store(:, i+1) = x;

    t = t + dt;

    g_progress_bar('Iteration progress: ', i/times);
end
g_logger(['Iteration done. Time cost: ', num2str(toc), ' s']);

%% draw and save figure
g_logger('Saving figure ...');

figure(1);
plot(timestamp(:,1:round(times)), x_store(:,1:round(times)));
xlabel('Duration');
ylabel('State');
legend_1 = legend('x1', 'x2', 'x3', 'x4', 'location', 'NorthEast');
set(legend_1, 'Fontsize', 6);

set(gcf, 'PaperPosition', [0, 0, 16, 12]);
set(gcf, 'PaperSize', [16, 12]);
saveas(gcf, [g_figure_dir, '/demo.pdf']);
g_logger([ 'Save as "', g_figure_dir, '/demo.pdf".']);

g_logger(['Save all figure to directory "', g_figure_dir, '" done.']);

%% end
g_end();
