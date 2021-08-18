clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);
try
    data = data([1:50],:); % Select first 50 rows
catch
end

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

%% Define struct which stores uitable properties like styling
% An example with cell and header stylings,
% as well as page_size property is provided:
%{
uit.UserData = struct(...
    'style_cell', struct(...
        'page_size', 3,...
        'textAlign', 'center',...
        'backgroundColor', 'rgb(50,50,50)',...
        'color', 'white',...
        'font_size', '16px',...
        'padding', '5px'),...
    'style_header', struct(...
        'backgroundColor', 'rgb(30,30,30)',...
        'fontWeight', 'bold'),...
    'page_size', 10);
%}
%%

[lnrows, lncols] = size(uit.Data);
tooltip_data = {lnrows};
for i=1:lnrows
    d = py.dict();
    for j=1:lncols
        update(d, py.dict(pyargs(string(uit.ColumnName(j)), py.dict(pyargs(...
            'value', string(uit.Data{i,j}), 'type', 'markdown')))));
    end
    tooltip_data{i} = d;
end
    
tooltip_data = py.list(tooltip_data);


uit.UserData = struct(...
    'style_cell', struct(...
        'overflow', 'hidden',...
        'textOverflow', 'ellipsis',...
        'maxWidth', 0),...
    'tooltip_data', tooltip_data,...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))