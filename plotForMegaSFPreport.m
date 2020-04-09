clear;close all;

data=readtable('ParamPin/ParamPin_ERandJitter_vs_Disp.xlsx');
fSize=14;
Lsize=2;

QfactorReq=7;
L=100;
d=18;

%time is measured in unit intervals (UI)
BW=7.5;%ГГц
tb=1/10;
tr=0.22/BW;
tr=tr/tb;
JTpp=0.35;


ymin=12;
ymax=16;
xmin=-3000+L*d;
xmax=2000+L*d;

Pins = [4,10:15];

f=figure('Position',[1,1,600,1600]);

for k=0:6
    disper=double(string(data{2:end,5*k+2}));
    DJpp=double(string(data{2:end,5*k+5}))*0;
    ER=double(string(data{2:end,5*k+1}));

    OSNRreq=2*QfactorReq*(ER+1)./(ER-1);
    OSNRreq=10*log10(OSNRreq);
    
    subplot(4,2,k+1);
    plot(disper+L*d,OSNRreq,'Linewidth',Lsize);
    
    ylim([ymin,ymax])
    xlim([xmin,xmax])
    set(gca,'FontSize',fSize)
    xlabel('Остаточная дисперсия, пс/нм','FontName','Times New Roman','FontSize', fSize, 'Color', 'black', 'FontWeight', 'normal');
    ylabel('SNRreq, дБ','FontName','Times New Roman','FontSize', fSize, 'Color', 'black', 'FontWeight', 'normal');
    title(['Мощность = ',char(string(Pins(k+1))),' дБм'],'FontName','Times New Roman','FontSize', fSize, 'Color', 'black', 'FontWeight', 'normal')
end