% Simulation en boucle ouverte  :
%% Vitesse du vehicule :
sim('Boucleouverte',800)
figure(1)
plot(Vs.time,Vs.signals.values,'b.')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Vitesse du vehicule (m/s)');
y.FontSize = 16;
%% Distance :
figure (2)
plot(xs.time,xs.signals.values,'g.')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Distance parcourue (m)');
y.FontSize = 16;
%% Couple :
sim('Boucleouverte',0.4)
figure(3)
plot(c.time,c.signals.values,'r.-')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Couple (N.m)');
y.FontSize = 16;
%%