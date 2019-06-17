function varargout = webcam_test_gui(varargin)
% WEBCAM_TEST_GUI MATLAB code for webcam_test_gui.fig
%      WEBCAM_TEST_GUI, by itself, creates a new WEBCAM_TEST_GUI or raises the existing
%      singleton*.
%
%      H = WEBCAM_TEST_GUI returns the handle to a new WEBCAM_TEST_GUI or the handle to
%      the existing singleton*.
%
%      WEBCAM_TEST_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEBCAM_TEST_GUI.M with the given input arguments.
%
%      WEBCAM_TEST_GUI('Property','Value',...) creates a new WEBCAM_TEST_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before webcam_test_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to webcam_test_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help webcam_test_gui

% Last Modified by GUIDE v2.5 11-Mar-2017 19:39:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @webcam_test_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @webcam_test_gui_OutputFcn, ...
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


% --- Executes just before webcam_test_gui is made visible.
function webcam_test_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to webcam_test_gui (see VARARGIN)

% Choose default command line output for webcam_test_gui
handles.output = hObject;

% Create video object
%   Putting the object into manual trigger mode and then
%   starting the object will make GETSNAPSHOT return faster
%   since the connection to the camera will already have
%   been established.
handles.video = videoinput('winvideo', 1);
set(handles.video,'TimerPeriod', 0.05, ...
      'TimerFcn',['if(~isempty(gco)),'...
                      'handles=guidata(gcf);'...                                 % Update handles
                      'image(getsnapshot(handles.video));'...                    % Get picture using GETSNAPSHOT and put it into axes using IMAGE
                      'set(handles.webcam_axes,''ytick'',[],''xtick'',[]),'...    % Remove tickmarks and labels that are inserted when using IMAGE
                  'else '...
                      'delete(imaqfind);'...                                     % Clean up - delete any image acquisition objects
                  'end']);
triggerconfig(handles.video,'manual');
handles.video.FramesPerTrigger = Inf; % Capture frames until we manually stop it

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes webcam_test_gui wait for user response (see UIRESUME)
 uiwait(handles.webcam_gui);


% --- Outputs from this function are returned to the command line.
function varargout = webcam_test_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

handles.output = hObject;
varargout{1} = handles.output;


% --- Executes when user attempts to close webcam_gui.
function webcam_gui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to webcam_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
delete(imaqfind);


% --- Executes on button press in startstopcamera.
function startstopcamera_Callback(hObject, eventdata, handles)
% hObject    handle to startstopcamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Start/Stop Camera
if strcmp(get(handles.startstopcamera,'String'),'Start Camera')
      % Camera is off. Change button string and start camera.
      set(handles.startstopcamera,'String','Stop Camera')
      start(handles.video)
      set(handles.startAcquisition,'Enable','on');
      set(handles.captureImage,'Enable','on');
else
      % Camera is on. Stop camera and change button string.
      set(handles.startstopcamera,'String','Start Camera')
      stop(handles.video)
      set(handles.startAcquisition,'Enable','off');
      set(handles.captureImage,'Enable','off');
end


% --- Executes on button press in captureImage.
function captureImage_Callback(hObject, eventdata, handles)
% hObject    handle to captureImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%frame = getsnapshot(handles.video);
frame = get(get(handles.webcam_axes,'children'),'cdata'); % The current displayed frame
save('testframe.mat', 'frame');
% saveas(fig,'testframe.jpg');
disp('Frame saved to file ''testframe.mat''');


% --- Executes on button press in startAcquisition.
function startAcquisition_Callback(hObject, eventdata, handles)
% hObject    handle to startAcquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Start/Stop acquisition
if strcmp(get(handles.startAcquisition,'String'),'Start Acquisition')
      % Camera is not acquiring. Change button string and start acquisition.
      set(handles.startAcquisition,'String','Stop Acquisition');
      trigger(handles.video);
else
      % Camera is acquiring. Stop acquisition, save video data,
      % and change button string.
      stop(handles.video);
      disp('Saving captured video...');
      videodata = getdata(handles.video);
      save('testvideo.mp4', 'videodata');
      disp('Video saved to file ''testvideo.mat''');
      start(handles.video); % Restart the camera
      set(handles.startAcquisition,'String','Start Acquisition');
end
