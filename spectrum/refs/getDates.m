function [tsdays, tstime] = getDates(group)
% Outputs date vectors for plotting
% tsdays: days from start
% tstime: datetime vec

leap = ones(1, 20) .* 365;
leap(4:4:end) = 366;
leap(1) = 0;
addin = cumsum(leap);
addin = repelem(addin, 12);
addin(1:3) = [];
addin = addin';

dates = readmatrix('gfodates.csv', 'Range', [2 1 238 3]);
mask = isnan(dates(:, 1));
dates(mask, :) = [];
addin(mask) = [];

startDay = dates(:,2); % start day of each dataset
endDay = dates(:,3); % end day of each dataset
mask2 = endDay < startDay;
endDay(mask2) = endDay(mask2) + 365;
avgDay = (startDay + endDay)/2;
tsdays =  avgDay + addin; % time in days
tsdays = tsdays - tsdays(1); % days from first day, first day = 0
tsdays = floor(tsdays);

% converting to datetime for regular plot
t1 = datetime(2002, 04, 15);
tstime = t1 + caldays(tsdays);
if group == 2
   tstime = tstime(end-35:end); % only 19-21
   tsdays = tsdays(end-35:end);
   tsdays = tsdays-tsdays(1);
end
end