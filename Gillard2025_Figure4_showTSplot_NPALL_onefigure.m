clear all;
close all;
clc;
addpath('/mnt/storage4/gillard/matlab/export_fig/')
addpath('/mnt/storage1/gillard/matlab/cbrewer/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run getModelvsObs.m first to get the matlfiles
% SANNA2016 Mooring Data VS Model ANHA4-EPM151 and ANHA4-EPM111
%
% 2023-11-17 Updated to use NearestPoint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Date for Each Mooring (2024-01-12)
% Find best date to match for model [When I ran model, I ran all locations from 2016-08 to 2018 - 09

% Mooring time                  % Match for Model time

%Time_CL1_1A
%14-Aug-2016 10:14:14            y2016m08d18 (start file 4)
%27-Aug-2018 09:04:14            y2018m08d28 (end file 152)

%Time_CL1_1B
%16-Aug-2016 11:25:07            y2016m08d18 (start file 4)
%04-Aug-2017 05:55:07            y2017m08d08 (end file 75)

%Time_CL1_2B
%21-Aug-2016 21:40:00            y2016m08d23 (start file 5)
%26-Jul-2017 05:19:59            y2017m07d29 (end file 73)

%Time_CL1_3A
%31-Aug-2016 08:10:52            y2016m09d02 (start file7)
%20-Jul-2017 15:00:52            y2017m07d24 (end file 72)

%Time_CL1_4A
%28-Aug-2016 18:22:07            y2016m08d28 (start file 6)
%23-Jul-2017 00:22:07            y2017m07d24 (end file 72)

%Time_CL1_5A
%01-Sep-2016 11:37:12            y2016m09d02 (start file 7)
%12-Jul-2017 21:17:11            y2017m07d14 (end file 70)

% ModeltimeFull = 158 5 day outputs
%datestr(ModeltimeFull)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot all locations with 151
for XX= 1:6
        if XX==1 %1A
                nick='1A';
        elseif XX==2 %1B
                nick='1B';
        elseif XX==3 %2B
                nick='2B';
        elseif XX==4 %3A
                nick='3A';
        elseif XX==5 %4A
                nick='4A';
        elseif XX==6 %5A
                nick='5A';
        end
MS = 7;
LW=1;
mk='o';


        homeP = '/mnt/storage1/gillard/POSTDOC/BaffinBayPolarWater/ModelVSObs/';
        eval(['load ' homeP 'matfiles/ModelVsMooring_nearestpoint_' nick '.mat;']) ;

%%% 2023-11-30 Potential Temp wasn't smoothed, so only smoothing it here.
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Smoothing
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Using a smooth function. Uses Loess and Robust Loess. Outliers have less influence on robust method.
        % plot clipped data with smooth loess and smooth robust loess, using 10%
        % smooth(x,y,0.1,'loess');
        % smooth(x,y,0.1,'rloess');
        ji=2;%1:2
        if ji==1
                SM=0.1;
        elseif ji==2
                SM=0.01;
        end
        SMP=SM*100;

PoTa_CL_1A=smooth(Temp_CL1_1A,SM,'loess');

PoTa_CL_1B=smooth(Temp_CL1_1B,SM,'loess');

PoTa_CL_2B=smooth(Temp_CL1_2B,SM,'loess');

PoTa_CL_3A=smooth(Temp_CL1_3A,SM,'loess');

PoTa_CL_4A=smooth(Temp_CL1_4A,SM,'loess');

PoTa_CL_5A=smooth(Temp_CL1_5A,SM,'loess');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 	if XX==1 %1A
                nick='1A';
ModelTimeFull_1A=ModeltimeFull;
Temp_1_1A=Temp_1;
Sal_1_1A=Sal_1;

        elseif XX==2 %1B
                nick='1B';
ModelTimeFull_1B=ModeltimeFull;
Temp_1_1B=Temp_1;
Sal_1_1B=Sal_1;
        elseif XX==3 %2B
                nick='2B';
ModelTimeFull_2B=ModeltimeFull;
Temp_1_2B=Temp_1;
Sal_1_2B=Sal_1;
        elseif XX==4 %3A
                nick='3A';
ModelTimeFull_3A=ModeltimeFull;
Temp_1_3A=Temp_1;
Sal_1_3A=Sal_1;
        elseif XX==5 %4A
                nick='4A';
ModelTimeFull_4A=ModeltimeFull;
Temp_1_4A=Temp_1;
Sal_1_4A=Sal_1;
        elseif XX==6 %5A
                nick='5A';
ModelTimeFull_5A=ModeltimeFull;
Temp_1_5A=Temp_1;
Sal_1_5A=Sal_1;
        end
end
                % POTENTIAL Temperature and Practical Salinity
% Replace all TempSL_CL_* with PoTa_CL_*
%PoTa_CL_4A
                m0=figure;
                set(m0,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')


%> cbrewer('seq','BuPu',7)
%
%ans =
%
%    0.9294    0.9725    0.9843
%    0.7490    0.8275    0.9020
%    0.6196    0.7373    0.8549 YES
%    0.5490    0.5882    0.7765
%    0.5490    0.4196    0.6941 YES
%    0.5333    0.2549    0.6157
%    0.4314    0.0039    0.4196 YES

%>> cbrewer('seq','GnBu',7)
%
%ans =
%
%    0.9412    0.9765    0.9098
%    0.8000    0.9216    0.7725
%    0.6588    0.8667    0.7098
%    0.4824    0.8000    0.7686 YES
%    0.3059    0.7020    0.8275
%    0.1686    0.5490    0.7451 YES
%    0.0314    0.3451    0.6196

%cbrewer('seq','BuGn',7)
%
%ans =
%
%    0.9294    0.9725    0.9843
%    0.8000    0.9255    0.9020
%    0.6000    0.8471    0.7882
%    0.4000    0.7608    0.6431 
%    0.2549    0.6824    0.4627
%    0.1373    0.5451    0.2706
%         0    0.3451    0.1412 
%>> cbrewer('seq','PuBuGn',7)
%ans =
%    0.9647    0.9373    0.9686
%    0.8157    0.8196    0.9020
%    0.6510    0.7412    0.8588
%    0.4039    0.6627    0.8118
%    0.2118    0.5647    0.7529
%    0.0078    0.5059    0.5412 YES
%    0.0039    0.3922    0.3137

% cbrewer('qual','Set3',12)
%
%    0.5529    0.8275    0.7804 yes  1A
%    1.0000    1.0000    0.7020
%    0.7451    0.7294    0.8549
%    0.9843    0.5020    0.4471 yes 2B
%    0.5020    0.6941    0.8275 yes 3A
%    0.9922    0.7059    0.3843
%    0.7020    0.8706    0.4118 yes 4A
%    0.9882    0.8039    0.8980 yes 5A
%    0.8510    0.8510    0.8510
%    0.7373    0.5020    0.7412 yes 1B
%    0.8000    0.9216    0.7725
%    1.0000    0.9294    0.4353


                % observations
mk='diamond';
plotts(PoTa_CL_1A,SalSL_CL_1A,'marker',mk,'plotopt',{'markeredgecolor',[0.5529    0.8275    0.7804],'markerfacecolor',[0.5529    0.8275    0.7804],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',true);

hold on

plotts(PoTa_CL_1B,SalSL_CL_1B,'marker',mk,'plotopt',{'markeredgecolor',[0.7373    0.5020    0.7412],'markerfacecolor',[0.7373    0.5020    0.7412],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);

hold on

plotts(PoTa_CL_2B,SalSL_CL_2B,'marker',mk,'plotopt',{'markeredgecolor',[0.9843    0.5020    0.4471],'markerfacecolor',[0.9843    0.5020    0.4471],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);

hold on

plotts(PoTa_CL_3A,SalSL_CL_3A,'marker',mk,'plotopt',{'markeredgecolor',[0.5020    0.6941    0.8275],'markerfacecolor',[0.5020    0.6941    0.8275],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);

hold on

plotts(PoTa_CL_4A,SalSL_CL_4A,'marker',mk,'plotopt',{'markeredgecolor',[0.7020    0.8706    0.4118],'markerfacecolor',[0.7020    0.8706    0.4118],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);
               
hold on

plotts(PoTa_CL_5A,SalSL_CL_5A,'marker',mk,'plotopt',{'markeredgecolor',[0.9882    0.8039    0.8980],'markerfacecolor',[0.9882    0.8039    0.8980],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);
                

%                legend('1A','1B','2B','3A','4A','5A','Location','EastOutside')
%%% ADD MODEL
%% Fine in readme file dates of indexing for period of mooring data.

mk='square';
MS=10;
LW=1;
%"showTSplot_NPALL_onefigure.m"
%scatter(x,y,sz,'MarkerEdgeColor',[0 .5 .5],...
%              'MarkerFaceColor',[0 .7 .7],...
%              'LineWidth',1.5)
plotts(Temp_1_1A(4:152),Sal_1_1A(4:152),'marker',mk,'plotopt',{'markeredgecolor',[ 0 0 0],'markerfacecolor',[0.5529    0.8275    0.7804],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',true);

hold on

plotts(Temp_1_1B(4:75),Sal_1_1B(4:75),'marker',mk,'plotopt',{'markeredgecolor',[0 0 0],'markerfacecolor',[0.7373    0.5020    0.7412],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);

hold on

plotts(Temp_1_2B(5:73),Sal_1_2B(5:73),'marker',mk,'plotopt',{'markeredgecolor',[0 0 0],'markerfacecolor',[0.9843    0.5020    0.4471],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);

hold on

plotts(Temp_1_3A(7:72),Sal_1_3A(7:72),'marker',mk,'plotopt',{'markeredgecolor',[0 0 0],'markerfacecolor',[0.5020    0.6941    0.8275],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false)

hold on

plotts(Temp_1_4A(6:72),Sal_1_4A(6:72),'marker',mk,'plotopt',{'markeredgecolor',[0 0 0],'markerfacecolor',[0.7020    0.8706    0.4118],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);

hold on

plotts(Temp_1_5A(7:70),Sal_1_5A(7:70),'marker',mk,'plotopt',{'markeredgecolor',[0 0 0],'markerfacecolor',[0.9882    0.8039    0.8980],'markersize',MS,'linewidth',LW},'stlevel',[20:.5:50],'stlabel',false);




%%%%%%
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)

 			set(gcf,'Position',[50,360,1000,600],'color','w','PaperPositionMode','auto')
                        set(gcf,'color','w');
                        xlim([33.8 35]);
                        ylim([0 7]);
                        xlabel('Salinity')
                        ylabel('Temperature (^oC)')
                        set(gca,'fontsize',20,'fontweight','bold','linewidth',2)
 			grid on
                figName= (['TSPLOT_OBS_MODEL_ALLLOC_POTA_v2']);
               eval(['print -dpng -r300 ' ,figName,'.png']);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

