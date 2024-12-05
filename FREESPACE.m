close all;

% Paramètres du modèle Free-Space
f_freespace = 2e9; % Fréquence en Hz (2 GHz)
c = 3e8; % Vitesse de la lumière (m/s)
d = linspace(1, 20, 100); % Distance en km

% Conversion de la distance en mètres
d_m = d * 1e3;

% Calcul de l'atténuation selon le modèle Free-Space
Lp_Freespace = 20 * log10(d_m) + 20 * log10(f_freespace) - 20 * log10(c / (4 * pi));

% Tracé du modèle Free-Space
figure;
plot(d, Lp_Freespace, 'b-.', 'LineWidth', 1.5);

% Ajout des labels et du titre
xlabel('Distance (km)');
ylabel('Atténuation (dB)');
title('Modèle Free-Space : Atténuation des signaux en fonction de la distance');

% Ajout de la grille
grid on;
axis([1 20 min(Lp_Freespace) - 10 max(Lp_Freespace) + 10]);
