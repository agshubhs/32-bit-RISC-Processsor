#include <iostream>
#include <bitset>
#include<fstream>
#include<cstdio>
#include<cstring>
#include<cstdlib>
#include<cctype>
using namespace std;
int main()

{

//To print the entries of 	register
		ifstream regFile("reg_data.txt");
		string regline;
		int n=0, flag=0;
		string err= "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";



		while ((getline(regFile,regline))/*&&(n<4)*/)
		{
                if(err.compare(regline)){
				cout<<"reg "<<n<<" content is "<<regline<<endl;

				string binary=regline;
		   	    unsigned long decimal = bitset<32>(binary).to_ulong();//binary to decimal
		    	cout<<"value of reg "<<n<<" is " <<decimal<<"\n";}
		    	n++;
		}
	cout<<"\n"<<"That concludes the contents of the register file. All other Registers are unused"<<"\n"<<"\n"<<endl;

		cout<<"Following are the contents of Data_Memory"<<"\n"<<endl;

//following code to print the values of each entry in data file.

	    ifstream dataFile("data_mem.txt");
		string Dataline;
		int n2=0;


		while (getline(dataFile, Dataline))
		{


				string binary=Dataline;
		   	    unsigned long decimal = bitset<32>(binary).to_ulong();//binary to decimal
		   	    if (!decimal)
		   	    {
		   	    	flag=1;
		   	    }
		   	    else{
				cout<<"Data_Memory "<<n2<<" content is "<<Dataline<<endl;
		    	cout<<"Data corresponds to integer " <<decimal<<"\n";
		    	}
		    	 flag=1;
		    	n2++;

		}
				if (flag)
				{
					cout<<"\n"<<"All other entries are 0 "<<"\n"<<endl;
				}
	    		cout<<"\n"<<"That concludes the contents of the Data_Memory "<<endl;

        system("pause");
	    return 0;

}
