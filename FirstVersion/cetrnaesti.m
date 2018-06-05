function varargout = cetrnaesti(varargin)
% CETRNAESTI MATLAB code for cetrnaesti.fig
%      CETRNAESTI, by itself, creates a new CETRNAESTI or raises the existing
%      singleton*.
%
%      H = CETRNAESTI returns the handle to a new CETRNAESTI or the handle to
%      the existing singleton*.
%
%      CETRNAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CETRNAESTI.M with the given input arguments.
%
%      CETRNAESTI('Property','Value',...) creates a new CETRNAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cetrnaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cetrnaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cetrnaesti

% Last Modified by GUIDE v2.5 31-May-2018 02:09:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cetrnaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @cetrnaesti_OutputFcn, ...
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


% --- Executes just before cetrnaesti is made visible.
function cetrnaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cetrnaesti (see VARARGIN)

% Choose default command line output for cetrnaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cetrnaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cetrnaesti_OutputFcn(hObject, eventdata, handles) 
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
captionFontSize = evalin('base', 'captionFontSize'); 

% Identify individual blobs by seeing which pixels are connected to each other.
% Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
% Do connected components labeling with either bwlabel() or bwconncomp().
labeledImage = bwlabel(binaryImage, 8);     % Label each blob so we can make measurements of it
% labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
axes(handles.axes2);
imshow(labeledImage, []);  % Show the gray scale image.
title('Labeled Image, from bwlabel()', 'FontSize', captionFontSize);

pic = imread('Images/14.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'labeledImage', labeledImage);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
