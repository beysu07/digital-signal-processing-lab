clc;
close all;

B = [2 -4];
A = [1 0.5 1];

n = 0:19;
x = (0.8).^n;

Yi = [0 1];     % [y(-1) y(-2)]
Xi = [-1];      % [x(-1)]

Zi = filtic(B, A, Yi, Xi);
y1 = filter(B, A, x, Zi);

figure;
stem(n, y1, 'filled');
grid on;
xlabel('n');
ylabel('y(n)');
title('Deney 1(a) - Başlangıç koşullu çıkış');