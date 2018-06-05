function varargout = dvadeseti(varargin)
% DVADESETI MATLAB code for dvadeseti.fig
%      DVADESETI, by itself, creates a new DVADESETI or raises the existing
%      singleton*.
%
%      H = DVADESETI returns the handle to a new DVADESETI or the handle to
%      the existing singleton*.
%
%      DVADESETI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DVADESETI.M with the given input arguments.
%
%      DVADESETI('Property','Value',...) creates a new DVADESETI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dvadeseti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dvadeseti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dvadeseti

% Last Modified by GUIDE v2.5 31-May-2018 20:25:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dvadeseti_OpeningFcn, ...
                   'gui_OutputFcn',  @dvadeseti_OutputFcn, ...
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


% --- Executes just before dvadeseti is made visible.
function dvadeseti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dvadeseti (see VARARGIN)

% Choose default command line output for dvadeseti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dvadeseti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dvadeseti_OutputFcn(hObject, eventdata, handles) 
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
labeledImage = evalin('base', 'labeledImage');
captionFontSize = evalin('base', 'captionFontSize');

% Now I'll demonstrate how to select certain blobs based using the ismember() function.
% Let's say that we wanted to find only those blobs
% with an intensity between 150 and 220 and an area less than 2000 pixels.
% This would give us the three brightest dimes (the smaller coin type).
allBlobIntensities = [blobMeasurements.MeanIntensity];
allBlobAreas = [blobMeasurements.Area];
% Get a list of the blobs that meet our criteria and we need to keep.
% These will be logical indices - lists of true or false depending on whether the feature meets the criteria or not.
% for example [1, 0, 0, 1, 1, 0, 1, .....].  Elements 1, 4, 5, 7, ... are true, others are false.
allowableIntensityIndexes = (allBlobIntensities > 150) & (allBlobIntensities < 220);
allowableAreaIndexes = allBlobAreas < 2000; % Take the small objects.
% Now let's get actual indexes, rather than logical indexes, of the  features that meet the criteria.
% for example [1, 4, 5, 7, .....] to continue using the example from above.
keeperIndexes = find(allowableIntensityIndexes & allowableAreaIndexes);
% Extract only those blobs that meet our criteria, and
% eliminate those blobs that don't meet our criteria.
% Note how we use ismember() to do this.  Result will be an image - the same as labeledImage but with only the blobs listed in keeperIndexes in it.
keeperBlobsImage = ismember(labeledImage, keeperIndexes);
% Re-label with only the keeper blobs kept.
labeledDimeImage = bwlabel(keeperBlobsImage, 8);     % Label each blob so we can make measurements of it
% Now we're done.  We have a labeled image of blobs that meet our specified criteria.

axes(handles.axes2);

imshow(labeledDimeImage, []);
title('"Keeper" blobs (3 brightest dimes in a re-labeled image)', 'FontSize', captionFontSize);

pic = imread('Images/20.1.png');
axes(handles.axes1);
imshow(pic);

pic = imread('Images/20.2.png');
axes(handles.axes4);
imshow(pic);

%putting variable in workspace
assignin('base', 'allBlobIntensities', allBlobIntensities);
assignin('base', 'allBlobAreas', allBlobAreas);
assignin('base', 'allowableIntensityIndexes', allowableIntensityIndexes);
assignin('base', 'keeperIndexes', keeperIndexes);
assignin('base', 'keeperBlobsImage', keeperBlobsImage);
assignin('base', 'allowableIntensityIndexes', allowableIntensityIndexes);
assignin('base', 'labeledDimeImage', labeledDimeImage);
assignin('base', 'allowableAreaIndexes', allowableAreaIndexes);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
