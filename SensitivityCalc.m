clear;close all;

data=readtable('ParamPin/ParamPin_InitJitIncluded.xlsx');
fSize=12;
Lsize=2;

QfactorReq=7;
L=100;
d=18;

%time is measured in unit intervals (UI)
BW=7.5;%ГГц
tb=1/10;
tr=0.22/BW;
tr=tr/tb;
JTpp=0.5;


ymin=12;
ymax=15;
%xmin=-3000+L*d;
%xmax=2000+L*d;
xmin=-200;
xmax=1700;

Pins = [4,10:15];

f=figure('Position',[1,1,600,1600]);

for k=0:6
    disper=double(string(data{2:end,5*k+2}));
    DJpp=double(string(data{2:end,5*k+5}))*2*0;
    ER=double(string(data{2:end,5*k+1}));

    OSNRreq=2*QfactorReq*(ER+1)./(ER-1);
    OSNRreq=10*log10(OSNRreq);
    
    subplot(7,3,3*k+1);
    plot(disper+L*d,OSNRreq,'Linewidth',Lsize);

    ylim([ymin,ymax])
    xlim([xmin,xmax])
    set(gca,'FontSize',fSize-4)
    xlabel('Resudial dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylabel('OSNRreqER, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');

    OSNRreqJ=2*QfactorReq*tr./((JTpp-DJpp)*0.6);
    OSNRreqJ=10*log10(OSNRreqJ);

    subplot(7,3,3*k+2);
    plot(disper+L*d,OSNRreqJ,'Linewidth',Lsize);
    title(['$P_{in}$ = ',char(string(Pins(k+1))),' dBm'],'Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold')

    set(gca,'FontSize',fSize-4)
    xlabel('Resudial dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylabel('OSNRreqJit, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylim([ymin,ymax])
    xlim([xmin,xmax])

    subplot(7,3,3*k+3);
    plot(disper+L*d,max(OSNRreq,OSNRreqJ),'Linewidth',Lsize);

    set(gca,'FontSize',fSize-4)
    xlabel('Resudial dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylabel('OSNRreq, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylim([ymin,ymax])
    xlim([xmin,xmax])
    %pause;
end