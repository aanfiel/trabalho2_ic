// SEGUNDO TRABALHO DE INTELIGÊNCIA COMPUTACIONAL
// Questão 2 (Perceptron)
// Aluno: José Lopes de Souza Filho
// Matrícula: 389097
// Aplicação: Scilab, versão 6.0.2
// SO: Linux Mint 19.2 Tina
//-----------------------------------------------------------------------------

clc;    //Limpa a tela
clear;  //Limpa as variáveis armazenadas anteriormente

base = fscanfMat ('iris_log.dat');  //Carrega a base de dados
q = 3;                              //qtd de neurônios 
p = 4;                              //qtd atributos
n = 0.001;                          //taxa de aprendizagem
X = base(:,1:4);                    //Carrega os dados de entrada na variável X
D = base(:,5:7);                    //Carrega as saídas na variável D
x_ones = ones(150,1)*(-1);          //Cria um vetor de 1s (bias)
X = [x_ones X];                     //Insere o vetor de 1s na entrada (bias)
W = zeros(q,p+1);                   //Cria a matriz de pesos
X = X';                             //Transpõe a matriz de entrada
D = D';                             //Transpõe a matriz de saída

//Método leave-one-out
disp("método leave-one-out: ");
for x = 1 : 150
    if (x==1)
        lista = [x+1 : 150];
    else
        lista = [1:x-1, x+1 : 150];
    end
    for i = lista
        Y = W*X(:,i);
        E = D(:,i) - Y;
        A = (X(:,i))';
        W = W + n*E*A;
       
    end
    XT = X(:,x);
    YT(:,x) = W*XT;
end
ach = 0;
for i = 1 : 150
    
    if(max(YT(:,i)) == YT(1,i))
        YT(:,i) = [1; 0; 0];
    elseif(max(YT(:,i)) == YT(2,i))
        YT(:,i) = [0; 1; 0];
    else
        YT(:,i) = [0; 0; 1];
    end
    if(YT(:,i) == D(:,i))
        ach = ach+1;
    end
end

disp("Acurácia do método leave-one-out: ");
disp(ach/150);
