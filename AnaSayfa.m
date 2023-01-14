clc;
clear all;
%veri = xlsread("örnek","ilk",'B:F');
veri = xlsread("veri","ilk",'A:J');
[m,n] = find (isnan(veri));
eksikIndex = [m,n];
yeniVeri = veri;


while(1==1)
        fprintf("\n\n");
        disp("[0] Veriyi Yazdýr");
        disp("[1] Eksik Verileri Tamamla");
        disp("[2] Ortalama");
        disp("[3] Mod");
        disp("[4] Medyan");
        disp("[5] Frekans");
        disp("[6] IQR");
        disp("[7] Aykýrý Deðerler");
        disp("[8] Beþ Sayý Özeti");
        disp("[9] Kutu Grafiði");
        disp("[10] Varyans Ve Standart Sapma");
        disp("[11] Çýkýþ");
        secim = input('seçim yapýnýz ');
        fprintf("\n\n");
       if(secim==0)
           display(yeniVeri);
       elseif(secim==1)
           verisayisi=size(veri,1); 
           sinifIndex = size(veri,2);
           eksikVeriSayisi = size(eksikIndex,1);
           yeniVeri(isnan(veri)) = 0;
           eksiksutunlar=[];
           eksiksutunlar = unique(eksikIndex(:,2)); 
           eksiksutunsay = size(eksiksutunlar(:,1),1);
           for i=1: eksiksutunsay
               toplam = 0;
               sut = eksiksutunlar(i,1); 
               boyut =0;
               for n=1: eksikVeriSayisi
                   if eksikIndex(n,2) == sut
                       boyut = boyut+1;
                   end
               end
               for k=1 : verisayisi
                   toplam = toplam + yeniVeri(k,sut); 
               end
               ort = toplam / (verisayisi-boyut);
               for m=1: eksikVeriSayisi
                   if eksikIndex(m,2) == sut
                       yeniVeri(eksikIndex(m,1),sut) = ort;
                   end
               end
           end
           disp(yeniVeri);

       elseif (secim==2)
           sinifIndex = size(veri,2);
           verisayisi=size(veri,1);
           
           for j=1: sinifIndex
               toplam=0;
               i=1;
               for i=1: verisayisi
                   toplam = toplam + yeniVeri(i,j);
               end
               ortalama = toplam / verisayisi;
               X = sprintf('%d. Sütun Ortalama : %f',j,ortalama);
               disp(X)
           end
           
       elseif(secim==3)
           sinifIndex = size(veri,2);
           verisayisi=size(veri,1);
           sinifIndex = size(veri,2);
           for m=1: sinifIndex
               sinifIndex = size(veri,2);
               verisayisi=size(veri,1);
               sutun = yeniVeri(:,m);
               sutun = [sutun zeros(verisayisi,1)];
               for i=1: verisayisi
                   sutun(i,2)=sum(yeniVeri(:,m) == sutun(i,1));
               end
               maxFrekans = max(sutun(:,2));
               modIndex = find(sutun(:,2)==maxFrekans);
               degerler=[];
               k=1;
               for n=1: verisayisi
                    if sutun(n,2) == maxFrekans
                       degerler(k) = sutun(n,1);
                       k=k+1;
                    end
               end
               tekildegerler = unique(degerler);
               
               fprintf("%d . Sütunun Modlarý\n" , m);
               for i=1: length(tekildegerler)
                    fprintf('-->: %f\n', tekildegerler(i));
               end
               
               
           end
       
       elseif(secim==4)
           sinifIndex = size(yeniVeri,2);
           verisayisi=size(yeniVeri,1);
           for i=1: sinifIndex
                verisayisi=size(yeniVeri,1);
                med = median(yeniVeri(:,i));
                fprintf('%d. Sütun Medyan : %f\n',i,med);
           end
       elseif(secim==5)
           sinifIndex = size(yeniVeri,2);
           verisayisi=size(yeniVeri,1);
           deger = input('Frekansýný Hesaplamak Ýstediðiniz Sütun');
           sutun=sort(yeniVeri(:,deger));
           tekilveriler = unique(sutun);
           tekilVeriAdet = size(tekilveriler,1);
           tekilveriler = [tekilveriler zeros(tekilVeriAdet,1)];
           for i = 1: tekilVeriAdet
                sayi = tekilveriler(i,1);
                sonucDizi = sutun == sayi;
                tekilveriler(i,2) = sum(sonucDizi);
           end
           disp(tekilveriler);
           bar(tekilveriler(:,1),tekilveriler(:,2));
           
       elseif(secim==6)
           sinifIndex = size(yeniVeri,2);
           verisayisi=size(yeniVeri,1);
           for i=1: sinifIndex
               Q1=quantile(yeniVeri(:,i),0.25);
               Q3=quantile(yeniVeri(:,i),0.75);
               IQR = iqr(yeniVeri(:,i));
               fprintf('%d. Sütun IQR : %f\n',i,IQR);                      
           end
           
       elseif(secim==7)
           sinifIndex = size(veri,2);
           verisayisi=size(veri,1);
           for i=1: sinifIndex
               degerler = [];
               x=1;
               sinifIndex = size(yeniVeri,2);
               Q1=quantile(yeniVeri(:,i),0.25);
               Q3=quantile(yeniVeri(:,i),0.75);
               alt_sinir = Q1 - (1.5* iqr(yeniVeri(:,i)));
               ust_sinir = Q3 + (1.5* iqr(yeniVeri(:,i)));
               for j=1: verisayisi
                  if yeniVeri(j,i) < alt_sinir || yeniVeri(j,i) > ust_sinir
                        degerler(x) = yeniVeri(j,i);
                        x=x+1;
                  end
               end
               tekildegerler = unique(degerler);
               
               fprintf("%d . Sütunun Aykýrý Deðerleri\n" , i);
               for m=1: length(tekildegerler)
                    fprintf('-->: %f\n', tekildegerler(m));
               end
           end
           
       elseif(secim==8)
           sinifIndex = size(veri,2);
           verisayisi=size(veri,1);
           for i=1: sinifIndex
                x =1;
                degerler =[];
                for j=1: verisayisi
                    degerler(x) = yeniVeri(j,i);
                    x = x+1;
                end   
                mini = min(degerler);
                maxi = max(degerler);
                Q1 =  quantile(degerler,0.25);
                Q3 = quantile(degerler,0.75);
                med = median(degerler);
                fprintf("\n%d . Sütun Beþ Sayý Özeti",i);
                fprintf("\nMinimum : %f\nMaximum : %f\n1. Çeyrek : %f\n3. Çeyrek : %f\nMedyan : %f\n",mini,maxi,Q1,Q3,med);
                fprintf("--------------------------------------------------------------------------");     
           end
       elseif(secim==9)
           sinifIndex = size(yeniVeri,2);
           verisayisi=size(yeniVeri,1);
           fprintf("\n[1] Bütün Sütunlarý Göster\n[2] Tek sütun Göster\n");
           secim2 = input('');
           if secim2 == 1
               boxplot(yeniVeri); title('Yeni Veri');
           
           elseif secim2 == 2
               secim3 = input('Hangi Sütun :');
               boxplot(yeniVeri(:,secim3));
           
           else
               disp("Hatalý Giris");
           end
           

           
       elseif(secim==10)
           sinifIndex = size(yeniVeri,2);
           for i=1: sinifIndex
               stdspma = std(yeniVeri(:,i));
               varyans = var(yeniVeri(:,i));
               fprintf("%d. Sütun\n",i); 
               fprintf("Standart Sapma : %f\nVaryans : %f",stdspma,varyans);
               fprintf("\n--------------------------------------------------------------------------\n"); 
           end
       elseif(secim==11)
            break;
       else
           disp("Hatalý Giris");
       end

      
end