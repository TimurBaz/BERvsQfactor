clear;close all;

data=readtable('ParamPin/ParamPin_ERandJitter_vs_Disp.xlsx');
fSize=30;

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
ymax=18;
xmin=-3000+L*d;
xmax=2000+L*d;

for k=0:6
    disper=double(string(data{2:end,5*k+2}));
    DJpp=double(string(data{2:end,5*k+5}));
    ER=double(string(data{2:end,5*k+1}));

    OSNRreq=2*QfactorReq*(ER+1)./(ER-1);
    OSNRreq=10*log10(OSNRreq);
    f=figure('Position',[1,1,1800,400]);
    subplot(1,3,1);
    plot(disper+L*d,OSNRreq,'Linewidth',5);

    ylim([ymin,ymax])
    xlim([xmin,xmax])
    set(gca,'FontSize',fSize-4)
    xlabel('Remaining dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylabel('OSNRreqER, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');

    OSNRreqJ=2*QfactorReq*tr./((JTpp-DJpp)*0.6);
    OSNRreqJ=10*log10(OSNRreqJ);

    subplot(1,3,2);
    plot(disper+L*d,OSNRreqJ,'Linewidth',5);

    set(gca,'FontSize',fSize-4)
    xlabel('Remaining dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylabel('OSNRreqJit, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylim([ymin,ymax])
    xlim([xmin,xmax])

    subplot(1,3,3);
    plot(disper+L*d,max(OSNRreq,OSNRreqJ),'Linewidth',5);

    set(gca,'FontSize',fSize-4)
    xlabel('Remaining dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylabel('OSNRreq, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
    ylim([ymin,ymax])
    xlim([xmin,xmax])
    pause;
end