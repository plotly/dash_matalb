terminate(pyenv);

% read data file

tab = readtable('dat.csv');

% create Dash app

slider_app = createApp();

% create slider

uifig = uifigure('visible', 'off');
sld = uislider(uifig);
sld.MajorTicks = [1952,1957,1962,1967,1972,1977,1982,1987,1992,1997,2002,2007];
dash_sld = ui2dash(sld, 'year');

uifigtable = uifigure('visible', 'off');
uitableinit = uitable(uifigtable)
uitableinit.Data = tab
dash_table = ui2dash(uitableinit,'year')



% create initial graph using fig2plotly

fig = figure('visible', 'off');
YEAR = 1952;
rows = (tab.year == YEAR);
subtab = tab(rows,:);
scatter(subtab.gdpPercap, ...
    subtab.lifeExp, ...
    subtab.pop/10000, ...
    categorical(subtab.country), 'filled');
 set(gca,'xscale','log');
 close(fig)
 
 fig = plotlyfig2dash(fig2plotly(gcf, 'offline', true, 'open', false,'Visible',false), 'graph');
% add slider and graph to Dash app layout


slider_app.layout = addLayout(fig, dash_sld);
%%%%%Part adding dash table to app%%%%%%
%slider_app.layout = addLayout(fig, dash_table);

% define the callbacks

slider_callback = slider_app.callback( {argsOut('graph', 'figure'), argsIn('year','value') });  

slider_callback(@py.callback.callback);

% run the app

slider_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))