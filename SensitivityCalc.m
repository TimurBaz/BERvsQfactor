clear;close all;

data=readtable('ERandJitter_vs_Disp_3.xlsx');
fSize=40;

QfactorReq=7;
L=100;
d=18;

%time is measured in unit intervals (UI)
BW=7;%ГГц
tb=1/10;
tr=0.22/BW;
tr=tr/tb;
JTpp=0.3;
DJpp=data.RMSJitter;

ymin=12;
ymax=18;

OSNRreq=2*QfactorReq*(data.ER+1)./(data.ER-1);
OSNRreq=10*log10(OSNRreq);
figure;
plot(data.Disp+L*d,OSNRreq,'Linewidth',5);

ylim([ymin,ymax])
set(gca,'FontSize',fSize-4)
xlabel('Remaining dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
ylabel('OSNRreq, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');

OSNRreqJ=2*QfactorReq*tr./((JTpp-DJpp)*0.6);
OSNRreqJ=10*log10(OSNRreqJ);

figure;
plot(data.Disp+L*d,OSNRreqJ,'Linewidth',5);

set(gca,'FontSize',fSize-4)
xlabel('Remaining dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
ylabel('OSNRreqJit, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
ylim([ymin,ymax])

figure;
plot(data.Disp+L*d,max(OSNRreq,OSNRreqJ),'Linewidth',5);

set(gca,'FontSize',fSize-4)
xlabel('Remaining dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
ylabel('OSNRreqJit, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
ylim([ymin,ymax])