classdef GuiBase < handle
    %GuiBase Core GUI Class with helpers for creating the gui.
    % The GuiBase class provides the core features needed for a Gui.
    % is also provides a number of helper functions to make building a gui
    % easier, such as functions for adding buttons, text boxes, graphs,
    % etc. Any functions that apply to a generic GUI are put into this
    % class so that they are available to any GUI's I build in Matlab.
    
    properties
        ui
    end
    
    methods
        function obj = GuiBase()
            obj.ui = struct();
            obj.ui.text = containers.Map();
            obj.ui.tables = containers.Map();
        end
        
        function hPanel = AddTripleGraph(obj,uiName, pos, dName, title)
            % This function is pretty specific, but it is still genertic i
            % some respects. It adds a triple graph that I used to display
            % x,y,z or rho,theta,psi coordinates, etc.


            hPanel = uipanel('Title','Controls','FontSize',12,...
                'Parent',obj.ui.Figure,...
                'Units','normalized',...
                'Position',pos);
                
            % Define the Gyro Axes
            xyz = {'Gyro X', 'Gyro Y', 'Gyro Z'};
            obj.ui.(uiName) = [];
            for r = 1:3
                % Left is always just right of the Video Axes.
                % Bottom is 2/3, 1/3 and 0/3
                % Width and height are fixed.
                aop = [0 (r-1)/3 1 1/3];
                ap = aop;
                obj.ui.(uiName)(r) = axes(...
                        'DataAspectRatio', [1 1 1],...
                        'DrawMode','fast',...
                        'Visible','on',...
                        'Units','normalized',...
                        'Position',ap,...
                        'Parent', hPanel);
                %title(obj.ui.(uiName)(r),title);
            end
        end
        
        function h = AddToggleButton(obj,string,row,cb)
            h = uicontrol(obj.ui.hPanelCtrl,...
                'Style','togglebutton',...
                'String',string,...
                'Units','normalized',...
                'Position',[0.05 row*(0.1) 0.8 0.1],...
                'Visible','on',...
                'Callback',cb...
            );
        end
        
        function h = AddButton(obj,string,row,cb)
            h = uicontrol(obj.ui.hPanelCtrl,...
                'Style','pushbutton',...
                'String',string,...
                'Units','normalized',...
                'Position',[0.05 row*(0.1) 0.8 0.1],...
                'Visible','on',...
                'Callback',cb...
            );
        end
        
        function [h,u] = AddButtonGroup(obj,type,group,names,row)
            % A routine to make adding a set of butons easier.
            h = uibuttongroup('visible','on',...
                'Units','normalized',...
                'Position',[0.05 row*(0.1) 0.8 0.1],...
                'Parent',obj.ui.hPanelCtrl);

            nitems = length(names);
            for x = 1:nitems
                n = names{x};
                
                u(x) = uicontrol('Style',type,...
                    'String',n,...
                    'Units','normalized',...
                    'pos',[(x-1)*(1/nitems) 0 1/nitems 1],...
                    'Parent',h,...
                    'HandleVisibility','off');
            end
            set(h,'SelectedObject',[]);
            set(h,'Visible','on');
        end
        
        function AddEditText(obj,label,value,row)
            % Add a text box and label.
            s.text = uicontrol('Style','text',...
                'Parent',obj.ui.hPanelCtrl,...
                'String',label,...
                'Units','normalized',...
                'Position',[0.05 row*(0.1) 0.185 0.08]);
            
            s.edit = uicontrol('Style','edit',...
                'Parent',obj.ui.hPanelCtrl,...
                'String',value,...
                'Units','normalized',...
                'Position',[0.21  row*(0.1) 0.76 0.08]);
            
            obj.ui.text(label) = s;
        end
        
        function  AddComboBox(obj,label,values,row,height)
            % Add a text box and label.
            s.text = uicontrol('Style','text',...
                'Parent',obj.ui.hPanelCtrl,...
                'String',label,...
                'Units','normalized',...
                'Position',[0 row*(0.1) 0.3 0.08]);
            
            s.list = uicontrol('Style','listbox',...
                'Parent',obj.ui.hPanelCtrl,...
                'String',values,...
                'Value',1,...
                'Max',1,'Min',1,...
                'Fontsize',16,...
                'Units','normalized',...
                'Position',[0.3 row*(0.1) 0.7 height*0.1]);
            
            obj.ui.list(label) = s;
        end
        
        function h = AddTable(obj,label,data,row,height)
            h = uitable(obj.ui.hPanelCtrl,...
                'Data',data,...
                'Units','normalized',...
                'Position',[0 row*(0.1) 1 height*(0.1)]);
            obj.ui.tables(label) = h;
        end
        
        function SetTableData(obj,label,data)
            set(obj.ui.tables(label),'Data',data);
        end
        
        function s = GetValue(obj,label)
            s = get(obj.ui.text(label).edit,'String');
        end
    end
    
end
