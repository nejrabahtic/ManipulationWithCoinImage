function varargout = dvadesetdrugi(varargin)
% DVADESETDRUGI MATLAB code for dvadesetdrugi.fig
%      DVADESETDRUGI, by itself, creates a new DVADESETDRUGI or raises the existing
%      singleton*.
%
%      H = DVADESETDRUGI returns the handle to a new DVADESETDRUGI or the handle to
%      the existing singleton*.
%
%      DVADESETDRUGI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DVADESETDRUGI.M with the given input arguments.
%
%      DVADESETDRUGI('Property','Value',...) creates a new DVADESETDRUGI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dvadesetdrugi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dvadesetdrugi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dvadesetdrugi

% Last Modified by GUIDE v2.5 01-Jun-2018 21:36:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dvadesetdrugi_OpeningFcn, ...
                   'gui_OutputFcn',  @dvadesetdrugi_OutputFcn, ...
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


% --- Executes just before dvadesetdrugi is made visible.
function dvadesetdrugi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dvadesetdrugi (see VARARGIN)

% Choose default command line output for dvadesetdrugi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dvadesetdrugi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dvadesetdrugi_OutputFcn(hObject, eventdata, handles) 
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
keeperBlobsImage = evalin('base', 'keeperBlobsImage');
captionFontSize = evalin('base', 'captionFontSize');

% Now use the keeper blobs as a mask on the original image.
% This will let us display the original image in the regions of the keeper blobs.
maskedImageDime = originalImage; % Simply a copy at first.
maskedImageDime(~keeperBlobsImage) = 0;  % Set all non-keeper pixels to zero.

axes(handles.axes3);
imshow(maskedImageDime);

title('Only the 3 brightest dimes from the original image', 'FontSize', captionFontSize);

pic = imread('Images/22.1.png');
axes(handles.axes1);
imshow(pic);

pic = imread('Images/22.2.png');
axes(handles.axes2);
imshow(pic);

%putting variable in workspace
assignin('base', 'maskedImageDime', maskedImageDime);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
