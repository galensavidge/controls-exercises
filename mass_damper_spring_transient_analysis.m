% Analysis of the mass-damper-spring system with constants (m, k, b)

s = tf('s');

% Create plant transfer function
m = 5;
k = 1;
b = 3;

plant = 1/(m*s^2 + k*s + b);

% Finding desired pole positions from transient characteristics
Mp = 9;

M = log(Mp/100)^2
zeta = sqrt(M/(pi^2+M))

tr = 5;
wd = atan2(sqrt(1-zeta^2), -zeta)/tr
wn = wd/(sqrt(1-zeta^2))

desired_p = -zeta*wn + [1i*wd, -1i*wd]

% Desired system composed of only the desired closed-loop poles with unity
% gain in steady-state
desired_sys = 1/((s - desired_p(1))*(s - desired_p(2)))
desired_sys = desired_sys / evalfr(desired_sys, 0)

% Plot desired step response
figure(5)
t = 0:0.1:40;
[y, t] = step(desired_sys, t);
plot(t, y)
grid on
title('Desired step response')

max_overshoot = (max(y) - 1)*100

% Lead compensator design using root locus technique
theta_plant = rad2deg(angle(evalfr(plant, desired_p(1)))) % Evaluate plant at desired closed-loop pole
phi = 180 - theta_plant

pause

% PID controller transfer function
Kp = 1;
Kd = 1;
Ki = 1;

ctrl = Kp + Kd*s + Ki/s

% Find natural frequency, damping ratio, poles, and period
[wn, zeta, p] = damp(plant)
wn = wn(1);
zeta = zeta(1);
wd = wn*sqrt(1 - zeta^2)
T = 2*pi/wd

% Plot plant step response
figure(1)
[y, t] = step(plant);
plot(t, y)
grid on
title('Step response')

% Plot plant impulse response
figure(2)
[y, t] = impulse(plant);
plot(t, y)
grid on
title('Impulse response')

% Plot plant root locus
figure(3)
rlocus(plant)
grid on

% Plot root locus
% figure(4)
% rlocus(plant*ctrl)
% grid on

% controlSystemDesigner('rlocus', plant)