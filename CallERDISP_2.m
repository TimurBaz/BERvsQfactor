clearvars;
close all;


% create a COM server running OptiSystem
optsys = actxserver('optisystem.application');

% Section looks for OptiSystem process and waits for it to start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Execute the system command
        taskToLookFor = 'OptiSystemx64.exe';
        % Now make up the command line with the proper argument
        % that will find only the process we are looking for.
        commandLine = sprintf('tasklist /FI "IMAGENAME eq %s"', taskToLookFor);
        % Now execute that command line and accept the result into "result".
        [status, result] = system(commandLine);
        % Look for our program's name in the result variable.
        itIsRunning = strfind(lower(result), lower(taskToLookFor));
        while isempty(itIsRunning)
          % pause(0.1)
           [status, result] = system(commandLine);
             itIsRunning = strfind(lower(result), lower(taskToLookFor));    
        end
%%%%%%%%%%%%%%%%%%%%%%%%%
directory = strcat(pwd,'\ER(DISP).osd');
optsys.Open(directory);

Document = optsys.GetActiveDocument;

LayoutMgr = Document.GetLayoutMgr;
Layout = LayoutMgr.GetCurrentLayout;
Canvas = Layout.GetCurrentCanvas;
Visualizer = Canvas.GetComponentByName('BER Analyzer');
PmMgr = Layout.GetParameterMgr;

EyeOsc = Canvas.GetComponentByName('Eye Diagram Analyzer');
BERAn = Canvas.GetComponentByName('BER Analyzer');

Pin=[4,10];
Disps=-3000:100:2000;
NN=length(Disps);

ER=zeros(1,NN);
Jit=zeros(1,NN);

meas.Pin=0;
meas.ER=zeros(1,NN);
meas.Jit=zeros(1,NN);

meass(1,length(Pin)) = meas;

for p=1:length(Pin)
    Layout.SetParameterValue('Pin', Pin(p));
    meass(p).Pin=Pin(p);
    for d=1:NN
          Layout.SetParameterValue('Disp',Disps(d));
          Document.CalculateProject( true , true);
          ER(d)=EyeOsc.GetResultValue('Extinction Ratio at Min. BER');
          Jit(d) = BERAn.GetResultValue("RMS Jitter at User Defined Threshold (UI)");
    end
    meass(p).ER=ER;
    meass(p).Jit=Jit;
end
% vary the parameters, run OptiSystem project and get the results
optsys.Quit;

QfactorReq=7;
L=100;
d=18;
OSNRreq=2*QfactorReq*(meass(1).ER+1)./(meass(1).ER-1);
OSNRreq=10*log10(OSNRreq);

figure;
plot(Disps+L*d,OSNRreq)

figure;
OSNRreq=2*QfactorReq*(meass(2).ER+1)./(meass(2).ER-1);
OSNRreq=10*log10(OSNRreq);
plot(Disps+L*d,OSNRreq)
