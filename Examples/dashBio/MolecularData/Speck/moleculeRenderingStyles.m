terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVwry');

data = dashBioUtils({'xyz_reader','read_xyz'},...
    {'datapath_or_datastring', data, 'is_datafile', false});

component = dashBio('Speck', {...
    'data', data,...
    'view', struct(...
        'resolution', 400,...
        'ao', 0.1,...
        'outline', 1,...
        'atomScale', 0.25,...
        'relativeAtomScale', 0.33,...
        'bonds', true)});
    
components = {component};

% Run the app
startDash(components, 8057);