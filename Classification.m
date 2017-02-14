function [LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1] = Classification(LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1)
%       Weighting of each sub-block depending on its own activity
% 
% in:   LL3: 3rd level approximation image
%       HL3: 3rd level horizontal detail image
%       LH3: 3rd level vertical detail image
%       HH3: 3rd level diagonal detail image
% 
%       HL2: 2nd level horizontal detail image
%       LH2: 2nd level vertical detail image
%       HH2: 2nd level diagonal detail image
% 
%       HL1: 1st level horizontal detail image
%       LH1: 1st level vertical detail image
%       HH1: 1st level diagonal detail image
% 
% J. de la Rica CCAV-UPC Dec-2016

LL3 = LL3.*0.55;
LH3 = LH3.*0.52;
HL3 = HL3.*0.52;
HH3 = HH3.*0.52;

LH2 = LH2.*0.48;
HL2 = HL2.*0.48;
HH2 = HH2.*0.55;

LH1 = LH1.*0.48;
HL1 = HL1.*0.48;
HH1 = HH1.*0.55;


% HH1
% for i = 1:length(HH1_b)
%     for j = 1:length(HH1_b)
%         if HH1_b(j,i)~=0
%             HH1 = HH1.*0.6;
%         else
%             HH1 = HH1.*0.4;
%         end
%     end
% end
% 
% % HL1
% for i = 1:length(HL1_b)
%     for j = 1:length(HL1_b)
%         if HL1_b(j,i)~=0
%             HL1 = HL1.*0.6;
%         else
%             HL1 = HL1.*0.4;
%         end
%     end
% end
% % LH1
% for i = 1:length(LH1_b)
%     for j = 1:length(LH1_b)
%         if LH1_b(j,i)~=0
%             LH1 = LH1.*0.6;
%         else
%             LH1 = LH1.*0.4;
%         end
%     end
% end
% 
% % HH2
% for i = 1:length(HH2_b)
%     for j = 1:length(HH2_b)
%         if HH2_b(j,i)~=0
%             HH2 = HH2.*0.6;
%         else
%             HH2 = HH2.*0.4;
%         end
%     end
% end
% % HL2
% for i = 1:length(HL2_b)
%     for j = 1:length(HL2_b)
%         if HL2_b(j,i)~=0
%             HL2 = HL2.*0.6;
%         else
%             HL2 = HL2.*0.4;
%         end
%     end
% end
% % LH2
% for i = 1:length(LH2_b)
%     for j = 1:length(LH2_b)
%         if LH2_b(j,i)~=0
%             LH2 = LH2.*0.6;
%         else
%             LH2 = LH2.*0.4;
%         end
%     end
% end
% % HH3
% for i = 1:length(HH3_b)
%     for j = 1:length(HH3_b)
%         if HH3_b(j,i)~=0
%             HH3 = HH3.*0.6;
%         else
%             HH3 = HH3.*0.4;
%         end
%     end
% end
% % HL3
% for i = 1:length(HL3_b)
%     for j = 1:length(HL3_b)
%         if HL3_b(j,i)~=0
%             HL3 = HL3.*0.6;
%         else
%             HL3 = HL3.*0.4;
%         end
%     end
% end
% % LH3
% for i = 1:length(LH3_b)
%     for j = 1:length(LH3_b)
%         if LH3_b(j,i)~=0
%             LH3 = LH3.*0.6;
%         else
%             LH3 = LH3.*0.4;
%         end
%     end
% end
% % LL3
% for i = 1:length(LL3_b)
%     for j = 1:length(LL3_b)
%         if LL3_b(j,i)~=0
%             LL3 = LL3.*0.6;
%         else
%             LL3 = LL3.*0.4;
%         end
%     end
% end
end
% end