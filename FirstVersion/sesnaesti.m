function varargout = sesnaesti(varargin)
% SESNAESTI MATLAB code for sesnaesti.fig
%      SESNAESTI, by itself, creates a new SESNAESTI or raises the existing
%      singleton*.
%
%      H = SESNAESTI returns the handle to a new SESNAESTI or the handle to
%      the existing singleton*.
%
%      SESNAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SESNAESTI.M with the given input arguments.
%
%      SESNAESTI('Property','Value',...) creates a new SESNAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sesnaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sesnaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sesnaesti

% Last Modified by GUIDE v2.5 31-May-2018 16:23:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sesnaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @sesnaesti_OutputFcn, ...
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


% --- Executes just before sesnaesti is made visible.
function sesnaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sesnaesti (see VARARGIN)

% Choose default command line output for sesnaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sesnaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sesnaesti_OutputFcn(hObject, eventdata, handles) 
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
originalImage = evalin('base', 'originalImage'); 

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobMeasurements = regionprops(labeledImage, originalImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

pic = imread('Images/16.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'blobMeasurements', blobMeasurements);
assignin('base', 'numberOfBlobs', numberOfBlobs);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
