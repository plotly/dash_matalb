terminate(pyenv);
clearvars;

code = sprintf(['```\n',...
    'Html(''Div'', {{...\n',...
    '    Dcc(''Markdown'', {...\n',...
    '        ''children'', code,...\n',...
    '        ''id'', ''code'',...\n',...
    '        ''style'', struct(''width'',500,''height'',200,''overflow'',''auto'')})...\n',...
    '    Dcc(''Clipboard'', {...\n',...
    '        ''target_id'', ''code'',...\n',...
    '        ''style'', struct(...\n',...
    '            ''position'', ''absolute'',...\n',...
    '            ''top'', 0,...\n',...
    '            ''right'', 20,...\n',...
    '            ''fontSize'', 20)})},...\n',...
    '    ''style'',struct(''width'', 500, ''height'', 200, ''position'', ''relative'')});\n',...
    '```']);

dashDiv = Html('Div', {{...
    Dcc('Markdown', {...
        'children', code,...
        'id', 'code',...
        'style', struct('width',500,'height',200,'overflow','auto')})...
    Dcc('Clipboard', {...
        'target_id', 'code',...
        'style', struct(...
            'position', 'absolute',...
            'top', 0,...
            'right', 20,...
            'fontSize', 20)})},...
    'style',struct('width', 500, 'height', 200, 'position', 'relative')});

components = {dashDiv};

% Start app
startDash(components, 8057, [], 'SOLAR');