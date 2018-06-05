function varargout = sedamnaesti(varargin)
% SEDAMNAESTI MATLAB code for sedamnaesti.fig
%      SEDAMNAESTI, by itself, creates a new SEDAMNAESTI or raises the existing
%      singleton*.
%
%      H = SEDAMNAESTI returns the handle to a new SEDAMNAESTI or the handle to
%      the existing singleton*.
%
%      SEDAMNAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEDAMNAESTI.M with the given input arguments.
%
%      SEDAMNAESTI('Property','Value',...) creates a new SEDAMNAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sedamnaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sedamnaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sedamnaesti

% Last Modified by GUIDE v2.5 31-May-2018 16:39:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sedamnaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @sedamnaesti_OutputFcn, ...
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


% --- Executes just before sedamnaesti is made visible.
function sedamnaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sedamnaesti (see VARARGIN)

% Choose default command line output for sedamnaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sedamnaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sedamnaesti_OutputFcn(hObject, eventdata, handles) 
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
captionFontSize = evalin('base', 'captionFontSize'); 
originalImage = evalin('base', 'originalImage'); 
binaryImage = evalin('base', 'binaryImage'); 
numberOfBlobs = evalin('base', 'numberOfBlobs'); 

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
% Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries.
axes(handles.axes2);
imshow(originalImage);
title('Outlines, from bwboundaries()', 'FontSize', captionFontSize); 

hold on;

boundaries = bwboundaries(binaryImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;

textFontSize = 14;	% Used to control size of "blob number" labels put atop the image.
labelShiftX = -7;	% Used to align the labels in the centers of the coins.
blobECD = zeros(1, numberOfBlobs);

pic = imread('Images/17.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'textFontSize', textFontSize);
assignin('base', 'labelShiftX', labelShiftX);
assignin('base', 'blobECD', blobECD);
assignin('base', 'k', k);
assignin('base', 'boundaries', boundaries);
assignin('base', 'numberOfBoundaries', numberOfBoundaries);
assignin('base', 'thisBoundary', thisBoundary);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
