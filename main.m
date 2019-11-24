clear all 
clc 
warning('off','all') 
%{ 
�}�l�]�w���  
Ne=1;Nce=1;Nu=1;Ts=0.5; 
�G���t�� num(s)/den(s) = K / (s^2+5s+6), K = 32 
%} 
gfc=readfis('gfc'); %�Цۤv�]�pgfc.fis 
global Ne Nce Nu Ts; 
Ne=1;Nce=2;Nu=3;Ts=0.5; 
K=32; %�Ǹ���G���(�Ҧp: U04127001) 
  
%{ 
�t��k�]�m�]optimptions�^ �b�Ǯչq���A�]�m�L�k�ϥΡI�H 
'...'  ���檺�N�� 
#GA: 'PopulationSize',10, 'Generations',50,'PlotFcn', 'gaplotbestf' 
'Generations',50 ...                         % ���N���� 
'PopulationSize', 60, ...                    % �V����ƶq 
'MaxGenerations', 100, ...                   % �̤j�c�l�N�� 
'PlotFcn', {@gaplotbestf, @my_plot}, ...     % ø�Ϩ�� @my_plot�i�H�۩w�q�A�]�i�H
���g 
    1. @gaplotbestf                          %�̨Τ��ƤΥ������� 
    2. @gaplotscores                         %�C�N���骺���� 
    3. @gaplotdistance                       %�C�N���鶡�������Z�� 
    4. @gaplotscorediversity                 %ø�s�C�@�N���ƪ������ 
'CrossoverFraction', 0.8, ...                % ��t�v 
'MutationFcn', {@mutationuniform, 0.1}, ...  % ���ܲv 
'Display', 'iter');                          % ���G�i�ܤ覡 #PSO: 'SwarmSize',10,'MaxIterations',50,'PlotFcn','pswplotbestf' 
'SwarmSize',10 ...                           % �s��ƶq 
'MaxIterations',50 ...                       % ���N���� 
'PlotFcn', {@gaplotbestf}, ...     % ø�Ϩ�� 
'pswplotbestf' 
%} 
GA_options = optimoptions('ga','PopulationSize',10,'Generations',50,'PlotFcn',{@gaplotbestf}); 
%PSO_options = optimoptions('particleswarm','SwarmSize',10,'MaxIterations',50,'PlotFcn','pswplotbestf'); 

%{  
�ΤU���{���άO���} optimization tool �� ga 
# ��MNe�BNce�BNu�̨έ� 
[x, fval] = ga(@fintness, nvars, A, B, C, D, LB, UB, [ ], IntCon, GA_options) 
[�̨θ�, �A����] = ga(�A�����, �ܼƼƶq, A, B, C, D, �U��(-2), �W��(2), �D�u�ʬ���
��, ������, �Ѽ�) 
�䤤�A������GA*x < B�BC*x = D�C 
 A*x' - b 
%}
A = []; 
b = []; 
%Aeq = [-1 1]; 
%beq = 5; 
fun = @fintness; 
[x, fval] = ga(fun,3,A,b,[],[],-2,2,[],[],GA_options); 
disp(A*x' - b); 
