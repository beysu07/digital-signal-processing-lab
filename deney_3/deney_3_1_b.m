clc;
clear;
close all;

B = [2 -4];
A = [1 0.5 1];

n = 0:19;
x = (0.8).^n;

% Başlangıç koşulları sıfır olduğu için filtic kullanılmaz
y2 = filter(B, A, x);

figure;
stem(n, y2, 'filled');
grid on;
xlabel('n');
ylabel('y(n)');
title('Deney 1(b) - Sıfır başlangıç koşullu çıkış');