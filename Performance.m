function [PO,ST,Err]=Performance(t,y,stepvlue)
k=find((y>stepvlue*1.02)|(y<stepvlue*0.98),1,'last');
ST=t(k);
PO=((max(y)-mean(y(k:end)))/mean(y(k:end)))*100;
Err=abs(stepvlue-mean(y(k:end)));