function [grouptag, dstag] = tag(group, ds)
switch group
    case 1 % Full Time Series
        grouptag = "full";
    case 2 % 2019-2021
        grouptag = "2019_21";
    otherwise
        error("no group specified");
end

switch ds
% case 1 % CSR L2
% 
% case 2 % GFZ L2
% 
% case 3 % JPL L2
        
case 4 % CSR L3
    dstag = "CSR";
case 5 % GFZ L3
    dstag = "GFZ";
        
case 6 % JPL L3
    dstag = "JPL";
        
% case 7 % JPL Mascons
        
case 8 % Cumulative CSR L3
    dstag = "cCSR";
        
case 9 % Cumulative GFZ L3
    dstag = "cGFZ";
        
case 10 % Cumulative JPL L3
    dstag = "cJPL";
        
% case 11 % Cumulative JPL Mascons

end

end