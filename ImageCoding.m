function varargout = ImageCoding(varargin)
% IMAGECODING MATLAB code for ImageCoding.fig
%      IMAGECODING, by itself, creates a new IMAGECODING or raises the existing
%      singleton*.
%
%      H = IMAGECODING returns the handle to a new IMAGECODING or the handle to
%      the existing singleton*.
%
%      IMAGECODING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGECODING.M with the given input arguments.
%
%      IMAGECODING('Property','Value',...) creates a new IMAGECODING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageCoding_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageCoding_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageCoding
% J. de la Rica, CCAV-UPC Dec-2016
% Last Modified by GUIDE v2.5 20-Dec-2016 23:46:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageCoding_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageCoding_OutputFcn, ...
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


% --- Executes just before ImageCoding is made visible.
function ImageCoding_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageCoding (see VARARGIN)

% Choose default command line output for ImageCoding
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageCoding wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% 
% axes(handles.axes8) 
% handles.imagen=imread('1.jpg'); 
% imagesc(handles.imagen) 
% axis off 
% axes(handles.axes9)
% handles.imagen=imread('2.jpg');
% imagesc(handles.imagen)
% axis off
% % 



% --- Outputs from this function are returned to the command line.
function varargout = ImageCoding_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in diff.
function diff_Callback(hObject, eventdata, handles)
% hObject    handle to diff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of diff


% --- Executes during object creation, after setting all properties.
function buttongroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buttongroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in buttongroup.
function buttongroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in buttongroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.camman)
    handles.infilename = 'camman.lum';
else if(hObject == handles.fruit)
        handles.infilename = 'fruit.lum';
    else if(hObject == handles.diff)
            handles.infilename = 'diff.lum';
        else if(hObject == handles.pam)
                handles.infilename = 'pam256.lum';
            else if(hObject == handles.people)
                    handles.infilename = 'people.lum';
                end
            end
        end
    end
end
guidata(hObject, handles);

% --- Executes on button press in compute.
function compute_Callback(hObject, eventdata, handles)
% hObject    handle to compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
infilename = handles.infilename;
[img] = Read_Image(infilename);
axes(handles.input);
imshow(img); title('Input Image');
% GETTING IMAGE INFORMATION
[nRow, nColumn] = size(img);
OrigSize = size(img, 1);
rate = 3;
max_bits = floor(rate * OrigSize^2);
img_fin = zeros(size(img));
im_double = im2double(img);

% DISCRETE WAVELET TRANSFORM

level = 3;
n = size(img,1);
n_log = log2(n); 
[LP_DecFilter,HP_DecFilter,LP_RecFilter,HP_RecFilter] = wfilters('bior4.4');
[I_Wavedata , S] = DWT_Analysis(img, level, LP_DecFilter, HP_DecFilter);
axes(handles.dwt);
Display_Image(I_Wavedata); title('DWT');

% SUB-BLOCK SPLIT + VARIANZA
[LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1] = SubBlocks_Split(I_Wavedata);

V_LL3 = Compute_Variance(LL3);
V_HL3 = Compute_Variance(HL3);
V_LH3 = Compute_Variance(LH3);
V_HH3 = Compute_Variance(HH3);

V_HL2 = Compute_Variance(HL2);
V_LH2 = Compute_Variance(LH2);
V_HH2 = Compute_Variance(HH3);

V_HL1 = Compute_Variance(HL1);
V_LH1 = Compute_Variance(LH1);
V_HH1 = Compute_Variance(HH1);

% BINARIZATION
[LL3_b] = SubBlock_Binarization(V_LL3,LL3);
[HL3_b] = SubBlock_Binarization(V_HL3,HL3);
[LH3_b] = SubBlock_Binarization(V_LH3,LH3);
[HH3_b] = SubBlock_Binarization(V_HH3,HH3);

[HL2_b] = SubBlock_Binarization(V_HL2,HL2);
[LH2_b] = SubBlock_Binarization(V_LH2,LH2);
[HH2_b] = SubBlock_Binarization(V_HH2,HH2);

[HL1_b] = SubBlock_Binarization(V_HL1,HL1);
[LH1_b] = SubBlock_Binarization(V_LH1,LH1);
[HH1_b] = SubBlock_Binarization(V_HH1,HH1);

% CLASSIFICATION 
[LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1] = Classification(LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1);
[DWT_Wavedata] = rec(LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1);

% SPIHT ALGORITHM - CODER
block_size = nRow*nColumn;
[spiht_bitstream] = SPIHT_Coder(DWT_Wavedata, max_bits, block_size, level);

% SPIHT ALGORITHM - DECODER
[img_nspiht] = SPIHT_Decoder(spiht_bitstream);
axes(handles.axes7);
Display_Image(img_nspiht); title('SPIHT output');
% Discrete Wavelet Transform - Synthesis
[img_rec] = DWT_Synthesis(img_nspiht, S, LP_RecFilter, HP_RecFilter, level);
axes(handles.dwt2);
Display_Image(img_rec); title('Output Image');
