%TASK A - simple mmsu
% arrivals - every 5 minutes
% service time - 8 minutes
% number of services - 2

% --- settings ----
N = 10; % number of people
c = 2; % number of services
arrivalInternal = 5;
serviceTime = 8;
inf = intmax;
arrayXs = [0,0]; % state of the services
% arrivals
maxT = 30;

% --- ini ---
l = 0; % number of jobs
t = 0; % simulation time
ta = t + arrivalInternal;
calendar = [ta, inf, inf];

% ---
while t < maxT
    [minCalendarValue, type] = min(calendar); %return value and index
    t = minCalendarValue; %moving the simulation time
    if type == 1 % arrival
        l = l + 1;
        ta = ta + 5;
        calendar(1) = ta; % update arrival time in the calendar
        if l <= c % service is available
            freeServiceIndex = find(arrayXs == 0, 1);
            arrayXs(freeServiceIndex) = 1;
            calendar(freeServiceIndex + 1) = t + serviceTime; % schedule service completion
        else % service is not available
        end
    else % leave
        l = l - 1;
        indexOfServiceInCalendar = type;
        if l >= c % there is a person waiting in queue
            calendar(indexOfServiceInCalendar) = t + serviceTime;
            arrayXs(indexOfServiceInCalendar - 1) = 1;
        else
            calendar(indexOfServiceInCalendar) = inf;
            arrayXs(indexOfServiceInCalendar - 1) = 0;
        end
    end
    fprintf('Time: %2.0f | Event: %d | l: %d | Server: [%d %d]\n', t, type, l, arrayXs(1), arrayXs(2));
end
