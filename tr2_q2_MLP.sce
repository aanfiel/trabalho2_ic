// SEGUNDO TRABALHO DE INTELIGÊNCIA COMPUTACIONAL
// Questão 2 (Perceptron Multi Camadas MLP)
// Aluno: José Lopes de Souza Filho
// Matrícula: 389097
// Aplicação: Scilab, versão 6.0.2
// SO: Linux Mint 19.2 Tina
// Para que esta aplicação rode apropriadamente deve ser instalado o 
// ANN Toolbox. (https://atoms.scilab.org/toolboxes/ANN_Toolbox)
//-----------------------------------------------------------------------------

clc;    //Limpa a tela
clear;  //Limpa as variáveis armazenadas anteriormente

// Assegura o mesmo ponto de início toda vez
rand('seed', 0);

// definição da rede
// 4 neurônios por rede, incluindo a entrada
// 4 neurônios na camada de entrada, 4 na camada oculta e 1 na camada de saída
N = [4,4,3];

//matriz de treinamento x deixando a primeira entrada de fora (leave-one-out)
base = fscanfMat('iris_log.dat');
x = base(2:150,1:4)';

//Saída desejada: 100 para classe 1, 010 para classe 2, 001 para classe 3
t = base(2:150,5:7)';

//Taxa de aprendizado e limite de erro tolerado pela rede
lp = [2.5, 0];

//Inicializa a matriz de pesos
W = ann_FF_init(N);

//Ciclos de treinamento
T = 100;

W = ann_FF_Std_online(x,t,N,W,lp,T);
//x é a matriz de treino t é a saída W são os pesos inicializados,
//N é a arquitetura da rede neural, lp é a taxa de aprendizado e
//T é o número de iterações

//Execução completa
retorno = ann_FF_run(x,N,W) //a rede N foi testada usando x como base de treino,
// e W como os pesos das conexões
