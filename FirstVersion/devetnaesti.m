function varargout = devetnaesti(varargin)
% DEVETNAESTI MATLAB code for devetnaesti.fig
%      DEVETNAESTI, by itself, creates a new DEVETNAESTI or raises the existing
%      singleton*.
%
%      H = DEVETNAESTI returns the handle to a new DEVETNAESTI or the handle to
%      the existing singleton*.
%
%      DEVETNAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEVETNAESTI.M with the given input arguments.
%
%      DEVETNAESTI('Property','Value',...) creates a new DEVETNAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before devetnaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to devetnaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help devetnaesti

% Last Modified by GUIDE v2.5 31-May-2018 20:07:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @devetnaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @devetnaesti_OutputFcn, ...
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


% --- Executes just before devetnaesti is made visible.
function devetnaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to devetnaesti (see VARARGIN)

% Choose default command line output for devetnaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes devetnaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = devetnaesti_OutputFcn(hObject, eventdata, handles) 
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
blobMeasurements = evalin('base', 'blobMeasurements'); 
numberOfBlobs = evalin('base', 'numberOfBlobs'); 
labelShiftX = evalin('base', 'labelShiftX'); 
textFontSize = evalin('base', 'textFontSize');
blobECD = evalin('base', 'blobECD');

% Now, I'll show you another way to get centroids.
% We can get the centroids of ALL the blobs into 2 arrays,
% one for the centroid x values and one for the centroid y values.
allBlobCentroids = [blobMeasurements.Centroid];
centroidsX = allBlobCentroids(1:2:end-1);
centroidsY = allBlobCentroids(2:2:end);
% Put the labels on the rgb labeled image also.

for k = 1 : numberOfBlobs           % Loop through all blobs.
	text(centroidsX(k) + labelShiftX, centroidsY(k), num2str(k), 'FontSize', textFontSize, 'FontWeight', 'Bold');
end

pic = imread('Images/19.png');
axes(handles.axes1);
imshow(pic);

%putting variable in workspace
assignin('base', 'allBlobCentroids', allBlobCentroids);
assignin('base', 'centroidsX', centroidsX);
assignin('base', 'centroidsY', centroidsY);
assignin('base', 'blobECD', blobECD);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
