function [p] = nsl_gss(t, s)
%NSL_GSS - Calculates a first set of parameters for the Neuzil (1982) solution for slug tests (pulse)
%
% Syntax: p = nsl_gss(t,s)
%
%   p(1) = Cd
%   p(2) = t0
%   t    = time
%   s    = relative drawdown
%
% Description:
%   First guess for the parameters of the Neuzil solution.
%
%   Two methods are defined:
%
%       One based on the value of the maximum of the derivative and 
%       on the time for which the drawdown is 0.5.
%
%       The second when the method fails because the derivative is 
%       too high, cd is fixed arbitrarily to 50.
%
% See also: nsl_dim, nsl_dmo, nsl_rpt
%






% First method
% 같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
% Based on the value of the maximum of the derivative
% and on the time for which the drawdown is 0.5

% Looking for the maximum of the derivative
np=size(t,1);                                     %number of rows of vector t
if np==1
    np=size(t,2);                                 %...of columns of t, if t is a row vector
end
  %calculating the logarithmic derivative
[dt,ds]=ldiffs(t,s,np/1.5);                       %LDIFFS(t,s) Approximate logarithmic derivative with Spline; d = optional argument allowing to adjust
                                                  %            the number of points used in the Spline. 
                                                   
  % finding the (negative) maximum and the corresponding index of the values of ds.
  %(the section with the steepest derivative on a slug test type curve
  % determines the value of alpha (or cd))                                                
[dmax,i]=max(-ds);    

  % first guess of cd  
  % -------------------
  % calculating from analytical sol. a type curve relating the maximum of the
  % derivative with Cd; finding from it the corresponding Cd for the found negative
  % maximum of the derivative of s 
dsmax=[0.13906	0.14019	0.14307	0.15001	0.16413	0.18562	0.21037	0.23401	0.25427	0.27064	0.28361	0.29381	0.3019	0.30843	0.31381	0.31823	0.32202	0.32525	0.32802	0.33047	0.33265	0.33452	0.33628	0.33779	0.33919	0.34048	0.34164	0.3427	0.34367	0.34457	0.3454	0.34619	0.34693	0.34761	0.34825	0.34884	0.34937	0.3499	0.35043	0.35091	0.35132	0.35176	0.35218	0.35253	0.35291	0.35327	0.35354	0.35392	0.3542	0.3545	0.35478	0.35502	0.35531	0.35551	0.35579	0.35597	0.35624	0.35641	0.35665	0.35682	0.35703	0.3572	0.35737	0.35756	0.35768	0.35789	0.35801	0.35819	0.35833	0.35844	0.35862	0.35872	0.35887	0.35901	0.35907	0.35925	0.35936	0.35943	0.35959	0.35968	0.35976	0.3599	0.35999	0.36005	0.36019	0.36027	0.36031	0.36046	0.36054	0.36058	0.3607	0.36079	0.36085	0.36091	0.36102	0.36109	0.36112	0.36122	0.36131	0.36136];
cdmax=[0.01	0.026561	0.070548	0.18738	0.4977	1.3219	3.5112	9.326	24.771	65.793	174.75	464.16	1232.8	3274.5	8697.5	23101	61359	162980	432880	1149800	3053900	8111300	21544000	57224000	151990000	403700000	1072300000	2848000000	7564600000	20092000000	53367000000	141750000000	376490000000	1000000000000	2656100000000	7054800000000	18738000000000	49770000000000	132190000000000	351120000000000	932600000000000	2.4771e+15	6.5793e+15	1.7475e+16	4.6416e+16	1.2328e+17	3.2745e+17	8.6975e+17	2.3101e+18	6.1359e+18	1.6298e+19	4.3288e+19	1.1498e+20	3.0539e+20	8.1113e+20	2.1544e+21	5.7224e+21	1.5199e+22	4.037e+22	1.0723e+23	2.848e+23	7.5646e+23	2.0092e+24	5.3367e+24	1.4175e+25	3.7649e+25	1e+26	2.6561e+26	7.0548e+26	1.8738e+27	4.977e+27	1.3219e+28	3.5112e+28	9.326e+28	2.4771e+29	6.5793e+29	1.7475e+30	4.6416e+30	1.2328e+31	3.2745e+31	8.6975e+31	2.3101e+32	6.1359e+32	1.6298e+33	4.3288e+33	1.1498e+34	3.0539e+34	8.1113e+34	2.1544e+35	5.7224e+35	1.5199e+36	4.037e+36	1.0723e+37	2.848e+37	7.5646e+37	2.0092e+38	5.3367e+38	1.4175e+39	3.7649e+39	1e+40];

p(1)=exp(interp1(dsmax,log(cdmax),dmax));         %exp because found value is a logarithm
                                                  %yi = INTERP1(X,Y,XI) 
                                                  %     interpolates (to find yi) the values of the underlying function Y (X)
                                                  %     at the point(s) XI. X must be a vector of length N.          

  % first guess of dimensionless time
  % ---------------------------------
  % Finding from another type curve the dimensionless time corresponding
  % to a dimensionless drawdown of 0.5 for a given value of Cd
  
[x,i]=sort(s);                                   % SORT   Sort in ascending order, 
                                                 % [Y,I] = SORT(X,DIM,MODE) also returns an index matrix I
y=t(i);                                          % sorting time vector in same manner
[x,i]=unique(x); 
                                                 % B = UNIQUE(A) for the array A returns the same values as in A but
                                                 %     with no repetitions. B will also be sorted. A can be a cell array of 
                                                 %     strings.

y=y(i);
t50=interp1(x,y,0.5);                             %1-D interpolation
    
td05=[0.00586770558742	0.01538276678787	0.03952949140660	0.09694461204071	0.21719603925390	0.42501780012524	0.71662305681555	1.06363233029027	1.43760222791051	1.82028724290396	2.20358418424062	2.58408967048293	2.96136937493074	3.33482849790512	3.70525943721090	4.07263907432772	4.43792575903868	4.80135835601924	5.16271293241688	5.52325181572752	5.88231715490175	6.23931944071651	6.59661383581317	6.95210659097099	7.30643224320023	7.66115976998289	8.01477682034437	8.36756008586347	8.71970765295706	9.07135123700411	9.42256498353144	9.77337153570370	10.12374618219556	10.47361933182128	10.82287789841075	11.17136553273684	11.52044344002349	11.86974847357249	12.21813252184930	12.56530458198805	12.91318067784498	13.26149706560916	13.60816009137916	13.95493769518254	14.30274614525803	14.64826645321799	14.99550293657282	15.34193768499867	15.68705068971524	16.03430073477501	16.37807076609380	16.72575485388320	17.06977548910524	17.41657199079698	17.76057059792890	18.10691433716675	18.45055957035689	18.79684650709133	19.13974751846824	19.48634380902855	19.82851525913239	20.17529734012830	20.51824259258036	20.86351679873552	21.20754050225741	21.55073134371076	21.89612895043074	22.23763508467999	22.58365010435056	22.92687153886336	23.26966547231196	23.61487577912874	23.95648343180061	24.30112659032918	24.64501565697978	24.98550026910186	25.33145439775837	25.67448982989344	26.01510452333986	26.36095666948836	26.70355761351395	27.04411599835794	27.38978772050444	27.73233575282293	28.07209819489549	28.41796332106905	28.76081111070927	29.10077224808644	29.44537021937825	29.78884858313224	30.12952033870633	30.47177166764350	30.81619529914736	31.15787771659484	31.49692855122661	31.84248208061840	32.18546561730872	32.52586464152356	32.86722245603525	33.21179163617694];
p(2)=t50./exp(interp1(log(cdmax),log(td05),log(p(1))));

  % Second method
  % 같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같
  % When the method fails because the derivative is too high,
  % cd is fixed arbitrarily to 50.
  % Knowing that the dimensionless time td/cd = t/t0 = 1.7255 
  % for sd=0.5 and cd=50, we locate the time t corresponding 
  % to sd=0.5 and calculate t0=t/1.7255.
if (isnan(p(1)) | isnan(p(2)))                  % if one out of p1, p2 is not a number
  p(2)=t50/1.71255;
  p(1)=50;
end