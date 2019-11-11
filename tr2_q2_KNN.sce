// SEGUNDO TRABALHO DE INTELIGÊNCIA COMPUTACIONAL
// Questão 2 (K Nearest neighbors KNN)
// Aluno: José Lopes de Souza Filho
// Matrícula: 389097
// Aplicação: Scilab, versão 6.0.2
// SO: Linux Mint 19.2 Tina
//-----------------------------------------------------------------------------

//PARTE 1: AJUSTES INICIAIS

clc;    //Limpa a tela
clear;  //Limpa as variáveis armazenadas anteriormente

//Importando a base de dados iris_log.dat para a variável ibase2
ibase2 = fscanfMat('iris_log.dat');

/*separando a primeira entrada para teste posterior (leave-one-out)
//para teste posterior basta entrar com os valores (5.1, 3.5, 1.4, 2.0) 
e verificar retorno 1 0 0 (flor setosa) nas entradas quando solicitado*/
ibase3 = ibase2(2:150,:);

//Normalização z-score da base de dados
C1 = mean(ibase3(:,1));     //Média da primeira coluna dos dados
P1 = stdev(ibase3(:,1));    //Desvio padrão da primeira coluna dos dados
C2 = mean(ibase3(:,2));     //Média da segunda coluna dos dados
P2 = stdev(ibase3(:,2));    //Desvio padrão da segunda coluna dos dados
C3 = mean(ibase3(:,3));     //Média da terceira coluna dos dados
P3 = stdev(ibase3(:,3));    //desvio padrão da terceira coluna dos dados
C4 = mean(ibase3(:,4));     //Média da quarta coluna dos dados
P4 = stdev(ibase3(:,4));    //Desvio padrão da quarta coluna dos dados
ibase(:,1) = (ibase3(:,1)-C1)./P1;  //Aplica Z-score na primeira coluna
ibase(:,2) = (ibase3(:,2)-C2)./P2;  //Aplica Z-score na segunda coluna
ibase(:,3) = (ibase3(:,3)-C3)./P3;  //Aplica Z-score na terceira coluna
ibase(:,4) = (ibase3(:,4)-C4)./P4;  //Aplica Z-score na quarta coluna
ibase(:,5) = (ibase3(:,5));     //Copia os dados da base para a quinta coluna
ibase(:,6) = (ibase3(:,6));     //Copia os dados da base para a sexta coluna
ibase(:,7) = (ibase3(:,7));     //Copia os dados da base para a sétima coluna

//PARTE 2: SOLICITA OS DADOS DO USUÁRIO

disp('---------------- ROBÔ BOTÂNICO USANDO KNN ------------------------------');
k = input('Quantos valores você gostaria de comparar? (k) -> ');
G = input('Qual a largura da sépala? (em cm) -> ');
H = input('Qual o comprimento da sépala? (em cm) -> ');
I = input('Qual a largura da pétala? (em cm) -> ');
J = input('Qual o comprimento da pétala? (em cm) -> ');

//Normaliza os dados da entrada
ponto_teste(1,1) = ((G-C1)/P1);
ponto_teste(1,2) = ((H-C2)/P2);
ponto_teste(1,3) = ((I-C3)/P3);
ponto_teste(1,4) = ((J-C4)/P4);

//PARTE 3: CALCULANDO A DISTANCIA EUCLIDIANA DOS PONTOS

tam = size(ibase, 1);   // numero de linhas da matriz

for i=1:tam
    linha = ibase(i,1:4);
    resultado(i,:) = linha-ponto_teste;
    resultado2 = resultado.^2;
    d_euclidiana(i,:) = sqrt(sum(resultado2(i,:)));
end

base2 = [d_euclidiana, ibase];  //Cria uma nova matriz com as distâncias euclidianas inseridas

//PARTE 4: SELECIONANDO OS K MENORES VALORES

for i=1:k
    [min_valor, min_linha] = min(base2(:,1));
    k_menores(i,:) = base2(min_linha,:);
    base2(min_linha,:) = [];
end

disp("Os "+ string(k) +" valores mais próximos da sua escolha na base de dados são:");
disp(k_menores);

//PARTE 5: CONTANDO O NÚMERO DE ENTRADAS 1 EM CADA COLUNA DO RESULTADO

[nb6, loc6] = members(1, k_menores(:,6));
[nb7, loc7] = members(1, k_menores(:,7));
[nb8, loc8] = members(1, k_menores(:,8));

//Verifica qual das 3 colunas possui mais entradas 1. Esta será a escolha do sistema
[w,y] = max(nb6, nb7, nb8);     

//PARTE FINAL: CLASSIFICANDO O TIPO DE FLOR DE ACORDO COM O RESULTADO

if y==1 then
    disp("A flor é do tipo setosa!");
elseif y==2 then
    disp("A flor é do tipo versicolor!");
elseif y==3 then
    disp("A flor é do tipo virginica!");
end
