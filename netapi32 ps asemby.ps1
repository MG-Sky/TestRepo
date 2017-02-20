Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;

public class NetShareMG 
{ 
    [DllImport("Netapi32.dll",CharSet=CharSet.Unicode)] 
    public static extern UInt32 NetValidateName(string lpServer,string lpName,string lpAccount,string lpPassword, 
    int NameType); 
} 
"@



[netsharemg]::NetValidateName


netapi32 poszyukac info jak zwlidowac acl i s permissions
