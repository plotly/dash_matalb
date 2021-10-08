terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVwnh');

seq = dashBioUtils({'protein_reader','read_fasta'},...
    {'datapath_or_datastring', data, 'is_datafile', false});
seq = struct(seq{1}).('sequence');

component = dashBio('SequenceViewer', {...
        'id', 'sequence-viewer-lines',...
        'sequence', seq,...
        'showLineNumbers', false,...
        'charsPerLine', 20});
    
components = {component};

% Run the app
startDash(components, 8057);