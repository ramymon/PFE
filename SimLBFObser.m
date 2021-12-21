% Simulation en boucle fermé avec observateur  :

%% Etats estimés
% Vitesse estimé du vehicule  :
sim('StabObserFlou',200)
figure(1)
subplot(121)
Vs_est = Xest.signals.values(:,1);

plot(Xest.time,Vs_est,'b.')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Vitesse estimé du vehicule (m/s)');
y.FontSize = 16;
% Couple estimé :
sim('StabObserFlou',50)
subplot(122)

c_est = Xest.signals.values(:,2);
plot(Xest.time,c_est,'r.-')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Couple estimé (N.m)');
y.FontSize = 16;
%% Etats reèls
% Vitesse  du vehicule  :
sim('StabObserFlou',200)
figure(2)
Vs = X.signals.values(:,1);
subplot(121)
plot(X.time,Vs,'b.')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Vitesse du vehicule (m/s)');
y.FontSize = 16;
% Couple estimé :
sim('StabObserFlou',50)
subplot(122)
c = X.signals.values(:,2);
plot(X.time,c,'r.-')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Couple (N.m)');
y.FontSize = 16;

%% Erreur d'estimation
% Erreur sur la Vitesse du vehicule  :
sim('StabObserFlou',200)
figure(3)
subplot(121)
E = X.signals.values(:,1)-Xest.signals.values(:,1);
plot(Xest.time,E,'b.')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('L''erreur en vitesse (m/s)');
y.FontSize = 16;
% Couple estimé :
sim('StabObserFlou',50)
subplot(122)
E = X.signals.values(:,2)-Xest.signals.values(:,2);
plot(Xest.time,E,'r.-')
grid on
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('L''erreur en couple (N.m)');
y.FontSize = 16;
