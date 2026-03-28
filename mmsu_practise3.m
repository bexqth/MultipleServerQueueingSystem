%post office with lunch queue
%arrivals
  % first 20 minutes - every 8 minutes 
  % last 20 minutes - every 2 minutes

%settings
tMax = 40;
c = 2;
serviceTime = 5;

inf = intmax;

%init
t = 0;
l = 0;
ta = 8;
arrayXs = [0, 0];
calendar = [ta, inf, inf];

while t < tMax
    [minCalendarValue, type] = min(calendar);
    t = minCalendarValue;
    
    if type == 1 %arrival
        l = l + 1;
        if t <= 20
            ta = ta + 8;
        else
            ta = ta + 2;
        end
        calendar(1) = ta;
        
        if l <= c
            freeServiceIndex = find(arrayXs == 0, 1);
            arrayXs(freeServiceIndex) = 1;
            calendar(freeServiceIndex + 1) = t + serviceTime;
        else
            %in queue
        end

    else %type = 2,3 => leave
        l = l - 1;
        indexOfServiceInCalendar = type;
        if l >= c
            calendar(indexOfServiceInCalendar) = t + serviceTime;
            arrayXs(indexOfServiceInCalendar - 1) = 1;
        else
            arrayXs(indexOfServiceInCalendar - 1) = 0;
            calendar(indexOfServiceInCalendar) = inf;
        end
    end

    fprintf('Time: %2.0f | Event: %d | l: %d | Server: [%d %d]\n', t, type, l, arrayXs(1), arrayXs(2));
end
