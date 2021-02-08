% Create transfer function
m = 5;
k = -1;
b = 3;

s = tf(1, [m k b])

% Plot step response
figure(1)
[y, t] = step(s);
plot(t, y)
grid on
title('Step response')

% Plot impulse response
figure(2)
[y, t] = impulse(s);
plot(t, y)
grid on
title('Impulse response')

% Plot root locus
figure(3)
rlocus(s)
grid on