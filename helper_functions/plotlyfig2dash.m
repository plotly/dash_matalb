function fig = plotlyfig2dash(plotlyfig, id)
    
    plotlyfig = py.dict(pyargs('data',plotlyfig.data,'layout',plotlyfig.layout));
    
    fig = py.dash_core_components.Loading(pyargs('id', string(id)+'loading',...
        'children',{py.dash_core_components.Graph(pyargs('id', id, 'figure', plotlyfig))},...
        'type','circle'));
end
