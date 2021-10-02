terminate(pyenv);
clearvars;

% Read data file
data = readtable('https://git.io/Jgvhr', 'PreserveVariableNames', true);
data = data((1:6),(1:5)); % Select first 6 rows and 5 columns

% Create ui elements
uiFigure = uifigure('visible', 'off');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

dataTable = uitable(uiGrid, 'ColumnName', data.Properties.VariableNames,...
    'Data', data, 'visible', 'off', 'Tag', 'table');

style_cell_conditional = {2};
style_cell_conditional{1} = struct(...
    'if', struct('column_id', 'City, State'),...
    'textAlign', 'left');
style_cell_conditional{2} = struct(...
    'if', struct('column_id', 'Classification'),...
    'textAlign', 'left');

style_cell_conditional = {style_cell_conditional};

dataTable.UserData = struct(...
    'style_cell_conditional', style_cell_conditional,...
    'style_as_list_view', true);

% Run the app
startDash(uiGrid, 8057);