function varargout = jedanaesti(varargin)
% JEDANAESTI MATLAB code for jedanaesti.fig
%      JEDANAESTI, by itself, creates a new JEDANAESTI or raises the existing
%      singleton*.
%
%      H = JEDANAESTI returns the handle to a new JEDANAESTI or the handle to
%      the existing singleton*.
%
%      JEDANAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JEDANAESTI.M with the given input arguments.
%
%      JEDANAESTI('Property','Value',...) creates a new JEDANAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jedanaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jedanaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jedanaesti

% Last Modified by GUIDE v2.5 31-May-2018 01:35:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jedanaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @jedanaesti_OutputFcn, ...
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


% --- Executes just before jedanaesti is made visible.
function jedanaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jedanaesti (see VARARGIN)

% Choose default command line output for jedanaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jedanaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jedanaesti_OutputFcn(hObject, eventdata, handles) 
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
thresholdValue = evalin('base', 'thresholdValue');
originalImage = evalin('base', 'originalImage');

[pixelCount, grayLevels] = imhist(originalImage);
bar(pixelCount);
title('Histogram of original image');
xlim([0 grayLevels(end)]); % Scale x axis manually.
ylim = [0 6000];

% Show the threshold as a vertical red bar on the histogram.
hold on;
maxYValue = ylim;
line([thresholdValue, thresholdValue], maxYValue, 'Color', 'r');

axes(handles.axes2);

pic = imread('Images/11.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'maxYValue', maxYValue);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
