function varargout = dvanaesti(varargin)
% DVANAESTI MATLAB code for dvanaesti.fig
%      DVANAESTI, by itself, creates a new DVANAESTI or raises the existing
%      singleton*.
%
%      H = DVANAESTI returns the handle to a new DVANAESTI or the handle to
%      the existing singleton*.
%
%      DVANAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DVANAESTI.M with the given input arguments.
%
%      DVANAESTI('Property','Value',...) creates a new DVANAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dvanaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dvanaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dvanaesti

% Last Modified by GUIDE v2.5 31-May-2018 01:53:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dvanaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @dvanaesti_OutputFcn, ...
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


% --- Executes just before dvanaesti is made visible.
function dvanaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dvanaesti (see VARARGIN)

% Choose default command line output for dvanaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dvanaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dvanaesti_OutputFcn(hObject, eventdata, handles) 
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

% Place a text label on the bar chart showing the threshold.
annotationText = sprintf('Thresholded at %d gray levels', thresholdValue);
% For text(), the x and y need to be of the data class "double" so let's cast both to double.
text(double(thresholdValue + 5), double(0.5 * maxYValue(2)), annotationText, 'FontSize', 10, 'Color', [0 .5 0]);
text(double(thresholdValue - 70), double(0.94 * maxYValue(2)), 'Background', 'FontSize', 10, 'Color', [0 0 .5]);
text(double(thresholdValue + 50), double(0.94 * maxYValue(2)), 'Foreground', 'FontSize', 10, 'Color', [0 0 .5]);

pic = imread('Images/12.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'annotationText', annotationText);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
