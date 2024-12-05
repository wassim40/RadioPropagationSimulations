close all;

% Paramètres communs
f = 1800; % Fréquence en MHz (sauf spécification contraire)
hb = 50; % Hauteur de l'antenne émettrice en mètres
hm = 1.5; % Hauteur de l'antenne réceptrice en mètres
d = linspace(1, 20, 100); % Distance en km
c = 3e8; % Vitesse de la lumière (m/s)

% Spécificités des modèles
% Modèle COST-231 Hata
if f >= 150 && f <= 2000
    C = 3; % Facteur pour les grandes villes
    a_hm = (1.1 * log10(f) - 0.7) * hm - (1.56 * log10(f) - 0.8); % Correction hauteur
    Lp_COSTAHATA = 46.3 + 33.9 * log10(f) - 13.82 * log10(hb) - a_hm + ...
                    (44.9 - 6.55 * log10(hb)) * log10(d) + C;
else
    Lp_COSTAHATA = NaN(size(d)); % Non applicable pour cette plage de fréquences
end

% Modèle Ericsson
if f >= 150 && f <= 2000
    a_0 = 36.2;
    a_1 = 30.2;
    a_2 = 12.0;
    a_3 = 0.1;
    g_f = 44.49 * log10(f) - 4.78 * (log10(f))^2; % Correction fréquence
    L_p_Ericsson = a_0 + a_1 * log10(d) + a_2 * log10(hb) + ...
                    a_3 * log10(hb) .* log10(d) - ...
                    3.2 * (log10(11.75 * hm))^2 + g_f;
else
    L_p_Ericsson = NaN(size(d)); % Non applicable
end

% Modèle de propagation en espace libre
f_freespace = 2e9; % Fréquence en Hz (2 GHz)
Lp_Freespace = 20 * log10(d) + 20 * log10(f_freespace) - 20 * log10(c / (4 * pi));

% Modèle ITU-R (Atténuation par la pluie)
R = 50; % Pluviométrie en mm/h
k = 0.036; % Facteur dépendant de la fréquence (ITU-R P.838)
alpha = 1.2; % Exposant de l'atténuation
gamma_r = k * R^alpha; % Atténuation spécifique
A_r = gamma_r * d; % Atténuation totale

% Modèle Hata - Urbain
if f >= 150 && f <= 2000
    Lp_Hata = 69.55 + 26.16 * log10(f) - 13.82 * log10(hb) - a_hm + ...
               (44.9 - 6.55 * log10(hb)) * log10(d);
else
    Lp_Hata = NaN(size(d)); % Non applicable
end

% Modèle SUI
f_SUI = 3.5e9; % Fréquence en Hz
lambda = c / f_SUI; % Longueur d'onde en mètres
gamma_SUI = 3.6; % Facteur d'exposant
X_f = 6 * log10(f_SUI / 2e9); % Correction pour la fréquence
X_h = -10.8 * log10(hm / 2); % Correction pour la hauteur
A_SUI = 20 * log10(4 * pi / lambda);
Lp_SUI = A_SUI + 10 * gamma_SUI * log10(d) + X_f + X_h;

% Affichage sur une seule figure
figure;

% Tracer les courbes pour chaque modèle
plot(d, Lp_COSTAHATA, 'r-', 'LineWidth', 1.5); hold on;
plot(d, L_p_Ericsson, 'g--', 'LineWidth', 1.5);
plot(d, Lp_Freespace, 'b-.', 'LineWidth', 1.5);
plot(d, A_r, 'm:', 'LineWidth', 1.5);
plot(d, Lp_Hata, 'c-', 'LineWidth', 1.5);
plot(d, Lp_SUI, 'k--', 'LineWidth', 1.5);

% Labels et titre
xlabel('Distance (km)');
ylabel('Atténuation (dB)');
title('Atténuation des signaux en fonction de la distance pour différents modèles');

% Ajouter une légende
legend('Modèle COST-231 Hata', 'Modèle Ericsson', 'Modèle Freespace', ...
       'Modèle ITU-R (Pluie)', 'Modèle Hata - Urbain', 'Modèle SUI');

% Grille et axes
grid on;
axis([1 20 -50 250]);

hold off;
