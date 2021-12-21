% Simulation en boucle fermé  :
%% Vitesse du vehicule :
sim('StabilisationBF',0.8)
figure(1)
plot(Vs.time,Vs.signals.values,'b.')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Vitesse du véhicule (m/s)');
y.FontSize = 16;

%% Couple :
sim('StabilisationBF',0.8)
figure(2)
plot(c.time,c.signals.values,'r.-')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Couple (N.m)');
y.FontSize = 16;
 
%% Sortie :
sim('StabilisationBF',0.8)
figure(3)
plot(Vs.time,Y.signals.values,'b.')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Sortie (Consigne de  la distance de sécurité) (m)');
y.FontSize = 16;