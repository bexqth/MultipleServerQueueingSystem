%cleaning shop
clc;
clear;
%settings
normalDis = makedist("Normal", "mu", 3, "sigma", 0.5);
uniformDis = makedist("uniform", "lower", 5, "upper", 10);
c = 3;
serviceTimeQuick = 4;
serviceTimeSlow = 12;
inf = intmax;
tMax = 60;
arrivalsIntoNode = [];
arrivalsIntoService = [];
leavesFromService = [];
timeInNode = [];

%init
t = 0;
l = 0;
ta = 2;
arrayXs = [0, 0, 0];
calendar = [ta, inf, inf, inf];

while (t < tMax) || (l > 0) %check time or there is someone in the node
    [minCalendarValue, type] = min(calendar);
    t = minCalendarValue;    
    if type == 1 %arrival
        l = l + 1;
        arrivalsIntoNode(end +1) = t;
        if t <= 10
            ta = ta + 2;
        elseif t > 10 && t <= 30
            randomArrival = random(normalDis, 1,1);
            ta = ta + randomArrival;
        elseif t <= 60
            randomArrival = random(uniformDis, 1,1);
            ta = ta + randomArrival;
        end
        if ta > tMax
            calendar(1) = inf;
        else
           calendar(1) = ta; 
        end

        if l <= c
            arrivalsIntoService(end +1) = t;
            randomInt = rand(1);
            freeServiceIndex = find(arrayXs == 0, 1);
            if randomInt <= 0.4
                calendar(freeServiceIndex + 1) = t + serviceTimeQuick;
            else
                calendar(freeServiceIndex + 1) = t + serviceTimeSlow;
            end
            
            arrayXs(freeServiceIndex) = 1;
        else
            %in queue
        end 

    else %leave
        l = l - 1;
        leavesFromService(end + 1) = t;
        indexOfServiceInCalendar = type;
        if l >= c
            arrivalsIntoService(end +1) = t;
            arrayXs(indexOfServiceInCalendar - 1) = 1;
            randomInt = rand(1);
            if randomInt <= 0.4
                calendar(indexOfServiceInCalendar) = t + serviceTimeQuick;
            else
                calendar(indexOfServiceInCalendar) = t + serviceTimeSlow;
            end
        else
            calendar(indexOfServiceInCalendar) = inf;
            arrayXs(indexOfServiceInCalendar - 1) = 0;
        end
    end 
    
    fprintf('Time: %2.0f | Event: %d | l: %d | Server: [%d %d %d]\n', t, type, l, arrayXs(1), arrayXs(2), arrayXs(3));
end

%stats for every agent
arrivalsIntoNode
arrivalsIntoService
leavesFromService

%everage stats
%time in node
wi = leavesFromService - arrivalsIntoNode
di = arrivalsIntoService - arrivalsIntoNode
si = leavesFromService - arrivalsIntoService

averageTimeInNode = mean(wi)
averageTimeInQeue = mean(di)
averageTimeInService = mean(si)

%histogram
figure;
histogram(arrivalsIntoNode, 12);
grid on;


