%TASK - coffee shop
%settings
arrivalInternal = 4;
c = 2;
serviceTimeEs = 3;
serviceTimeCap = 6;
tMax = 20;
arrayXs = [0, 0];

%init
t = 0;
l = 0;
ta = 4;
inf = intmax;
calendar = [ta, inf, inf];


while t < tMax 
    [minCalendarValue, type] = min(calendar);
    t = ta;

    if type == 1 %arrival
        l = l + 1;
        ta = ta + arrivalInternal; %plan next event
        calendar(1) = ta;
        if l <= c %if the service is available
            serviceFreeIndex = find(arrayXs == 0, 1);
            arrayXs(freeServiceIndex) = 1;
            randomInt = randi(1);
            if randomInt <= 0.6
                calendar(freeServiceIndex + 1) = t + serviceTimeCap;
            else
                calendar(freeServiceIndex + 1) = t + serviceTimeEs;
            end
            
        else
            
        end
    else %type = 1,2 => leave
        l = l - 1;
        indexOfServiceInCalendar = type;
        if l >= c
            arrayXs(indexOfServiceInCalendar - 1) = 1;
            randomInt = randi(1);
            if randomInt <= 0.6
                calendar(indexOfServiceInCalendar) = t + serviceTimeCap;
            else
                calendar(indexOfServiceInCalendar) = t + serviceTimeEs;
            end
        else
            arrayXs(indexOfServiceInCalendar - 1) = 0;
            calendar(indexOfServiceInCalendar) = inf;
        end
    end
    fprintf('Time: %2.0f | Event: %d | l: %d | Server: [%d %d]\n', t, type, l, arrayXs(1), arrayXs(2));
end

