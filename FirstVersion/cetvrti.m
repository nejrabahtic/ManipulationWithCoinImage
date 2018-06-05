function varargout = cetvrti(varargin)
% CETVRTI MATLAB code for cetvrti.fig
%      CETVRTI, by itself, creates a new CETVRTI or raises the existing
%      singleton*.
%
%      H = CETVRTI returns the handle to a new CETVRTI or the handle to
%      the existing singleton*.
%
%      CETVRTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CETVRTI.M with the given input arguments.
%
%      CETVRTI('Property','Value',...) creates a new CETVRTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cetvrti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cetvrti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cetvrti

% Last Modified by GUIDE v2.5 29-May-2018 15:45:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cetvrti_OpeningFcn, ...
                   'gui_OutputFcn',  @cetvrti_OutputFcn, ...
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


% --- Executes just before cetvrti is made visible.
function cetvrti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cetvrti (see VARARGIN)

% Choose default command line output for cetvrti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cetvrti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cetvrti_OutputFcn(hObject, eventdata, handles) 
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
fullFileName = evalin('base', 'fullFileName'); 

% If we get here, we should have found the image file.
originalImage = imread(fullFileName);

pic = imread('Images/4.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'originalImage', originalImage);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
