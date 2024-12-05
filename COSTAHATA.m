close all;

% Paramètres pour le modèle COST-231 Hata
f = 1800; % Fréquence en MHz
hb = 50; % Hauteur de l'antenne émettrice en mètres
hm = 1.5; % Hauteur de l'antenne réceptrice en mètres
d = linspace(1, 20, 100); % Distance en km
C = 3; % Facteur pour les grandes villes

% Calcul de la correction pour la hauteur de l'antenne réceptrice
a_hm = (1.1 * log10(f) - 0.7) * hm - (1.56 * log10(f) - 0.8);

% Calcul de l'atténuation pour le modèle COST-231 Hata
Lp_COSTAHATA = 46.3 + 33.9 * log10(f) - 13.82 * log10(hb) - a_hm + ...
               (44.9 - 6.55 * log10(hb)) * log10(d) + C;

% Tracé des résultats
figure;
plot(d, Lp_COSTAHATA, 'r-', 'LineWidth', 1.5);
xlabel('Distance (km)');
ylabel('Atténuation (dB)');
title('Modèle COST-231 Hata : Atténuation en fonction de la distance');
grid on;
legend('Modèle COST-231 Hata');
axis([1 20 min(Lp_COSTAHATA)-10 max(Lp_COSTAHATA)+10]);
