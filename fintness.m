function fitnessvalue=fintness(x)

global Ne Nce Nu Ts;

mdl='gfc199A_yen.mdl';
load_system(mdl);
assignin('base','Ne',x(1)); 
assignin('base','Nce',x(2));
assignin('base','Nu',x(3)); 
sim(mdl,10);

%%計算響應的指標
stepvalue = 1;
[OverShoot, AdjustTime, SteadyStateError] = Performance(t, y, stepvalue);
if(OverShoot<30)
    OverShoot=0;
end
if(AdjustTime<3)
    AdjustTime=0;
end
fitnessvalue=OverShoot*2+AdjustTime*10+(SteadyStateError*100)^2
