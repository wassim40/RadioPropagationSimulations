close all;

% Paramètres du modèle ITU-R
d = linspace(1, 20, 100); % Distance en km
R = 50; % Pluviométrie en mm/h
k = 0.036; % Facteur dépendant de la fréquence (ITU-R P.838)
alpha = 1.2; % Exposant de l'atténuation

% Conversion de la distance en kilomètres vers mètres
d_m = d * 1e3;

% Calcul de l'atténuation spécifique (en dB/km)
gamma_r = k * R^alpha;

% Calcul de l'atténuation totale (en dB)
A_r = gamma_r * d; 

% Tracé du modèle ITU-R
figure;
plot(d, A_r, 'm:', 'LineWidth', 1.5);

% Ajout des labels et du titre
xlabel('Distance (km)');
ylabel('Atténuation (dB)');
title('Modèle ITU-R : Atténuation par la pluie en fonction de la distance');

% Ajout de la grille
grid on;
axis([1 20 min(A_r) - 5 max(A_r) + 5]);
