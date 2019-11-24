clear all 
clc 
warning('off','all') 
%{ 
開始設定初值  
Ne=1;Nce=1;Nu=1;Ts=0.5; 
二階系統 num(s)/den(s) = K / (s^2+5s+6), K = 32 
%} 
gfc=readfis('gfc'); %請自己設計gfc.fis 
global Ne Nce Nu Ts; 
Ne=1;Nce=2;Nu=3;Ts=0.5; 
K=32; %學號後二位數(例如: U04127001) 
  
%{ 
演算法設置（optimptions） 在學校電腦，設置無法使用！？ 
'...'  換行的意思 
#GA: 'PopulationSize',10, 'Generations',50,'PlotFcn', 'gaplotbestf' 
'Generations',50 ...                         % 迭代次數 
'PopulationSize', 60, ...                    % 染色體數量 
'MaxGenerations', 100, ...                   % 最大繁衍代數 
'PlotFcn', {@gaplotbestf, @my_plot}, ...     % 繪圖函數 @my_plot可以自定義，也可以
不寫 
    1. @gaplotbestf                          %最佳分數及平均分數 
    2. @gaplotscores                         %每代個體的分數 
    3. @gaplotdistance                       %每代個體間的平均距離 
    4. @gaplotscorediversity                 %繪製每一代分數的直方圖 
'CrossoverFraction', 0.8, ...                % 交配率 
'MutationFcn', {@mutationuniform, 0.1}, ...  % 突變率 
'Display', 'iter');                          % 結果展示方式 #PSO: 'SwarmSize',10,'MaxIterations',50,'PlotFcn','pswplotbestf' 
'SwarmSize',10 ...                           % 群體數量 
'MaxIterations',50 ...                       % 迭代次數 
'PlotFcn', {@gaplotbestf}, ...     % 繪圖函數 
'pswplotbestf' 
%} 
GA_options = optimoptions('ga','PopulationSize',10,'Generations',50,'PlotFcn',{@gaplotbestf}); 
%PSO_options = optimoptions('particleswarm','SwarmSize',10,'MaxIterations',50,'PlotFcn','pswplotbestf'); 

%{  
用下面程式或是打開 optimization tool 的 ga 
# 找尋Ne、Nce、Nu最佳值 
[x, fval] = ga(@fintness, nvars, A, B, C, D, LB, UB, [ ], IntCon, GA_options) 
[最佳解, 適應值] = ga(適應函數, 變數數量, A, B, C, D, 下界(-2), 上界(2), 非線性約束
式, 整數欄位, 參數) 
其中，限制式為：A*x < B、C*x = D。 
 A*x' - b 
%}
A = []; 
b = []; 
%Aeq = [-1 1]; 
%beq = 5; 
fun = @fintness; 
[x, fval] = ga(fun,3,A,b,[],[],-2,2,[],[],GA_options); 
disp(A*x' - b); 
