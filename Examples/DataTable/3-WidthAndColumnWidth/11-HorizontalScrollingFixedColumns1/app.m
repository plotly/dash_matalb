terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', false);
data = data((1:3),:); % Select first 3 rows

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

dataTable.UserData = struct(...
    'fixed_columns', struct(...
        'headers', true, 'data', 1),...
    'style_table', struct(...
        'minWidth', '100%'));

% Run the app
startDash(uiGrid, 8057);