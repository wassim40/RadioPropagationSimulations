close all;

% Paramètres du modèle SUI
d = linspace(1, 20, 100); % Distance en km
hm = 1.5; % Hauteur de l'antenne réceptrice en mètres
hb = 50; % Hauteur de l'antenne émettrice en mètres
f_SUI = 3.5e9; % Fréquence en Hz (3.5 GHz)
c = 3e8; % Vitesse de la lumière en m/s

% Calcul des paramètres du modèle SUI
lambda = c / f_SUI; % Longueur d'onde en mètres
gamma_SUI = 3.6; % Facteur d'exposant pour le modèle
X_f = 6 * log10(f_SUI / 2e9); % Correction pour la fréquence
X_h = -10.8 * log10(hm / 2); % Correction pour la hauteur
A_SUI = 20 * log10(4 * pi / lambda); % Composante de base de l'atténuation

% Atténuation totale du modèle SUI
Lp_SUI = A_SUI + 10 * gamma_SUI * log10(d) + X_f + X_h;

% Tracé du modèle SUI
figure;
plot(d, Lp_SUI, 'k--', 'LineWidth', 1.5);

% Ajout des labels et du titre
xlabel('Distance (km)');
ylabel('Atténuation (dB)');
title('Modèle SUI : Atténuation en fonction de la distance');

% Ajout de la grille
grid on;
axis([1 20 min(Lp_SUI) - 5 max(Lp_SUI) + 5]);
