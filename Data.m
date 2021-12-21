% Données pour la simulation :
choice = menu('Votre choix','Suivi','frienage','Sortir');
switch choice
%% conditions initials cas poursuite :    
   case 1 
Pt0 = 6 ;
Vt0 = 6;
Ps0 = 0;
Vs0 = 6;
Choix =1;
Ts=200;

%% conditions initials cas freinage :    
   case 2
Pt0 = 50 ;
Vt0 = 23.946459624338537;
Ps0 = 2;
Vs0 = 23.9;
Choix =-1;
 Ts=30;
end