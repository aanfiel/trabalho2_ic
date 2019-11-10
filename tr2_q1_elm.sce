// SEGUNDO TRABALHO DE INTELIGÊNCIA COMPUTACIONAL
// Questão 1
// Aluno: José Lopes de Souza Filho
// Matrícula: 389097
// Aplicação: Scilab, versão 6.0.2
// SO: Linux Mint 19.2 Tina
//-----------------------------------------------------------------------------

clc;    //Limpa a tela
clear;  //Limpa as variáveis armazenadas anteriormente

//Carrega a base de dados 'aerogerador.dat' na variável base
base = fscanfMat('aerogerador.dat');

X1 = base(:,1); //Armazena a primeira coluna da base de dados na variável X1
D = base(:,2);  //Armazena a segunda coluna na base de dados na variável D
q = 7;          //Número de neurônios ocultos
p = 1;          //Número de atributos
a = 0; b = 1;   //Intervalo dos pesos

//Fase 1: Inicialização Aleatória dos Pesos dos Neurônios Ocultos

//matriz de pesos aleatórios W, com q linhas e p + 1 colunas
W = a + (b - a).*rand(q,p+1);

x_ones = ones(2250,1);  //Vetor coluna com 2250 linhas de 1s

/*Reorganiza o vetor de entrada X onde a primeira coluna representa
a entrada bias (valores 1) e a segunda coluna representa os valores
dos dados de entrada coletados. */

X(:,1) = x_ones;
X(:,2) = X1;
X = X';         //Transpõe a matriz X (cada coluna corresponde a uma entrada)
D = D';         //Transpõe a matriz D (cada coluna corresponde a uma saída)

//Fase 2: Acúmulo das Saídas dos Neurônios Ocultos

u = W*X;                //Matriz de saída u onde cada coluna representa as saidas do set de neurônios
Z = 1./(1+exp(-u));     //Passa a matriz u pela função de ativação e armazena os valores em Z
Z = ([x_ones Z'])';     //Acrescenta uma coluna de 1s na matriz Z e a transpõe

//Fase 3: Cálculo dos Pesos dos Neurônios de Saída

M = D*Z'*(Z*Z')^(-1);   //Aplica o método dos mínimos quadrados e encontra a matriz M de saída

//Teste e Capacidade de Generalização da Rede ELM

Y = M*Z;    //Ativa os neurônios da camada de saída

//Avaliação do modelo pela métrica R2
R2 = 1-(sum((D-Y).^2)/sum((D - mean(D)).^2));

//Plota os gráficos dos dados do aerogerador e da rede ativada
clf;
disp(R2);
scatter(X1,base(:,2), "scilabblue2", ".");
plot2d(X1,Y);
xlabel("Regressão usando ELM (Extreme Learning machine");
