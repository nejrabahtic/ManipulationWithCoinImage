function varargout = dvadesettreci(varargin)
% DVADESETTRECI MATLAB code for dvadesettreci.fig
%      DVADESETTRECI, by itself, creates a new DVADESETTRECI or raises the existing
%      singleton*.
%
%      H = DVADESETTRECI returns the handle to a new DVADESETTRECI or the handle to
%      the existing singleton*.
%
%      DVADESETTRECI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DVADESETTRECI.M with the given input arguments.
%
%      DVADESETTRECI('Property','Value',...) creates a new DVADESETTRECI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dvadesettreci_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dvadesettreci_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dvadesettreci

% Last Modified by GUIDE v2.5 01-Jun-2018 21:56:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dvadesettreci_OpeningFcn, ...
                   'gui_OutputFcn',  @dvadesettreci_OutputFcn, ...
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


% --- Executes just before dvadesettreci is made visible.
function dvadesettreci_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dvadesettreci (see VARARGIN)

% Choose default command line output for dvadesettreci
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dvadesettreci wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dvadesettreci_OutputFcn(hObject, eventdata, handles) 
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
keeperIndexes = evalin('base', 'keeperIndexes'); 
originalImage = evalin('base', 'originalImage');
captionFontSize = evalin('base', 'captionFontSize');
allBlobAreas = evalin('base', 'allBlobAreas');
labeledImage = evalin('base', 'labeledImage');

% Now let's get the nickels (the larger coin type).
keeperIndexes = find(allBlobAreas > 2000);  % Take the larger objects.
% Note how we use ismember to select the blobs that meet our criteria.
nickelBinaryImage = ismember(labeledImage, keeperIndexes);
% Let's get the nickels from the original grayscale image, with the other non-nickel pixels blackened.
% In other words, we will create a "masked" image.
maskedImageNickel = originalImage; % Simply a copy at first.
maskedImageNickel(~nickelBinaryImage) = 0;  % Set all non-nickel pixels to zero.

axes(handles.axes3);
imshow(maskedImageNickel, []);
title('Only the nickels from the original image', 'FontSize', captionFontSize);

pic = imread('Images/23.1.png');
axes(handles.axes1);
imshow(pic);

pic = imread('Images/23.2.png');
axes(handles.axes2);
imshow(pic);

%putting variable in workspace
assignin('base', 'keeperIndexes', keeperIndexes);
assignin('base', 'nickelBinaryImage', nickelBinaryImage);
assignin('base', 'maskedImageNickel', maskedImageNickel);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
