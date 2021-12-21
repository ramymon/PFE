function [ K ] = Gainfind(r,A,B,opt)
% Description :
% Cette fonction calucle les gain K qui assure que la paire A,B stable
% A et B matrices tridimentionnelle(tableau tridimentionnel) de dimension 3
% qui represente le modele de Takagi-Sogeno
% r : nombre de modele locaux /nombre de regles


n = size(A(:,1),1); % nombre d'états par rapport aux lignes A1.
m = size(B(:,1),2); % nombre d'entrées(ou colomnes) de B1 (systeme SISO : m =1 ).

N = struct('matrix',{zeros(m,n)});
K = struct('matrix',{zeros(m,n)});
%%
setlmis([]); %le debut de LMI.

X = lmivar(1,[n 1]); % X symetrique pleinne (n*n)
for i=1:r
N(i).matrix = lmivar(2,[m n]); % N sont des matrices rectangulaires inconnus(m*n)
end

lmiterm([1 1 1 0],1)    % LMI#n°1 X>I:I
lmiterm([-1 1 1 X],1,1) % LMI#n°1 X>I:X

nb = 1; %initialisation, nb = i : LMI(i)
 
 for i=1:r
   j=i+1; %initialisation de j
   while(j<=r)
      nb=i+j; 
      lmiterm([nb 1 1 X],A(:,:,i),1,'s') % X.Ai'+Ai.X
      lmiterm([nb 1 1 X],A(:,:,j),1,'s') % X.Aj'+Aj.X
      lmiterm([nb 1 1 N(j).matrix],B(:,:,i),-1,'s') % -Nj'.Bi'-Bi.Nj    
      lmiterm([nb 1 1 N(i).matrix],B(:,:,j),-1,'s') % -Ni'.Bj'-Bj.Ni
      j=j+1; %incrémentation de j
   end
 end
 for i=1:r
 nb = nb+1;     
 lmiterm([nb 1 1 X],A(:,:,i),1,'s') %Ai.X+X.Ai'
 lmiterm([nb 1 1 N(i).matrix],B(:,:,i),-1,'s') %-Bi.Ni-Ni'.Bi'
 
end    
lmis = getlmis;   % La fin de LMI.
%%
%1)finding matrix variables X and Ni if feasible(tmin<0)
  [t,xfeas] = feasp(lmis,[zeros(1,4) 1]);
%% 
if t<= 0 
    X = dec2mat(lmis,xfeas,X);
   for i=1:r
N(i).matrix = dec2mat(lmis,xfeas,N(i).matrix);
   end

M = inv(X); P = M;
for i=1:r
K(i).matrix = (N(i).matrix)*P;
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

