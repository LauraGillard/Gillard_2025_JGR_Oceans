clear all;
close all;
clc;
addpath('/mnt/storage4/gillard/matlab/export_fig/')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run getModelvsObs.m first to get the matlfiles
% load matfiles to calculation the corrleation between
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use 
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


	homeP = '/mnt/storage1/gillard/POSTDOC/BaffinBayPolarWater/ModelVSObs/';
	eval(['load ' homeP 'matfiles/ModelVsMooring_nearestpoint_' nick '.mat;']) ;
%ModelVsMooring_mask1Atiny2.mat
%ModelVsMooring_nearestpoint_5A.mat

%datenum(2016,07,01)
xlim1= 736512;
%datenum(2018,10,01)
xlim3 = 737334;
%datenum(2017,09,01)
xlim2 = 736939;

% cbrewer('qual','Set3',12)
%    0.5529    0.8275    0.7804 yes MF 1A light green
%    0.9843    0.5020    0.4471 yes KF 2B orange/red
%    0.5020    0.6941    0.8275 yes DS 3A blue
%    0.7020    0.8706    0.4118 yes DF 4A green
%    0.9882    0.8039    0.8980 yes NS 5A pink %% adjusted so that it was darker: 0.8941 0.652 0.774]
%    0.7373    0.5020    0.7412 yes MS 1B purple

% Mooring Names:
% MF = 1A, MS = 1B, KF = 2B, DS = 3A, DF = 4A, NS = 5A
% model colour
Gr=[0.3 0.3 0.3];
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Plotting
	LW = 3;
	LWobs = 5;
	if XX == 1 %  1A 
                % Temperature
                m3t=figure;
                set(m3t,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(4:152),Temp_1(4:152),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_1A,TempSL_CL_1A,'linewidth',LWobs,'Color',[0.5529    0.8275    0.7804])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Temperature [^oC]');
		% same limit
		ylim([0 7])
                xlim([xlim1,xlim3]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_TEMP_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIMv2']);
                eval(['print -dpng -r300 ' ,figName,'.png']);

                % Salinity
                m3s=figure;
                set(m3s,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(4:152),Sal_1(4:152),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_1A,SalSL_CL_1A,'linewidth',LWobs,'Color',[0.5529    0.8275    0.7804])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Salinity');
                xlim([xlim1,xlim3]);
		% same limiti
		ylim([33.7 35])
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_SAL_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIMv2']);
                eval(['print -dpng -r300 ' ,figName,'.png']);

        elseif XX == 2 % NP 1B
                % Temperature
                m3t=figure;
                set(m3t,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(4:75),Temp_1(4:75),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_1B,TempSL_CL_1B,'linewidth',LWobs,'Color',[0.7373    0.5020    0.7412])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Temperature [^oC]');
		% same limit
		ylim([0 7])
   		xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_TEMP_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIMv2']);
                eval(['print -dpng -r300 ' ,figName,'.png']);
                % Salinity
                m3s=figure;
                set(m3s,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(4:75),Sal_1(4:75),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_1B,SalSL_CL_1B,'linewidth',LWobs,'Color',[0.7373    0.5020    0.7412])
                hold on
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Salinity');
		% same limiti
		ylim([33.7 35])
               xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_SAL_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIMv2']);
                eval(['print -dpng -r300 ' ,figName,'.png']);

	elseif XX == 3 % NP 2B
                % Temperature
                m3t=figure;
                set(m3t,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(5:73),Temp_1(5:73),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_2B,TempSL_CL_2B,'linewidth',LWobs,'Color',[0.9843    0.5020    0.4471])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Temperature [^oC]');
		% same limit
		ylim([0 7])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_TEMP_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIM']);
                eval(['print -dpng -r300 ' ,figName,'.png']);
                % Salinity
                m3s=figure;
                set(m3s,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(5:73),Sal_1(5:73),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_2B,SalSL_CL_2B,'linewidth',LWobs,'Color',[0.9843    0.5020    0.4471])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Salinity');
		% same limiti
		ylim([33.7 35])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_SAL_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIM']);
                eval(['print -dpng -r300 ' ,figName,'.png']);

 	elseif XX == 4 % NP 3A
                % Temperature
                m3t=figure;
                set(m3t,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(7:72),Temp_1(7:72),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_3A,TempSL_CL_3A,'linewidth',LWobs,'Color',[0.5020    0.6941    0.8275])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Temperature [^oC]');
		% same limit
		ylim([0 7])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_TEMP_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIMv2']);
	       eval(['print -dpng -r300 ' ,figName,'.png']);
                % Salinity
                m3s=figure;
                set(m3s,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(7:72),Sal_1(7:72),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_3A,SalSL_CL_3A,'linewidth',LWobs,'Color',[0.5020    0.6941    0.8275])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Salinity');
		% same limiti
		ylim([33.7 35])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_SAL_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIMv2']);
                eval(['print -dpng -r300 ' ,figName,'.png']);
 
	elseif XX == 5 % NP 4A 
                % Temperature
                m3t=figure;
                set(m3t,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')               
                plot(ModeltimeFull(6:72),Temp_1(6:72),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_4A,TempSL_CL_4A,'linewidth',LWobs,'Color',[0.7020    0.8706    0.4118])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Temperature [^oC]');
		% same limit
		ylim([0 7])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_TEMP_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIM']);
                eval(['print -dpng -r300 ' ,figName,'.png']);
                % Salinity
                m3s=figure;
                set(m3s,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(6:72),Sal_1(6:72),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_4A,SalSL_CL_4A,'linewidth',LWobs,'Color',[0.7020    0.8706    0.4118])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Salinity')
		% same limiti
		ylim([33.7 35])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_SAL_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIM']);
                eval(['print -dpng -r300 ' ,figName,'.png']);

	elseif XX == 6 % NP 5A
                % Temperature
                m3t=figure;
                set(m3t,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(7:70),Temp_1(7:70),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_5A,TempSL_CL_5A,'linewidth',LWobs,'Color',[0.8941 0.652 0.774])
                hold on
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Temperature [^oC]');
		% same limit
		ylim([0 7])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_TEMP_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIM']);
                eval(['print -dpng -r300 ' ,figName,'.png']);
                % Salinity
                m3s=figure;
                set(m3s,'Position',[0,200,1000,460],'color','w','PaperPositionMode','auto')
                plot(ModeltimeFull(7:70),Sal_1(7:70),'linewidth',LW,'Color',Gr)
		hold on
		plot(Time_CL1_5A,SalSL_CL_5A,'linewidth',LWobs,'Color',[0.8941 0.652 0.774])
                set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
                set(gca,'LineWidth',LW)
                set(gca,'XTickLabelRotation',45)
                ylabel('Salinity');
		% same limiti
		ylim([33.7 35])
                xlim([xlim1,xlim2]);
                grid on
		figName= (['ModelVsOBS_SANNA_NearestPT_' nick '_SAL_' num2str(YS) '_' num2str(YE) '_only151_time_sameLIM']);
                eval(['print -dpng -r300 ' ,figName,'.png']);
	end % plotting loop 
end % mask


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

