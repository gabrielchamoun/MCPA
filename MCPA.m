clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')

nt = 1000;  % Number of iterations
dt = 1; % Time step
F = 1;	% Arbitrary Force
m = 1;  % Arbitrary Mass

x = zeros(1,1);     % position
v = zeros(1,1);     % velocity
va = zeros(1,1);    % average velocity
t = zeros(1,1);     % time

% scattering
% probability of scattering
tau = 19.5; % tau = 19.5 equivalent to 5% of the time
p = 1 - exp(-dt/tau);

% scattering multiplier
sm = 0; % setting to 1 turns scattering off

for i = 2:nt
    % on every loop compute new velocity and position
    t(:,i) = t(:,i-1) + dt;
    v(:,i) = v(:,i-1) + F/m * dt;
    x(:,i) = x(:,i-1) + (v(:,i-1)*dt) + (F/m * dt^2 * 1/2);
    
    % scattering effect
    % probability of scattering based on p.
    r = rand(1) < p; % result will be a logical 1 or 0
    if r == 1   % 'if true'
        v(:,i) = sm * v(:,i);
    end
    
    % running average of the velocities
    va(:,i) = mean(v, 2);
    
    % Plotting
    % time vs velocity
    subplot(3,1,1),plot(t,v,'k','LineWidth',2)
    hold on % average velocity
    plot(t,va,'--r'), legend('value', 'average')   
    hold off
    xlabel('time'), ylabel('velocity')
    
    % position vs velocity
    subplot(3,1,2),plot(x,v,'k','LineWidth',2)	
    xlabel('position'), ylabel('velocity')
    
    % time vs position
    subplot(3,1,3),plot(t,x,'k','LineWidth',2)	
    xlabel('time'), ylabel('position')
    
    pause(0.01) % delay to animate the plot
end

