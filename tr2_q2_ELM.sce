// SEGUNDO TRABALHO DE INTELIGÊNCIA COMPUTACIONAL
// Questão 2 (ELM)
// Aluno: José Lopes de Souza Filho
// Matrícula: 389097
// Aplicação: Scilab, versão 6.0.2
// SO: Linux Mint 19.2 Tina
//-----------------------------------------------------------------------------

clear;
clc;
base = fscanfMat('iris_log.dat');
X = base(:,1:4);
D = base(:,5:7);
q = 9; //qtd de neurônios ocultos
p = 4; //qtd atributos
a=0; b=0.1; // define intervalo dos pesos

x_ones  = ones(150,1);
X = [x_ones X];
X = X';
D = D';


//----------------leave-one-out--------------------------------------------
disp("método leave-one-out: \n");
W=a+(b-a).*rand(q,p+1); // gera numeros uniformes
YT1 = [];
for x = 1 : 150
    XT = X(:,x);
    DT = D(:,x);
    if (x==1)
        XTR = X(:,x+1 : 150);
        DTR = D(:,x+1 : 150);
      
    else
        XTR = X(:,[1:x-1, x+1 : 150]);
        DTR = D(:,[1:x-1, x+1 : 150]);
        
    end
    u1 = W*XTR;
    Z1 = 1./(1+exp(-u1));
    Z1 = [ones(1,149); Z1];
    M1 = DTR*Z1'*(Z1*Z1')^(-1);

    ut1 = W*XT;
    ZT1 = 1./(1+exp(-ut1));
    ZT1 = [ones(1,1); ZT1];
    ach = 0;
    YT1 = [YT1 M1*ZT1]; 
    
end

ach = 0;
for i = 1 : 150
    
    if(max(YT1(:,i)) == YT1(1,i))
        YT1(:,i) = [1; 0; 0];
    elseif(max(YT1(:,i)) == YT1(2,i))
        YT1(:,i) = [0; 1; 0];
    else
        YT1(:,i) = [0; 0; 1];
    end
    if(YT1(:,i) == D(:,i))
        ach = ach+1;
    end
end
// disp(YT1');
disp("Acuracia do método leave-one-out: ");
disp(ach/150);
