Head
% Indiquer le modèle non lineaire :
Model
%% cette fonction calcule le modele TakagiSugeno (systeme lineare par secteur)
[A,B,C] = TakagiSugeno(nnl,minn,maxx,A,B,C);
%% La stabilité du systeme :
[P,S]=Stableornot(r,A);
%% 
choice = menu('Approche :','Basic','Taux de decroissance','Placement de poles','Sortir');
switch choice
%%
  case 1 % Basic
% Calcul du retour d'etat qui assure la stabilité du systeme en BF :
K = GainfindV2(r,A,B,1); % avec relaxation
K = cat(3,K(1:r).matrix); % forme tridimentionnelle du matrice

% Calcule des parametre de l'observateurs
L = Observateurflou(r,A,C);
L = cat(3,L(1:r).matrix); %% forme tridimentionnelle du matrice (pour Simulink)

% Calcule des gains qui assurent la stabilité + la poursuite (structure avec integrateur)
[K1,M] = Poursuite(A,B,C,r);
K1 = cat(3,K1(1:r).sys);
M = cat(3,M(1:r).sys); 
%%
    case 2 % Taux de decroissance
% Calcul du retour d'etat qui assure la stabilité du systeme en BF autre approche :
K = GainfindVTD(0.5,r,A,B,1);
K = cat(3,K(1:r).matrix);

% Calcule des parametre de l'observateurs :
% à faire

% Calcule des gains qui assurent la stabilité + la poursuite (structure avec integrateur) :
[K1,M] = PoursuiteVTD(0.5,A,B,C,r);
K1 = cat(3,K1(1:r).sys);
M = cat(3,M(1:r).sys);

%%
  case 3 % Placement de poles 
% Calcul du retour d'etat qui assure la stabilité du systeme en BF autre approche :
K = FctPP(A,B,r,[1,1,1],[10,100,pi/200],1);
K = cat(3,K(1:r).matrix);

% Calcule des parametre de l'observateurs :
% a faire

% Calcule des gains qui assurent la stabilité + la poursuite (structure avec integrateur) :
[K1,M] = PoursuitePP(A,B,C,r,[1,0,1],[2,50,pi/10]);
K1 = cat(3,K1(1:r).sys);
M = cat(3,M(1:r).sys);
%%
end