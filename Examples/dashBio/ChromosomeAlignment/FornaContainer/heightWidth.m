terminate(pyenv);
clearvars;

sequences = {struct(...
    'sequence', 'AUGGGCCCGGGCCCAAUGGGCCCGGGCCCA',...
    'structure', '.((((((())))))).((((((()))))))')};

component = dashBio('FornaContainer', {...
        'sequences', sequences,...
        'height', 300,...
        'width', 500});  
    
components = {component};

% Run the app
startDash(components, 8057);