function varargout = osamnaesti(varargin)
% OSAMNAESTI MATLAB code for osamnaesti.fig
%      OSAMNAESTI, by itself, creates a new OSAMNAESTI or raises the existing
%      singleton*.
%
%      H = OSAMNAESTI returns the handle to a new OSAMNAESTI or the handle to
%      the existing singleton*.
%
%      OSAMNAESTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OSAMNAESTI.M with the given input arguments.
%
%      OSAMNAESTI('Property','Value',...) creates a new OSAMNAESTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before osamnaesti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to osamnaesti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help osamnaesti

% Last Modified by GUIDE v2.5 31-May-2018 17:20:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @osamnaesti_OpeningFcn, ...
                   'gui_OutputFcn',  @osamnaesti_OutputFcn, ...
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


% --- Executes just before osamnaesti is made visible.
function osamnaesti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to osamnaesti (see VARARGIN)

% Choose default command line output for osamnaesti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes osamnaesti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = osamnaesti_OutputFcn(hObject, eventdata, handles) 
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
captionFontSize = evalin('base', 'captionFontSize'); 
originalImage = evalin('base', 'originalImage'); 
k = evalin('base', 'k'); 
numberOfBlobs = evalin('base', 'numberOfBlobs'); 
labelShiftX = evalin('base', 'labelShiftX'); 
textFontSize = evalin('base', 'textFontSize');
thisBoundary = evalin('base', 'thisBoundary');
boundaries = evalin('base', 'boundaries');
binaryImage = evalin('base', 'binaryImage');

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
% Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries.
axes(handles.axes5);
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


% Print header line in the command window.
fprintf(1,'Blob #      Mean Intensity  Area   Perimeter    Centroid       Diameter\n');
% Loop over all blobs printing their measurements to the command window.
for k = 1 : numberOfBlobs           % Loop through all blobs.
	% Find the mean of each blob.  (R2008a has a better way where you can pass the original image
	% directly into regionprops.  The way below works for all versions including earlier versions.)
	thisBlobsPixels = blobMeasurements(k).PixelIdxList;  % Get list of pixels in current blob.
	meanGL = mean(originalImage(thisBlobsPixels)); % Find mean intensity (in original image!)
	meanGL2008a = blobMeasurements(k).MeanIntensity; % Mean again, but only for version >= R2008a 
    
	blobArea = blobMeasurements(k).Area;		% Get area.
	blobPerimeter = blobMeasurements(k).Perimeter;		% Get perimeter.
	blobCentroid = blobMeasurements(k).Centroid;		% Get centroid one at a time
	blobECD(k) = sqrt(4 * blobArea / pi);					% Compute ECD - Equivalent Circular Diameter.
	fprintf(1,'#%2d %17.1f %11.1f %8.1f %8.1f %8.1f % 8.1f\n', k, meanGL, blobArea, blobPerimeter, blobCentroid, blobECD(k));
	% Put the "blob number" labels on the "boundaries" grayscale image.
	text(blobCentroid(1) + labelShiftX, blobCentroid(2), num2str(k), 'FontSize', textFontSize, 'FontWeight', 'Bold');
end

pic = imread('Images/18.png');
axes(handles.axes1);
imshow(pic);

pic = imread('Images/18.1.png');
axes(handles.axes3);
imshow(pic);

%putting variable in workspace
assignin('base', 'boundaries', boundaries);
assignin('base', 'thisBoundary', thisBoundary);
assignin('base', 'blobArea', blobArea);
assignin('base', 'blobPerimeter', blobPerimeter);
assignin('base', 'blobECD', blobECD);
assignin('base', 'thisBlobsPixels', thisBlobsPixels);
assignin('base', 'meanGL', meanGL);
assignin('base', 'meanGL2008a', meanGL2008a);
assignin('base', 'blobCentroid', blobCentroid);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
