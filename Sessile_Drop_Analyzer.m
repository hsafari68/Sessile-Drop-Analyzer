function varargout = Sessile_Drop_Analyzer(varargin)
% SESSILE_DROP_ANALYZER MATLAB code for Sessile_Drop_Analyzer.fig
%      SESSILE_DROP_ANALYZER, by itself, creates a new SESSILE_DROP_ANALYZER or raises the existing
%      singleton*.
%
%      H = SESSILE_DROP_ANALYZER returns the handle to a new SESSILE_DROP_ANALYZER or the handle to
%      the existing singleton*.
%
%      SESSILE_DROP_ANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SESSILE_DROP_ANALYZER.M with the given input arguments.
%
%      SESSILE_DROP_ANALYZER('Property','Value',...) creates a new SESSILE_DROP_ANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sessile_Drop_Analyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sessile_Drop_Analyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sessile_Drop_Analyzer

% Last Modified by GUIDE v2.5 12-Apr-2015 15:35:08

% h = waitbar(0,'Name','Approximating pi...');%,...
%             'CreateCancelBtn',...
%             'setappdata(gcbf,''canceling'',1)');
% setappdata(h,'canceling',0)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sessile_Drop_Analyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @Sessile_Drop_Analyzer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT




% --- Executes just before Sessile_Drop_Analyzer is made visible.
function Sessile_Drop_Analyzer_OpeningFcn(hObject, eventdata, handles, varargin) %#ok
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sessile_Drop_Analyzer (see VARARGIN)

% Set the name of the sessile drop analyzer software
set(hObject,'Name','Sessile Drop Analyzer');

% Necessary variables that are shared within the GUI objects
handles.image = [];
handles.hand = [];
handles.edge = [];
handles.BW = [];
handles.dist = [];
handles.crop = [];
handles.sf = [];
handles.LB = [];
handles.UB = [];
handles.thresh = [];
handles.cutoff = [];
handles.cutratio = [];
handles.FunTol = [];
handles.odesspan = [];
handles.initpnt = [];
handles.BulkDensity = 0.001;
handles.Liquiddensity = 0.998;
handles.gravity = 981.7;
handles.calcflag = 1;
handles.compflag = 1;
handles.BWedgeCrop = [];
handles.x = [];
handles.z = [];
handles.flip_bound = [];
handles.time_sph = [];
handles.Height = [];
handles.xeqleft = [];
handles.xeqright = [];
handles.zeqleft = [];
handles.zeqright = [];
handles.SphAngle = 0;
handles.Eqdiameter = 0;
handles.Wetdiameter = 0;
handles.xcut_nd = [];
handles.zcut_nd = [];
handles.xcut = [];
handles.zcut = [];
handles.b = [];
handles.c = [];
handles.Xcirc_nd = [];
handles.Zcirc_nd = [];
handles.Drop_vol_cm3 = 0;
handles.Drop_area_cm2 = 0;
handles.Bo = 0;
handles.w_theta = 0;
handles.h1 = [];
handles.sigma = [];
handles.needlediameter = [];


% Choose default command line output for Sessile_Drop_Analyzer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sessile_Drop_Analyzer wait for user response (see UIRESUME)
% uiwait(handles.MainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = Sessile_Drop_Analyzer_OutputFcn(hObject, eventdata, handles) %#ok
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles) %#ok
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YLTimeText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to YLTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YLTimeText as text
%        str2double(get(hObject,'String')) returns contents of YLTimeText as a double


% --- Executes during object creation, after setting all properties.
function YLTimeText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to YLTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YLAngleText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to YLAngleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YLAngleText as text
%        str2double(get(hObject,'String')) returns contents of YLAngleText as a double


% --- Executes during object creation, after setting all properties.
function YLAngleText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to YLAngleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YLbText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to YLbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YLbText as text
%        str2double(get(hObject,'String')) returns contents of YLbText as a double


% --- Executes during object creation, after setting all properties.
function YLbText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to YLbText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YLsigmaText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to YLsigmaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YLsigmaText as text
%        str2double(get(hObject,'String')) returns contents of YLsigmaText as a double


% --- Executes during object creation, after setting all properties.
function YLsigmaText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to YLsigmaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropHeightText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DropHeightText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropHeightText as text
%        str2double(get(hObject,'String')) returns contents of DropHeightText as a double


% --- Executes during object creation, after setting all properties.
function DropHeightText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to DropHeightText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropEQDText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DropEQDText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropEQDText as text
%        str2double(get(hObject,'String')) returns contents of DropEQDText as a double


% --- Executes during object creation, after setting all properties.
function DropEQDText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to DropEQDText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropWDText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DropWDText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropWDText as text
%        str2double(get(hObject,'String')) returns contents of DropWDText as a double


% --- Executes during object creation, after setting all properties.
function DropWDText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to DropWDText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropVolText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DropVolText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropVolText as text
%        str2double(get(hObject,'String')) returns contents of DropVolText as a double


% --- Executes during object creation, after setting all properties.
function DropVolText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to DropVolText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropAreaText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DropAreaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropAreaText as text
%        str2double(get(hObject,'String')) returns contents of DropAreaText as a double


% --- Executes during object creation, after setting all properties.
function DropAreaText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to DropAreaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropBoText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DropBoText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropBoText as text
%        str2double(get(hObject,'String')) returns contents of DropBoText as a double


% --- Executes during object creation, after setting all properties.
function DropBoText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to DropBoText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SphTimeText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to SphTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SphTimeText as text
%        str2double(get(hObject,'String')) returns contents of SphTimeText as a double


% --- Executes during object creation, after setting all properties.
function SphTimeText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to SphTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SphAngleText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to SphAngleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SphAngleText as text
%        str2double(get(hObject,'String')) returns contents of SphAngleText as a double


% --- Executes during object creation, after setting all properties.
function SphAngleText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to SphAngleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LiquiddensText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to LiquiddensText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LiquiddensText as text
%        str2double(get(hObject,'String')) returns contents of LiquiddensText as a double

Liquiddensity = get(hObject,'String');
handles.Liquiddensity = str2double(Liquiddensity);


guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function LiquiddensText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to LiquiddensText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BulkdenText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to BulkdenText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BulkdenText as text
%        str2double(get(hObject,'String')) returns contents of BulkdenText as a double

Bulkdensity = get(hObject,'String');
handles.BulkDensity = str2double(Bulkdensity);


guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function BulkdenText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to BulkdenText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GravText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to GravText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GravText as text
%        str2double(get(hObject,'String')) returns contents of GravText as a double
gravity = get(hObject,'String');
handles.gravity = str2double(gravity);

guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function GravText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to GravText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropApexText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DropApexText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropApexText as text
%        str2double(get(hObject,'String')) returns contents of DropApexText as a double


% --- Executes during object creation, after setting all properties.
function DropApexText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to DropApexText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LeftCPointText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to LeftCPointText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LeftCPointText as text
%        str2double(get(hObject,'String')) returns contents of LeftCPointText as a double


% --- Executes during object creation, after setting all properties.
function LeftCPointText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to LeftCPointText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RightCPointText_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to RightCPointText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RightCPointText as text
%        str2double(get(hObject,'String')) returns contents of RightCPointText as a double


% --- Executes during object creation, after setting all properties.
function RightCPointText_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to RightCPointText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OrigImPB.
function OrigImPB_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to OrigImPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.hand = imshow(handles.image);
impixelinfo(handles.hand);

guidata(hObject,handles);

% --- Executes on button press in BWImPB.
function BWImPB_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to BWImPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty (handles.thresh)
    handles.thresh = graythresh(handles.image);
else
    handles.thresh = handles.thresh;
end
handles.BW = im2bw(handles.image,handles.thresh);
hBW = imshow(handles.BW);
impixelinfo(hBW);
% impixelregion(hBW);

guidata(hObject,handles);

% --- Executes on button press in EdgePB.
function EdgePB_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to EdgePB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.edge = edge(handles.image,'Canny',0.4);
imshow(handles.edge);

guidata(hObject,handles);

% --- Executes on button press in DistPB.
function DistPB_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to DistPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dist = imdistline(handles.Axes);

guidata(hObject,handles);

% --- Executes on button press in CropPB.
function CropPB_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to CropPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.crop = imcrop(handles.image);
hCr = imshow(handles.crop);
impixelinfo(hCr);

guidata(hObject,handles);

% --- Executes on button press in CalcPB.
function CalcPB_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to CalcPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xcut zcut sf

if isempty(handles.image)
    answer = modaldlgM('Title','Load new image:');
    switch answer
        case 'Yes'
            [filename, pathname] = uigetfile(...
                {'*.bmp;*.tif;*.gif;*.png;*.jpg','Image Files(*.bmp,*.tif,*.gif,*.png,*.jpg)';
                '*.*','All Files(*.*)'},...
                'Pick an Image');
            fid = fopen ('pathname.dat','w');
            fprintf(fid,'%s',pathname);
            fclose(fid);
            
            if filename
                image = imread([pathname,filename]);
                handles.image = rgb2gray(image);
                handles.hand = imshow(handles.image);
                impixelinfo(handles.hand);
            else
                warndlg('No image Has Been Loaded!','Warning');
            end
            
        case 'No'
    end
    
else
    
    if isempty(handles.sf);
        
        th = graythresh(handles.image);
        
        BW_image = im2bw(handles.image,th);
        pixels = abs(sum(BW_image(3,:)-1));
        
        if isempty(handles.needlediameter)
            handles.needlediameter = 0.75;
            scale_cm = handles.needlediameter/10;
        else
            scale_cm = handles.needlediameter/10;
        end
        sf  = abs(pixels/scale_cm);
        handles.sf = sf;
        
    end
    
    strpop = get(handles.MethodPopM,'String');
    popval = get(handles.MethodPopM,'Value');
    Type = strpop{popval};
    
    if strcmp(Type, 'Spherical Cap')
        anglecr = questdlg('What is the image angle?  ', ...
            'Contact angle criteria:', ...
            'Greater than 90','Less than 90','Greater than 90');
        
        tic;
                
        if ~isempty(handles.cutratio)
            handles.cutratio = handles.cutratio;
        else
            handles.cutratio = 0.95;
        end
        
        handles.BWedgeCrop = im2bw(handles.crop);
        contour = bwtraceboundary (handles.BWedgeCrop, [1,1], 'S');
        bound1=contour(find(contour(:,2)==(size(handles.BWedgeCrop,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),1);
        bound2=contour(find(contour(:,2)==(size(handles.BWedgeCrop,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),2);
        
        bound=[bound2,bound1];
        handles.flip_bound=flipud(bound);
        
        % Approximate apex coordinates
        handles.z = min(handles.flip_bound(:,2));
        handles.x = handles.flip_bound(round(mean(find(handles.flip_bound(:,2)==handles.z))),1);
        
        
        hbwedge = imshow(handles.BWedgeCrop);
        impixelinfo(hbwedge);
        hold on
        plot(handles.Axes, handles.x,handles.z,'bo')
        hold on
        plot(handles.Axes, handles.flip_bound(:,1),handles.flip_bound(:,2),'r','LineWidth',2);
        legend('Apex','Drop edge');
        hold off
        
        % Setting the apex to (0,0)
        z_surf = handles.flip_bound(:,2) - handles.z;
        x_surf = handles.flip_bound(:,1) - handles.x;
        
        % Finding the left and right Z-plane
        xind = round(mean(find(handles.flip_bound(:,2)==handles.z)));
        
        left = z_surf(1);
        right = z_surf(end);
        
        pindleft = find(z_surf>= left-1 & z_surf <=left+1);
        pindright = find(z_surf>= right-1 & z_surf<=right+1);
        
        idxlf = find(pindleft<xind);
        idxrt = find(pindright>xind);
        
        lpidx = pindleft(idxlf);%#ok
        rpidx = pindright(idxrt);%#ok
        
        % Height determination
        
        Leftplane = z_surf(lpidx);
        Rightplane = z_surf(rpidx);
        
        lfavg = mean(Leftplane);
        rtavg = mean(Rightplane);
        
        lr =[lfavg rtavg];
        
        p = round(mean(lr)); % Height
        
        % Equator radius calculation
        
        dh = p;
        handles.Height = (dh/handles.sf)*10; % in mm
        
        handles.cutoff = round(handles.cutratio*dh); % 15 percent cuttoff
        
        idx = find(z_surf<=handles.cutoff);
        start = idx(1);
        finish = idx(end);
        
        handles.xcut = x_surf (start:finish);
        handles.zcut = z_surf (start:finish);
        
        
        xeqpleft = handles.xcut(1); % left contact point x-coordinates
        xeqpright = handles.xcut(end); % right contact point x-coordinates
        
        
        % xeqpleft = min(xcut); % left contact point x-coordinates
        % xeqpright = max(xcut); % right contact point x-coordinates
        
        xeqpleft_cm = xeqpleft/handles.sf; % left contact point in cm
        xeqpright_cm = xeqpright/handles.sf; % right contact point in cm
        
        er = 0.5*(abs(xeqpleft_cm)+abs(xeqpright_cm)); % equator radius
        Xequator = 2*max(abs(handles.xcut/handles.sf))*10;
        Xwet = 2*er*10;
        
        
        handles.Eqdiameter = Xequator;
        handles.Wetdiameter = Xwet;
        % idxlefteq = find(xcut == xeqpleft);
        % idxrighteq = find(xcut == xeqpright);
        %
        % zeqpleft = mean(zcut(idxlefteq)); % left contact point z-coordinates
        % zeqpright = mean(zcut(idxrighteq)); % right contact point z-coordinates
        
        zeqpleft = handles.zcut(1);
        zeqpright = handles.zcut(end);
        
        zeqpleft_cm = zeqpleft/handles.sf; %#ok
        zeqpright_cm = zeqpright/handles.sf; %#ok
        
        handles.xeqleft =  xeqpleft;
        handles.xeqright = xeqpright;
        
        handles.zeqleft = zeqpleft;
        handles.zeqright = zeqpright;
        
        % [xeqpleft,xeqpright]
        % [zeqpleft,zeqpright]
        
        % figure;
        % plot(x_surf,z_surf,'bo')
        % hold all
        % plot(xcut,zcut,'y','LineWidth',2)
        % plot([xeqpleft,xeqpright],[zeqpleft,zeqpright],'gs','MarkerFaceColor','g')
        % set(gca,'YDir','reverse');
        
        
        
        zp = [handles.zeqleft,handles.zeqright];
        xp = [handles.xeqleft,handles.xeqright];
        
        ma = zp(1)/xp(1);
        mb = zp(2)/xp(2);
        
        xcenter = (ma*mb*(zp(2)-zp(1))+mb*xp(1)-ma*xp(2))/(2*(mb-ma));
        zcenter = ((-1/ma)*(xcenter-(xp(1)/2)))+(zp(1)/2);
        
        radius = sqrt(xcenter^2+zcenter^2);
        center = [xcenter, zcenter];
        nop=1000;
        [Xnew,Znew] = circle(center, radius,nop);
        
        value1 = Znew-dh;
        value2 = abs(value1);
        value3 = min(value2);
        
        index = find(value2 == value3);
        
        xx = Xnew (index);
        zz = Znew (index);
        
        xd = xcenter - xx;
        zd = zcenter - zz;
        
        theta_a = atan(zd/xd);
        theta_a = abs(theta_a);
        
        rad_angle1 = theta_a+(pi/2);
        rad_angle2 = rad_angle1*180/pi;
        
        bl90angle =mod (180-rad_angle2,180);
        
        time_sph = toc;
        handles.time_sph = time_sph;
        %     gr90angle = mod(180+rad_angle2,180);
        
        
        
        switch anglecr
            case 'Greater than 90'
                
                handles.SphAngle = rad_angle2;
                set(handles.DropEQDText,'String',num2str(handles.Eqdiameter));
                set(handles.DropWDText,'String',num2str(handles.Wetdiameter));
                
            case 'Less than 90'
                
                handles.SphAngle = bl90angle;
                set(handles.DropEQDText,'String',num2str(handles.Eqdiameter));
                set(handles.DropWDText,'String',num2str(handles.Eqdiameter));
        end
        
        
        set(handles.SphTimeText,'String',num2str(handles.time_sph));
        set(handles.SphAngleText,'String',sprintf('%3.2f',handles.SphAngle));
        set(handles.YLTimeText,'String',num2str(0));
        set(handles.DropHeightText,'String',num2str(handles.Height));
        set(handles.DropApexText,'String',['Apex_x = ' num2str(handles.x) '         Apex_z = ' num2str(handles.z)]);
        set(handles.LeftCPointText,'String',['Left_x = ' num2str(handles.xeqleft) '         Left_z = ' num2str(handles.zeqleft)]);
        set(handles.RightCPointText,'String',['Right_x = ' num2str(handles.xeqright) '         Right_z = ' num2str(handles.zeqright)]);
        set(handles.YLAngleText,'String',[num2str(0)]);%#ok
        set(handles.YLbText,'String',num2str(0));
        set(handles.YLsigmaText,'String',num2str(0));
        set(handles.DropVolText,'String',num2str(0));
        set(handles.DropAreaText,'String',num2str(0));
        set(handles.DropBoText,'String',num2str(0));
        
        
        
    elseif strcmp(Type, 'Young-Laplace')
        
        tic;
        
        if ~isempty(handles.cutratio)
            handles.cutratio = handles.cutratio;
        else
            handles.cutratio = 0.95;
        end
        
        
        if ~isempty(handles.odesspan)
            handles.odesspan = handles.odesspan;
        else
            handles.odesspan = [0:0.01:10];%#ok
        end
        
        
        if ~isempty(handles.FunTol)
            handles.FunTol = handles.FunTol;
        else
            handles.FunTol = 1e-6;
        end
        
        
        if ~isempty(handles.initpnt)
            handles.initpnt = handles.initpnt;
        else
            handles.initpnt = [1,1];
        end
        
        handles.BWedgeCrop = im2bw(handles.crop);
        contour = bwtraceboundary (handles.BWedgeCrop, [1,1], 'S');
        bound1=contour(find(contour(:,2)==(size(handles.BWedgeCrop,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),1);
        bound2=contour(find(contour(:,2)==(size(handles.BWedgeCrop,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),2);
        
        bound=[bound2,bound1];
        handles.flip_bound=flipud(bound);
        
        % Approximate apex coordinates
        handles.z = min(handles.flip_bound(:,2));
        handles.x = handles.flip_bound(round(mean(find(handles.flip_bound(:,2)==handles.z))),1);
        
        
        hbwedge = imshow(handles.BWedgeCrop);
        impixelinfo(hbwedge);
        hold on
        plot(handles.Axes, handles.x,handles.z,'bo')
        hold on
        plot(handles.Axes, handles.flip_bound(:,1),handles.flip_bound(:,2),'r','LineWidth',2);
        legend('Apex','Drop edge');
        hold off
        
        % Setting the apex to (0,0)
        z_surf = handles.flip_bound(:,2) - handles.z;
        x_surf = handles.flip_bound(:,1) - handles.x;
        
        % Finding the left and right Z-plane
        xind = round(mean(find(handles.flip_bound(:,2)==handles.z)));
        
        left = z_surf(1);
        right = z_surf(end);
        
        pindleft = find(z_surf>= left-1 & z_surf <=left+1);
        pindright = find(z_surf>= right-1 & z_surf<=right+1);
        
        idxlf = find(pindleft<xind);
        idxrt = find(pindright>xind);
        
        lpidx = pindleft(idxlf);%#ok
        rpidx = pindright(idxrt);%#ok
        
        % Height determination
        
        Leftplane = z_surf(lpidx);
        Rightplane = z_surf(rpidx);
        
        lfavg = mean(Leftplane);
        rtavg = mean(Rightplane);
        
        lr =[lfavg rtavg];
        
        p = round(mean(lr)); % Height
        
        % Equator radius calculation
        
        dh = p;
        handles.Height = (dh/handles.sf)*10; % in mm
        
        handles.cutoff = round(handles.cutratio*dh); % 15 percent cuttoff
        
        idx = find(z_surf<=handles.cutoff);
        start = idx(1);
        finish = idx(end);
        
        handles.xcut = x_surf (start:finish);
        handles.zcut = z_surf (start:finish);
        
        handles.xcut_nd = handles.xcut/handles.sf;
        handles.zcut_nd = handles.zcut/handles.sf;
        
        xcut = x_surf (start:finish);
        zcut = z_surf (start:finish);
        
        xeqpleft = handles.xcut(1); % left contact point x-coordinates
        xeqpright = handles.xcut(end); % right contact point x-coordinates
        
        
        % xeqpleft = min(xcut); % left contact point x-coordinates
        % xeqpright = max(xcut); % right contact point x-coordinates
        
        xeqpleft_cm = xeqpleft/handles.sf; % left contact point in cm
        xeqpright_cm = xeqpright/handles.sf; % right contact point in cm
        
        er = 0.5*(abs(xeqpleft_cm)+abs(xeqpright_cm)); % equator radius
        Xequator = 2*max(abs(handles.xcut/handles.sf))*10;
        Xwet = 2*er*10;
        
        
        handles.Eqdiameter = Xequator;
        handles.Wetdiameter = Xwet;
        % idxlefteq = find(xcut == xeqpleft);
        % idxrighteq = find(xcut == xeqpright);
        %
        % zeqpleft = mean(zcut(idxlefteq)); % left contact point z-coordinates
        % zeqpright = mean(zcut(idxrighteq)); % right contact point z-coordinates
        
        zeqpleft = handles.zcut(1);
        zeqpright = handles.zcut(end);
        
        zeqpleft_cm = zeqpleft/handles.sf;%#ok
        zeqpright_cm = zeqpright/handles.sf;%#ok
        
        handles.xeqleft =  xeqpleft;
        handles.xeqright = xeqpright;
        
        handles.zeqleft = zeqpleft;
        handles.zeqright = zeqpright;
        
        %% Constraints
        
        Var_Num = 2;  % Number of coefficients to determine
        
        % GA constraints
        % Upper bound on the design variables: lb <= x <= ub
        % If bounds are set to scalars, they will automatically propagate to all variables
        if isempty(handles.LB)
            
            handles.LB=[8,0.01];
            handles.UB=[40,10];
            
        else
            handles.LB = handles.LB;
            handles.UB = handles.UB;
            
        end
        
        A = [];  % Linear inequality constraint: A*X <= b
        bin= [];  % Linear inequality constraint: A*X <= b
        Aeq = [];  % Linear equality constraint: Aeq*X = beq
        beq = [];  % Linear equality constraint: Aeq*X = beq
        nonlcon = [];  % A function returning the nonlinear inequality (C(x)<=0) and equality (Ceq(x)=0) vectors
        
        %% Setting Options as Specified by the User
        
        % Defining pattern search (hybrid function) options
        Hybrid_Options = psoptimset(@patternsearch);
        Hybrid_Options = psoptimset(Hybrid_Options,'CompletePoll','on');
        Hybrid_Options = psoptimset(Hybrid_Options,'TolMesh',1e-6);
        Hybrid_Options = psoptimset(Hybrid_Options,'TolFun',handles.FunTol);
        Hybrid_Options = psoptimset(Hybrid_Options,'TolX',1e-6);
%       Hybrid_Options = psoptimset(Hybrid_Options,'UseParallel','always');
        Hybrid_Options = psoptimset(Hybrid_Options,'Display','iter');
        if handles.calcflag
            Hybrid_Options = psoptimset(Hybrid_Options ,'PlotFcn',{@psplotbestf  @psplotmeshsize  @psplotfuncount  @psplotbestx});
        end
        
        % GA_Options = gaoptimset(GA_Options, 'HybridFcn', { @patternsearch,Hybrid_Options });
        % 'TolMesh',1e-10,'TolFun',1e-10,'TolX',1e-10,
        %% Preparing and Executing the Genetic Algorithm
        
        % Extending lower and upper bounds to the same size as number of variables, if they are entered as scalars
        if size(handles.LB,2) == 1 && Var_Num > 1
            handles.LB(1,1:Var_Num) = handles.LB;
            handles.UB(1,1:Var_Num) = handles.UB;
        end
        
        handles.initpnt = handles.initpnt;
        
        % Running the genetic algorithm
        [Coefficients] = patternsearch(@ContactFcn,handles.initpnt,A,bin,Aeq,beq,handles.LB,handles.UB,nonlcon,Hybrid_Options);
        
        
        %% Numerical soution of the Young-Laplae equation
        handles.odesspan = handles.odesspan;
        handles.c = Coefficients(1);
        % c = (rho_l - rho_f)*g/sig;
        zn = handles.c^.5;
        l_c = 1/zn;%#ok
        handles.b=  Coefficients(2);
        handles.sigma = abs(handles.Liquiddensity-handles.BulkDensity)*handles.gravity/handles.c;
        [S,Y] = ode45(@Laplace, handles.odesspan, [0 1e-100 0 0 0], [], handles.b, handles.c);
        Z = Y(:,1);
        
        i=1;
        while Z(i)<Z(i+1)
            
            i=i+1;
            
        end
        
        x_yl (1:i,1) = Y(1:i,2);
        z_yl (1:i,1) = Y(1:i, 1);
        V_yl (1:i,1) = Y(1:i,4);
        A_yl (1:i,1) = Y(1:i,5);
        S_yl (1:i,1) = S(1:i,1);%#ok
        phi_yl (1:i,1) = Y (1:i,3)*180/pi;
        
        handles.xcut_nd = handles.c^0.5*handles.xcut/handles.sf;
        handles.zcut_nd = handles.c^0.5*handles.zcut/handles.sf;
        
        
        %         handles.Xcirc_nd = Xnew*handles.c^0.5/handles.sf;
        %         handles.Zcirc_nd = Znew*handles.c^0.5/handles.sf;
        
        
        
        [m,n] = min(abs(handles.zcut_nd(end)-z_yl(:,1)));
        % % Error = abs(xcut_nd (end) - x_yl (n));
        handles.YLAngle = phi_yl(n);
        Error_Laplace = 0.5*((handles.zcut_nd(end)-z_yl(n))^2+(handles.xcut_nd(end)-x_yl(n))^2);%#ok
        
        %
        %         [pr,qr] = min(abs(handles.zcut_nd(end)-handles.Zcirc_nd(1,:)));
        %         Error_Circ = 0.5*((handles.zcut_nd(end)-handles.Zcirc_nd(qr))^2+(handles.xcut_nd(end)-handles.Xcirc_nd(qr))^2);
        
        handles.Drop_vol_cm3 = V_yl(n)/handles.c^1.5;
        handles.Drop_area_cm2 = A_yl(n)/handles.c;
        
        handles.Bo = handles.c*(handles.Eqdiameter/20)^2; % Bond number
        
        drop_height_nd = dh*handles.c^0.5/handles.sf;
        
        w_H = 5/(handles.sf*handles.c^0.5);
        w_R = 2*handles.b*handles.c^0.5;
        w_theta = handles.YLAngle*sqrt((w_H/drop_height_nd)^2+(w_R/(0.19*drop_height_nd))^2);
        handles.w_theta = w_theta/1000;
        
        %% Drop volume calculation
        
        
        
        Z_yl_ind = find(z_yl <= drop_height_nd); % Index of end point on drop
        
        Z_YL = z_yl(1:length(Z_yl_ind)); % End Z
        X_YL = x_yl(1:length(Z_yl_ind)); % End X
        V = zeros(length(Z_YL)-1,1); % Size of Volume matrix
        A = zeros(length(Z_YL)-1,1);
        for n = 2:length(Z_YL)
            V(n-1) = pi*(((X_YL(n)+X_YL(n-1))/2)^2)*(Z_YL(n)-Z_YL(n-1));
            A(n-1) = pi * ((X_YL(n)+X_YL(n-1)));
        end
        drop_vol = sum(V)*1000;
        
        drop_vol_micL = (drop_vol/handles.c^1.5);%#ok
        
        
        
        
        
        
        time_YL = toc;
        handles.time_YL = time_YL;
        
        
        if handles.YLAngle > 90
            
            set(handles.DropEQDText,'String',num2str(handles.Eqdiameter));
            set(handles.DropWDText,'String',num2str(handles.Wetdiameter));
            
        else
            
            set(handles.DropEQDText,'String',num2str(handles.Eqdiameter));
            set(handles.DropWDText,'String',num2str(handles.Eqdiameter));
        end
        
        
        set(handles.YLTimeText,'String',num2str(handles.time_YL));
        set(handles.DropHeightText,'String',num2str(handles.Height));
        set(handles.DropApexText,'String',['Apex_x = ' num2str(handles.x) '         Apex_z = ' num2str(handles.z)]);
        set(handles.LeftCPointText,'String',['Left_x = ' num2str(handles.xeqleft) '         Left_z = ' num2str(handles.zeqleft)]);
        set(handles.RightCPointText,'String',['Right_x = ' num2str(handles.xeqright) '         Right_z = ' num2str(handles.zeqright)]);
        set(handles.YLAngleText,'String',sprintf ('%3.2f ± %2.2f',handles.YLAngle,handles.w_theta));
        set(handles.YLbText,'String',num2str(handles.b));
        set(handles.YLsigmaText,'String',num2str(handles.sigma));
        set(handles.DropVolText,'String',num2str(handles.Drop_vol_cm3));
        set(handles.DropAreaText,'String',num2str(handles.Drop_area_cm2));
        set(handles.DropBoText,'String',num2str(handles.Bo));
        set(handles.SphTimeText,'String',num2str(0));
        set(handles.SphAngleText,'String',num2str(0));
        
    else
        anglecr = questdlg('What is the image angle?  ', ...
            'Contact angle criteria:', ...
            'Greater than 90','Less than 90','Greater than 90');
        
        tic;
        if ~isempty(handles.cutratio)
            handles.cutratio = handles.cutratio;
        else
            handles.cutratio = 0.95;
        end
        
        
        if ~isempty(handles.odesspan)
            handles.odesspan = handles.odesspan;
        else
            handles.odesspan = [0:0.01:10];%#ok
        end
        
        
        if ~isempty(handles.FunTol)
            handles.FunTol = handles.FunTol;
        else
            handles.FunTol = 1e-6;
        end
        
        
        if ~isempty(handles.initpnt)
            handles.initpnt = handles.initpnt;
        else
            handles.initpnt = [1,1];
        end
        
        handles.BWedgeCrop = im2bw(handles.crop);
        contour = bwtraceboundary (handles.BWedgeCrop, [1,1], 'S');
        bound1=contour(find(contour(:,2)==(size(handles.BWedgeCrop,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),1);
        bound2=contour(find(contour(:,2)==(size(handles.BWedgeCrop,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),2);
        
        bound=[bound2,bound1];
        handles.flip_bound=flipud(bound);
        
        % Approximate apex coordinates
        handles.z = min(handles.flip_bound(:,2));
        handles.x = handles.flip_bound(round(mean(find(handles.flip_bound(:,2)==handles.z))),1);
        
        
        hbwedge = imshow(handles.BWedgeCrop);
        impixelinfo(hbwedge);
        hold on
        plot(handles.Axes, handles.x,handles.z,'bo')
        hold on
        plot(handles.Axes, handles.flip_bound(:,1),handles.flip_bound(:,2),'r','LineWidth',2);
        legend('Apex','Drop edge');
        hold off
        
        % Setting the apex to (0,0)
        z_surf = handles.flip_bound(:,2) - handles.z;
        x_surf = handles.flip_bound(:,1) - handles.x;
        
        % Finding the left and right Z-plane
        xind = round(mean(find(handles.flip_bound(:,2)==handles.z)));
        
        left = z_surf(1);
        right = z_surf(end);
        
        pindleft = find(z_surf>= left-1 & z_surf <=left+1);
        pindright = find(z_surf>= right-1 & z_surf<=right+1);
        
        idxlf = find(pindleft<xind);
        idxrt = pindright>xind;
        
        lpidx = pindleft(idxlf);%#ok
        rpidx = pindright(idxrt);
        
        % Height determination
        
        Leftplane = z_surf(lpidx);
        Rightplane = z_surf(rpidx);
        
        lfavg = mean(Leftplane);
        rtavg = mean(Rightplane);
        
        lr =[lfavg rtavg];
        
        p = round(mean(lr)); % Height
        
        % Equator radius calculation
        
        dh = p;
        handles.Height = (dh/handles.sf)*10; % in mm
        
        handles.cutoff = round(handles.cutratio*dh); % 15 percent cuttoff
        
        idx = find(z_surf<=handles.cutoff);
        start = idx(1);
        finish = idx(end);
        
        handles.xcut = x_surf (start:finish);
        handles.zcut = z_surf (start:finish);
        
        xcut = x_surf (start:finish);
        zcut = z_surf (start:finish);
        
        xeqpleft = handles.xcut(1); % left contact point x-coordinates
        xeqpright = handles.xcut(end); % right contact point x-coordinates
        
        
        % xeqpleft = min(xcut); % left contact point x-coordinates
        % xeqpright = max(xcut); % right contact point x-coordinates
        
        xeqpleft_cm = xeqpleft/handles.sf; % left contact point in cm
        xeqpright_cm = xeqpright/handles.sf; % right contact point in cm
        
        er = 0.5*(abs(xeqpleft_cm)+abs(xeqpright_cm)); % equator radius
        Xequator = 2*max(abs(handles.xcut/handles.sf))*10;
        Xwet = 2*er*10;
        
        
        handles.Eqdiameter = Xequator;
        handles.Wetdiameter = Xwet;
        % idxlefteq = find(xcut == xeqpleft);
        % idxrighteq = find(xcut == xeqpright);
        %
        % zeqpleft = mean(zcut(idxlefteq)); % left contact point z-coordinates
        % zeqpright = mean(zcut(idxrighteq)); % right contact point z-coordinates
        
        zeqpleft = handles.zcut(1);
        zeqpright = handles.zcut(end);
        
        zeqpleft_cm = zeqpleft/handles.sf;%#ok
        zeqpright_cm = zeqpright/handles.sf;%#ok
        
        handles.xeqleft =  xeqpleft;
        handles.xeqright = xeqpright;
        
        handles.zeqleft = zeqpleft;
        handles.zeqright = zeqpright;
        
        % [xeqpleft,xeqpright]
        % [zeqpleft,zeqpright]
        
        % figure;
        % plot(x_surf,z_surf,'bo')
        % hold all
        % plot(xcut,zcut,'y','LineWidth',2)
        % plot([xeqpleft,xeqpright],[zeqpleft,zeqpright],'gs','MarkerFaceColor','g')
        % set(gca,'YDir','reverse');
        
        
        
        zp = [handles.zeqleft,handles.zeqright];
        xp = [handles.xeqleft,handles.xeqright];
        
        ma = zp(1)/xp(1);
        mb = zp(2)/xp(2);
        
        xcenter = (ma*mb*(zp(2)-zp(1))+mb*xp(1)-ma*xp(2))/(2*(mb-ma));
        zcenter = ((-1/ma)*(xcenter-(xp(1)/2)))+(zp(1)/2);
        
        radius = sqrt(xcenter^2+zcenter^2);
        center = [xcenter, zcenter];
        nop=1000;
        [Xnew,Znew] = circle(center, radius,nop);
        
        value1 = Znew-dh;
        value2 = abs(value1);
        value3 = min(value2);
        
        index = find(value2 == value3);
        
        xx = Xnew (index);
        zz = Znew (index);
        
        xd = xcenter - xx;
        zd = zcenter - zz;
        
        theta_a = atan(zd/xd);
        theta_a = abs(theta_a);
        
        rad_angle1 = theta_a+(pi/2);
        rad_angle2 = rad_angle1*180/pi;
        
        bl90angle =mod (180-rad_angle2,180);
        
        time_sph = toc;
        handles.time_sph = time_sph;
        %     gr90angle = mod(180+rad_angle2,180);
        
        %% Constraints
        
        Var_Num = 2;  % Number of coefficients to determine
        
        % GA constraints
        % Upper bound on the design variables: lb <= x <= ub
        % If bounds are set to scalars, they will automatically propagate to all variables
        if isempty(handles.LB)
            
            handles.LB=[8,0.01];
            handles.UB=[40,10];
            
        else
            handles.LB = handles.LB;
            handles.UB = handles.UB;
            
        end
        
        A = [];  % Linear inequality constraint: A*X <= b
        bin= [];  % Linear inequality constraint: A*X <= b
        Aeq = [];  % Linear equality constraint: Aeq*X = beq
        beq = [];  % Linear equality constraint: Aeq*X = beq
        nonlcon = [];  % A function returning the nonlinear inequality (C(x)<=0) and equality (Ceq(x)=0) vectors
        
        %% Setting Options as Specified by the User
        
        % Defining pattern search (hybrid function) options
        Hybrid_Options = psoptimset(@patternsearch);
        Hybrid_Options = psoptimset(Hybrid_Options,'CompletePoll','on');
        Hybrid_Options = psoptimset(Hybrid_Options,'TolMesh',1e-6);
        Hybrid_Options = psoptimset(Hybrid_Options,'TolFun',handles.FunTol);
        Hybrid_Options = psoptimset(Hybrid_Options,'TolX',1e-6);
        Hybrid_Options = psoptimset(Hybrid_Options,'UseParallel','always');
        Hybrid_Options = psoptimset(Hybrid_Options,'Display','iter');
        if handles.calcflag
            Hybrid_Options = psoptimset(Hybrid_Options ,'PlotFcn',{@psplotbestf  @psplotmeshsize  @psplotfuncount  @psplotbestx});
        end
        
        % GA_Options = gaoptimset(GA_Options, 'HybridFcn', { @patternsearch,Hybrid_Options });
        % 'TolMesh',1e-10,'TolFun',1e-10,'TolX',1e-10,
        %% Preparing and Executing the Genetic Algorithm
        
        % Extending lower and upper bounds to the same size as number of variables, if they are entered as scalars
        if size(handles.LB,2) == 1 && Var_Num > 1
            handles.LB(1,1:Var_Num) = handles.LB;
            handles.UB(1,1:Var_Num) = handles.UB;
        end
        
        handles.initpnt = handles.initpnt;
        
        % Running the genetic algorithm
        [Coefficients] = patternsearch(@ContactFcn,handles.initpnt,A,bin,Aeq,beq,handles.LB,handles.UB,nonlcon,Hybrid_Options);
        
        
        %% Numerical soution of the Young-Laplae equation
        handles.odesspan = handles.odesspan;
        handles.c = Coefficients(1);
        % c = (rho_l - rho_f)*g/sig;
        zn = handles.c^.5;
        l_c = 1/zn;%#ok
        handles.b=  Coefficients(2);
        handles.sigma = abs(handles.Liquiddensity-handles.BulkDensity)*handles.gravity/handles.c;
        [S,Y] = ode45(@Laplace, handles.odesspan, [0 1e-100 0 0 0], [], handles.b, handles.c);
        Z = Y(:,1);
        
        i=1;
        while Z(i)<Z(i+1)
            
            i=i+1;
            
        end
        
        x_yl (1:i,1) = Y(1:i,2);
        z_yl (1:i,1) = Y(1:i, 1);
        V_yl (1:i,1) = Y(1:i,4);
        A_yl (1:i,1) = Y(1:i,5);
        S_yl (1:i,1) = S(1:i,1);%#ok
        phi_yl (1:i,1) = Y (1:i,3)*180/pi;
        
        handles.xcut_nd = handles.c^0.5*handles.xcut/handles.sf;
        handles.zcut_nd = handles.c^0.5*handles.zcut/handles.sf;
        
        
        handles.Xcirc_nd = Xnew*handles.c^0.5/handles.sf;
        handles.Zcirc_nd = Znew*handles.c^0.5/handles.sf;
        
        
        
        [m,n] = min(abs(handles.zcut_nd(end)-z_yl(:,1)));
        % % Error = abs(xcut_nd (end) - x_yl (n));
        handles.YLAngle = phi_yl(n);
        Error_Laplace = 0.5*((handles.zcut_nd(end)-z_yl(n))^2+(handles.xcut_nd(end)-x_yl(n))^2);%#ok
        
        
        [pr,qr] = min(abs(handles.zcut_nd(end)-handles.Zcirc_nd(1,:)));
        Error_Circ = 0.5*((handles.zcut_nd(end)-handles.Zcirc_nd(qr))^2+(handles.xcut_nd(end)-handles.Xcirc_nd(qr))^2);%#ok
        
        handles.Drop_vol_cm3 = V_yl(n)/handles.c^1.5;
        handles.Drop_area_cm2 = A_yl(n)/handles.c;
        
        handles.Bo = handles.c*(handles.Eqdiameter/20)^2; % Bond number
        
        drop_height_nd = dh*handles.c^0.5/handles.sf;
        
        w_H = 5/(handles.sf*handles.c^0.5);
        w_R = 2*handles.b*handles.c^0.5;
        w_theta = handles.YLAngle*sqrt((w_H/drop_height_nd)^2+(w_R/(0.19*drop_height_nd))^2);
        handles.w_theta = w_theta/1000;
        
        %% Drop volume calculation
        
        
        
        Z_yl_ind = find(z_yl <= drop_height_nd); % Index of end point on drop
        
        Z_YL = z_yl(1:length(Z_yl_ind)); % End Z
        X_YL = x_yl(1:length(Z_yl_ind)); % End X
        V = zeros(length(Z_YL)-1,1); % Size of Volume matrix
        A = zeros(length(Z_YL)-1,1);
        for n = 2:length(Z_YL)
            V(n-1) = pi*(((X_YL(n)+X_YL(n-1))/2)^2)*(Z_YL(n)-Z_YL(n-1));
            A(n-1) = pi * ((X_YL(n)+X_YL(n-1)));
        end
        drop_vol = sum(V)*1000;
        
        drop_vol_micL = (drop_vol/handles.c^1.5);%#ok
        
        
        
        switch anglecr
            case 'Greater than 90'
                
                handles.SphAngle = rad_angle2;
                set(handles.DropEQDText,'String',num2str(handles.Eqdiameter));
                set(handles.DropWDText,'String',num2str(handles.Wetdiameter));
                
            case 'Less than 90'
                
                handles.SphAngle = bl90angle;
                set(handles.DropEQDText,'String',num2str(handles.Eqdiameter));
                set(handles.DropWDText,'String',num2str(handles.Eqdiameter));
        end
        
        
        
        
        
        
        time_YL = toc;
        handles.time_YL = time_YL;
        
        set(handles.YLTimeText,'String',num2str(handles.time_YL));
        set(handles.SphTimeText,'String',num2str(handles.time_sph));
        set(handles.SphAngleText,'String',sprintf('%3.2f',handles.SphAngle));
        set(handles.DropHeightText,'String',num2str(handles.Height));
        set(handles.DropApexText,'String',['Apex_x = ' num2str(handles.x) '         Apex_z = ' num2str(handles.z)]);
        set(handles.LeftCPointText,'String',['Left_x = ' num2str(handles.xeqleft) '         Left_z = ' num2str(handles.zeqleft)]);
        set(handles.RightCPointText,'String',['Right_x = ' num2str(handles.xeqright) '         Right_z = ' num2str(handles.zeqright)]);
        set(handles.YLAngleText,'String',sprintf ('%3.2f ± %2.2f',handles.YLAngle,handles.w_theta));
        set(handles.YLbText,'String',num2str(handles.b));
        set(handles.YLsigmaText,'String',num2str(handles.sigma));
        set(handles.DropVolText,'String',num2str(handles.Drop_vol_cm3));
        set(handles.DropAreaText,'String',num2str(handles.Drop_area_cm2));
        set(handles.DropBoText,'String',num2str(handles.Bo));
        
        if handles.compflag
            
            handles.h1=figure;
            plot(handles.xcut_nd,handles.zcut_nd,'g','LineWidth',2);
            hold all;
            plot(-x_yl,z_yl,'b--','LineWidth',2);
            plot(x_yl,z_yl,'b','LineWidth',2);
            plot(handles.Xcirc_nd,handles.Zcirc_nd,'r','LineWidth',2);
            plot([xeqpleft*handles.c^0.5/handles.sf,xeqpright*handles.c^0.5/handles.sf],...
                [zeqpleft*handles.c^0.5/handles.sf,zeqpright*handles.c^0.5/handles.sf],'ks','MarkerFaceColor','k')
            set(gca,'YDir','reverse');
            % set(gca,'Xlim',[min(Xcirc_nd)-0.7 max(Xcirc_nd)+0.7]);
            % set(gca,'Ylim',[min(Zcirc_nd)-0.7 max(Zcirc_nd)+0.7]);
            axis square
            pbaspect([2 2 1])
            legend('Experimental profile','Young-Laplace left profile','Young-Laplace right profile',...
                'Spherical cap approximation','Contact points','Location','SouthWest');
            xlabel('\bfHorizontal coordinates');
            ylabel('\bfVertical coordinates');
            title('\bfComparison of the non-dimensionalized data');
            
            hold off;
            set(gca,'XGrid','on','YGrid','on');
        end
        figure;
        imshow(handles.crop);
        hold all
        plot(-x_yl*handles.sf/handles.c^0.5+handles.x,z_yl*handles.sf/handles.c^0.5+handles.z,'b--','LineWidth',2);
        plot(x_yl*handles.sf/handles.c^0.5+handles.x,z_yl*handles.sf/handles.c^0.5+handles.z,'b','LineWidth',2);
        plot(handles.Xcirc_nd*handles.sf/handles.c^0.5+handles.x,handles.Zcirc_nd*handles.sf/handles.c^0.5+handles.z,'r','LineWidth',2);
        plot([xeqpleft+handles.x,xeqpright+handles.x],...
            [zeqpleft+handles.z,zeqpright+handles.z],'ks','MarkerFaceColor','k')
        hold off
    end    
end

handles.sf = [];

guidata(hObject,handles);

% --- Executes on button press in ViewCalcChekBox.
function ViewCalcChekBox_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to ViewCalcChekBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ViewCalcChekBox
value = get(hObject,'Value');

if value
    handles.calcflag = 1;
else
    handles.calcflag = 0;
end

guidata(hObject,handles);

% --- Executes on button press in ViewCompChckBox.
function ViewCompChckBox_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to ViewCompChckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ViewCompChckBox
value = get(hObject,'Value');

if value
    handles.compflag = 1;
else
    handles.compflag = 0;
end

guidata(hObject,handles);

% --------------------------------------------------------------------
function FileM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to FileM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function LoadM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to LoadM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[filename, pathname] = uigetfile(...
                                               {'*.bmp;*.tif;*.gif;*.png;*.jpg','Image Files(*.bmp,*.tif,*.gif,*.png,*.jpg)';
                                                '*.*','All Files(*.*)'},...
                                               'Pick an Image');
fid = fopen ('pathname.dat','w');
fprintf(fid,'%s',pathname);
fclose(fid);

image = imread([pathname,filename]);
handles.image = rgb2gray(image);
handles.hand = imshow(handles.image);
impixelinfo(handles.hand);
% handles.region = impixelregion(handles.hand);

guidata(hObject,handles);

% --------------------------------------------------------------------
function SaveM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to SaveM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[File, Path] = uiputfile({'*.fig','Figures (*.fig)'},'Save Figure as...');
NewFig = handles.h1;
% NewAx = copyobj(handles.h1,NewFig);
set(NewFig,'Units','normalized','Position',[0.11 0.13 0.85 0.75]);
hgsave(NewFig,[Path File]);
close(NewFig);

% --------------------------------------------------------------------
function SaveTxtM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to SaveTxtM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

time_YLsave = get(handles.YLTimeText,'String');
time_sphsave = get(handles.SphTimeText,'String');
SphAngle = get(handles.SphAngleText,'String');
Height = get(handles.DropHeightText,'String');
YLCangle = get(handles.YLAngleText,'String');
Curatapex = get(handles.YLbText,'String');
Sigma = get(handles.YLsigmaText,'String');
Volume = get(handles.DropVolText,'String');
Area = get(handles.DropAreaText,'String');
Bond = get(handles.DropBoText,'String');
Equator = get(handles.DropEQDText,'String');
Wet = get(handles.DropWDText,'String');

options.Resize = 'on';
params = inputdlg({'File name','Date'},'Enter file name and date of experiment',...
    repmat([1 50],2,1),{'exp.txt','1394/01/01'},options);
File_name = params{1};
Date = params{2};
fileID = fopen(File_name,'w');

%% Spherical cap approximation
fprintf(fileID,'File name: %12s\r\n',File_name);
fprintf(fileID,'Date: %12s\r\n',Date);
fprintf(fileID,'=============================================\r\n\r\n\r\n');



fprintf(fileID,'%12s\r\n','Spherical Cap');
fprintf(fileID,'---------------------------------------------\r\n');
fprintf(fileID,'Time (s): %6.2f\r\n',str2num(time_sphsave));%#ok
fprintf(fileID,'Angle (degrees): %6.2f\r\n\r\n\r\n',str2num(SphAngle));%#ok

%% Young-Laplace
fprintf(fileID,'%12s\r\n','Young-Laplace');
fprintf(fileID,'---------------------------------------------\r\n');
fprintf(fileID,'Time (s): %6.2f\r\n',str2num(time_YLsave));%#ok
fprintf(fileID,'Angle (degrees): %12s\r\n',YLCangle);
fprintf(fileID,'Curvature at the apex (cm): %6.4f\r\n',str2num(Curatapex));%#ok
fprintf(fileID,'Surface tension (mN/m): %6.2f\r\n\r\n\r\n',str2num(Sigma));%#ok


%% Drop characteristics
fprintf(fileID,'%12s\r\n','Drop Characteristics');
fprintf(fileID,'---------------------------------------------\r\n');
fprintf(fileID,'Drop height (mm): %6.2f\r\n',str2num(Height));%#ok
fprintf(fileID,'Equator diameter (mm): %6.2f\r\n',str2num(Equator));%#ok
fprintf(fileID,'Wetted diameter (mm): %6.2f\r\n',str2num(Wet));%#ok
fprintf(fileID,'Drop volume (cu. cm): %6.5f\r\n',str2num(Volume));%#ok
fprintf(fileID,'Drop surface area (sq. cm): %6.5f\r\n',str2num(Area));%#ok
fprintf(fileID,'Bond number (dimensionless): %6.4f\r\n',str2num(Bond));%#ok




fclose(fileID);




% --------------------------------------------------------------------
function ExitM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to ExitM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.MainFigure);

% --------------------------------------------------------------------
function EditM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to EditM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --------------------------------------------------------------------
function ScaleM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to ScaleM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sf

if isempty(handles.image)
    warndlg('No image has been loaded!','Warning');
else
    
    imshow(handles.image);
    answer = questdlg('How would you like the scale to be calculated?  ', ...
        'Scale', ...
        'Horizontal','Vertical','Automatic','Horizontal');
    
    
    
    if ~isempty(answer)
       
        
        
        switch answer
            case 'Horizontal'
                [x,y] = ginput(2);%#ok
                pixels = abs(x(2)-x(1));
                prompt = {'Scale, mm'};
                label = 'Enter scale:';
                defaults = {'0.75'};
                options.Resize = 'on';
                params = inputdlg (prompt,label,[1 20],defaults,options);
                scale_mm = str2num(params{1}); %#ok
                
                scale_cm = scale_mm/10;
                
                sf = abs(pixels/scale_cm);
                handles.sf = sf;
                
            case 'Vertical'
                [x,y] = ginput(2);
                pixels = abs(y(2)-y(1));
                prompt = {'Scale, mm'};
                label = 'Enter scale:';
                defaults = {'0.75'};
                options.Resize = 'on';
                params = inputdlg (prompt,label,[1 20],defaults,options);
                scale_mm = str2num(params{1}); %#ok
                
                scale_cm = scale_mm/10;
                
                sf = abs(pixels/scale_cm);
                handles.sf = sf;
                
            case 'Automatic'
                handles.sf = [];
        end
        
        
    else
        handles.sf = [];
    end
    
end


guidata(hObject,handles);
% --------------------------------------------------------------------
function SettingM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to SettingM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function AboutM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to AboutM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function BoundCM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to BoundCM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'Lower bounds:', 'Upper bounds:'};
label = 'Bound constraints';
defaults = {'[8,0.01]','[40, 10]'};
options.Resize = 'on';
params = inputdlg (prompt,label,repmat([1 50],2,1),defaults,options);

if isempty(params)
    handles.LB = [8,0.01];
    handles.UB = [40,10];
else
    handles.LB = str2num(params{1}); %#ok
    handles.UB = str2num(params{2}); %#ok
end

guidata(hObject,handles);
% --------------------------------------------------------------------
function GrayThreshM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to GrayThreshM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Threshhold:'};
label = 'Enter B & W threshhold';
defaults = {'0.4'};
options.Resize = 'on';
params = inputdlg (prompt,label,[1 50],defaults,options);


if isempty (params)
    handles.thresh = graythresh(handles.image);
else
    handles.thresh = str2num(params{1}); %#ok
end


guidata(hObject,handles);
% --------------------------------------------------------------------
function CutoffM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to CutoffM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Cutoff ratio;'};
label = 'Enter cutoff ratio';
defaults = {'0.95'};
options.Resize = 'on';
params = inputdlg (prompt,label,[1 50],defaults,options);

if isempty (params)
    handles.cutratio = 0.95;
else
    handles.cutratio = str2num(params{1}); %#ok
end

guidata(hObject,handles);
% --------------------------------------------------------------------
function FunTolM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to FunTolM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Function tolerance:'};
label = 'Enter function tolerance';
defaults = {'1e-4'};
options.Resize = 'on';
params = inputdlg (prompt,label,[1 50],defaults,options);

if isempty (params)
    handles.FunTol = 1e-4;
else
    handles.FunTol = str2num(params{1}); %#ok
end

guidata(hObject,handles);

% --------------------------------------------------------------------
function ODESpanM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to ODESpanM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Arc span:'};
label = 'Enter ode arc span';
defaults = {'[0:0.01:10]'};
options.Resize = 'on';
params = inputdlg (prompt,label,[1 50],defaults,options);

if isempty (params)
    handles.odesspan = [0:0.01:10];%#ok
else
    handles.odesspan = str2num(params{1}); %#ok
end

guidata(hObject,handles);

% --------------------------------------------------------------------
function InitPM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to InitPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Initial point:'};
label = 'Enter initial points that define laplacian';
defaults = {'[1,1]'};
options.Resize = 'on';
params = inputdlg (prompt,label,[1 50],defaults,options);

if isempty (params)
    handles.initpnt = [1,1];
else
    handles.initpnt = str2num(params{1}); %#ok
end

guidata(hObject,handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over OrigImPB.
function OrigImPB_ButtonDownFcn(hObject, eventdata, handles)%#ok
% hObject    handle to OrigImPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function AboutSessM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to AboutSessM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
message = ['Contact the programmer: safari.hossein68@gmail.com'];%#ok
label = 'About Sessile Drop Analyzer';
h = msgbox(message,label,'help');%#ok

% --- Executes on selection change in MethodPopM.
function MethodPopM_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to MethodPopM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MethodPopM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MethodPopM


% --- Executes during object creation, after setting all properties.
function MethodPopM_CreateFcn(hObject, eventdata, handles)%#ok
% hObject    handle to MethodPopM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Circle function
% --------------------------------------------------------------------
function [X,Y,H] = circle(center, radius,nop,style)%#ok

if nargin < 3
    
    error ('Not enough input arguments!!')
    
elseif nargin == 3
    
    style= 'b-';%#ok
    
end

theta = linspace(0,2*pi,nop);
rho = ones(1,nop)*radius;
[X,Y] = pol2cart(theta,rho);

X = X + center(1);
Y = Y + center(2);

% H = plot(X,Y,style);
axis square;


% Laplace Function
% --------------------------------------------------------------------
function [dy] = Laplace (s,y,b,c)%#ok
% Laplace function defines the ordinary differential equation that needs to
% be solved.


% Z = y(1); Z' = dZ/dS = dy(1); 
% X = y(2); X' = dX/dS = d(2);
% phi = y(3); phi ' = dphi/dS =dy(3);
% All the derivatives are with respect to arc-length s


% Z' = sin(phi);
% X' = cos(phi);
% phi' = 2/B + Z - (sin(phi)/X);



dy = zeros(5,1);


B = b*c^0.5;

dy(1) = sin(y(3));
dy(2) = cos(y(3));
dy(3) = (2/B) + y(1) - (sin(y(3))/y(2));
dy(4) = pi*(y(2)^2)*sin(y(3));
dy(5) = 2*pi*y(2);





% Objective function
% --------------------------------------------------------------------
function Error = ContactFcn (X)

global xcut zcut sf

S_span = [0:0.01:10];%#ok
% c = (rho_l - rho_f)*g/X(1);
c = X(1);
b = X(2);

[S,Y] = ode45(@Laplace, S_span, [0 1e-100 0 0 0], [], b, c);
Z = Y(:,1);

i=1;
while Z(i)<Z(i+1)
    
    i=i+1;
    
end

x_yl (1:i,1) = Y(1:i,2);
z_yl (1:i,1) = Y(1:i,1);
% S_yl (1:i,1) = S(1:i,1);
% phi_yl (1:i,1) = Y (1:i,3)*180/pi;

xcut_nd = (c^0.5)*xcut/sf;
zcut_nd = (c^0.5)*zcut/sf;

[m,n] = min(abs(zcut_nd(end)-z_yl(:,1)));
% Error = abs((xcut_nd (end)) - (x_yl (n)));
% Error = sqrt((zcut_nd(end)-z_yl(n))^2+(xcut_nd(end)-x_yl(n))^2);
Error = 0.5*((zcut_nd(end)-z_yl(n))^2+(xcut_nd(end)-x_yl(n))^2);


% --------------------------------------------------------------------
function NeedleDm_Callback(hObject, eventdata, handles)%#ok
% hObject    handle to NeedleDm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'Neddle diameter, mm'};
label = 'Enter scale:';
defaults = {'0.75'};
options.Resize = 'on';
params = inputdlg (prompt,label,[1 20],defaults,options);

if isempty (params)
    handles.needlediameter = 0.75;
else
    scale_mm = str2num(params{1}); %#ok
    handles.needlediameter = scale_mm;
end


guidata(hObject,handles);
