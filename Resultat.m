%sim('Simulation',100) 
%% Vitesses des vehicules :
figure(1)
plot(Vs.time,Vs.signals.values,'b.-')
hold on
plot(Vt.time,Vt.signals.values,'r')
grid on 
l=legend('Vitesse du vehicule suiveur (m/s)','Vitesse du vehicule de tete (m/s)');
l.FontSize = 16;
set(l,'position',[0.7 0.71 0.2 0.2])
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Vitesses des vehicules (m/s)');
y.FontSize = 16;
%% distance et vitesse :
figure (2)
plot(Vs.signals.values,dist.signals.values,'k*')
grid on 
y=ylabel('La distance entre les véhicules (m)');
y.FontSize = 16;
x=xlabel('La vitesse du véhicule suiveur (m/s)');
x.FontSize = 16;
%% position des Vehicule :
figure (3)
plot(xt.time,xt.signals.values,'k')
hold on
plot(xs.time,xs.signals.values,'r')
t=title('La distance parcourue par les vehicules (m)');
t.FontSize = 16;
x=xlabel('Temps (s)');
x.FontSize = 16;
y=ylabel('Distance longitudinale parcourue (m)');
y.FontSize = 16;
grid on
%% distance de sécurité :
figure(4)
plot(xt.time,dist.signals.values,'r.:',distc.time,distc.signals.values,'b.-')
grid on 
t=title('Distance de sécurité');
t.FontSize = 16;
l=legend('Distance entre les véhicules (m)','Distance de sécurité (m)');
l.FontSize = 16;
x=xlabel('Temps (s)');
x.FontSize = 16;
%% Erreur :
figure(5)
plot(xt.time(5:length(xt.time)),dist.signals.values(5:length(xt.time))-distc.signals.values(5:length(xt.time)),'k.')
grid on 
y=ylabel('Erreur de suivi(m)');
y.FontSize = 16;
x=xlabel('Temps (s)');
x.FontSize = 16;
%% La commande :
figure(6)
plot(xt.time(7:length(xt.time)),Commande.signals.values(7:length(xt.time)),'r.-')
grid on 
y=ylabel('Couple (N.m)');
y.FontSize = 16;
x=xlabel('Temps (s)');
x.FontSize = 16;