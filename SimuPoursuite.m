sim('PoursuiteSimu',70) 
plot(R1.time,R1.signals.values,'.:',Y1.time,Y1.signals.values,'.-')
x=xlabel('Temps (s)');
x.FontSize = 14;
l=legend('Consigne (m)','Sortie (m)');
l.FontSize = 12;
grid on
