function varargout = Filter(varargin)
% FILTER MATLAB code for Filter.fig
%      FILTER, by itself, creates a new FILTER or raises the existing
%      singleton*.
%
%      H = FILTER returns the handle to a new FILTER or the handle to
%      the existing singleton*.
%
%      FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTER.M with the given input arguments.
%
%      FILTER('Property','Value',...) creates a new FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Filter

% Last Modified by GUIDE v2.5 07-Jun-2019 14:48:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Filter_OpeningFcn, ...
                   'gui_OutputFcn',  @Filter_OutputFcn, ...
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


% --- Executes just before Filter is made visible.
function Filter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Filter (see VARARGIN)

% Choose default command line output for Filter
handles.output = hObject;
handles.xp_array=[];
handles.zeros_array=[];%imaginary
handles.poles_array=[];
handles.zeros_array_column=[];
handles.poles_array_column=[];
handles.zero_clicks = [];
handles.pole_clicks = [];
handles.yp_array=[];
handles.yp2=[];%software mood bs myrsmsh
handles.xp2=[];
handles.xz2=[];
handles.yz2=[];
handles.xz_array=[];
handles.yz_array=[];
handles.axes_extention = 1.2;
handles.mode=1;
handles.FS=150;
handles.signal=0;
handles.pole_clicks=[];
handles.zero_clicks=[];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% Get default command line output from handles structure
axes(handles.axes1);
%%draw the circle
ce = exp(j*2*pi*(0:.01:1));
h = line(real(ce),imag(ce));
set(h,'linestyle',':','color','b','HitTest','off')
% draw the cartesian coordinates
h = line([0 0],[-handles.axes_extention handles.axes_extention]);
set(h,'linestyle',':','color','b','HitTest','off')
h = line([-handles.axes_extention handles.axes_extention],[0 0]);
set(h,'linestyle',':','color','b','HitTest','off')
axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
hold on
grid on
xlabel('Real(z)');
ylabel('Imag(z)');
guidata(hObject, handles);

% --- Executes on button press in Browse_button.
function Browse_button_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,filename]= uigetfile('*.csv;*.xls;*.xlsx');
handles.signal= xlsread([filename,file]);
axes(handles.axes4);
plot(handles.signal(1:1000,1))
hold on;
guidata(hObject,handles);


% --- Executes on button press in AddZero.
function AddZero_Callback(hObject, eventdata, handles)
% hObject    handle to AddZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     if  handles.mode==1 
         [x,y]=ginput(1);
         handles.xz  = x;
         handles.yz  = y;
         handles.xz2(end+1)=handles.xz;
         handles.yz2(end+1)=handles.yz;
         handles.xz2(end+1)=handles.xz;
         handles.yz2(end+1)=-handles.yz;
         handles.xz_array(end+1)=handles.xz;
         
         handles.zero_clicks(end+1)= handles.xz;
         handles.zero_clicks(end+2) = handles.yz;
         handles.zero_clicks(end-1) =[];
         'xpoints'
         handles.xz_array
         handles.yz_array(end+1)=handles.yz;
         'ypoints'
         handles.yz_array
         handles.zeros_array=handles.xz2+i.*handles.yz2;
         'array'
         handles.zeros_array
         handles.zeros_array_column=transpose(handles.zeros_array);
         'arraytrans'
         handles.zeros_array_column
         axes(handles.axes1);
         plot(handles.xz_array,handles.yz_array,'O','markersize',20);
         else if handles.mode==2
             'in2'
         [x,y]=ginput(1);
         handles.xz  = x;
         handles.yz  = y;
         handles.xz_array(end+1)=handles.xz;
         handles.xz_array
         handles.yz_array(end+1)=handles.yz;
         handles.yz_array
         handles.xz_array(end+1)=handles.xz;
         handles.yz_array(end+1)=-handles.yz;
         handles.zeros_array=handles.xz_array+i.*handles.yz_array;
         handles.zeros_array_column=transpose(handles.zeros_array);
         handles.zeros_array
         handles.zeros_array_column
         axes(handles.axes1);
         plot(handles.xz_array,handles.yz_array,'O','markersize',20); 
      end
     end 
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
x=z_coordinate.*sin(theta);
y=z_coordinate.*cos(theta);
z_coordinate=x+y*i;
    fs=handles.FS;
    Frequency= linspace(0,fs./2,315);
    [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
    Polynomial_tf= tf(num_coeff,den_coeff);
    for k =1:length(z_coordinate)
   substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
   substitution_in_tf=substitution_in_tf(:);
   gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
axes(handles.axes3);
plot (Frequency,gain_matlab)
    %Gain_manual();
    distance=ones(315,1);
    %handles.zeros_array_column
for t=1:length(z_coordinate)
    for j=1:length(handles.zeros_array_column)        
      distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(j));  
    end
end

for t=1:length(z_coordinate)
    for j=1:length(handles.poles_array_column)       
      distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(j)));
    end
end
manual_gain=20*log10(distance);
axes(handles.axes2);
plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
cla(handles.axes4,'reset'); 
axes(handles.axes4)
plot(handles.signal(1:1000,1))
hold on;
plot(handles.filtered_signal(1:1000,1))
guidata(hObject, handles);

% --- Executes on button press in AddPoles.
function AddPoles_Callback(hObject, eventdata, handles)
% hObject    handle to AddPoles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  handles.mode==1 
        'in'
         [x,y]=ginput(1);
         handles.xp  = x;
         handles.yp  = y;
         handles.xp_array(end+1)=handles.xp;%ZEROES_X
         handles.yp_array(end+1)=handles.yp;%ZEROS_Y
         handles.xp2(end+1)=handles.xp;
         handles.yp2(end+1)=handles.yp;
         handles.pole_clicks(end+1)= handles.xp;
         handles.pole_clicks(end+2) = handles.yp;
         handles.pole_clicks(end-1) =[];
         %'x_pole coor'
         handles.xp_array
         %'y_pole coor'
         handles.yp_array
         handles.poles_array=handles.xp2+i.*handles.yp2;
         handles.poles_array_column=transpose(handles.poles_array);
         axes(handles.axes1);
         plot(handles.xp_array,handles.yp_array,'X','markersize',20);
    else if handles.mode==2
             'in2'
          [x,y]=ginput(1);
          handles.xp  = x;
          handles.yp  = y;
          handles.xp_array(end+1)=handles.xp;
          handles.xp_array
          handles.yp_array(end+1)=handles.yp;
          handles.yp_array
          handles.xp_array(end+1)=handles.xp;
          handles.yp_array(end+1)=-handles.yp;
          handles.poles_array=handles.xp_array+i.*handles.yp_array;
          handles.poles_array_column=transpose(handles.poles_array);
         %handles.zeros_array(end+1)=handles.xp_array -i.*handles.yp_array;
          handles.poles_array
          handles.poles_array_column
          axes(handles.axes1);
          plot(handles.xp_array,handles.yp_array,'X','markersize',20); 
    end
end
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
a=z_coordinate.*sin(theta);
b=z_coordinate.*cos(theta);
z_coordinate=a+b*i;
    fs=handles.FS;
    Frequency= linspace(0,fs./2,315);
    [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
    Polynomial_tf= tf(num_coeff,den_coeff);

for k =1:length(z_coordinate)
   substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
   substitution_in_tf=substitution_in_tf(:);
   gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
axes(handles.axes3);
plot (Frequency,gain_matlab)
    %Gain_manual();
    distance=ones(315,1);
    %handles.zeros_array_column
for t=1:length(z_coordinate)
    for j=1:length(handles.zeros_array_column)        
      distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(j));  
    end
end

for t=1:length(z_coordinate)
    for j=1:length(handles.poles_array_column)       
      distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(j)));
    end
end
manual_gain=20*log10(distance);
axes(handles.axes2);
plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
cla(handles.axes4,'reset'); 
axes(handles.axes4)
plot(handles.signal(1:1000,1))
hold on;
plot(handles.filtered_signal(1:1000,1))
guidata(hObject,handles);



% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [x,y]=ginput(1);
  indexOfXPoles = find(handles.pole_clicks>(x-0.05) & handles.pole_clicks<(x+0.05));
  indexOfXZeros = find(handles.zero_clicks>(x-0.05) & handles.zero_clicks<(x+0.05));
  counterXPoles = size(indexOfXPoles,2);
  counterXZeros = size(indexOfXZeros,2);

  for iterator = 1:counterXPoles-1
      if mod(indexOfXPoles(iterator),2) == 0
          indexOfXPoles(iterator) =[];
          counterXPoles = counterXPoles - 1;
      end
  end
  for iterator = 1:counterXZeros-1
      if mod(indexOfXZeros(iterator),2) == 0
          indexOfXZeros(iterator) =[];
          counterXZeros = counterXZeros - 1;
      end
  end
  indexOfYPoles = find(handles.pole_clicks>(y-0.05) & handles.pole_clicks<(y+0.05));
  counterYPoles = size(indexOfYPoles,2);
  indexOfYZeros = find(handles.zero_clicks>(y-0.05) & handles.zero_clicks<(y+0.05));
  counterYZeros = size(indexOfYZeros,2);
  for iterator = 1:counterYPoles-2
      if mod(indexOfYPoles(iterator),2) ~= 0
          indexOfYPoles(iterator) =[];
          counterYPoles = counterYPoles - 1;
      end
  end
  for iterator = 1:counterYZeros-2
      if mod(indexOfYZeros(iterator),2) ~= 0
          indexOfYZeros(iterator) =[];
          counterYZeros = counterYZeros - 1;
      end
  end

  if size(indexOfXPoles,2) > 1 && size(indexOfYPoles,2) == 1
      indexOfXPoles = indexOfYPoles-1;
      handles.pole_clicks(indexOfYPoles)=[];
      handles.pole_clicks(indexOfXPoles)=[];
      handles.yp_array(ceil(indexOfYPoles/2))= [];
      handles.xp_array(ceil(indexOfXPoles/2))= [];
  elseif size(indexOfYPoles,2) > 1 && size(indexOfXPoles,2) == 1
      indexOfYPoles = indexOfXPoles+1;
      handles.pole_clicks(indexOfYPoles)=[];
      handles.pole_clicks(indexOfXPoles)=[];
      handles.yp_array(ceil(indexOfYPoles/2))= [];
      handles.xp_array(ceil(indexOfXPoles/2))= [];
  elseif indexOfYPoles == indexOfXPoles+1
      handles.pole_clicks(indexOfYPoles)=[];
      handles.pole_clicks(indexOfXPoles)=[];
      handles.yp_array(ceil(indexOfYPoles/2))= [];
      handles.xp_array(ceil(indexOfXPoles/2))= [];
  end
  

  if size(indexOfXZeros,2) > 1 && size(indexOfYZeros,2) == 1
      indexOfXZeros = indexOfYZeros-1;
      handles.zero_clicks(indexOfYZeros)=[];
      handles.zero_clicks(indexOfXZeros)=[];
      handles.yz_array(ceil(indexOfYZeros/2))= [];
      handles.xz_array(ceil(indexOfXZeros/2))= [];
  elseif size(indexOfYZeros,2) > 1 && size(indexOfXZeros,2) == 1
      indexOfYZeros = indexOfXZeros+1;
      handles.zero_clicks(indexOfYZeros)=[];
      handles.zero_clicks(indexOfXZeros)=[];
      handles.yz_array(ceil(indexOfYZeros/2))= [];
      handles.xz_array(ceil(indexOfXZeros/2))= [];
  elseif indexOfYZeros == indexOfXZeros+1
      handles.zero_clicks(indexOfYZeros)=[];
      handles.zero_clicks(indexOfXZeros)=[];
      handles.yz_array(ceil(indexOfYZeros/2))= [];
      handles.xz_array(ceil(indexOfXZeros/2))= [];
  end
  
  
  cla(handles.axes1,'reset'); 
  axes(handles.axes1)
ce = exp(j*2*pi*(0:.01:1));
h = line(real(ce),imag(ce));
set(h,'linestyle',':','color','b','HitTest','off')
% draw the cartesian coordinates
h = line([0 0],[-handles.axes_extention handles.axes_extention]);
set(h,'linestyle',':','color','b','HitTest','off')
h = line([-handles.axes_extention handles.axes_extention],[0 0]);
set(h,'linestyle',':','color','b','HitTest','off')
axis([-handles.axes_extention handles.axes_extention -handles.axes_extention handles.axes_extention]);
hold on
grid on
xlabel('Real(z)');
ylabel('Imag(z)');

plot(handles.xp_array,handles.yp_array,'x','markersize',20);
plot(handles.xz_array,handles.yz_array,'o','markersize',20);
handles.zeros_array=handles.xz_array+i.*handles.yz_array;
handles.zeros_array_column=transpose(handles.zeros_array);
handles.poles_array=handles.xp_array+i.*handles.yp_array;
handles.poles_array_column=transpose(handles.poles_array);
%"Poles"
handles.xp_array
handles.yp_array
%"Zeros"
handles.xz_array
handles.yz_array
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
length(z_coordinate)
a=z_coordinate.*sin(theta);
b=z_coordinate.*cos(theta);
z_coordinate=a+b*i;
    fs=handles.FS;
    Frequency= linspace(0,fs./2,315);
    [num_coeff,den_coeff]=zp2tf(handles.zeros_array_column,handles.poles_array_column,1);
    Polynomial_tf= tf(num_coeff,den_coeff);

for k =1:length(z_coordinate)
   substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
   substitution_in_tf=substitution_in_tf(:);
   gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
end
axes(handles.axes3);
plot (Frequency,gain_matlab)
    %Gain_manual();
    distance=ones(315,1);
    %handles.zeros_array_column
for t=1:length(z_coordinate)
    for w=1:length(handles.zeros_array_column)        
      distance(t)= distance(t)*norm(z_coordinate(t)- handles.zeros_array_column(w));  
    end
end

for t=1:length(z_coordinate)
    for w=1:length(handles.poles_array_column)       
      distance(t)= distance(t)*(1./norm(z_coordinate(t)-handles.poles_array_column(w)));
    end
end
manual_gain=20*log10(distance);
axes(handles.axes2);
plot(Frequency, manual_gain);
handles.filtered_signal = filter(num_coeff,den_coeff,handles.signal) ;
cla(handles.axes4,'reset'); 
axes(handles.axes4)
%plot(handles.signal(1:1000,1))
hold on;
%plot(handles.filtered_signal(1:1000,1))
guidata(hObject, handles);

% --- Executes on selection change in MODE.
function MODE_Callback(hObject, eventdata, handles)
% hObject    handle to MODE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns MODE contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MODE
handles.contents=get(hObject,'Value');
handles.contents
if handles.contents==1
    handles.mode=1;
else if handles.contents==2
        handles.mode=2;
    end 
end 
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function MODE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MODE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end