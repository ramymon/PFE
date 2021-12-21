function [ K ] = FctPP( A,B,r,option,para,opt)
%Description :
%cette fonction calcule les gains K qui assurent que la paire A,B stable
% et placer les poles du système en BF dans des regions LMI desirées
% A et B matrices tridimentionnelle(tableau tridimentionnel) de dimension 3
% qui represente le modele de Takagi-Sugeno
% r : nombre de modele locaux /nombre de 
% option est un vecteur de 3 elements(chaque element correspand a une region)
% mettre 1 pour inclure la region

n = size(A(:,1),1); % nombre d'états par rapport aux lignes A1.
m = size(B(:,1),2); % nombre d'entrées(ou colomnes) de B1 (systeme SISO : m =1 ).


lampda = para (1);
R = para (2);
theta = para (3);
Cs = cos(theta);
Sn = sin(theta);

% Allocation 
N = struct('matrix',{zeros(m,n)});
K = struct('matrix',{zeros(m,n)});
%%
setlmis([]); %le debut de LMI.
P = lmivar(1,[n 1]); % X symetrique pleinne (n*n)

for i=1:r
N(i).matrix = lmivar(2,[m n]); %rectangulaire (m*n)
end

lmiterm([1 1 1 0],1)    % LMI#n°1 I<X:I
lmiterm([-1 1 1 P],1,1) % LMI#n°1 I<X:X
nb =1;

%%
if option(1) == 1
 for i=1:r
   j=i+1; %initialisation de j
   while(j<=r)
      nb=nb+1; 
      lmiterm([nb 1 1 P],A(:,:,i),1,'s') % X.Ai'+Ai.X
      lmiterm([nb 1 1 P],A(:,:,j),1,'s') % X.Aj'+Aj.X
      lmiterm([nb 1 1 N(j).matrix],B(:,:,i),-1,'s') % -Nj'.Bi'-Bi.Nj    
      lmiterm([nb 1 1 N(i).matrix],B(:,:,j),-1,'s') % -Ni'.Bj'-Bj.Ni
       lmiterm([nb 1 1 P],1,4*lampda) % 2(lampdaa)X

      j=j+1; %incrémentation de j
   end
end
 
 for i=1:r
 nb = nb+1;     
 lmiterm([nb 1 1 P],A(:,:,i),1,'s') %Ai.P+P.Ai'
 lmiterm([nb 1 1 N(i).matrix],B(:,:,i),-1,'s') %-Bi.Ni-Ni'.Bi'
 lmiterm([nb 1 1 P],1,2*lampda) % 2(lampdaa)X
 end 
end
%%
if option(2) == 1
 for i=1:r
   j=i+1; %initialisation de j
   while(j<=r)
      nb=nb+1; 
       lmiterm([nb 1 1 P],-R,1) %-rP
       lmiterm([nb 2 2 P],-R,1) %-rP
  
    lmiterm([nb 1 2 P],A(:,:,i),1) %Ai.P
 lmiterm([nb 1 2 N(j).matrix],B(:,:,i),-1) %-Bi.Nj
 lmiterm([nb 2 1 P],1,A(:,:,i)') %P.Ai'
 lmiterm([nb 2 1 -N(j).matrix],-1,B(:,:,i)') %-.Nj'Bi'
 
  lmiterm([nb 1 2 P],A(:,:,j),1) %Aj.P
 lmiterm([nb 1 2 N(i).matrix],B(:,:,j),-1) %-Bj.Ni
 lmiterm([nb 2 1 P],1,A(:,:,j)') %P.Aj'
 lmiterm([nb 2 1 -N(i).matrix],-1,B(:,:,j)') %-.Ni'Bj'
 j=j+1; %incrémentation de j
   end    
 end 
    
 for i=1:r
 nb = nb+1;  
  lmiterm([nb 1 1 P],-R,1) %-rP
  lmiterm([nb 2 2 P],-R,1) %-rP
 lmiterm([nb 1 2 P],A(:,:,i),1) %Ai.P
 lmiterm([nb 1 2 N(i).matrix],B(:,:,i),-1) %-Bi.Ni
 lmiterm([nb 2 1 P],1,A(:,:,i)') %P.Ai'
 lmiterm([nb 2 1 -N(i).matrix],-1,B(:,:,i)') %-.Ni'Bi'
 end 
end
%%
if option(3) == 1
 for i=1:r
   j=i+1; %initialisation de j
   while(j<=r)
      nb=nb+1; 
   lmiterm([nb 1 1 P],A(:,:,i),Sn,'s') %Ai.P+P.Ai'
 lmiterm([nb 1 1 N(j).matrix],B(:,:,i),-Sn,'s') %-Bi.Ni-Ni'.Bi'
 lmiterm([nb 2 2 P],A(:,:,i),Sn,'s') %Ai.P+P.Ai'
 lmiterm([nb 2 2 N(j).matrix],B(:,:,i),-Sn,'s') %-Bi.Ni-Ni'.Bi'
 
  lmiterm([nb 2 1 P],A(:,:,i),-Cs) %-Ai.P
 lmiterm([nb 2 1 N(j).matrix],B(:,:,i),Cs) %Bi.Ni
 lmiterm([nb 2 1 P],Cs,A(:,:,i)') %P.Ai'
 lmiterm([nb 2 1 -N(j).matrix],-Cs,B(:,:,i)') %-.Ni'Bi'
 
  lmiterm([nb 1 2 P],A(:,:,i),Cs) %Ai.P
 lmiterm([nb 1 2 N(j).matrix],B(:,:,i),-Cs) %-Bi.Ni
 lmiterm([nb 1 2 P],-Cs,A(:,:,i)') %-P.Ai'
 lmiterm([nb 1 2 -N(j).matrix],Cs,B(:,:,i)') %.Ni'Bi'
 
 lmiterm([nb 1 1 P],A(:,:,j),Sn,'s') %Ai.P+P.Ai'
 lmiterm([nb 1 1 N(i).matrix],B(:,:,j),-Sn,'s') %-Bi.Ni-Ni'.Bi'
 lmiterm([nb 2 2 P],A(:,:,j),Sn,'s') %Ai.P+P.Ai'
 lmiterm([nb 2 2 N(i).matrix],B(:,:,j),-Sn,'s') %-Bi.Ni-Ni'.Bi'
 
  lmiterm([nb 2 1 P],A(:,:,j),-Cs) %-Ai.P
 lmiterm([nb 2 1 N(i).matrix],B(:,:,j),Cs) %Bi.Ni
 lmiterm([nb 2 1 P],Cs,A(:,:,j)') %P.Ai'
 lmiterm([nb 2 1 -N(i).matrix],-Cs,B(:,:,j)') %-.Ni'Bi'
 
  lmiterm([nb 1 2 P],A(:,:,j),Cs) %Ai.P
 lmiterm([nb 1 2 N(i).matrix],B(:,:,j),-Cs) %-Bi.Ni
 lmiterm([nb 1 2 P],-Cs,A(:,:,j)') %-P.Ai'
 lmiterm([nb 1 2 -N(i).matrix],Cs,B(:,:,j)') %.Ni'Bi'
      j=j+1; %incrémentation de j
   end
end
 
 for i=1:r
 nb = nb+1;     
lmiterm([nb 1 1 P],A(:,:,i),Sn,'s') %Ai.P+P.Ai'
 lmiterm([nb 1 1 N(i).matrix],B(:,:,i),-Sn,'s') %-Bi.Ni-Ni'.Bi'
 lmiterm([nb 2 2 P],A(:,:,i),Sn,'s') %Ai.P+P.Ai'
 lmiterm([nb 2 2 N(i).matrix],B(:,:,i),-Sn,'s') %-Bi.Ni-Ni'.Bi'
 
  lmiterm([nb 2 1 P],A(:,:,i),-Cs) %-Ai.P
 lmiterm([nb 2 1 N(i).matrix],B(:,:,i),Cs) %Bi.Ni
 lmiterm([nb 2 1 P],Cs,A(:,:,i)') %P.Ai'
 lmiterm([nb 2 1 -N(i).matrix],-Cs,B(:,:,i)') %-.Ni'Bi'
 
  lmiterm([nb 1 2 P],A(:,:,i),Cs) %Ai.P
 lmiterm([nb 1 2 N(i).matrix],B(:,:,i),-Cs) %-Bi.Ni
 lmiterm([nb 1 2 P],-Cs,A(:,:,i)') %-P.Ai'
 lmiterm([nb 1 2 -N(i).matrix],Cs,B(:,:,i)') %.Ni'Bi'
 end 
end
%%
lmis = getlmis;   % La fin de LMI.
%% 

%1)finding matrix variables X and Ni if feasible(tmin<0)
  [t,xfeas] = feasp(lmis,[zeros(1,4) 1]);
%%
if t<=0 
   P = dec2mat(lmis,xfeas,P);
   for i=1:r
N(i).matrix = dec2mat(lmis,xfeas,N(i).matrix);
   end
% Calcule des terme en utilisant le changement de variable bejectif
for i=1:r
K(i).matrix = (N(i).matrix)*inv(P);
end
%%
if opt == 1
disp ("=====================================");
disp ("Les gains qui assure la stabilié sont");
for i=1:r
disp ("=====================================");
disp (["K" i]);
disp(K(i).matrix)
end
disp ("=====================================");
end
else 
    disp ("Le systeme LMI ne peut pas etre resolu");
    K = NaN;
end
end

