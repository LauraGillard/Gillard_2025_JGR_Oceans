% Updated 2023-09-26 for EPM151 (bug in EPM101)
clear all;
close all;
clc;
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

saveP='./figures/';
if ~exist(saveP,'dir')
  mkdir(saveP)
end

%EPM151 19 years
%EPM111 62 years
YS=2004;
YE=2022;
MS=1;
ME=12;

caseTag = 'ANHA4-EPM151'
CEXP=caseTag;
caseTagStr=strrep(caseTag,'-','_');

addpath('/mnt/storage4/gillard/matlab/export_fig/')

dataF           = ['/mnt/storage6/myers/NEMO/ANHA4-EPM151/'];

maskfile        ='/mnt/storage1/xhu/ANHA4-I/ANHA4_mask.nc';
meshfile        ='/mnt/storage1/xhu/ANHA4-I/ANHA4_mesh_zgr.nc';
nav_lon         = GetNcVar(meshfile,'nav_lon');
[NY,NX]=size(nav_lon);

%ipos=198;
%jpos=412;

%tmask= GetNcVar(maskfile,'tmask',[ipos jpos 0 0],[1 1 1 1]);

%nick=           '5A';

%Sanna mooring
for ii=1:3
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
 	elseif ii==3 %3A
                depthmin=434.5;
                Z1=30; %380.21 m
                ZZ=30; % 453.94
                ipos=209;
                jpos=446;
                nick='3A';
       elseif ii==4 %2B
                depthmin=421;
                Z1=30; %380.21 m
                ZZ=31; % 453.94
                ipos=218;
                jpos=463;
                nick='2B';
%        elseif ii==4 %3A
%                depthmin=434.5;
%                Z1=30; %380.21 m
%                ZZ=31; % 453.94
%                ipos=209;
%                jpos=446;
%                nick='3A';
        elseif ii==5 %4A
                depthmin=408.5
                Z1=30; %380.21 m
                ZZ=31 % 453.94
                ipos=214;
                jpos=448;
                nick='4A';
        elseif ii==6 %5A
                depthmin=411;
                Z1=30; %380.21 m
                ZZ=31; % 453.94
                ipos=198;
                jpos=412;
                nick='5A';
        end



tmask= GetNcVar(maskfile,'tmask',[ipos jpos 0 0],[1 1 1 1]);

%                e1t = GetNcVar(meshfile,'e1t');
%                e2t = GetNcVar(meshfile,'e2t');

%       e3t =  getE3t(meshfile);
        e1t = GetNcVar(meshfile,'e1t',   [ipos jpos 0],[1 1 1]);
        e2t = GetNcVar(meshfile,'e2t',   [ipos jpos 0],[1 1 1]);

                % mask out land
                e1t(tmask==0)=nan;
                e2t(tmask==0)=nan;

                                area=e1t.*e2t;
				level=ZZ-Z1+1;

			ncount=0;
			nrec=0;  
			nyear=0;
			for ny=YS:YE;              % year domain
			    	yystr=num2str(ny,'%04d');   % setup year month day text to grab correct nc file
			    	for nmon=MS:ME
			    		[mmstr,ddstr]=getyymmdd(nmon);
					for nd=1:size(mmstr,1)
			            		if ~isempty(mmstr) %if not empty
		        			    	timeTag=['y',yystr,'m',mmstr(nd,:),'d',ddstr(nd,:)]  
							tfile=[dataF,CEXP,'_',timeTag,'_gridT.nc'];
                                	              	nrec=nrec+1;
							if Z1==0
								tt= GetNcVar(tfile,'votemper',[ipos jpos Z1 0],  [1 1 ZZ 1]);
		                         			ss= GetNcVar(tfile,'vosaline',[ipos jpos Z1 0],  [1 1 ZZ 1]);
                                                		e3t= GetNcVar(tfile,'e3t',  [ipos jpos Z1 0],  [1 1 ZZ 1]);

							else
								tt= GetNcVar(tfile,'votemper',[ipos jpos Z1-1 0],  [1 1 level 1]);
 	 		                       			ss= GetNcVar(tfile,'vosaline',[ipos jpos Z1-1 0],  [1 1 level 1]);
                                                		e3t= GetNcVar(tfile,'e3t',   [ipos jpos Z1-1 0],  [1 1 level 1]);
							end
%e3t_ps =   GetNcVar(meshfile,'e3t_ps',[ipos jpos 0], [1 1 1]);
%partialdepthdiff=e3t(end)-e3t_ps
%stop
% 1A , 1B, 3A,5A  do not reach the bottom level so do not use PS
% 2B 4A reaches bottom level - so PS would work - but when I inspected the difference, its like 0.01 so volume wouldn't change too much.
% 
%e3t_both=e3t;
%e3t_both(end)=e3t_ps;

                                                        tt(tt>1e+20)=nan;
                                                        ss(ss>1e+20)=nan;
                                                        tt(tmask==0)=nan; % mask out land
                                                        ss(tmask==0)=nan;
		 					e3t(ss==0)=nan;
                                        		tt(ss==0)=nan;
                                        		ss(ss==0)=nan;                                                       
  							if Z1==0
		                                                for ii=(Z1+1):ZZ
                		                                        newe3t=e3t;
                                		                        vol(ii)=newe3t(ii).*area;
                                                		end
		                                        else
                		                                for ii=1:level
                                		                        newe3t=e3t;
                                                		        vol(ii)=newe3t(ii).*area;
		                                                end
                		                        end
                                	                totalvol=nansum(nansum(nansum(vol)));


							TempI= tt.*vol'; %zz by 800 by 544
							TempSum=(nansum(nansum(nansum(TempI))));
							TempAVG=TempSum./totalvol;

							Temp(nrec)=TempAVG;
  							SalI = ss.*vol'; %zz by 800 by 544
                                                        SalSum=(nansum(nansum(nansum(SalI))));
                                                        SalAVG=SalSum./totalvol;
							Sal(nrec)=SalAVG;
						end %if
					end %day
				end % month
				nyear=nyear+1;
				TempY(nyear,:)= Temp;
                                SalY(nyear,:)= Sal;
			nrec = 0;
			clear TempI Temp TempM SalI Sal SalM ss tt SalAVG TempAVG
			end %year
			
			% Figure
			TT=TempY;
			SS=SalY;

			clear TempY SalY
			% YearAvg will be a 73 by 1 dataset
			YearAVG=(mean(TT))';
			YearSTD=(std(TT))';
			WindowSTD=[(YearAVG-YearSTD),(YearAVG+YearSTD)];

			PosSTD=WindowSTD(:,2);
			NegSTD=WindowSTD(:,1);


 			length = 1:73;
                        ll=[length';flipud(length')];
                        yy=[NegSTD;flipud(PosSTD)];

%%%%%%%%%%%%%%%%%%% Save Data
% change so that it saves in matfiles  folder

saveMAT = './matfiles/';
if ~exist(saveMAT,'dir')
  mkdir(saveMAT)
end

saveFile=(['SeasonalityT_',CEXP,'_',nick,'_depthlevel_', num2str(Z1) , '_',num2str(ZZ),'.mat']);

eval(['cd ' saveMAT])
save(saveFile,'-v7.3')
eval(['cd ..'])
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear some variables
clear YearAVG
clear YearSTD
clear WindowSTD
clear PosSTD
clear NegSTD
clear ll
clear yy
clear SS
%        end % XX
end% ZZ
