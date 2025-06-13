% Updated 2023-09-26 for EPM151 (bug in EPM101)
clear all;
close all;
clc;
addpath('/mnt/storage4/gillard/matlab/export_fig/')
addpath('/mnt/storage1/gillard/matlab/cbrewer/');

saveP='./figures/';
if ~exist(saveP,'dir')
  mkdir(saveP)
end

saveMAT = './matfiles/';
if ~exist(saveMAT,'dir')
  mkdir(saveMAT)
end



caseTag = 'ANHA4-EPM151'
%numyears=62;
numyears=19;
%exclude 2004-2006 and start at 2007
% 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 
startYear=4;
%62 for epm111
CEXP=caseTag;
caseTagStr=strrep(caseTag,'-','_');


%for ZZZ=1
%	if ZZZ==1
%                Z1=0;
%                ZZ=27;%222.48m
%        elseif ZZZ==2
%                Z1=27;%222.48m
%                ZZ=50;%entire depth
%        end

 	for XX = 5:10
                if XX==1
                       Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_ANHA475/BBPW_NS_SlopeCoast_Smaller5.nc';
                        mn=2
                        nick='NorthSlopeLine'
                        mn1=1;mn2=5;
                elseif XX==2
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_ANHA475/BBPW_NS_SlopeCoast_Smaller5.nc';
                        mn=3
                        nick='SouthSlopeLine'
                        mn1=1;mn2=5;
                elseif XX==3
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_ANHA475/BBPW_NS_SlopeCoast_Smaller5.nc';
                        mn=4
                        nick='NorthCoastLine'
                        mn1=1;mn2=5;
                elseif XX==4
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_ANHA475/BBPW_NS_SlopeCoast_Smaller5.nc';
                        mn=5
                        nick='SouthCoastLine'
                        mn1=1;mn2=5;
 		elseif XX==5
                        nick='1A';
                	Z1= 31; % 453.94
	                ZZ= 31;%32 ;% 541.09
        	elseif XX==6 %1B
                	Z1=30; %380.21 m
	                ZZ=30;%31; % 453.94
        	        nick='1B';
	        elseif XX==7 %2B
	                Z1=30; %380.21 m
        	        ZZ=31; % 453.94
                	nick='2B';
	        elseif XX==8 %3A
        	        Z1=30; %380.21 m
                	ZZ=30;%31; % 453.94
	                nick='3A';
        	elseif XX==9 %4A
                	Z1=30; %380.21 m
	                ZZ=31 % 453.94
        	        nick='4A';
	        elseif XX==10 %5A
        	        Z1=30; %380.21 m
                	ZZ=31; % 453.94
	                nick='5A';
		end

eval(['cd ' saveMAT])

%saveFile=(['SeasonalityT_',CEXP,'_',num2str(mn),'_',nick,'_depthlevel_', num2str(Z1) , '_',num2str(ZZ),'.mat']);

saveFile=(['SeasonalityT_',CEXP,'_',nick,'_depthlevel_', num2str(Z1) , '_',num2str(ZZ),'.mat']);

eval(['load ' saveFile])
eval(['cd ..'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                        % Temperature
                        % Take the average of all of the years
                        % InterED is a 73 by 19 dataset
                        % YearAvg will be a 73 by 1 dataset
                        YearAVG=(mean(TT(startYear:numyears,:)))';
                        YearSTD=(std(TT(startYear:numyears,:)))';
                        WindowSTD=[(YearAVG-YearSTD),(YearAVG+YearSTD)];
                        PosSTD=WindowSTD(:,2);
                        NegSTD=WindowSTD(:,1);

                        length = 1:73;
                        ll=[length';flipud(length')];
                        yy=[NegSTD;flipud(PosSTD)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dark base colors (colorblind-friendly palette)
% 9 base (dark) colorblind-friendly hues
base_colors = [
    0.00 0.45 0.70;  % blue
    0.94 0.60 0.00;  % orange
    0.00 0.62 0.45;  % teal
    0.80 0.47 0.65;  % pink
    0.35 0.70 0.90;  % light blue
    0.90 0.60 0.60;  % rose
    0.60 0.60 0.00;  % olive
    0.65 0.34 0.16;  % brown
    0.60 0.40 0.80;  % purple
];

% Create lighter versions of each color
light_colors = base_colors + (1 - base_colors) * 0.4;
light_colors = min(light_colors, 1);

% Interleave base and light versions
paired_colormap = zeros(18, 3);
for i = 1:9
    paired_colormap(2*i - 1, :) = base_colors(i, :);   % dark
    paired_colormap(2*i, :)     = light_colors(i, :);  % light
end

% Add a 19th color: neutral gray
neutral_gray = [0.6 0.6 0.6];
paired_colormap(19, :) = neutral_gray;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			matrix=paired_colormap;

			fig=figure; %set(fig,'Position', [0, 0, 2500,900]);
			set(fig,'Position', [0,200, 1000,650]);
			yy=[NegSTD;flipud(PosSTD)];
                        h=fill(ll,yy,[0.6 0.6 0.6],'linestyle','none');
                        set(h,'facealpha',0.3);
			set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
			hold on
			for ff=startYear:numyears %1:numyears
				plot(length,TT(ff,:),'LineWidth',5,'LineStyle','-','color',matrix(ff,:)); %(length instead of 1:6)
				hold on
			end
 			hold on
                        plot(1:73,YearAVG,'LineWidth',5,'LineStyle','-','Color','k')
                        set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
			xlabel('Month');ylabel('^o C'); %TW
			set(gcf,'color','w');
			grid on
	     		set(gca,'XTick',[1,7,12,19,25,31,37,43,49,55,61,67] , ...
			     'XTickLabel',{' J ',' F ',' M ',' A ',' M ',' J ',' J ',' A ',' S ',' O ',' N ',' D '})
    			xlim([1 73])
			lgd=legend('1STD','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022','mean','Location','EastOutSide');
figName= (['SeasonalityT_',CEXP,'_',nick,'_depthlevel_', num2str(Z1) , '_',num2str(ZZ),'_',num2str(2007),'v2']);
eval(['cd ' saveP])
eval(['print -dpng -r300 ' ,figName,'.png']);
eval(['cd ..'])
clear YearAVG
clear YearSTD
clear WindowSTD
clear PosSTD
clear NegSTD
clear ll
clear yy
clear TT 
			% Salinity
			% Take the average of all of the years
                        % InterED is a 73 by 19 dataset
                        % YearAvg will be a 73 by 1 dataset
                        YearAVG=(mean(SS(startYear:numyears,:)))';
                        YearSTD=(std(SS(startYear:numyears,:)))';
                        WindowSTD=[(YearAVG-YearSTD),(YearAVG+YearSTD)];
                        PosSTD=WindowSTD(:,2);
                        NegSTD=WindowSTD(:,1);
			length = 1:73;
			ll=[length';flipud(length')];
			yy=[NegSTD;flipud(PosSTD)];

			fig=figure; %set(fig,'Position', [0, 0, 2500,900]);
			set(fig,'Position', [0,200, 1000,650]);
 			h=fill(ll,yy,[0.6 0.6 0.6],'linestyle','none');
                        set(h,'facealpha',0.3);
                        set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)
			hold on
			for ff=startYear:numyears%1:numyears
				plot(length,SS(ff,:),'LineWidth',5,'LineStyle','-','color',matrix(ff,:));
				hold on
			end
 			hold on
                        plot(1:73,YearAVG,'LineWidth',5,'LineStyle','-','Color','k')
                        set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', 20)

			xlabel('Month');
			set(gcf,'color','w');
			grid on
			set(gca,'XTick',[1,7,12,19,25,31,37,43,49,55,61,67] , ...
			     'XTickLabel',{' J ',' F ',' M ',' A ',' M ',' J ',' J ',' A ',' S ',' O ',' N ',' D '})
			xlim([1 73])
			legend('1STD','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021','2022','mean','Location','EastOutSide')
figName= (['SeasonalityS_',CEXP,'_',nick,'_depthlevel_',num2str(Z1) , '_', num2str(ZZ),'_',num2str(2007),'v2']);

eval(['cd ' saveP])
eval(['print -dpng -r300 ' ,figName,'.png']);
eval(['cd ..'])

% clear some variables
clear YearAVG
clear YearSTD
clear WindowSTD
clear PosSTD
clear NegSTD
clear ll
clear yy
clear SS
        end % XX
