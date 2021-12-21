function [At,Bt,Ct] = TakagiSugeno( nnl,min,max,A,B,C )
% Description:
% Cette fonction calcule le modele flou TS (Modèle linéare par secteur).
% nnl : nombre de non linearité.
% max : vecteur de borne superieure de chaque non linearité.
% minn : vecteur de borne inferieure de chaque non linearité.

r = 2^nnl; %nombre de regles

index =[[max ;min]';zeros(5,2)]; % zeros(f,2) f est le nombre de symboles utilsiés, si le systeme a plus de 5 on doit faire un changement.
syms n1 n2 n3 n4 n5 % 5 symboles

n = size(A(:,1),1); % nombre d'états par rapport aux lignes A1.
m = size(B(:,1),2); % nombre d'entrées(ou colomnes) de B1 (systeme SISO : m = 1 ).
p = size(C(:,1),1); % nombre de sorties(ou lignes) de C1 (systeme SISO : p = 1).

%Prelocation de l'espace pour les matrices A,B,C flous :
Ats = struct('sys',{zeros(n,n)});
Bts = struct('sys',{zeros(m,1)});
Cts = struct('sys',{zeros(p,n)});

%%
i=1; %initialisation.
% Combinaison :
for n55 = index(5,:)
    for n44 = index(4,:)
        for n33 = index(3,:)
            for n22 = index(2,:)
                for n11 = index(1,:)
        Ats(i).sys = double(subs(A,{n1,n2,n3,n4,n5},{n11,n22,n33,n44,n55}));
        Bts(i).sys = double(subs(B,{n1,n2,n3,n4,n5},[n11,n22,n33,n44,n55]));
        Cts(i).sys = double(subs(C,{n1,n2,n3,n4,n5},[n11,n22,n33,n44,n55]));
        i = i+1;
                end
            end
        end
    end
end
%% 
 disp ("===========================");
  disp ("Le modèle flou TS est :");
  disp ("===========================");
for i =1:r
 disp(["A", i]); 
 disp(Ats(i).sys); 
  disp ("**************************");
 disp(["B", i]); 
 disp(Bts(i).sys );
  disp ("**************************");
 disp(["C", i]); 
 disp(Cts(i).sys );
disp ("=================================");
end
At=cat(3,Ats(1:r).sys);
Bt=cat(3,Bts(1:r).sys);
Ct=cat(3,Cts(1:r).sys);

end