%cleaning shop

%settings
normalDis = makedist("Normal", "mu", 3, "sigma", 0.5);
uniformDis = makedist("uniform", "lower", 5, "upper", 10);
c = 3;
serviceTimeQuick = 4;
serviceTimeSlow = 12;
inf = intmax;
tMax = 60;

%init
t = 0;
l = 0;
ta = 2;
arrayXs = [0, 0, 0];
calendar = [ta, inf, inf, inf];

while t < tMax
    [minCalendarValue, type] = min(calendar);
    t = minCalendarValue;

    if type == 1 %arrival
        l = l + 1;
        if t <= 10
            ta = ta + 2;
        elseif t > 10 && t <= 30
            randomArrival = random(normalDis, 1,1);
            ta = ta + randomArrival;
        elseif t <= 60
            randomArrival = random(uniformDis, 1,1);
            ta = ta + randomArrival;
        end
        calendar(1) = ta;

        if l <= c
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
        indexOfServiceInCalendar = type;
        if l >= c
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


