clear all
close all
terminate(pyenv);

% Define data table
shop = {'Bakersfield';'Berkeley';'Big Bear Lake'};
sales = [3;1;5];
goal = [10;1;4];
address = {...
    sprintf('3000 Mall View Road, Suite 1107\n\nBakersfield, CA\n\n93306');...
    sprintf('2130 Center Street, Suite 102\n\nBerkeley, CA\n\n94704');...
    sprintf('652 Pine Knot Avenue\n\nBig Bear Lake, CA\n\n92315')};
data = table(shop,sales,goal,address);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

% Define custom columns
[lnrows, lncols] = size(uit.Data);
columns = {lncols};
columns{1} = struct('name', 'shop', 'id', 'shop');
columns{2} = struct('name', 'sales', 'id', 'sales');
columns{3} = struct('name', 'goal', 'id', 'goal');
columns = {columns};

% Tooltips
tooltip_data = {lnrows};
for i=1:lnrows
    if data{i,{'goal'}} > data{i,{'sales'}}
        state = 'less';
        achieved = 'not achieved';
    else
        state = 'more';
        achieved = 'achieved';
    end

    tooltip_data{i} = struct(...
        'shop',struct('value',string(data{i,{'address'}}),'type','markdown'),...
        'sales',struct(...
            'value',sprintf('Sales were **%s %s** than the goal', string(abs(data{i,{'goal'}}-data{i,{'sales'}})), state),...
            'type','markdown'),...
        'goal',sprintf('Goal was %s', achieved));
end
tooltip_data = {tooltip_data};

% User data
uit.UserData = struct(...
    'columns', columns,...
    'tooltip_data', tooltip_data,...
    'style_cell', struct(...
        'overflow', 'hidden',...
        'textOverflow', 'ellipsis',...
        'maxWidth', 0),...
    'tooltip_delay', 10,... % In ms. If set to 0 tooltip is not shown...
    'tooltip_duration', -1); % Use -1 to prevent the tooltip from disappearing

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))