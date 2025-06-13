%function showSection(YS,YE,MS,ME)

addpath('/mnt/storage1/gillard/matlab/cbrewer/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Previous usage: 
%function showDavisStraitMonthlyTS(YS,YE,CFEXP)
% show the section plot (special for Davis Strait here)
% usage:
%       showDavisStraitMonthlyTS(YS,YE,CFEXP)
% e.g.,
%       showDavisStraitMonthlyTS(2002,2002,'ANHA4_ENG3')
% see also: 
%       getSimpleDavisStraitTSUV
%  xianmin@ualberta.ca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edited to show section along west greenland shelf and coast 
% copied from/mnt/storage4/gillard/Paper_AtlanticWater/eval/WGC/showFYLLAANHA4.m .
% Need to have created monthly averages before this.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CFEXP='ANHA4-EPM151';%
%CFEXP='ANHA4-EPM111';
%CFEXP='ANHA4-ELG019';
CFEXP=strrep(CFEXP,'-','_');
homeP = '/mnt/storage1/gillard/POSTDOC/BaffinBayPolarWater/Sections/'
YS = 2016;
YE = 2017;
MS = 06;
ME = 07;
%dep=GetNcVar('/mnt/storage0/xhu/ANHA4-I/ANHA4_mesh_zgr.nc','gdept_0');
% number of points
%ii=1:45; 
%[ii,dep]=meshgrid(ii,dep);
%DIM=size(secInfo.sectionE3t);
for transect=1:2
	if transect==1
		indexname='BB_COAST_ANHA450';%'BB_COAST_ANHA450';
	else
	 	indexname='BB_SLOPE_ANHA450';%'BB_SLOPE_ANHA450';
	end


	eval(['load ' homeP 'secIndex/' indexname 'Index.mat;']) ;
	DIM= size(secInfo.etopo);
	DIM3=size(secInfo.wgtTS);
	Zdim= DIM3(3);
	YY=DIM(2);
	ii=1:YY;
%	dep=GetNcVar('ANHA4_mesh_mask_BedMachineV3_L75.nc','gdept_0');
 	dep=GetNcVar('/mnt/storage1/gillard/POSTDOC/BaffinBayPolarWater/Sections/ANHA4_mesh_zgr.nc','gdept_0');
	[ii,dep]=meshgrid(ii,dep);
	
	nrec=0;

	for ind=1:YY;
    		nrec=nrec+1;
	    	if nrec==1
       			length(ind,1)= myll2dist(secInfo.myLon(ind,1),secInfo.myLat(ind,1),secInfo.myLon(ind+1,1),secInfo.myLat(ind+1,1));
	    	else
        		length(ind,1)= myll2dist(secInfo.myLon(ind-1,1),secInfo.myLat(ind-1,1),secInfo.myLon(ind,1),secInfo.myLat(ind,1));
	     	end
	end

	dist=zeros(1,YY);
	for kk=1:(YY-1)
		if kk ==1
        		dist(1,kk+1)=length(kk);
	        else
        		dist(1,kk+1)=length(kk)+dist(kk);
	        end
	end
	for qq=1:Zdim;%50
		dist2(qq,:)=(dist(:)); %fliplr does not do anything
% this comment is old and does not actually do anything	% this is to flip the section that was drawn south to north, to be north to south
	end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get monthly average
	datapath= [homeP 'matfile/MonthAvg/'];i
	eval(['load ' datapath CFEXP '_' indexname '_TSUV_y',num2str(YS),num2str(MS,'%02d'),'_' num2str(YE),num2str(ME,'%02d'), '.mat '])
	secT=mySectionAve.temp;
	secS=mySectionAve.salt;
% set land point to be nan
	[row,col]=find(secS==0);
	for zz=1:size(row)
    		secT(row(zz),col(zz))=nan;
	    	secS(row(zz),col(zz))=nan;
	end
	[row2,col2]=find(isnan(secS));
	for z2=1:size(row2)
	    	secT(row2(z2),col2(z2))=nan;
    		secS(row2(z2),col2(z2))=nan;
	end
%	cT=fliplr(secT); % this is to flip the section that was drawn south to north, to be north to south
%	cS=fliplr(secS); % this is to flip the section that was drawn south to north, to be north to south
cT=secT;
cS=secS;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
saveP= ['figures']
eval(['cd ' saveP ])
% Plot
zrange=600; % depth
LW=3;
%cT=fliplr(cT);%dist2=fliplr(dist2);
% Temperature
JJ=figure; max(dist2(1,:))
set(JJ,'Position',[100,500,1000,460],'color','w','PaperPositionMode','auto');
ax1=axes('Position',[0.13 0.25 0.81 0.68])
mypcolor(dist2,dep,cT); hold on; %FF.CData=fliplr(FF.CData) 

contour(dist2,dep,cT,[-1.4 -1.8],'m-','linewidth',2);

contour(dist2,dep,cT,[0 0],'w-','linewidth',2);

%contour(dist2,dep,cS,[34.2 34.2],'k--','linewidth',LW)
%contour(dist2,dep,cT,[2 2],'m-','linewidth',LW); 
%set(gca,'ylim',[0 zrange],'ydir','r','XColor',[0.3 0.3 0.3],'YColor',[0.3 0.3 0.3],'XMinortick','on','YMinortick','on','TickDir','out','fontweight','bold','fontsize',12,'linewidth',LW)
set(gca,'ylim',[0 zrange],'ydir','r','XColor','k','YColor','k','XMinortick','on','YMinortick','on','TickDir','out','fontweight','bold','fontsize',12,'linewidth',LW);
h1=colorbar('eastoutside');
caxis([-2 8]);

%%%%%%%%% New Colourmap%%%%
%cmap = cbrewer('seq', 'YlGnBu');
%colormap(cmap);
%%%%%%%%%%%%%%%%%%%%%%%%%%%

colormap(jet);
% FIXED: this is old % drawn south to north
% to orient figure from north to south and have distance along the transect from northern most point (km)
set(gca,'xdir','reverse' );
%xt = get(gca, 'XTick');
%set(gca, 'XTickLabel', fliplr(xt))
% 
ylabel('Depth (m)');
xlabel('Distance along transect from northern most point (km)');
ylabel(h1,'Temperature (^oC)');
if transect ==1
         set(ax1,'xtick',[0,200,400,600,800,1000,1200,1400,1600,1800,1938.8] , ...
        'XTickLabel',{'','1800','1600','1400','1200','1000','800','600','400','200','0'});
else
	set(ax1,'xtick',[0,200,400,600,800,1000,1200,1400,1600,1800,1973.5] , ...
    	'XTickLabel',{'','1800','1600','1400','1200','1000','800','600','400','200','0'});
end


str=([num2str(YS),num2str(MS,'%02d')]);
an=annotation(JJ,'textbox',...
    [0.747931873479319 0.406809110992489 0.0145985400205597 0.0498915397667302],...
'EdgeColor','w','String',{str});

myFontSize=20;
set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', myFontSize)
set(gcf,'color','w','paperpositionmode','auto')
eval(['print -dpng -r300 ',CFEXP,'_', indexname, '_T_',num2str(zrange),'m_',num2str(YS),'_m',num2str(MS,'%02.f'),'_y',num2str(YE),'_m',num2str(ME),'contours_date_shallowdepth.png'])

% Salinity
HH=figure;
set(HH,'Position',[100,500,1000,460],'color','w','PaperPositionMode','auto')
ax1=axes('Position',[0.13 0.25 0.81 0.68])
mypcolor(dist2,dep,cS); hold on;

contour(dist2,dep,cS,[33.6 33.6],'k-','linewidth',LW);

%contour(dist2,dep,cS,[34.2 34.2],'k--','linewidth',LW)
%contour(dist2,dep,cT,[2 2],'m-','linewidth',LW);
%set(gca,'ylim',[0 zrange],'ydir','r','XColor',[0.3 0.3 0.3],'YColor',[0.3 0.3 0.3],'XMinortick','on','YMinortick','on','TickDir','out','fontweight','bold','fontsize',12,'linewidth',LW)
set(gca,'ylim',[0 zrange],'ydir','r','XColor','k','YColor','k','XMinortick','on','YMinortick','on','TickDir','out','fontweight','bold','fontsize',12,'linewidth',LW);
h2=colorbar('eastoutside');

caxis([30 35.5]);
%%%%%%%%% New Colourmap%%%%
%cmap = cbrewer('seq', 'YlGnBu');
%colormap(cmap);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
colormap(jet);
%FIXED- this is old:  to orient figure from north to south and have distance along the transect from northern most point (km)
set(gca,'xdir','reverse' );
if transect==1
	 set(ax1,'xtick',[0,200,400,600,800,1000,1200,1400,1600,1800,1938.8] , ...
        'XTickLabel',{'','1800','1600','1400','1200','1000','800','600','400','200','0'});
else
	set(ax1,'xtick',[0,200,400,600,800,1000,1200,1400,1600,1800,1973.5] , ...
    	'XTickLabel',{'','1800','1600','1400','1200','1000','800','600','400','200','0'});
end
%xt = get(gca, 'XTick');
%set(gca, 'XTickLabel', fliplr(xt))
%
ylabel('Depth (m)');
xlabel('Distance along transect from northern most point (km)');
ylabel(h2,'Salinity');

str=([num2str(YS),num2str(MS,'%02d')]);
an=annotation(HH,'textbox',...
    [0.747931873479319 0.406809110992489 0.0145985400205597 0.0498915397667302],...
'EdgeColor','w','String',{str});

myFontSize=20;
set(gca,'fontname','Nimbus Sans L','FontWeight','bold','FontSize', myFontSize)
set(gcf,'color','w','paperpositionmode','auto')
eval(['print -dpng -r300 ',CFEXP,'_', indexname, '_S_',num2str(zrange),'m_',num2str(YS),'_m',num2str(MS,'%02.f'),'_y',num2str(YE),'_m',num2str(ME),'contours_date_shallowdepth.png'])

eval(['cd ' homeP ])

%cd homeP
%cd /mnt/storage1/gillard/POSTDOC/BaffinBayPolarWater/Sections/
% clear variables
close all
clear dist2 dep cS cT secT secS row2 col2 row col dist zz
end % transect
end % function
