#include<iostream>
#include<cstdlib>
using namespace std;

int main(){

    int numero;
    do{
    cout<<"Digite un numero: "; cin>>numero; 
    }while((numero<1) || (numero>10)); 
    
    for(int i=1;i<=20;i++){
        cout<<"\n"<<numero<<"*"<<i<<"="<<numero*i<<endl;
    }
    
    cout<<"\n\n";
    system("pause");
    return 0;
}