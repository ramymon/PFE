% Exemple : Modele véhicule electrique :
clear;
syms n1 
%% Constants
ax = 14.55;
bx = 0.055;
Rap = 34.73;
alpha = 1860;
tau = 0.05;
Parametres =[ax, bx, Rap, alpha, tau];
tr = 1;
f = 0.021;
Parametres2 =[tr, f];    
dmin = 5;
%%
nnl = 1; %nombre de non linearité dans le systeme.
maxx = 25; %vecteur de borne superieure de chaque non linearité.
minn = 2; %vecteur de borne inferieure de chaque non linearité.
bornes =[minn, maxx];
r = 2^nnl; % nombre de règles (modèle locaux).
%% define the systeme matrix
% on remplace chaque non linearité par le symbole n1,n2...etc
A =[-(ax+bx*n1)/alpha Rap/alpha; 0 -1/tau];
B =[0 ; 1/tau];
C = [tr+(f*n1) 0];
