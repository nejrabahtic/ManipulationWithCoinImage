function varargout = petnaesti(varargin)
% PETNAESTI MATLAB code for petnaesti.fig
%      PETNAESTI, by itself, creates a new PETNAESTI or raises the existing
%      singleton*.
%
%      H = PETNAESTI returns the handle to a new PETNAESTI or the handle to
%      the existing singleton*.
%
%      PETNAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PETNAESTI.M with the given input arguments.
%
%      PETNAESTI('Property','Value',...) creates a new PETNAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before petnaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to petnaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help petnaesti

% Last Modified by GUIDE v2.5 31-May-2018 02:23:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @petnaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @petnaesti_OutputFcn, ...
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


% --- Executes just before petnaesti is made visible.
function petnaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to petnaesti (see VARARGIN)

% Choose default command line output for petnaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes petnaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = petnaesti_OutputFcn(hObject, eventdata, handles) 
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
labeledImage = evalin('base', 'labeledImage'); 
captionFontSize = evalin('base', 'captionFontSize'); 

% Let's assign each blob a different color to visually show the user the distinct blobs.
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle'); % pseudo random color labels
% coloredLabels is an RGB image.  We could have applied a colormap instead (but only with R2014b and later)
axes(handles.axes2);
imshow(coloredLabels);

caption = sprintf('Pseudo colored labels, from label2rgb().\nBlobs are numbered from top to bottom, then from left to right.');
title(compose('Pseudo colored labels, from label2rgb().\nBlobs are numbered from top to bottom, then from left to right.'), 'FontSize', 12);

pic = imread('Images/15.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'coloredLabels', coloredLabels);
assignin('base', 'caption', caption);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
