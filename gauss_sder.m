%readme
%��������
%��˹���¶���
%����:���۵�kazusa
%ʱ��:2019.10.28
%�汾:1.0.1,���԰汾,3�ڵ�Сϵͳ
clc;
clear
close all;
%line_data = [֧·��,�׶˽ڵ��,ĩ�˽ڵ��,֧·����,֧·�翹,�Եص���/2]
%line_data = xlsread('��·����.xlsx');
%line_data = [֧·��,�׶˽ڵ��,ĩ�˽ڵ��,֧·�迹,�������й�,�������޹�,�����й�,�����޹�];
line_data = [1 1 2 1.05+0i 0.08+0.24i 0  0  0  0
             2 1 3 1.03    0.02+0.06i 0  0  60 25
             3 2 3 0       0.06+0.18i 20 0  50 20];
%����ڵ㵼�ɾ���
YY = zeros(size(line_data,1));
yy = 1./line_data(:,5);
B=line_data(:,2:3);
B(:,3)=yy;
for i = 1:3
    for j=1:3
        if i == j %�Ե�
           YY(i,j)= B(B(i,1),3)+B(B(i,2),3);
        end
        if i < j %����(û�е��ɣ�ʵ�Գƾ���
           YY(i,j)= -B(i+j-2,3);
           YY(j,i)= YY(i,j);
        end
    end
end %�ɹ���ýڵ㵼�ɾ���
%���ó�ʼ����
% U = [1.05 1.03 1.0];
% U2 = U(1,2);
% U3 = U(1,3);
% Q2 = imag(U(1,2)*(YY(:,2)'*conj(U')));%���ﲻ��ΪʲôYY(:,2)'ת�����¾�ȡ�˹����ˣ�Amazon��
%sqrt(real(a).^2+imag(a).^2)ģ�Ĵ�С abs angle complex(1,2)
%atan(sqrt(a))*180/pi ���Ǵ�С
%             ����  ģ  ���
Caculate_v = [1.05 1.05 0
              1.03 1.03 0 
              1.0  1.0  0];%��ʼ��ѹ
%             P  Q  
Caculate_P_Q=[20-50 0 
              -60   -25 ]./100 %��Ϊ����ֵ
 %����Q2
Caculate_P_Q(1,2) = imag(Caculate_v(2,1)*(YY(:,2)'*conj(Caculate_v(:,1))));%���ﲻ��ΪʲôYY(:,2)'ת�����¾�ȡ�˹����ˣ�Amazon��
%����u2
t1=Caculate_P_Q(1,1);t2=Caculate_P_Q(1,2);
Caculate_v(2,1)=1./YY(2,2).*(complex(t1,-t2)./conj(Caculate_v(2,1))-YY(2,1).*Caculate_v(1,1)-YY(2,3).*Caculate_v(3,1)); 
%Caculate_v(2,2)���ֲ���
Caculate_v(2,3)=angle(Caculate_v(2,1));
Caculate_v(2,1)=Caculate_v(2,2)*(complex(cos(Caculate_v(2,3)),sin(Caculate_v(2,3))));
%����u3
t3=Caculate_P_Q(2,1);t4=Caculate_P_Q(2,2);
Caculate_v(3,1)=1./YY(3,3).*(complex(t3,t4)./conj(Caculate_v(3,1))-YY(3,1).*Caculate_v(1,1)-YY(3,2).*Caculate_v(2,1)); 
%Caculate_v(3,2)���ֲ���
Caculate_v(3,3)=angle(Caculate_v(3,1));










