% Paramètres de simulation
f = 10; % Fréquence en GHz
d = 5; % Distance en km
rain_rate = 25; % Intensité de pluie en mm/h
liquid_water_density = 0.5; % Densité d'eau liquide (g/m^3) pour le brouillard

% Constantes
gamma0 = 0.01; % Constante de perte de base (absorption par l'air sec)
k_r = 0.1; % Coefficient pour la pluie
alpha_r = 0.8; % Exposant pour la pluie
gamma_rain = k_r * (rain_rate)^alpha_r * d; % Atténuation par pluie

% Atténuation par brouillard
gamma_fog = 0.2 * liquid_water_density * d;

% Atténuation par absorption (approximation simple)
gamma_absorption = gamma0 * f^2 * d;

% Atténuation totale
gamma_total = gamma_rain + gamma_fog + gamma_absorption;

% Visualisation
types = {'Pluie', 'Brouillard', 'Absorption Atmosphérique'};
values = [gamma_rain, gamma_fog, gamma_absorption];

figure;
bar(values);
set(gca, 'XTickLabel', types);
ylabel('Atténuation (dB)');
title('Contributions des Atténuations dans l Atmosphère');
grid on;

disp(['Atténuation totale : ', num2str(gamma_total), ' dB']);
