import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def update_figure(*args):
    if args[0] is None:
        outputs = json.loads(eng.update_figure("NaN"))
    else:
        outputs = json.loads(eng.update_figure(*args))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

