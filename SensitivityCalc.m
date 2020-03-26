clear;close all;

data=readtable('ERandJitter_vs_Disp.xlsx');
fSize=40;
%plot(data.Disp, data.ER)

QfactorReq=7;
NTIA = 1;
Rval=0.5;
OMAmin=2*NTIA*QfactorReq/Rval;
Sens=OMAmin/2*(data.ER+1)./(data.ER-1);

%plot(data.Disp,10*log10(Sens/1000))

OSNRreq=2*QfactorReq*(data.ER+1)./(data.ER-1);
OSNRreq=10*log10(OSNRreq);
plot(data.Disp+18*80,OSNRreq,'Linewidth',5);
%xlabel('Остаточная дисперсия');
%ylabel('Требуемый OSNR')

set(gca,'FontSize',fSize-4)
xlabel('Remaining dispersion, ps/nm','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');
ylabel('OSNRreq, dB','Interpreter','latex','FontSize', fSize, 'Color', 'black', 'FontWeight', 'bold');


%plot(data.Disp,data.Q)
