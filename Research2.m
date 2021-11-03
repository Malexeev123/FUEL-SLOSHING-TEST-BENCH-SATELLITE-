function Research2
instrreset
global q3
global q2
global q1
global serialObject

serialPort = 'COM3';
serialObject = serial(serialPort);
serialObject.Baudrate = 115200; % Set the baud rate at the specific value
serialObject.BytesAvailableFcn = {@Rea2};

q1 = zeros(1,10);
q2 = zeros(1,10);
q3 = zeros(1,10);
    

fopen(serialObject)
end




