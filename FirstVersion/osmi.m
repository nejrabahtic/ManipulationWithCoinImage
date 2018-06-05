function varargout = osmi(varargin)
% OSMI MATLAB code for osmi.fig
%      OSMI, by itself, creates a new OSMI or raises the existing
%      singleton*.
%
%      H = OSMI returns the handle to a new OSMI or the handle to
%      the existing singleton*.
%
%      OSMI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OSMI.M with the given input arguments.
%
%      OSMI('Property','Value',...) creates a new OSMI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before osmi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to osmi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help osmi

% Last Modified by GUIDE v2.5 30-May-2018 23:41:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @osmi_OpeningFcn, ...
                   'gui_OutputFcn',  @osmi_OutputFcn, ...
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


% --- Executes just before osmi is made visible.
function osmi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to osmi (see VARARGIN)

% Choose default command line output for osmi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes osmi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = osmi_OutputFcn(hObject, eventdata, handles) 
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
originalImage = evalin('base', 'originalImage'); 

% Just for fun, let's get its histogram and display it.
[pixelCount, grayLevels] = imhist(originalImage);
bar(pixelCount);
title('Histogram of original image');
xlim([0 grayLevels(end)]); % Scale x axis manually.

axes(handles.axes2);

pic = imread('Images/8.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'grayLevels', grayLevels);
assignin('base', 'pixelCount', pixelCount);
assignin('base', 'grayLevels', grayLevels);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
