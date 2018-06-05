function varargout = deseti(varargin)
% DESETI MATLAB code for deseti.fig
%      DESETI, by itself, creates a new DESETI or raises the existing
%      singleton*.
%
%      H = DESETI returns the handle to a new DESETI or the handle to
%      the existing singleton*.
%
%      DESETI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DESETI.M with the given input arguments.
%
%      DESETI('Property','Value',...) creates a new DESETI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before deseti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to deseti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help deseti

% Last Modified by GUIDE v2.5 31-May-2018 01:20:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @deseti_OpeningFcn, ...
                   'gui_OutputFcn',  @deseti_OutputFcn, ...
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


% --- Executes just before deseti is made visible.
function deseti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to deseti (see VARARGIN)

% Choose default command line output for deseti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes deseti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = deseti_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%loading variables from workspace
binaryImage = evalin('base', 'binaryImage'); 

% Do a "hole fill" to get rid of any background pixels or "holes" inside the blobs.
binaryImage = imfill(binaryImage, 'holes');

pic = imread('Images/10.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'binaryImage', binaryImage);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
