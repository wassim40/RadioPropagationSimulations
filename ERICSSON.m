close all;

% Paramètres du modèle Ericsson
f = 1800; % Fréquence en MHz
hb = 50; % Hauteur de l'antenne émettrice en mètres
hm = 1.5; % Hauteur de l'antenne réceptrice en mètres
d = linspace(1, 20, 100); % Distance en km

% Vérification de la plage de fréquence pour l'application du modèle
if f >= 150 && f <= 2000
    % Coefficients du modèle Ericsson
    a_0 = 36.2;
    a_1 = 30.2;
    a_2 = 12.0;
    a_3 = 0.1;

    % Correction pour la fréquence
    g_f = 44.49 * log10(f) - 4.78 * (log10(f))^2;

    % Calcul de l'atténuation selon le modèle Ericsson
    L_p_Ericsson = a_0 + a_1 * log10(d) + a_2 * log10(hb) + a_3 * log10(hb) .* log10(d) - 3.2 * (log10(11.75 * hm))^2 + g_f;
else
    L_p_Ericsson = NaN(size(d)); % Non applicable pour cette plage de fréquences
end

% Tracé du modèle Ericsson
figure;
plot(d, L_p_Ericsson, 'g--', 'LineWidth', 1.5);

% Ajout des labels et du titre
xlabel('Distance (km)');
ylabel('Atténuation (dB)');
title('Modèle Ericsson : Atténuation des signaux en fonction de la distance');

% Ajout de la grille
grid on;
axis([1 20 min(L_p_Ericsson) - 10 max(L_p_Ericsson) + 10]);
