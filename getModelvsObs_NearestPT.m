clear all;
close all;
clc;
addpath('/mnt/storage4/gillard/matlab/export_fig/')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2024-02-09
% need to change depths because model level at nearest point thickness was 
% to large for 1A/B and 3A 

% 2023-11-16 
% Changed code to use one single [i,j] location
% i and j where found first by using closest_point.m to get
% the models lat and lon  and then cdffindij. cdffindij uses fortran
% and opens the mask starting at 0 for the first index

% depth levels start at 1.

% matlab likes to start the first index at 1
% GetNcVar starts at 0 for the first index
% Cdftools starts at 0 for the first index
% ncview starts at 1


%GetNcVar(tfile,'votemper',[ii jj Z1-1 0], [1 1 level 1]);

%GetNcVar(tfile,'votemper',[ii jj kk 0], [1 1 1 1]);
%			   [ starting],  [stride]
% stride of 1 means "i only want this point"
% stride of 2 means "get starting point and the next one"


% 2023-10-27 Updated to compare mooring data with ANHA4-EPM151 and EPM111
% BUG - No longer use: Plot SANNA2016 Mooring Data VS Model ANHA4-EPM101
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model: 
% ANHA4-EPM151:         Path: /mnt/storage6/myers/NEMO/ANHA4-EPM151/
%                       Tides/ 50 vertical levels / CGRF / HydroGFD River Runoff / Glorys2v3
%                       Bamber 2018 GrIS melt and icebergs / LIM2 / 5 day output
%                       Maskfile locations same as ANHA4-EPM101
%                       Use same mat files as drawn for ANHA4-EPM101
%                       Experiment dates: y2002m01d05 - y2022m12d31
%
% ANHA4-EPM111:         Path: /mnt/storage6/myers/NEMO/ANHA4-EPM151/
%                       Tides/ 50 vertical levels / CORE-IA / Dai and Trenberth River Runoff /
%                        OBCS: Kiel_K3415, Output from the NEMO modelling group at Keil
%                        IC: PHC, Polar Hyrdrographic Climatology
%                       Bamber 2018 GrIS melt and icebergs / LIM2 / 5 day output
%                       Maskfile locations same as ANHA4-EPM101
%                       Use same mat files as drawn for ANHA4-EPM101
%                       Experiment dates: y1958m01d05 - y2021m12d31
%
% BUG in runoff - no longer use EPM101
% 50 VL, CGRF 2002-2019, Glorys2v3 5-day output 
% Bamber 2018, Icebergs, Hydro GFD (RIver runoff), with Tides. 
% Stored /mnt/storage0/myers/NEMO/ANHA4-EPM101
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 50 vertical levels
% 0.49 1.54 2.64 3.82 5.08
% 6.44 7.93 9.57 11.4 13.47
% 15.81 18.5 21.6 25.21 29.44
% 34.43 40.34 47.37 55.76 65.81
% 77.85 92.33 109.73 130.66 155.85
% 186.12 222.48 266.04 318.13 380.21
% 453.94 541.09 643.57 763.33 902.34
% 1062.44 1245.29 1452.25
% 38 levels and up
% 1684.28 1941.89
% 2225.08 2533.34 2865.7 3220.82 3597.03
% 3992.48 4405.22 4833.29 5274.78 5727.92 ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Model Sept 2016 - Sept 2018
YS=2016;
YE=2018;
caseTag1 	= 'ANHA4-EPM151'
CEXP1		= caseTag1;
caseTagStr1	= strrep(caseTag1,'-','_');
dataF1          = ['/mnt/storage6/myers/NEMO/ANHA4-EPM151/'];

caseTag2        = 'ANHA4-EPM111'
CEXP2           = caseTag2;
caseTagStr2     = strrep(caseTag2,'-','_');
dataF2          = ['/mnt/storage6/myers/NEMO/ANHA4-EPM111/'];

meshfile        ='/mnt/storage1/xhu/ANHA4-I/ANHA4_mesh_zgr.nc';
maskfile	='/mnt/storage1/xhu/ANHA4-I/ANHA4_mask.nc';

nav_lon         = GetNcVar(meshfile,'nav_lon');
Gmask         	= GetNcVar(meshfile,'tmask');

[NY,NX]		= size(nav_lon);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Depth levels 0-27 and 27-50
% Need to determine which depth will work best for each mooring.
% Moorings are between 400-460 m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Depth levels 0-27 and 27-50
% Need to determine which depth will work best for each mooring.
% Moorings are between 400-460 m
% Model level 30 - 32 (380.21 m  - 541.09 m)
%Z1=30;
%ZZ=32;
%Sanna mooring
for ii=4
        if ii==1 %1A
                depthmin=455.5;
		Z1= 31; % 453.94
                ZZ= 31 ;% 541.09
		ipos=218;
		jpos=494;
		nick='1A';
        elseif ii==2 %1B
                depthmin=434.5;
		Z1=30; %380.21 m 
                ZZ=30; % 453.94
                ipos=218;
                jpos=494;
		nick='1B';
        elseif ii==3 %2B
                depthmin=421;
                Z1=30; %380.21 m
                ZZ=31; % 453.94
		ipos=218;
		jpos=463;
		nick='2B';
        elseif ii==4 %3A
                depthmin=434.5;
                Z1=30; %380.21 m
                ZZ=30; % 453.94
		ipos=209;
		jpos=446;
		nick='3A';
        elseif ii==5 %4A
                depthmin=408.5
                Z1=30; %380.21 m
                ZZ=31 % 453.94
		ipos=214;
		jpos=448;
		rick='4A';
        elseif ii==6 %5A
                depthmin=411;
                Z1=30; %380.21 m
               	ZZ=31; % 453.94
		ipos=198;
		jpos=412;
		nick='5A';
        end

 	level=ZZ-Z1+1;


	% determine how to do the time for model.... sept - sept
	MS=08;ME=12;MM=01;M2=09;
	nrec=0;
	for ny=YS:YE;
	        yystr=num2str(ny,'%04d');
		if ny==2016
			for nmon=MS:ME; % 08 - 12
	                	[mmstr,ddstr]=getyymmdd(nmon);
		                for nd=1:size(mmstr,1)
                		        if ~isempty(mmstr) %if not empty
                                		timeTag=['y',yystr,'m',mmstr(nd,:),'d',ddstr(nd,:)]
		                                tfile1=[dataF1,CEXP1,'_',timeTag,'_gridT.nc'];
						tfile2=[dataF2,CEXP2,'_',timeTag,'_gridT.nc'];
		                                nrec=nrec+1;
                		                if Z1==0
                                		        tt1= GetNcVar(tfile1,'votemper',[ipos jpos Z1 0],  [1 1 ZZ 1]);
		                                        ss1= GetNcVar(tfile1,'vosaline',[ipos jpos Z1 0],  [1 1 ZZ 1]);
							tt2= GetNcVar(tfile2,'votemper',[ipos jpos Z1 0],  [1 1 ZZ 1]);
                                                        ss2= GetNcVar(tfile2,'vosaline',[ipos jpos Z1 0],  [1 1 ZZ 1]);

                                                        e3t1= GetNcVar(tfile1,'e3t',    [ipos jpos Z1 0],  [1 1 ZZ 1]);
                                                        e3t2= GetNcVar(tfile2,'e3t',    [ipos jpos Z1 0],  [1 1 ZZ 1]);
                		                else
                                		        tt1= GetNcVar(tfile1,'votemper',[ipos jpos Z1-1 0],  [1 1 level 1]);
		                                        ss1= GetNcVar(tfile1,'vosaline',[ipos jpos Z1-1 0],  [1 1 level 1]);
                                                        tt2= GetNcVar(tfile2,'votemper',[ipos jpos Z1-1 0],  [1 1 level 1]);
                                                        ss2= GetNcVar(tfile2,'vosaline',[ipos jpos Z1-1 0],  [1 1 level 1]);

								e3t1= GetNcVar(tfile1,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
 							e3t2= GetNcVar(tfile2,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
                		                end
		                                tt1(tt1>1e+20)=nan;
		                                ss1(ss1>1e+20)=nan;
 						tt2(tt2>1e+20)=nan;
                                                ss2(ss2>1e+20)=nan;

						e3t1(ss1==0)=nan;
						tt1(ss1==0)=nan;
                                                ss1(ss1==0)=nan;

                                                e3t2(ss2==0)=nan;
                                                tt2(ss2==0)=nan;
                                                ss2(ss2==0)=nan;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here is where you need to create a tmask for naning out  things
% do volume calculation here too
        					tmask= GetNcVar(maskfile,'tmask',[ipos jpos 0 0],[1 1 1 1]);
        					e1t = GetNcVar(meshfile,'e1t',   [ipos jpos 0],[1 1 1]);
        					e2t = GetNcVar(meshfile,'e2t',   [ipos jpos 0],[1 1 1]);
        
						e1t(tmask==0)=nan;	
        					e2t(tmask==0)=nan;
        					%e3t1(tmask==0)=nan;
						%e3t2(tmask==0)=nan;
       					 	area=e1t.*e2t;

						if Z1==0
					                for ii=(Z1+1):ZZ
					                      %  newe3t1=squeeze(e3t1(ii,:,:));
								newe3t1=e3t1;newe3t2=e3t2;
								vol1(ii)=newe3t1(ii).*area;
								vol2(ii)=newe3t2(ii).*area;

					                        %vol1(ii,:,:)=newe3t1(:,:).*area;
 			
							%	newe3t2=squeeze(e3t2(ii,:,:));
					                        %vol2(ii,:,:)=newe3t2(:,:).*area;
					                end	
					        else
				                	for ii=1:level
					                 %       newe3t1=squeeze(e3t1(ii,:,:));
								newe3t1=e3t1;newe3t2=e3t2;

								vol1(ii)=newe3t1(ii).*area;
								vol2(ii)=newe3t2(ii).*area;

					                        %vol1(ii,:,:)=newe3t1(:,:).*area;

					                  %      newe3t2=squeeze(e3t2(ii,:,:));
					                        %vol2(ii,:,:)=newe3t2(:,:).*area;
					                end
					        end
					        totalvol1=nansum(nansum(nansum(vol1)));
					        totalvol2=nansum(nansum(nansum(vol2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		                                tt1(tmask==0)=nan; % mask out land
		                                ss1(tmask==0)=nan;
                                                tt2(tmask==0)=nan; % mask out land
                                                ss2(tmask==0)=nan;

%						vol1=vol1';
%						vol2=vol2';
						TempI_1= tt1.*vol1'; %zz by 800 by 544
                                                TempSum_1=(nansum(nansum(nansum(TempI_1))));
                                                TempAVG_1=TempSum_1./totalvol1;
                                                Temp_1(nrec)=TempAVG_1;
                                                SalI_1 = ss1.*vol1'; %zz by 800 by 544
                                                SalSum_1=(nansum(nansum(nansum(SalI_1))));
                                                SalAVG_1=SalSum_1./totalvol1;
                                                Sal_1(nrec)=SalAVG_1;

 						TempI_2= tt2.*vol2'; %zz by 800 by 544
                                                TempSum_2=(nansum(nansum(nansum(TempI_2))));
                                                TempAVG_2=TempSum_2./totalvol2;
                                                Temp_2(nrec)=TempAVG_2;
                                                SalI_2 = ss2.*vol2'; %zz by 800 by 544
                                                SalSum_2=(nansum(nansum(nansum(SalI_2))));
                                                SalAVG_2=SalSum_2./totalvol2;
                                                Sal_2(nrec)=SalAVG_2;


					end % if empty
				end % day
			end %month
		elseif ny==2018
			for nmon=MM:M2; %01-09
		                [mmstr,ddstr]=getyymmdd(nmon);
                		for nd=1:size(mmstr,1)
		                        if ~isempty(mmstr) %if not empty
                		                timeTag=['y',yystr,'m',mmstr(nd,:),'d',ddstr(nd,:)]
                                		tfile1=[dataF1,CEXP1,'_',timeTag,'_gridT.nc'];
                                                tfile2=[dataF2,CEXP2,'_',timeTag,'_gridT.nc'];

						nrec=nrec+1;
						if Z1==0
						tt1= GetNcVar(tfile1,'votemper',[ipos jpos Z1 0],  [1 1 ZZ 1]);
						ss1= GetNcVar(tfile1,'vosaline',[ipos jpos Z1 0],  [1 1 ZZ 1]);
						tt2= GetNcVar(tfile2,'votemper',[ipos jpos Z1 0],  [1 1 ZZ 1]);
						ss2= GetNcVar(tfile2,'vosaline',[ipos jpos Z1 0],  [1 1 ZZ 1]);

						e3t1= GetNcVar(tfile1,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
						e3t2= GetNcVar(tfile2,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
						else
						tt1= GetNcVar(tfile1,'votemper',[ipos jpos Z1-1 0],  [1 1 level 1]);
						ss1= GetNcVar(tfile1,'vosaline',[ipos jpos Z1-1 0],  [1 1 level 1]);
						tt2= GetNcVar(tfile2,'votemper',[ipos jpos Z1-1 0],  [1 1 level 1]);
						ss2= GetNcVar(tfile2,'vosaline',[ipos jpos Z1-1 0],  [1 1 level 1]);

						e3t1= GetNcVar(tfile1,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
						e3t2= GetNcVar(tfile2,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
						end
						tt1(tt1>1e+20)=nan;
						ss2(ss2>1e+20)=nan;
						tt2(tt2>1e+20)=nan;
						ss2(ss2>1e+20)=nan;
 						
						e3t1(ss1==0)=nan;
                                                tt1(ss1==0)=nan;
                                                ss1(ss1==0)=nan;

                                                e3t2(ss2==0)=nan;
                                                tt2(ss2==0)=nan;
                                                ss2(ss2==0)=nan;

						%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
						% Here is where you need to create a tmask for naning out  things
						% do volume calculation here too
						tmask= GetNcVar(maskfile,'tmask',[ipos jpos 0 0],[1 1 1 1]);
						e1t = GetNcVar(meshfile,'e1t',   [ipos jpos 0],[1 1 1]);
						e2t = GetNcVar(meshfile,'e2t',   [ipos jpos 0],[1 1 1]);

						e1t(tmask==0)=nan;
						e2t(tmask==0)=nan;
						%e3t1(tmask==0)=nan;
						%e3t2(tmask==0)=nan;
						area=e1t.*e2t;

						if Z1==0
							for ii=(Z1+1):ZZ
						%	      newe3t1=squeeze(e3t1(ii,:,:));
						%	      vol1(ii,:,:)=newe3t1(:,:).*area;

						%	      newe3t2=squeeze(e3t2(ii,:,:));
						%	      vol2(ii,:,:)=newe3t2(:,:).*area;
  								newe3t1=e3t1;newe3t2=e3t2;
                                                                vol1(ii)=newe3t1(ii).*area;
                                                                vol2(ii)=newe3t2(ii).*area;
							end
					      else
						      for ii=1:level
%							      newe3t1=squeeze(e3t1(ii,:,:));
%							      vol1(ii,:,:)=newe3t1(:,:).*area;
%							      newe3t2=squeeze(e3t2(ii,:,:));
%							      vol2(ii,:,:)=newe3t2(:,:).*area;
  								newe3t1=e3t1;newe3t2=e3t2;
                                                                vol1(ii)=newe3t1(ii).*area;
                                                                vol2(ii)=newe3t2(ii).*area;
						      end
						end
						totalvol1=nansum(nansum(nansum(vol1)));
                                                totalvol2=nansum(nansum(nansum(vol2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                		                tt1(tmask==0)=nan; % mask out land
		                                ss1(tmask==0)=nan;
					 	tt2(tmask==0)=nan; % mask out land
                                                ss2(tmask==0)=nan;

%						vol1=vol1';
%                                                vol2=vol2';

						TempI_1= tt1.*vol1'; %zz by 800 by 544
                                                TempSum_1=(nansum(nansum(nansum(TempI_1))));
                                                TempAVG_1=TempSum_1./totalvol1;
                                                Temp_1(nrec)=TempAVG_1;
                                                SalI_1 = ss1.*vol1'; %zz by 800 by 544
                                                SalSum_1=(nansum(nansum(nansum(SalI_1))));
                                                SalAVG_1=SalSum_1./totalvol1;
                                                Sal_1(nrec)=SalAVG_1;

 						TempI_2= tt2.*vol2'; %zz by 800 by 544
                                                TempSum_2=(nansum(nansum(nansum(TempI_2))));
                                                TempAVG_2=TempSum_2./totalvol2;
                                                Temp_2(nrec)=TempAVG_2;
                                                SalI_2 = ss2.*vol2'; %zz by 800 by 544
                                                SalSum_2=(nansum(nansum(nansum(SalI_2))));
                                                SalAVG_2=SalSum_2./totalvol2;
                                                Sal_2(nrec)=SalAVG_2;
     					end % if empty
                                end % day
                        end %month
		else
			for nmon=MM:ME; % 01-12
                		[mmstr,ddstr]=getyymmdd(nmon);
		                for nd=1:size(mmstr,1)
		                        if ~isempty(mmstr) %if not empty
                	        	        timeTag=['y',yystr,'m',mmstr(nd,:),'d',ddstr(nd,:)]
                        	        	tfile1=[dataF1,CEXP1,'_',timeTag,'_gridT.nc'];
		                                tfile2=[dataF2,CEXP2,'_',timeTag,'_gridT.nc'];
						nrec=nrec+1;
                		                if Z1==0
                                		        tt1= GetNcVar(tfile1,'votemper',[ipos jpos Z1 0],  [1 1 ZZ 1]);
		                                        ss1= GetNcVar(tfile1,'vosaline',[ipos jpos Z1 0],  [1 1 ZZ 1]);
 							tt2= GetNcVar(tfile2,'votemper',[ipos jpos Z1 0],  [1 1 ZZ 1]);
                                                        ss2= GetNcVar(tfile2,'vosaline',[ipos jpos Z1 0],  [1 1 ZZ 1]);

                                                        e3t1= GetNcVar(tfile1,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
                                                        e3t2= GetNcVar(tfile2,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
                		                else
                                		        tt1= GetNcVar(tfile1,'votemper',[ipos jpos Z1-1 0],  [1 1 level 1]);
		                                        ss1= GetNcVar(tfile1,'vosaline',[ipos jpos Z1-1 0],  [1 1 level 1]);
 							tt2= GetNcVar(tfile2,'votemper',[ipos jpos Z1-1 0],  [1 1 level 1]);
                                                        ss2= GetNcVar(tfile2,'vosaline',[ipos jpos Z1-1 0],  [1 1 level 1]);

							e3t1= GetNcVar(tfile1,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
                                                        e3t2= GetNcVar(tfile2,'e3t',    [ipos jpos Z1-1 0],  [1 1 level 1]);
                		                end
		                                tt1(tt1>1e+20)=nan;
		                                ss1(ss1>1e+20)=nan;
 						tt2(tt2>1e+20)=nan;
                                                ss2(ss2>1e+20)=nan;
 						
						e3t1(ss1==0)=nan;
                                                tt1(ss1==0)=nan;
                                                ss1(ss1==0)=nan;

                                                e3t2(ss2==0)=nan;
                                                tt2(ss2==0)=nan;
                                                ss2(ss2==0)=nan;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here is where you need to create a tmask for naning out  things
% do volume calculation here too
                                                tmask= GetNcVar(maskfile,'tmask',[ipos jpos 0 0],[1 1 1 1]);
                                                e1t = GetNcVar(meshfile,'e1t',   [ipos jpos 0],[1 1 1]);
                                                e2t = GetNcVar(meshfile,'e2t',   [ipos jpos 0],[1 1 1]);

                                                e1t(tmask==0)=nan;
                                                e2t(tmask==0)=nan;
 %                                               e3t1(tmask==0)=nan;
%                                                e3t2(tmask==0)=nan;
                                                area=e1t.*e2t;

                                                if Z1==0
                                                        for ii=(Z1+1):ZZ
 %                                                               newe3t1=squeeze(e3t1(ii,:,:));
%                                                                vol1(ii,:,:)=newe3t1(:,:).*area;
%
%                                                                newe3t2=squeeze(e3t2(ii,:,:));
%                                                                vol2(ii,:,:)=newe3t2(:,:).*area;
  								newe3t1=e3t1;newe3t2=e3t2;
                                                                vol1(ii)=newe3t1(ii).*area;
                                                                vol2(ii)=newe3t2(ii).*area;


                                                        end
                                                else
                                                        for ii=1:level
%                                                                newe3t1=squeeze(e3t1(ii,:,:));
%                                                                vol1(ii,:,:)=newe3t1(:,:).*area;
%                                                                newe3t2=squeeze(e3t2(ii,:,:));
%                                                                vol2(ii,:,:)=newe3t2(:,:).*area;
  								newe3t1=e3t1;newe3t2=e3t2;
                                                                vol1(ii)=newe3t1(ii).*area;
                                                                vol2(ii)=newe3t2(ii).*area;
                                                        end
                                                end
                                                totalvol1=nansum(nansum(nansum(vol1)));
                                                totalvol2=nansum(nansum(nansum(vol2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
						tt1(tmask==0)=nan; % mask out land
                                		ss1(tmask==0)=nan;
	 					tt2(tmask==0)=nan; % mask out land
                                                ss2(tmask==0)=nan;

%						vol1=vol1';
 %                                               vol2=vol2';


						TempI_1= tt1.*vol1'; %zz by 800 by 544
                                                TempSum_1=(nansum(nansum(nansum(TempI_1))));
                                                TempAVG_1=TempSum_1./totalvol1;
                                                Temp_1(nrec)=TempAVG_1;
                                                SalI_1 = ss1.*vol1'; %zz by 800 by 544
                                                SalSum_1=(nansum(nansum(nansum(SalI_1))));
                                                SalAVG_1=SalSum_1./totalvol1;
                                                Sal_1(nrec)=SalAVG_1;

 						TempI_2= tt2.*vol2'; %zz by 800 by 544
                                                TempSum_2=(nansum(nansum(nansum(TempI_2))));
                                                TempAVG_2=TempSum_2./totalvol2;
                                                Temp_2(nrec)=TempAVG_2;
                                                SalI_2 = ss2.*vol2'; %zz by 800 by 544
                                                SalSum_2=(nansum(nansum(nansum(SalI_2))));
                                                SalAVG_2=SalSum_2./totalvol2;
                                                Sal_2(nrec)=SalAVG_2;

                                      	end %if
                      		end %day
			end % month
		end % if different years 
	end % for cycle years
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Now you can plot Temp and Sal, for Model's south or north coast. Temp and Sal (152 time steps)
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% ModelTimeL: using [m,d]=getyymmdd to find out dates of the month and then convert
	% to days to be similar to observations time series
%	ModelTime0=datetime(2016,8,[03,08,13,18,23,28]);
%	ModelTime1=datetime(2016,9,[2,7,12,17,22,27]);
%	ModelTime2=datetime(2016,10,[2,7,12,17,22,27]);
%	ModelTime3=datetime(2016,11,[01,06,11,16,21,26]);
%	ModelTime4=datetime(2016,12,[01,06,11,16,21,26,31]);
%	ModelTime5=datetime(2017,1,[05,10,15,20,25,30]);
%	ModelTime6=datetime(2017,2,[04,09,14,19,24]);
%	ModelTime7=datetime(2017,3,[01,06,11,16,21,26,31]);
%	ModelTime8=datetime(2017,4,[05,10,15,20,25,30]);
%	ModelTime9=datetime(2017,5,[05,10,15,20,25,30]);
%	ModelTime10=datetime(2017,6,[04,09,14,19,24,29]);
%	ModelTime11=datetime(2017,7,[04,09,14,19,24,29]);
%	ModelTime12=datetime(2017,8,[03,08,13,18,23,28]);
%	ModelTime13=datetime(2017,9,[2,7,12,17,22,27]);
%	ModelTime14=datetime(2017,10,[2,7,12,17,22,27]);
%	ModelTime15=datetime(2017,11,[01,06,11,16,21,26]);
%	ModelTime16=datetime(2017,12,[01,06,11,16,21,26,31]);
%	ModelTime17=datetime(2018,1,[05,10,15,20,25,30]);
%	ModelTime18=datetime(2018,2,[04,09,14,19,24]);
%	ModelTime19=datetime(2018,3,[01,06,11,16,21,26,31]);
%	ModelTime20=datetime(2018,4,[05,10,15,20,25,30]);
%	ModelTime21=datetime(2018,5,[05,10,15,20,25,30]);
%	ModelTime22=datetime(2018,6,[04,09,14,19,24,29]);
%	ModelTime23=datetime(2018,7,[04,09,14,19,24,29]);
%	ModelTime24=datetime(2018,8,[03,08,13,18,23,28]);
%	ModelTime25=datetime(2018,9,[2,7,12,17,22,27]);
%%ModelTimeFull=[ModelTime0,ModelTime1,ModelTime2,ModelTime3,ModelTime4,ModelTime5,ModelTime6,ModelTime7,ModelTime8,ModelTime9,ModelTime10,ModelTime11,ModelTime12,ModelTime13,ModelTime14,ModelTime15,ModelTime16];%

%	ModelTimeFull=[ModelTime0,ModelTime1,ModelTime2,ModelTime3,ModelTime4,ModelTime5,ModelTime6,ModelTime7,ModelTime8,ModelTime9,ModelTime10,ModelTime11,ModelTime12,ModelTime13,ModelTime14,ModelTime15,ModelTime16,ModelTime17,ModelTime18,ModelTime19,ModelTime20,ModelTime21,ModelTime22,ModelTime23,ModelTime24,ModelTime25];

%% New Model Date time 2023-11-01
ModeltimeFull=getXTime(2016,08,2018,09);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Now get the observations


	% Load in modified files (copies of the originals)  where the headers were removed and files were renamed
	% to have a consistent structure
	% Orginal files : /mnt/storage5/gillard/POSTDOC/SANNA2016/mooring/
	% Mod Files     : /mnt/storage5/gillard/POSTDOC/SANNA2016/mooring/MODfiles
	% Despiked files: /mnt/storage5/gillard/POSTDOC/SANNA2016/mooring/MODfiles/CLEAN
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Each coluumn has:
	% name 0 = timeJV2: Time, Instrument [julian days]
	% name 1 = prdM: Pressure, Strain Gauge [db]
	% name 2 = tv290C: Temperature [ITS-90, deg C]
	% name 3 = cond0S/m: Conductivity [S/m]
	% name 4 = scan: Scan Count
	% name 5 = sal00: Salinity, Practical [PSU]
	% name 6 = pta090C: Potential Temperature Anomaly [ITS-90, deg C], a0 = 0, a1 = 0
	% name 7 = sigma-é00: Density [sigma-theta, kg/m^3]
	% name 8 = flag:  0.000e+00
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Mooring Number and SBE37 Serial Number
	% Open SANNA2016 Mooring Files
	% FNorig='/mnt/storage5/gillard/POSTDOC/SANNA2016/mooring/MODfiles/';
	FNclean='/mnt/storage5/gillard/POSTDOC/SANNA2016/mooring/MODfiles/CLEAN/';
	% SANNA_1B_03714361
	% SANNA_2B_03714362
	% SANNA_4A_03714351
	% SANNA_5A_03714352
	% SANNA_1A_03714363
	% SANNA_2A_03714349
	% SANNA_3A_03714350
	% SANNA_4B_14358
%	if XX == 1 % North Coast in Model, then we need Moorings 1A/1B/2A/2B/3A/4A
	SANNA_1A	= 'SANNA_1A_03714363_CLEAN';
        PressMin_1A	=  2;
        SANNA_1B	= 'SANNA_1B_03714361_CLEAN';
        PressMin_1B	= 400;
        SANNA_2A	= 'SANNA_2A_03714349_CLEAN';
       	PressMin_2A	= 250;
        SANNA_2B	= 'SANNA_2B_03714362_CLEAN';
        PressMin_2B	= 400;
      	SANNA_3A	= 'SANNA_3A_03714350_CLEAN';
        PressMin_3A	= 330;
        SANNA_4A	= 'SANNA_4A_03714351_CLEAN';
        PressMin_4A	= 90;
	SANNA_4B        = 'SANNA_4B_14358_CLEAN';
        PressMin_4B     = 2;
        SANNA_5A        = 'SANNA_5A_03714352_CLEAN';
        PressMin_5A     = 4;

	% Structure used to call file needs to be s.x_file. "file" is from the 
	% modfile where I had to input a header for the structure
	sCL_1A= tdfread([FNclean SANNA_1A '.cnv'], 'tab'); % filename, delimiter
        sCL_1B= tdfread([FNclean SANNA_1B '.cnv'], 'tab'); % filename, delimiter
        sCL_2A= tdfread([FNclean SANNA_2A '.cnv'], 'tab'); % filename, delimiter
        sCL_2B= tdfread([FNclean SANNA_2B '.cnv'], 'tab'); % filename, delimiter
        sCL_3A= tdfread([FNclean SANNA_3A '.cnv'], 'tab'); % filename, delimiter
        sCL_4A= tdfread([FNclean SANNA_4A '.cnv'], 'tab'); % filename, delimiter
        sCL_4B= tdfread([FNclean SANNA_4B '.cnv'], 'tab'); % filename, delimiter
        sCL_5A= tdfread([FNclean SANNA_5A '.cnv'], 'tab'); % filename, delimiter

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Clean Data % 1A
	DayOfYearCL_1A 	= sCL_1A.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
	PressCL_1A      = sCL_1A.x_file(:,2);
	TempCL_1A       = sCL_1A.x_file(:,3);
	CondCL_1A       = sCL_1A.x_file(:,4);
	ScanCL_1A       = sCL_1A.x_file(:,5);
	SalCL_1A        = sCL_1A.x_file(:,6);
	PoTaCL_1A       = sCL_1A.x_file(:,7);
	DensCL_1A       = sCL_1A.x_file(:,8);
	FlagCL_1A       = sCL_1A.x_file(:,9);
	Time_1A		= datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_1A); 
	% output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
	jj_1A              = find(PressCL_1A>PressMin_1A);
	Time_CL1_1A        = Time_1A(jj_1A);
	Press_CL1_1A       = PressCL_1A(jj_1A);
	Temp_CL1_1A        = TempCL_1A(jj_1A);
	Cond_CL1_1A        = CondCL_1A(jj_1A);
	Scan_CL1_1A        = ScanCL_1A(jj_1A);
	Sal_CL1_1A         = SalCL_1A(jj_1A);
	PoTa_CL1_1A        = PoTaCL_1A(jj_1A);
	Dens_CL1_1A        = DensCL_1A(jj_1A);
	Flag_CL1_1A        = FlagCL_1A(jj_1A);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Clean Data % 1B
        DayOfYearCL_1B  = sCL_1B.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
        PressCL_1B      = sCL_1B.x_file(:,2);
        TempCL_1B       = sCL_1B.x_file(:,3);
        CondCL_1B       = sCL_1B.x_file(:,4);
        ScanCL_1B       = sCL_1B.x_file(:,5);
        SalCL_1B        = sCL_1B.x_file(:,6);
        PoTaCL_1B       = sCL_1B.x_file(:,7);
        DensCL_1B       = sCL_1B.x_file(:,8);
        FlagCL_1B       = sCL_1B.x_file(:,9);
        Time_1B         = datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_1B);
	%output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
	jj_1B              = find(PressCL_1B>PressMin_1B);
        Time_CL1_1B        = Time_1B(jj_1B);
        Press_CL1_1B       = PressCL_1B(jj_1B);
        Temp_CL1_1B        = TempCL_1B(jj_1B);
        Cond_CL1_1B        = CondCL_1B(jj_1B);
        Scan_CL1_1B        = ScanCL_1B(jj_1B);
        Sal_CL1_1B         = SalCL_1B(jj_1B);
        PoTa_CL1_1B        = PoTaCL_1B(jj_1B);
        Dens_CL1_1B        = DensCL_1B(jj_1B);
        Flag_CL1_1B        = FlagCL_1B(jj_1B);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 		
	% Clean Data % 2A
        DayOfYearCL_2A  = sCL_2A.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
        PressCL_2A      = sCL_2A.x_file(:,2);
        TempCL_2A       = sCL_2A.x_file(:,3);
        CondCL_2A       = sCL_2A.x_file(:,4);
        ScanCL_2A       = sCL_2A.x_file(:,5);
        SalCL_2A        = sCL_2A.x_file(:,6);
        PoTaCL_2A       = sCL_2A.x_file(:,7);
        DensCL_2A       = sCL_2A.x_file(:,8);
        FlagCL_2A       = sCL_2A.x_file(:,9);
        Time_2A         = datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_2A);
	% output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
	jj_2A              = find(PressCL_2A>PressMin_2A);
        Time_CL1_2A        = Time_2A(jj_2A);
        Press_CL1_2A       = PressCL_2A(jj_2A);
        Temp_CL1_2A        = TempCL_2A(jj_2A);
        Cond_CL1_2A        = CondCL_2A(jj_2A);
        Scan_CL1_2A        = ScanCL_2A(jj_2A);
        Sal_CL1_2A         = SalCL_2A(jj_2A);
        PoTa_CL1_2A        = PoTaCL_2A(jj_2A);
        Dens_CL1_2A        = DensCL_2A(jj_2A);
        Flag_CL1_2A        = FlagCL_2A(jj_2A);
 		
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Clean Data % 2B
        DayOfYearCL_2B  = sCL_2B.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
        PressCL_2B      = sCL_2B.x_file(:,2);
        TempCL_2B       = sCL_2B.x_file(:,3);
        CondCL_2B       = sCL_2B.x_file(:,4);
        ScanCL_2B       = sCL_2B.x_file(:,5);
        SalCL_2B        = sCL_2B.x_file(:,6);
        PoTaCL_2B       = sCL_2B.x_file(:,7);
        DensCL_2B       = sCL_2B.x_file(:,8);
        FlagCL_2B       = sCL_2B.x_file(:,9);
        Time_2B         = datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_2B); 
	% output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
	jj_2B              = find(PressCL_2B>PressMin_2B);
        Time_CL1_2B        = Time_2B(jj_2B);
        Press_CL1_2B       = PressCL_2B(jj_2B);
        Temp_CL1_2B        = TempCL_2B(jj_2B);
        Cond_CL1_2B        = CondCL_2B(jj_2B);
        Scan_CL1_2B        = ScanCL_2B(jj_2B);
        Sal_CL1_2B         = SalCL_2B(jj_2B);
        PoTa_CL1_2B        = PoTaCL_2B(jj_2B);
        Dens_CL1_2B        = DensCL_2B(jj_2B);
        Flag_CL1_2B        = FlagCL_2B(jj_2B);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Clean Data % 3A
        DayOfYearCL_3A  = sCL_3A.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
        PressCL_3A      = sCL_3A.x_file(:,2);
        TempCL_3A       = sCL_3A.x_file(:,3);
        CondCL_3A       = sCL_3A.x_file(:,4);
        ScanCL_3A       = sCL_3A.x_file(:,5);
        SalCL_3A        = sCL_3A.x_file(:,6);
        PoTaCL_3A       = sCL_3A.x_file(:,7);
        DensCL_3A       = sCL_3A.x_file(:,8);
        FlagCL_3A       = sCL_3A.x_file(:,9);
        Time_3A         = datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_3A); 
	% output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
	jj_3A              = find(PressCL_3A>PressMin_3A);
        Time_CL1_3A        = Time_3A(jj_3A);
        Press_CL1_3A       = PressCL_3A(jj_3A);
        Temp_CL1_3A        = TempCL_3A(jj_3A);
        Cond_CL1_3A        = CondCL_3A(jj_3A);
        Scan_CL1_3A        = ScanCL_3A(jj_3A);
        Sal_CL1_3A         = SalCL_3A(jj_3A);
        PoTa_CL1_3A        = PoTaCL_3A(jj_3A);
        Dens_CL1_3A        = DensCL_3A(jj_3A);
        Flag_CL1_3A        = FlagCL_3A(jj_3A);
 	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Clean Data % 4A
        DayOfYearCL_4A  = sCL_4A.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
        PressCL_4A      = sCL_4A.x_file(:,2);
        TempCL_4A       = sCL_4A.x_file(:,3);
        CondCL_4A       = sCL_4A.x_file(:,4);
        ScanCL_4A       = sCL_4A.x_file(:,5);
        SalCL_4A        = sCL_4A.x_file(:,6);
        PoTaCL_4A       = sCL_4A.x_file(:,7);
        DensCL_4A       = sCL_4A.x_file(:,8);
        FlagCL_4A       = sCL_4A.x_file(:,9);
        Time_4A         = datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_4A); 
	% output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
	jj_4A              = find(PressCL_4A>PressMin_4A);
        Time_CL1_4A        = Time_4A(jj_4A);
        Press_CL1_4A       = PressCL_4A(jj_4A);
        Temp_CL1_4A        = TempCL_4A(jj_4A);
        Cond_CL1_4A        = CondCL_4A(jj_4A);
        Scan_CL1_4A        = ScanCL_4A(jj_4A);
        Sal_CL1_4A         = SalCL_4A(jj_4A);
        PoTa_CL1_4A        = PoTaCL_4A(jj_4A);
        Dens_CL1_4A        = DensCL_4A(jj_4A);
        Flag_CL1_4A        = FlagCL_4A(jj_4A);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Clean Data % 4B
        DayOfYearCL_4B  = sCL_4B.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
        PressCL_4B      = sCL_4B.x_file(:,2);
        TempCL_4B       = sCL_4B.x_file(:,3);
        CondCL_4B       = sCL_4B.x_file(:,4);
        ScanCL_4B       = sCL_4B.x_file(:,5);
        SalCL_4B        = sCL_4B.x_file(:,6);
        PoTaCL_4B       = sCL_4B.x_file(:,7);
        DensCL_4B       = sCL_4B.x_file(:,8);
        FlagCL_4B       = sCL_4B.x_file(:,9);
        Time_4B         = datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_4B);
        % output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
        jj_4B              = find(PressCL_4B>PressMin_4B);
        Time_CL1_4B        = Time_4B(jj_4B);
        Press_CL1_4B       = PressCL_4B(jj_4B);
        Temp_CL1_4B        = TempCL_4B(jj_4B);
        Cond_CL1_4B        = CondCL_4B(jj_4B);
        Scan_CL1_4B        = ScanCL_4B(jj_4B);
        Sal_CL1_4B         = SalCL_4B(jj_4B);
        PoTa_CL1_4B        = PoTaCL_4B(jj_4B);
        Dens_CL1_4B        = DensCL_4B(jj_4B);
        Flag_CL1_4B        = FlagCL_4B(jj_4B);
  	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Clean Data % 5A
        DayOfYearCL_5A  = sCL_5A.x_file(:,1); % Number of days since Jan 1 2016  - Day of Year
        PressCL_5A      = sCL_5A.x_file(:,2);
        TempCL_5A       = sCL_5A.x_file(:,3);
        CondCL_5A       = sCL_5A.x_file(:,4);
        ScanCL_5A       = sCL_5A.x_file(:,5);
        SalCL_5A        = sCL_5A.x_file(:,6);
        PoTaCL_5A       = sCL_5A.x_file(:,7);
        DensCL_5A       = sCL_5A.x_file(:,8);
        FlagCL_5A       = sCL_5A.x_file(:,9);
        Time_5A         = datetime(2016,1,0,'TimeZone','UTC')+days(DayOfYearCL_5A);
        % output dd-mmm-yyyy hr:mm:ss UTC ex. 12-Aug-2016 16:14:14
        jj_5A              = find(PressCL_5A>PressMin_5A);
        Time_CL1_5A        = Time_5A(jj_5A);
        Press_CL1_5A       = PressCL_5A(jj_5A);
        Temp_CL1_5A        = TempCL_5A(jj_5A);
        Cond_CL1_5A        = CondCL_5A(jj_5A);
        Scan_CL1_5A        = ScanCL_5A(jj_5A);
        Sal_CL1_5A         = SalCL_5A(jj_5A);
        PoTa_CL1_5A        = PoTaCL_5A(jj_5A);
        Dens_CL1_5A        = DensCL_5A(jj_5A);
        Flag_CL1_5A        = FlagCL_5A(jj_5A);

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

	TempSL_CL_1A       = smooth(Temp_CL1_1A,SM,'loess');
	SalSL_CL_1A        = smooth(Sal_CL1_1A,SM,'loess');

        TempSL_CL_1B       = smooth(Temp_CL1_1B,SM,'loess');
        SalSL_CL_1B        = smooth(Sal_CL1_1B,SM,'loess');

        TempSL_CL_2A       = smooth(Temp_CL1_2A,SM,'loess');
        SalSL_CL_2A        = smooth(Sal_CL1_2A,SM,'loess');

        TempSL_CL_2B       = smooth(Temp_CL1_2B,SM,'loess');
        SalSL_CL_2B        = smooth(Sal_CL1_2B,SM,'loess');

	TempSL_CL_3A       = smooth(Temp_CL1_3A,SM,'loess');
        SalSL_CL_3A        = smooth(Sal_CL1_3A,SM,'loess');

        TempSL_CL_4A       = smooth(Temp_CL1_4A,SM,'loess');
        SalSL_CL_4A        = smooth(Sal_CL1_4A,SM,'loess');

        TempSL_CL_4B       = smooth(Temp_CL1_4B,SM,'loess');
        SalSL_CL_4B        = smooth(Sal_CL1_4B,SM,'loess');

        TempSL_CL_5A       = smooth(Temp_CL1_5A,SM,'loess');
        SalSL_CL_5A        = smooth(Sal_CL1_5A,SM,'loess');

%%%%%%%%%%%%%%%%%%% Save Data
% change so that it saves in matfiles  folder

saveMAT = './matfiles/';
if ~exist(saveMAT,'dir')
 	mkdir(saveMAT)
end

saveFile=(['ModelVsMooring_nearestpoint_' nick '.mat'])
eval(['cd ' saveMAT])
save(saveFile,'-v7.3')
eval(['cd ..'])


end % mask

