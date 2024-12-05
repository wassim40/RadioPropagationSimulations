% Paramètres
f = 900; % Fréquence en MHz
hb = 50; % Hauteur de l'antenne émettrice en mètres
hm = 1.5; % Hauteur de l'antenne réceptrice en mètres
d = linspace(1, 20, 100); % Distance en km

% Correction pour la hauteur du récepteur
a_hm = (1.1 * log10(f) - 0.7) * hm - (1.56 * log10(f) - 0.8);

% Calcul de la perte
Lp = 69.55 + 26.16 * log10(f) - 13.82 * log10(hb) - a_hm + ...
     (44.9 - 6.55 * log10(hb)) * log10(d);

% Affichage
figure;
plot(d, Lp);
xlabel('Distance (km)');
ylabel('Perte (dB)');
title('Modèle Hata - Urbain');
grid on;