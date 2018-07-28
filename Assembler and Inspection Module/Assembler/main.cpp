#include<iostream>
#include<cstdio>
#include<cstring>
#include<cmath>
#include<cstdlib>
#include<cctype>
#include <fstream>



using namespace std;

void calc_opcode(char instr[], char opcode[]);
char calc_class(char opcode[]);
void R_filter(char opcode[], char bit_instr[],char instr[]);
void L_filter(char opcode[], char bit_instr[],char instr[]);
void J_filter(char opcode[], char bit_instr[],char instr[]);
char reg_table[32][10]={ {"$r0"}, {"$r1"}, {"$r2"}, {"$r3"}, {"$r4"}, {"$r5"}, {"$r6"}, {"$r7"},
                         {"$r8"}, {"$r9"}, {"$r10"}, {"$r11"}, {"$r12"}, {"$r13"}, {"$r14"}, {"$r15"},
                         {"$r16"}, {"$r17"}, {"$r18"}, {"$r19"}, {"$r20"}, {"$r21"}, {"$r22"}, {"$r23"},
                         {"$r24"}, {"$r25"}, {"$r26"}, {"$r27"}, {"$r28"}, {"$r29"}, {"$r30"}, {"$r31"} };
int main()
{
    ofstream myfile;
    myfile.open ("processor_instruction.txt");

    char instr[20];
    char opcode[10];
    char instr_type;
    static char bit_instr[33];
    static char out_instr[256][33];
    int i,j,k=0;
    int count = 0;
    int flag=1;
    int flaga=0;
    while(flag==1)
    {

    cout<<"Instruction "<<(k+1)<<": ";
    gets(instr);
    calc_opcode(instr,opcode); //Extracts opcode from instruction
    instr_type=calc_class(opcode);  //Calculates if r, j, i
    if(instr_type == 'R')
        R_filter(opcode,bit_instr,instr);
    else if(instr_type =='I')
        L_filter(opcode,bit_instr,instr);
    else if(instr_type =='J')
        J_filter(opcode,bit_instr,instr);
    strcpy(out_instr[k],bit_instr);
    label:
    cout<< " More instructions?(1/0):";
    cin>>flag;
    if(flag!= 1 && flag!= 0)
        goto label;
    k++;
    cin.get();
    }
    flaga=k;
    while(k<256)
    {

        strcpy(out_instr[k],"11111111111111111111111111111111");
        k++;
    }
    cout<<"\n";
    for(i=0;i<k;i++)
    {
         myfile <<out_instr[i]<<"\n";
         if(flaga>i)
         cout<<"\n"<<"    "<<out_instr[i];
    }



  myfile.close();
  cout<<"\n\n\n";
  system("pause");

 //*************    add $t0 $t1 $t2

}

void calc_opcode(char instr[20], char opcode[10])
{
    int i=0;
    for(i=0;instr[i]!=' ';i++)
    {
        opcode[i] = instr[i];
    }
    opcode[i]='\0';
}

char calc_class(char opcode[10])
{
    char instr_type;
    if(strcmpi(opcode,"add") == 0||strcmpi(opcode,"and")==0||strcmpi(opcode,"or")==0
       ||strcmpi(opcode,"xor")==0||strcmpi(opcode,"sub")==0||strcmpi(opcode,"slt")==0)
    {
        instr_type = 'R';
    }

    else if(strcmpi(opcode,"addi")==0||strcmpi(opcode,"andi")==0||strcmpi(opcode,"ori")==0
       ||strcmpi(opcode,"xori")==0||strcmpi(opcode,"slti")==0||strcmpi(opcode,"lw")==0||strcmpi(opcode,"sw")==0
       ||strcmpi(opcode,"beq")==0||strcmpi(opcode,"bne")==0)
    {
        instr_type = 'I';
    }
    else
    {
        instr_type = 'J';
    }

    return instr_type;
}

void R_filter(char opcode[10],char bit_instr[33],char instr[20])
{
    int i=0,j,k=6,m,n=0;
    char dec_temp[6];
    static char temp[10];
    for(i=0;i<6;i++)
    {
        if(strcmpi(opcode,"ADD")==0)
         strcpy(bit_instr,"000000");
        else if(strcmpi(opcode,"AND")==0)
         strcpy(bit_instr,"000001");
        else if(strcmpi(opcode,"OR")==0)
         strcpy(bit_instr,"000010");
        else if(strcmpi(opcode,"XOR")==0)
         strcpy(bit_instr,"000011");
        else if(strcmpi(opcode,"SUB")==0)
         strcpy(bit_instr,"000100");
        else if(strcmpi(opcode,"SLT")==0)
         strcpy(bit_instr,"000101");

    }

    for(i=0;instr[i]!='\0';i++)
    {
        if(instr[i]=='$')
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            for(j=0;j<32;j++)
            {
                if(strcmpi(temp,reg_table[j])==0)
                    break;
            }

            itoa (j,dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<5-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }

    }
    while(k<32)
    {
        bit_instr[k]='0';
        k++;
    }

    bit_instr[k]='\0';
    char  c[20];

    c[0]= bit_instr[6]; c[1]= bit_instr[7]; c[2]= bit_instr[8]; c[3]= bit_instr[9]; c[4]= bit_instr[10];
    //c[5]= bit_instr[11]; c[6]= bit_instr[12]; c[7]= bit_instr[13]; c[8]= bit_instr[14]; c[9]= bit_instr[15];
    bit_instr[6]=bit_instr[11]; bit_instr[7]=bit_instr[12]; bit_instr[8]=bit_instr[13]; bit_instr[9]=bit_instr[14]; bit_instr[10]=bit_instr[15];
    bit_instr[11]=bit_instr[16]; bit_instr[12]=bit_instr[17]; bit_instr[13]=bit_instr[18]; bit_instr[14]=bit_instr[19]; bit_instr[15]=bit_instr[20];
    bit_instr[16]=c[0]; bit_instr[17]=c[1]; bit_instr[18]=c[2]; bit_instr[19]=c[3]; bit_instr[20]=c[4];




}

void L_filter(char opcode[10],char bit_instr[33],char instr[20])
{
    int i=0,j,k=6,m,n=0;
    char dec_temp[30];
    static char temp[30];
    int fk=0;
    for(i=0;i<6;i++)
    {
        if(strcmpi(opcode,"ADDI")==0)
         {strcpy(bit_instr,"010000"); fk=1; }
        else if(strcmpi(opcode,"ANDI")==0)
         {strcpy(bit_instr,"010001"); fk=1; }
        else if(strcmpi(opcode,"ORI")==0)
         {strcpy(bit_instr,"010010"); fk=1; }
        else if(strcmpi(opcode,"XORI")==0)
         {strcpy(bit_instr,"010011"); fk=1; }
        else if(strcmpi(opcode,"SLTI")==0)
         {strcpy(bit_instr,"010101");fk=1; }
        else if(strcmpi(opcode,"LW")==0)
         {strcpy(bit_instr,"011111");fk=1; }
        else if(strcmpi(opcode,"SW")==0)
         {strcpy(bit_instr,"011101");fk=1; }
        else if(strcmpi(opcode,"BEQ")==0)
         strcpy(bit_instr,"110000");
        else if(strcmpi(opcode,"BNE")==0)
         strcpy(bit_instr,"110001");

    }

    for(i=0;instr[i]!='\0';i++)
    {
        if(instr[i]=='$')
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            for(j=0;j<32;j++)
            {
                if(strcmpi(temp,reg_table[j])==0)
                    break;
            }
            //temp_dec=convertDecimalToBinary(j);
            itoa (j,dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<5-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }
        else if(instr[i-1]==' '&& isdigit(instr[i]))
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            itoa (atoi(temp),dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<16-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }

    }
    while(k<32)
    {
        bit_instr[k]='0';
        k++;
    }
    bit_instr[k]='\0';

    if(fk==1)
    {
        char c[10];
        c[0] = bit_instr[6];c[1] = bit_instr[7];c[2] = bit_instr[8];c[3] = bit_instr[9];c[4] = bit_instr[10];
        bit_instr[6] =bit_instr[11];bit_instr[7] =bit_instr[12];bit_instr[8] =bit_instr[13];bit_instr[9] =bit_instr[14];bit_instr[10] =bit_instr[15];
        bit_instr[11]=c[0];bit_instr[12]=c[1];bit_instr[13]=c[2];bit_instr[14]=c[3];bit_instr[15]=c[4];
    }


}

void J_filter(char opcode[10],char bit_instr[33],char instr[20])
{
    int i=0,j,k=6,m,n=0;
    char dec_temp[30];
    static char temp[10];
    for(i=0;i<6;i++)
    {
        if(strcmpi(opcode,"J")==0)
         strcpy(bit_instr,"110010");

    }

    for(i=0;instr[i]!='\0';i++)
    {
        if(instr[i-1]==' '&& isdigit(instr[i]))
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            itoa (atoi(temp),dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<26-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }


    }
    while(k<32)
    {
        bit_instr[k]='0';
        k++;
    }
    bit_instr[k]='\0';


}

/*
#include<iostream>
#include<cstdio>
#include<cstring>
#include<cmath>
#include<cstdlib>
#include<cctype>
#include <fstream>



using namespace std;

void calc_opcode(char instr[], char opcode[]);
char calc_class(char opcode[]);
void R_filter(char opcode[], char bit_instr[],char instr[]);
void L_filter(char opcode[], char bit_instr[],char instr[]);
void J_filter(char opcode[], char bit_instr[],char instr[]);
char reg_table[32][10]={ {"$r0"}, {"$r1"}, {"$r2"}, {"$r3"}, {"$r4"}, {"$r5"}, {"$r6"}, {"$r7"},
                         {"$r8"}, {"$r9"}, {"$r10"}, {"$r11"}, {"$r12"}, {"$r13"}, {"$r14"}, {"$r15"},
                         {"$r16"}, {"$r17"}, {"$r18"}, {"$r19"}, {"$r20"}, {"$r21"}, {"$r22"}, {"$r23"},
                         {"$r24"}, {"$r25"}, {"$r26"}, {"$r27"}, {"$r28"}, {"$r29"}, {"$r30"}, {"$r31"} };
int main()
{
    ofstream myfile;
    myfile.open ("processor_instruction.txt");

    char instr[20];
    char opcode[10];
    char instr_type;
    static char bit_instr[33];
    static char out_instr[256][33];
    int i,j,k=0;
    int count = 0;
    int flag=1;
    int flaga=0;
    while(flag==1)
    {

    cout<<"\n Instruction "<<(k+1)<<": ";
    gets(instr);
    calc_opcode(instr,opcode); //Extracts opcode from instruction
    instr_type=calc_class(opcode);  //Calculates if r, j, i
    if(instr_type == 'R')
        R_filter(opcode,bit_instr,instr);
    else if(instr_type =='I')
        L_filter(opcode,bit_instr,instr);
    else if(instr_type =='J')
        J_filter(opcode,bit_instr,instr);
    strcpy(out_instr[k],bit_instr);
    label:
    cout<< "  More instructions?(1/0):";
    cin>>flag;
    if(flag!= 1 && flag!= 0)
        goto label;
    k++;
    cin.get();
    }
    flaga=k;
    while(k<256)
    {

        strcpy(out_instr[k],"00000000000000000000000000000000");
        k++;
    }
    cout<<"\n";
    for(i=0;i<k;i++)
    {
         myfile <<out_instr[i]<<"\n";
         if(flaga>i)
         cout<<"\n"<<"    "<<out_instr[i];
    }



  myfile.close();
  cout<<"\n\n\n";
  system("pause");

 //*************    add $t0 $t1 $t2

}

void calc_opcode(char instr[20], char opcode[10])
{
    int i=0;
    for(i=0;instr[i]!=' ';i++)
    {
        opcode[i] = instr[i];
    }
    opcode[i]='\0';
}

char calc_class(char opcode[10])
{
    char instr_type;
    if(strcmpi(opcode,"add") == 0||strcmpi(opcode,"and")==0||strcmpi(opcode,"or")==0
       ||strcmpi(opcode,"xor")==0||strcmpi(opcode,"sub")==0||strcmpi(opcode,"slt")==0)
    {
        instr_type = 'R';
    }

    else if(strcmpi(opcode,"addi")==0||strcmpi(opcode,"andi")==0||strcmpi(opcode,"ori")==0
       ||strcmpi(opcode,"xori")==0||strcmpi(opcode,"slti")==0||strcmpi(opcode,"lw")==0||strcmpi(opcode,"sw")==0
       ||strcmpi(opcode,"beq")==0||strcmpi(opcode,"bne")==0)
    {
        instr_type = 'I';
    }
    else
    {
        instr_type = 'J';
    }

    return instr_type;
}

void R_filter(char opcode[10],char bit_instr[33],char instr[20])
{
    int i=0,j,k=6,m,n=0;
    char dec_temp[6];
    static char temp[10];
    for(i=0;i<6;i++)
    {
        if(strcmpi(opcode,"ADD")==0)
         strcpy(bit_instr,"000000");
        else if(strcmpi(opcode,"AND")==0)
         strcpy(bit_instr,"000001");
        else if(strcmpi(opcode,"OR")==0)
         strcpy(bit_instr,"000010");
        else if(strcmpi(opcode,"XOR")==0)
         strcpy(bit_instr,"000011");
        else if(strcmpi(opcode,"SUB")==0)
         strcpy(bit_instr,"000100");
        else if(strcmpi(opcode,"SLT")==0)
         strcpy(bit_instr,"000101");

    }

    for(i=0;instr[i]!='\0';i++)
    {
        if(instr[i]=='$')
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            for(j=0;j<32;j++)
            {
                if(strcmpi(temp,reg_table[j])==0)
                    break;
            }

            itoa (j,dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<5-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }

    }
    while(k<32)
    {
        bit_instr[k]='0';
        k++;
    }

    bit_instr[k]='\0';


}

void L_filter(char opcode[10],char bit_instr[33],char instr[20])
{
    int i=0,j,k=6,m,n=0;
    char dec_temp[30];
    static char temp[30];
    for(i=0;i<6;i++)
    {
        if(strcmpi(opcode,"ADDI")==0)
         strcpy(bit_instr,"010000");
        else if(strcmpi(opcode,"ANDI")==0)
         strcpy(bit_instr,"010001");
        else if(strcmpi(opcode,"ORI")==0)
         strcpy(bit_instr,"010010");
        else if(strcmpi(opcode,"XORI")==0)
         strcpy(bit_instr,"010011");
        else if(strcmpi(opcode,"SLTI")==0)
         strcpy(bit_instr,"010101");
        else if(strcmpi(opcode,"LW")==0)
         strcpy(bit_instr,"011111");
        else if(strcmpi(opcode,"SW")==0)
         strcpy(bit_instr,"011101");
        else if(strcmpi(opcode,"BEQ")==0)
         strcpy(bit_instr,"110000");
        else if(strcmpi(opcode,"BNE")==0)
         strcpy(bit_instr,"110001");

    }

    for(i=0;instr[i]!='\0';i++)
    {
        if(instr[i]=='$')
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            for(j=0;j<32;j++)
            {
                if(strcmpi(temp,reg_table[j])==0)
                    break;
            }
            //temp_dec=convertDecimalToBinary(j);
            itoa (j,dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<5-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }
        else if(instr[i-1]==' '&& isdigit(instr[i]))
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            itoa (atoi(temp),dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<16-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }

    }
    while(k<32)
    {
        bit_instr[k]='0';
        k++;
    }
    bit_instr[k]='\0';


}

void J_filter(char opcode[10],char bit_instr[33],char instr[20])
{
    int i=0,j,k=6,m,n=0;
    char dec_temp[30];
    static char temp[10];
    for(i=0;i<6;i++)
    {
        if(strcmpi(opcode,"J")==0)
         strcpy(bit_instr,"110010");

    }

    for(i=0;instr[i]!='\0';i++)
    {
        if(instr[i-1]==' '&& isdigit(instr[i]))
        {
            j=i;
            while(instr[j]!=' ')
            {
                temp[j-i]=instr[j];
                j++;
            }
            temp[j]='\0';
            itoa (atoi(temp),dec_temp,2);
            m=0;n=0;
            while(dec_temp[m]!='\0')
            {
                m++;
            }
            while(n<26-m)
            {
                bit_instr[k] = '0';
                n++;
                k++;
            }
            n=0;

            while(n<m)
            {
                bit_instr[k]=dec_temp[n];
                n++;
                k++;
            }

        }


    }
    while(k<32)
    {
        bit_instr[k]='0';
        k++;
    }
    bit_instr[k]='\0';


}
*/
