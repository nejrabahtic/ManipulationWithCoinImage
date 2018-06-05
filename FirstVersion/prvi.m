function varargout = prvi(varargin)
% PRVI MATLAB code for prvi.fig
%      PRVI, by itself, creates a new PRVI or raises the existing
%      singleton*.
%
%      H = PRVI returns the handle to a new PRVI or the handle to
%      the existing singleton*.
%
%      PRVI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRVI.M with the given input arguments.
%
%      PRVI('Property','Value',...) creates a new PRVI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prvi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prvi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prvi

% Last Modified by GUIDE v2.5 29-May-2018 14:54:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prvi_OpeningFcn, ...
                   'gui_OutputFcn',  @prvi_OutputFcn, ...
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


% --- Executes just before prvi is made visible.
function prvi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prvi (see VARARGIN)

% Choose default command line output for prvi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prvi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prvi_OutputFcn(hObject, eventdata, handles) 
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

% function BlobsDemo()
% echo on;
% Startup code.
tic; % Start timer.
fprintf('Running BlobsDemo.m...\n'); % Message sent to command window.
workspace; % Make sure the workspace panel with all the variables is showing.
imtool close all;  % Close all imtool figures.
format long g;
format compact;
captionFontSize = 14;

pic = imread('Images/1.png');
axes(handles.axes1);
imshow(pic);

string = "Running BlobsDemo.m...";
set(handles.text3, 'String', string);

%putting variable in workspace
assignin('base', 'captionFontSize', captionFontSize);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
