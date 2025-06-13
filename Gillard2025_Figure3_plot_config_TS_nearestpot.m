clear all
close all
clc
addpath('/mnt/storage2/nathan/PROGRAM/matlab/export_fig/')
addpath('/mnt/storage1/gillard/matlab/cbrewer/');

saveP='./figures/';
if ~exist(saveP,'dir')
  mkdir(saveP)
end


% colormap(cbrewer('qual','Set3',51,'linear'));% f
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting
%colours
%LPK=[1 .7 .8]; % light pink
%LPR=[.6 .9 .8]; % light purple .6 .5 .8
%LB=[.1 .5 .8];% light blue %
MrS=5;
mk='o';
%color75=jet(51);
%color50=jet(38);
%color75=colormap(cbrewer('qual','Paired',75,'linear')); %change to 75
%color50=colormap(cbrewer('qual','Paired',50,'linear')); %change to 50
%color75=colormap(cbrewer('qual','Paired',5902,'linear')); %change to 75
%color50=colormap(cbrewer('qual','Paired',5728,'linear')); %change to 50
%color75=jet(5902);
%color50=jet(5728);
dz=3000;
colorZZ=(cbrewer('qual','Paired',dz,'linear')); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 75 vertical levels
%0.51 1.56 2.67 3.86 5.14
%6.54 8.09 9.82 11.77 13.99
%16.52 19.43 22.76 26.56 30.87
%35.74 41.18 47.21 53.85 61.11
%69.02 77.61 86.93 97.04 108.03
%120 133.08 147.41 163.16 180.55
%199.79 221.14 244.89 271.36 300.89
%333.86 370.69 411.79 457.63 508.64
%565.29 628.03 697.26 773.37 856.68
%947.45 1045.85 1151.99 1265.86 1387.38
% 51 levels and up:
%1516.36 1652.57 1795.67 1945.3 2101.03
%2262.42 2429.03 2600.38 2776.04 2955.57
%3138.56 3324.64 3513.45 3704.66 3897.98
%4093.16 4289.95 4488.15 4687.58 4888.07
%5089.48 5291.68 5494.58 5698.06 5902.06
depth75=[0.51 1.56 2.67 3.86 5.14 6.54 8.09 9.82 11.77 13.99 16.52 19.43 22.76 26.56 30.87 35.74 41.18 47.21 53.85 61.11 69.02 77.61 86.93 97.04 108.03 120 133.08 147.41 163.16 180.55 199.79 221.14 244.89 271.36 300.89 333.86 370.69 411.79 457.63 508.64 565.29 628.03 697.26 773.37 856.68 947.45 1045.85 1151.99 1265.86 1387.38 1516.36 1652.57 1795.67 1945.3 2101.03 2262.42 2429.03 2600.38 2776.04 2955.57 3138.56 3324.64 3513.45 3704.66 3897.98 4093.16 4289.95 4488.15 4687.58 4888.07 5089.48 5291.68 5494.58 5698.06 5902.06];
%cbh=colorbar('XTickLabel',{'5' '14' '30' '66' '156' '380' '900' '1941' '3597' '5727.92'  },'Xtick',[5 10 15 21 28 37  46 55 66 75 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 50 vertical levels
%0.49 1.54 2.64 3.82 5.08
%6.44 7.93 9.57 11.4 13.47
%15.81 18.5 21.6 25.21 29.44
%34.43 40.34 47.37 55.76 65.81
%77.85 92.33 109.73 130.66 155.85
%186.12 222.48 266.04 318.13 380.21
%453.94 541.09 643.57 763.33 902.34
%1062.44 1245.29 1452.25
%38 levels and up
% 1684.28 1941.89
%2225.08 2533.34 2865.7 3220.82 3597.03
%3992.48 4405.22 4833.29 5274.78 5727.92 ];
depth50=[0.49 1.54 2.64 3.82 5.08 6.44 7.93 9.57 11.4 13.47 15.81 18.5 21.6 25.21 29.44 34.43 40.34 47.37 55.76 65.81 77.85 92.33 109.73 130.66 155.85 186.12 222.48 266.04 318.13 380.21 453.94 541.09 643.57 763.33 902.34 1062.44 1245.29 1452.25 1684.28 1941.89 2225.08 2533.34 2865.7 3220.82 3597.03 3992.48 4405.22 4833.29 5274.78 5727.92 ];
%cbh=colorbar('XTickLabel',{'5' '14' '30' '66' '156' '380' '900' '1941' '3597' '5727.92'  },'Xtick',[5 10 15 20 25 30 35 40 45 50 )
%c50: 
% depth
% 109 (100)	222 (200)	318(300) 	453(400)
% level
% 23		27		29		31		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update: Coauthors thought the very cold -2 water and it being very fresh,didn't look real. When I looked at the code to see where the temperatures where that were colder than -2, it was located in the top layer of the model
% indices = find(TTii <-2);
% Convert linear indices to subscript indices
%[I1, I2, I3, I4, I5] = ind2sub(size(TTii), indices);
% comparing to Rysgaard 2020 figure 3
% removed top 10 metres of the water column helpd. Going to do more
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CTDLOCcoast
% size of file to load yrS(:,:,[380:505],[190:230]);
% CTDLOCslope
% size of file to load
for cf=3
	if cf==1; 
		CEXP='ANHA4-ELG019';
		zz=75;
	elseif cf==2;
		CEXP='ANHA4-EPM101';
                zz=50;
        elseif cf==3;
                CEXP='ANHA4-EPM151';
                zz=50;
		YS=2004;
		YE=2022;
        elseif cf==4;
                CEXP='ANHA4-EPM111';
                zz=50;
		YS=1960;
		YE=2021;
	end
	ii=0;
	% BUG SOMETHING KEEPS KILLING MY JOB - SO GOING TO PIECE MEAL THIS.
	% CONTINUE 2019
YS=2019;
        for mm=1 %mask number
                if mm==1
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_ANHA475/BBPW_NS_SlopeCoast_Smaller5.nc';
                        nick='NS_SLOPECOASTsmall'
                        mn=5;
                elseif mm==2
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_ANHA475/BBPW_NS_SlopeCoast5.nc';
                        nick='NS_SLOPECOAST'
                        mn=5;
                elseif mm==3
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_ANHA475/BBPW_Mask12.nc';
                        nick='BB_Regions'
                        mn=12;
            	elseif mm==4
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/CTDLOCcoast_23.nc';
                        nick='TU88';
                        mn=12;
                elseif mm==5
                       	Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/CTDLOCcoast_29.nc';
                       	nick='CTDLOCcoast';
                       	mn=18;%2-7 north, 8-18 south
			mn1=8;mn2=18;
                elseif mm==6
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/CTDLOCslope_11.nc';
                        nick='CTDLOCslope';
                        mn=12;%2-6 north, 7-12 south
			mn1=7;mn2=12;%12 is all NAN

  		elseif mm==7
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_CTDloc/TU88_region.nc';
                        nick='TU88_region';
                        mn=2;
                elseif mm==8
                        Gmask='/mnt/storage5/gillard/POSTDOC/BaffinBayPolarWater/Regions/Masks_CTDloc/TU88_regionV2.nc';
                        nick='TU88_regionV2';
                        mn=2;

		end
		for ny=2016;%YS:YE; 
			ii=0;
                	for mmn=2:mn %  mask out loop
				mmn
				mS=6;
				mE=7; 
				for nmon=mS:mE;
					ii=ii+1;
%					load(['matfile/TSdiagram_' CEXP '_' nick '_mask' num2str(mmn) '_' num2str(ny) '_m' num2str(nmon) '.mat'], 'yrS', 'yrT');
% for mm =1 and 2
load(['/mnt/storage1/gillard/POSTDOC/BaffinBayPolarWater/Regions/matfile/TSdiagram_' CEXP '_' nick '_mask' num2str(mmn) '_' num2str(ny) '_m' num2str(nmon) '.mat'], 'yrS', 'yrT');
					yrS=yrS(:,:,[380:505],[190:230]);
					yrT=yrT(:,:,[380:505],[190:230]);
					
					yrT(yrT>1e+20)=nan;
					yrS(yrS>1e+20)=nan;
                                        yrT(yrS==0)=nan;
                                        yrS(yrS==0)=nan;

					%yrS(find(yrS<0))=nan;
					%yrS(yrS<0)=nan;
					%yrT(find(yrS==nan))=nan;

					Temp(ii,:,:,:,:)=yrT; clear yrT
					Salt(ii,:,:,:,:)= yrS; clear yrS
					TTii=Temp; clear Temp
					SSii=Salt; clear Salt
			 	end % months 
%			end % mask numbers
			% TTii and SSii dimensions [looped  time, dates in month, depth, space , space]
figure
			if cf==1
				for dd=1:zz;
			        	if dd==1
					
						CA=round(depth75(dd));
						%if CA > dz set CA to dz. 
						if CA > dz
							CA=dz;
						end
	                                        e1=plotts(TTii(:,:,dd,:,:),SSii(:,:,dd,:,:),'marker',mk,'plotopt',{'color',colorZZ(CA,:),'markersize',MrS},'stlevel',[20:.5:50],'stlabel',false);
						set(e1,'MarkerFaceColor',get(e1,'Color'));
						hold on
	       				elseif dd==zz
						if ny==2017
 							CA=round(depth75(dd));
							if CA > dz
                                                        	CA=dz;
	                                                end                                       
						        e1=plotts(TTii(:,:,dd,:,:),SSii(:,:,dd,:,:),'marker',mk,'plotopt',{'color',colorZZ(CA,:),'markersize',MrS},'stlevel',[20:.5:50],'stlabel',true);
	        			                set(e1,'MarkerFaceColor',get(e1,'Color'));
							hold on
						end
					else
						CA=round(depth75(dd));
						if CA > dz
                                                        CA=dz;
                                                end

                                                e1=plotts(TTii(:,:,dd,:,:),SSii(:,:,dd,:,:),'marker',mk,'plotopt',{'color',colorZZ(CA,:),'markersize',MrS},'stlevel',[20:.5:50],'stlabel',false);
						set(e1,'MarkerFaceColor',get(e1,'Color'));
						hold on
				        end
				end
			else %edited 2023-09-19 LG
			%elseif cf==2 
   				for dd=13:zz; 	% 2024-07-05 Need to remove the top 10 metres, as it was giving temperature values to be very cold and fresh
						%, which didn't look real... (top 1 m had water colder that -2oC). (previous loop had dd=1:zz)
						% start at level 13 = 20 m
						%depth50=[0.49 1.54 2.64 3.82 5.08 6.44 7.93 9.57 11.4 13.47 15.81 18.5 21.6 25.21 29.44 34.43 40.34 47.37
						% 55.76 65.81 77.85 92.33 109.73 130.66 155.85 186.12 222.48 266.04 318.13 380.21 453.94 541.09 643.57 
						% 763.33 902.34 1062.44 1245.29 1452.25 1684.28 1941.89 2225.08 2533.34 2865.7 3220.82 3597.03 3992.48 
						%4405.22 4833.29 5274.78 5727.92 ];
		                        if dd==1
 						CA=round(depth50(dd));
 						if CA > dz
                                                        CA=dz;
                                                end
						if CA==0
							CA=1;
						end
                                                f1=plotts(TTii(1:ii,:,dd,:,:),SSii(1:ii,:,dd,:,:),'marker',mk,'plotopt',{'color',colorZZ(CA,:),'markersize',MrS},'stlevel',[20:.5:50],'stlabel',false);
		                                set(f1,'MarkerFaceColor',get(f1,'Color'));
                		                hold on
%commented out 2023-09-19 LG
%		                        elseif dd==zz
%                		                if ny==YS%2017
%	                                                CA=round(depth50(dd));
%						 	if CA > dz
%        	                                                CA=dz;
%	                                                end
%        	                                        f1=plotts(TTii(1:ii,:,dd,:,:),SSii(1:ii,:,dd,:,:),'marker',mk,'plotopt',{'color',colorZZ(CA,:),'markersize',MrS},'stlevel',[20:.5:50],'stlabel',true);
%		                                        set(f1,'MarkerFaceColor',get(f1,'Color'));
%						
%                		                        hold on
%                                		end
		                        else
                                                CA=round(depth50(dd));
 						if CA > dz
                                                        CA=dz;
                                                end
                                                f1=plotts(TTii(1:ii,:,dd,:,:),SSii(1:ii,:,dd,:,:),'marker',mk,'plotopt',{'color',colorZZ(CA,:),'markersize',MrS},'stlevel',[20:.5:50],'stlabel',false); % change false for clean version to add density text using another platform (inkscape) 2023-09-19 LG
		                                set(f1,'MarkerFaceColor',get(f1,'Color'));
                		                hold on
		                        end	
                		end
			end
			hold on
 			set(gcf,'Position',[50,360,1000,600],'color','w','PaperPositionMode','auto') 
			set(gcf,'color','w');
			xlim([30 35.5]);
			ylim([-2 8]);
			xlabel('Salinity')
			ylabel('Temperature (^oC)')
			set(gca,'fontsize',20,'fontweight','bold','linewidth',2)
			hAxes=gca;
			colormap(colorZZ);
			colorBounds=[1,dz]; % need to change so that range is only for metres and within the limt dz
			caxis(colorBounds)
			cbh=colorbar
			ylabel(cbh,'Depth (m)');
			set(cbh,'YDir','reverse');
			caseTagStr=strrep(CEXP,'-','_');

%if mn = 1 2 3 4  
%eval(['cd ' saveP])

export_fig(['TSplot_' caseTagStr '_' nick '_mask' num2str(mmn) '_' num2str(ny) '_m' num2str(mS) '_' num2str(mE) '_depth_nodenslabel_v3.png'])

%eval(['cd ..'])

%if mn = 5 6 
%export_fig(['TSplot_' caseTagStr '_' nick '_mask' num2str(mn1) '_' num2str(mn2) '_' num2str(ny) '_m' num2str(mS) '_' num2str(mE) '_depth.png'])
%close all
		clear TT SS TTii SSii Temp Salt yrS yrT   
		end % year
		end %mask number
	end % mask file
end % for CF
