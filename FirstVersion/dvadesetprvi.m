function varargout = dvadesetprvi(varargin)
% DVADESETPRVI MATLAB code for dvadesetprvi.fig
%      DVADESETPRVI, by itself, creates a new DVADESETPRVI or raises the existing
%      singleton*.
%
%      H = DVADESETPRVI returns the handle to a new DVADESETPRVI or the handle to
%      the existing singleton*.
%
%      DVADESETPRVI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DVADESETPRVI.M with the given input arguments.
%
%      DVADESETPRVI('Property','Value',...) creates a new DVADESETPRVI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dvadesetprvi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dvadesetprvi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dvadesetprvi

% Last Modified by GUIDE v2.5 01-Jun-2018 20:48:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dvadesetprvi_OpeningFcn, ...
                   'gui_OutputFcn',  @dvadesetprvi_OutputFcn, ...
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


% --- Executes just before dvadesetprvi is made visible.
function dvadesetprvi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dvadesetprvi (see VARARGIN)

% Choose default command line output for dvadesetprvi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dvadesetprvi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dvadesetprvi_OutputFcn(hObject, eventdata, handles) 
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
originalImage = evalin('base', 'originalImage'); 
numberOfBlobs = evalin('base', 'numberOfBlobs');
allBlobAreas = evalin('base', 'allBlobAreas');
k = evalin('base', 'k');
centroidsX = evalin('base', 'centroidsX');
centroidsY = evalin('base', 'centroidsY');

% Display the grayscale image.
axes(handles.axes2);
imshow(originalImage);

% Plot the centroids in the original image in the upper left.
% Dimes will have a red cross, nickels will have a blue X.
message = sprintf('Now I will plot the centroids over the original image on the left side.\nPlease look at the left side image.');
reply = questdlg(message, 'Plot Centroids?', 'OK', 'Cancel', 'Cancel');
% Note: reply will = '' for Upper right X, 'OK' for OK, and 'Cancel' for Cancel.
if strcmpi(reply, 'Cancel')
	return;
end

axes(handles.axes2);

hold on; % Don't blow away image.
for k = 1 : numberOfBlobs           % Loop through all keeper blobs.
	% Identify if blob #k is a dime or nickel.
	itsADime = allBlobAreas(k) < 2200; % Dimes are small.
	if itsADime
		% Plot dimes with a red +.
		plot(centroidsX(k), centroidsY(k), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
	else
		% Plot dimes with a blue x.
		plot(centroidsX(k), centroidsY(k), 'bx', 'MarkerSize', 10, 'LineWidth', 2);
	end
end

pic = imread('Images/21.1.png');
axes(handles.axes1);
imshow(pic);

pic = imread('Images/21.2.png');
axes(handles.axes3);
imshow(pic);

%putting variable in workspace
assignin('base', 'message', message);
assignin('base', 'reply', reply);
assignin('base', 'itsADime', itsADime);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
