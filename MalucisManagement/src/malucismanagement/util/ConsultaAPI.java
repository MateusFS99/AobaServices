package malucismanagement.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

public class ConsultaAPI {
    
    public static String consultaCep(String cep) {
        
        StringBuilder dados = new StringBuilder();
        
        try {
            
            URL url = new URL("http://apps.widenet.com.br/busca-cep/api/cep.json?code=" + cep);
            URLConnection con = url.openConnection();
            
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setAllowUserInteraction(false);
            con.addRequestProperty("User-Agent", "Mozilla");
            
            InputStream in = con.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(in));
            String s = "";
            
            while (null != (s = br.readLine()))
                 dados.append(s);
            br.close();
        }
        catch (Exception ex) {
            System.out.println(ex);
        }
        
        return dados.toString();
    } 
}