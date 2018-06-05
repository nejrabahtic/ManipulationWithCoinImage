function varargout = dvadesetcetvrti(varargin)
% DVADESETCETVRTI MATLAB code for dvadesetcetvrti.fig
%      DVADESETCETVRTI, by itself, creates a new DVADESETCETVRTI or raises the existing
%      singleton*.
%
%      H = DVADESETCETVRTI returns the handle to a new DVADESETCETVRTI or the handle to
%      the existing singleton*.
%
%      DVADESETCETVRTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DVADESETCETVRTI.M with the given input arguments.
%
%      DVADESETCETVRTI('Property','Value',...) creates a new DVADESETCETVRTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dvadesetcetvrti_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dvadesetcetvrti_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dvadesetcetvrti

% Last Modified by GUIDE v2.5 01-Jun-2018 22:45:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dvadesetcetvrti_OpeningFcn, ...
                   'gui_OutputFcn',  @dvadesetcetvrti_OutputFcn, ...
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


% --- Executes just before dvadesetcetvrti is made visible.
function dvadesetcetvrti_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dvadesetcetvrti (see VARARGIN)

% Choose default command line output for dvadesetcetvrti
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dvadesetcetvrti wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dvadesetcetvrti_OutputFcn(hObject, eventdata, handles) 
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
coloredLabels = evalin('base', 'coloredLabels'); 
originalImage = evalin('base', 'originalImage');
numberOfBlobs = evalin('base', 'numberOfBlobs');
blobMeasurements = evalin('base', 'blobMeasurements');
blobECD = evalin('base', 'blobECD');
textFontSize = evalin('base', 'textFontSize');


elapsedTime = toc;

% Alert user that the demo is done and give them the option to save an image.
message = sprintf('Done making measurements of the features.\n\nElapsed time = %.2f seconds.', elapsedTime);
message = sprintf('%s\n\nCheck out the figure window for the images.\nCheck out the command window for the numerical results.', message);
message = sprintf('%s\n\nDo you want to save the pseudo-colored image?', message);
reply = questdlg(message, 'Save image?', 'Yes', 'No', 'No');
% Note: reply will = '' for Upper right X, 'Yes' for Yes, and 'No' for No.
if strcmpi(reply, 'Yes')
	% Ask user for a filename.
	FilterSpec = {'*.PNG', 'PNG Images (*.png)'; '*.tif', 'TIFF images (*.tif)'; '*.*', 'All Files (*.*)'};
	DialogTitle = 'Save image file name';
	% Get the default filename.  Make sure it's in the folder where this m-file lives.
	% (If they run this file but the cd is another folder then pwd will show that folder, not this one.
	thisFile = mfilename('fullpath');
	[thisFolder, baseFileName, ext] = fileparts(thisFile);
	DefaultName = sprintf('%s/%s.tif', thisFolder, baseFileName);
	[fileName, specifiedFolder] = uiputfile(FilterSpec, DialogTitle, DefaultName);
	if fileName ~= 0
		% Parse what they actually specified.
		[folder, baseFileName, ext] = fileparts(fileName);
		% Create the full filename, making sure it has a tif filename.
		fullImageFileName = fullfile(specifiedFolder, [baseFileName '.tif']);
		% Save the labeled image as a tif image.
		imwrite(uint8(coloredLabels), fullImageFileName);
		% Just for fun, read image back into the imtool utility to demonstrate that tool.
		tifimage = imread(fullImageFileName);
		imtool(tifimage, []);
	end
end

message = sprintf('Would you like to crop out each coin to individual images?');
reply = questdlg(message, 'Extract Individual Images?', 'Yes', 'No', 'Yes');
% Note: reply will = '' for Upper right X, 'Yes' for Yes, and 'No' for No.
if strcmpi(reply, 'Yes')
	figure('name', 'Cropped coins');	% Create a new figure window.
	% Maximize the figure window.
	set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
	for k = 1 : numberOfBlobs           % Loop through all blobs.
		% Find the bounding box of each blob.
		thisBlobsBoundingBox = blobMeasurements(k).BoundingBox;  % Get list of pixels in current blob.
		% Extract out this coin into it's own image.
		subImage = imcrop(originalImage, thisBlobsBoundingBox);
		% Determine if it's a dime (small) or a nickel (large coin).
		if blobMeasurements(k).Area > 2200
			coinType = 'nickel';
		else
			coinType = 'dime';
		end
		% Display the image with informative caption.
		subplot(3, 4, k);
		imshow(subImage);
		caption = sprintf('Coin #%d is a %s.\nDiameter = %.1f pixels\nArea = %d pixels', ...
			k, coinType, blobECD(k), blobMeasurements(k).Area);
		title(compose(caption), 'FontSize', textFontSize);
    end
end

pic = imread('Images/24.1.png');
axes(handles.axes2);
imshow(pic);

pic = imread('Images/24.2.png');
axes(handles.axes3);
imshow(pic);

%putting variable in workspace
assignin('base', 'elapsedTime', elapsedTime);
assignin('base', 'reply', reply);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

closereq;
maingui();
