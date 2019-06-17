function varargout = bot_gui(varargin)
% BOT_GUI MATLAB code for bot_gui.fig
%      BOT_GUI, by itself, creates a new BOT_GUI or raises the existing
%      singleton*.
%
%      H = BOT_GUI returns the handle to a new BOT_GUI or the handle to
%      the existing singleton*.
%
%      BOT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOT_GUI.M with the given input arguments.
%
%      BOT_GUI('Property','Value',...) creates a new BOT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bot_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bot_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bot_gui

% Last Modified by GUIDE v2.5 11-Mar-2017 16:30:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bot_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @bot_gui_OutputFcn, ...
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


% --- Executes just before bot_gui is made visible.
function bot_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bot_gui (see VARARGIN)

% Choose default command line output for bot_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bot_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bot_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in up.
function up_Callback(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in left.
function left_Callback(hObject, eventdata, handles)
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in down.
function down_Callback(hObject, eventdata, handles)
% hObject    handle to down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in right.
function right_Callback(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in manual.
function manual_Callback(hObject, eventdata, handles)
% hObject    handle to manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in auto.
function auto_Callback(hObject, eventdata, handles)
% hObject    handle to auto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
