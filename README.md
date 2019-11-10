# 09/11/2019: Trabalho 2 de inteligência computacional
### Este repositório hospeda os arquivos necessários à execução do trabalho 2 realizado durante os estudos da disciplina de inteligência computacional

# Universidade Federal do Ceará
### Inteligência Computacional
### Professor: Jarbas Joaci de Mesquita Sá Júnior

### Construído em:

* [Scilab 6.0.2](https://www.scilab.org/) - Software open source para computação numérica
* [Linux Mint 19.2 Tina](https://www.linuxmint.com/) - Sistema operacional usado

### Autor:

* **José Lopes de S. Filho** - [LinkedIn](https://www.linkedin.com/in/joselopesfilho/)
* *Engenharia da Computação (UFC) - Matrícula # 389097*

### Licença:

Este projeto é licenciado sob a MIT License - ver o arquivo [LICENSE](LICENSE) para detalhes

## Questão 1

*1. Determine um modelo de regressão usando rede neural Extreme Learning Machine (ELM) para o conjunto de dados aerogerador.dat (variável de entrada: velocidade do vento, variável de saída: potência gerada). Avalie a qualidade do modelo pela métrica R2 (equação 48, slides sobre Regressão Múltipla) para diferentes quantidades de neurônios ocultos.*

### Iniciando 
Para a resolução desta questão e criação deste relatório foram usados os seguintes arquivos:

* [tr2_q1_elm.sce](tr2_q1_elm.sce) - Código-fonte da aplicação proposta na questão
* [aerogerador.dat](aerogerador.dat) - Conjunto de dados da questão
* [grafico_1n.png](grafico_1n.png) - Gráfico de saída da rede com 1 neurônio
* [grafico_7n.png](grafico_7n.png) - Gráfico de saída da rede com 7 neurônios
* [grafico_17n.png](grafico_17n.png) - Gráfico de saída da rede com 17 neurônios

## Código comentado

### Parte 1: Preparação dos dados da rede
Primeiramente, o conjunto de dados foi carregado e os dados de entrada e de saída foram divididos nos vetores X1 (entrada) e D (saída). Foi estipulado o número de neurônios *q*, o número de atributos *p* e o intervalo dos pesos *a* e *b*.
```
clc;    //Limpa a tela
clear;  //Limpa as variáveis armazenadas anteriormente

//Carrega a base de dados 'aerogerador.dat' na variável base
base = fscanfMat('aerogerador.dat');

X1 = base(:,1); //Armazena a primeira coluna da base de dados na variável X1
D = base(:,2);  //Armazena a segunda coluna na base de dados na variável D
q = 7;          //Número de neurônios ocultos
p = 1;          //Número de atributos
a = 0; b = 1;   //Intervalo dos pesos
```
### Parte 2: Inicialização aleatória dos pesos dos neurônios ocultos
A matriz W (matriz de pesos aleatórios) foi criada com *q* linhas e *p+1* colunas (p = número de atributos de entrada) com números aleatórios entre 0 e 1. Em seguida foi criada a matriz X (entradas) onde cada coluna corresponde a uma entrada na rede com dois valores. 1 do bias e o valor de entrada da base de dados. A matriz de saída D também foi transposta.

```
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
```
### Parte 3: Acúmulo das saídas dos neurônios ocultos *matriz u* e matriz da função de ativação Z
Nesta parte do código, foi criado a matriz com o acúmulo das saídas. Esses valores foram passados pela função de ativação e uma matriz Z com esses valores foi criada. Uma nova coluna de valores 1 foi inserida e a matriz transposta.

```
//Fase 2: Acúmulo das Saídas dos Neurônios Ocultos

u = W*X;                //Matriz de saída u onde cada coluna representa as saidas do set de neurônios
Z = 1./(1+exp(-u));     //Passa a matriz u pela função de ativação e armazena os valores em Z
Z = ([x_ones Z'])';     //Acrescenta uma coluna de 1s na matriz Z e a transpõe
```
### Parte 4: Cálculo dos pesos dos neurônios de saída
A matriz de pesos *M* é calculada usando método dos mínimos quadrados.

```
//Fase 3: Cálculo dos Pesos dos Neurônios de Saída

M = D*Z'*(Z*Z')^(-1);   //Aplica o método dos mínimos quadrados e encontra a matriz M de saída
```
### Parte 5: Ativação da rede
A rede é ativada criando o vetor linha Y que é a saída da rede.

```
//Teste e Capacidade de Generalização da Rede ELM

Y = M*Z;    //Ativa os neurônios da camada de saída
```
### Parte 6: Avaliação do modelo
Conforme solicitado na questão, o modelo é testado usando a métrica R2 e o resultado é exibido no console.
```
//Avaliação do modelo pela métrica R2
R2 = 1-(sum((D-Y).^2)/sum((D - mean(D)).^2));
disp(R2);
```
### Parte 7: Plotagem dos gráficos
Para finalizar os dois gráficos são plotados, o dos dados iniciais do aerogerador e o dos dados da saída da rede ELM.
```
//Plota os gráficos dos dados do aerogerador e da rede ativada
clf;
scatter(X1,base(:,2), "scilabblue2", ".");
plot2d(X1,Y);
xlabel("Regressão usando ELM (Extreme Learning machine");
```

## Discussão dos resultados obtidos

Ao executar o arquivo [tr2_q1_elm.sce](tr2_q1_elm.sce) no Scilab, podemos verificar basicamente duas ações: 
* A abertura da janela gráfica exibindo o gráfico da função da questão:

![grafico_q1](https://user-images.githubusercontent.com/51038132/65838269-cad03700-e2d7-11e9-9a1f-59569719ef10.png)

* O console irá retornar o valor máximo local encontrado:

![console_q1](https://user-images.githubusercontent.com/51038132/65838454-8a71b880-e2d9-11e9-844f-a746cb702366.png)

* A cada execução, como o hill climbing inicia em pontos aleatórios, podemos verificar que o algoritmo pode encontrar diferentes pontos máximos locais:

![console_q1_2](https://user-images.githubusercontent.com/51038132/65838467-c73daf80-e2d9-11e9-9026-72d3a7743170.png)

## Conclusão

O algoritmo Hill Climbing (subida de encosta) é capaz de encontrar a cada execução diferentes máximos locais, dependendo do valor *n* inicial.
