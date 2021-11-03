function Rea2(ser,~)

global q3
global q2
global q1

i=1;
%uncomment for graph
%thetaNplot = zeros(1,25);
%phiNplot= zeros(1,25);
%thetaRplot = zeros(1,25);

pitchOld = 0;
rollOld = 0;
yawOld = 0;
persistent sOld;
tic;

while i>0 
    if isempty(sOld)
        sOld = toc;
        dTime = 0;
    end
    
    val = fscanf(ser);
    numVal = str2num(val);
    n = numel( numVal );
    if n == 4
        %Obtains Euler Parameters (Quaternions) from Artemis
        q1(11) = numVal(1);
        q1(1) = [];
        q1(11:end) = [];
        
        q2(11) = numVal(2);
        q2(1) = [];
        q2(11:end) = [];
        
        q3(11) = numVal(3);
        q3(1) = [];
        q3(11:end) = [];
        
        %q0
        q0 = double(sqrt(abs(( 1.0 - ((q1(10) * q1(10)) + (q2(10) * q2(10)) + (q3(10) * q3(10)))))));
        q2sqr = double(q2(10) * q2(10));
            
        %roll calculation from parameters
        t0 = double(+2.0 * (q0 * q1(10) + q2(10) * q3(10)));
        t1 = double(+1.0 - 2.0 * (q1(10) * q1(10) + q2sqr));
        rollNew = double(atan2(t0, t1) * 180.0 / pi);
        
        dTime = toc - sOld;
        sOld = toc;
        
        %pitch calculation using euler parameters
        t2 = double(+2.0 * (q0 * q2(10) - q3(10) * q1(10)));
        if t2 >= 1
            pitchNew = double(90);
        elseif t2<= -1
            pitchNew = double(-90);
        else
            pitchNew = double(asin(t2) * 180.0 / pi);
        end
        %yaw calculation
        t3 = double(+2.0 * (q0 * q3(10) + q1(10) * q2(10)));
        t4 = double(+1.0 - 2.0 * (q2sqr + q3(10) * q3(10)));
        yawNew = double(atan2(t3, t4) * 180.0 / pi);
        
        % theta dot calculation
        omegaPitch = (pitchNew-pitchOld)/dTime;
        omegaRoll = (rollNew-rollOld)/dTime;
        omegaR = (yawNew - yawOld)/dTime;
                
        pitchOld = pitchNew;
        rollOld = rollNew;
        yawOld = yawNew;
        
        %Angular momentum calculation
        %Moment of inertia may need to be changed
        Lpitch = omegaPitch*.76;
        Lroll = omegaRoll*.76;
        Lyaw = omegaR*.76;
        
      Val = ["Ang" "AngVel" "AngMom"]';
      Pitch = [pitchNew omegaPitch Lpitch]';
      Roll = [rollNew omegaRoll Lroll]';
      Yaw = [yawNew omegaR Lyaw]';
      T = table(Val,Pitch,Roll,Yaw);
      disp(T)
      
      %uncomment below for a graph
        %thetaNplot(25) = rollNew;
        %thetaNplot(1) = [];
        %phiNplot(25) = pitchNew;
        %phiNplot(1) = [];
        %thetaRplot(26) = yawNew;
        %thetaRplot(1) = [];
    end
    
   %uncomment for a graph 
   %plot(thetaNplot);
   %hold on
   %plot(phiNplot);
   %plot(thetaRplot);
   %hold off
   %axis([0 inf -90 90])
   %drawnow
   
   i= i+1;
end

end