function [ data, t] = read_dfs0(infile )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

NET.addAssembly('DHI.Generic.MikeZero.DFS');
import DHI.Generic.MikeZero.DFS.*;
import DHI.Generic.MikeZero.DFS.dfs0.*;

%infile = 'D:\Charles Greenwood\Post-processing\Plots\Results-(EWTEC2013)\area plots\New_Area.dfs0';

% Read times and data for all items
dfs0File  = DfsFileFactory.DfsGenericOpen(infile);
dd = double(Dfs0Util.ReadDfs0DataDouble(dfs0File));
t = dd(:,1);
data = dd(:,2:end);

end

