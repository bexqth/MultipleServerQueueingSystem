%pharmacy

%settings
normalDis = makedist('Normal', 'mu', 5, 'sigma', 1);
triangularDis = makedist('Triangular', 'a', 6, 'b', 8, 'c', 10);
uniformDis = makedist('Uniform', 'lower', 8, 'upper', 16);
c = 2;
tMax = 720;
serviceTime = 7;
inf = intmax;

%init
l = 0;
t = 0;
ta = random(normalDis, 1, 1);
arrayXs = [0 ,0];
calendar = [ta, inf, inf];

while t < tMax
    [minCalendarValue, type] = min(calendar);
    t = minCalendarValue;
    
    if type == 1 %arrival
        l = l + 1;
        if t <= 240
            randomArrival = random(normalDis, 1, 1);
            ta = ta + randomArrival;
        elseif t > 240 && t <= 480
            randomArrival = random(triangularDis, 1, 1);
            ta = ta + randomArrival;
        elseif t <= 720
            randomArrival = random(uniformDis, 1, 1);
            ta = ta + randomArrival;
        end
        calendar(1) = ta;
        
        if l <= c
            freeServiceIndex = find(arrayXs == 0, 1);
            arrayXs(freeServiceIndex) = 1;
            calendar(freeServiceIndex + 1) = t + serviceTime;
        else
            %nothing -> in queue
        end

    else %leave
        indexOfServiceInCalendar = type;
        l = l - 1;
        if l >= c
            arrayXs(indexOfServiceInCalendar - 1) = 1;
            calendar(indexOfServiceInCalendar) = t + serviceTime;
        else
            arrayXs(indexOfServiceInCalendar - 1) = 0;
            calendar(indexOfServiceInCalendar) = inf;
        end
    end
    
    fprintf('Time: %2.0f | Event: %d | l: %d | Server: [%d %d]\n', t, type, l, arrayXs(1), arrayXs(2));
end

