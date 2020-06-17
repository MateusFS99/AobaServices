/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package malucismanagement.db.dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import malucismanagement.db.banco.Banco;
import malucismanagement.db.entidades.ListaEscola;
import malucismanagement.db.entidades.ListaItens;

/**
 *
 * @author HITRON
 */
public class DALListaMateriais 
{
    
    public List<ListaEscola> get(String filtro)
    {
        String sql = "SELECT * FROM Cliente c RIGHT JOIN listaescola l ON c.cli_id = l.cli_id";
        
        if(!filtro.isEmpty())
            sql += " WHERE " + filtro;
        
        List <ListaEscola> aux = new ArrayList();
        ResultSet rs = Banco.getCon().consultar(sql);
        
        try {
            
            while(rs.next())
            {
                aux.add(new ListaEscola(rs.getInt("lis_cod"), rs.getString("cli_nome"), rs.getString("lis_serie"), rs.getString("lis_desc"), rs.getDouble("lis_total")));
            }     
        } 
        catch (SQLException ex) {}
        
        return aux;
    }
    
    public ListaEscola getEscolaProdutos(int cod)
    {
        ListaEscola aux = null;
        
        String sql = "SELECT * FROM ListaEscola l INNER JOIN cliente c ON l.cli_id = c.cli_id WHERE l.lis_cod = '" +cod+ "'";
        
        ResultSet rs = Banco.getCon().consultar(sql);
        
        try
        {
            if(rs.next())
                aux = new ListaEscola(rs.getInt("lis_cod"), rs.getString("cli_nome"), 
                        rs.getString("lis_serie"), 
                        rs.getString("lis_desc"), rs.getString("cli_id"), 
                        rs.getDouble("lis_total"), rs.getDate("lis_data"));
        }
        catch(SQLException ex){}
        
        sql = "SELECT * FROM  listaescola le INNER JOIN listamateriais lm ON lm.lis_cod = le.lis_cod "
                + "INNER JOIN produto p ON lm.pro_cod = p.pro_cod WHERE le.lis_cod = "+cod+"";
        
        rs = Banco.getCon().consultar(sql);
        ArrayList<ListaItens> prod = new ArrayList<>();
        try
        {
            if(rs.next())
                prod.add(new ListaItens(rs.getInt("lis_quantidade"), rs.getInt("pro_cod"), rs.getString("pro_nome")));
        }
        catch(SQLException ex){}
        
        if(aux != null)
            aux.setProdutos(prod);
        
        return aux;
    }
    
    public boolean salvar(ListaEscola escola) throws SQLException
    {
        boolean b = true;
        
        try
        {
            Banco.getCon().getConnect().setAutoCommit(false);
            
            String sql;
            
            sql = "INSERT INTO listaescola (cli_id, lis_data, lis_serie, lis_anoreferencia)"
                    + "VALUES ('#1', current_date, '#2', date_trunc('year',current_date))";
            
            sql = sql.replaceAll("#1",escola.getCnpj());
            sql = sql.replaceAll("#2",escola.getSerie());
            
            try{
                //p.executeUpdate();
                Banco.getCon().manipular(sql);
            }
            catch(Exception e)
            {
                b = false;
                System.out.println(e);
            }
            
            int id = Banco.getCon().getMaxPK("listaescola", "lis_cod");

            try
            {
                //laço para insert dos itens da comanda
                //caso deu erro: ok=false;
                for (ListaItens item : escola.getProdutos()) 
                {
                    sql = "INSERT INTO listamateriais (lis_cod,pro_cod,lis_quantidade)"
                            + "VALUES (#1,#2,#3)";
                    sql = sql.replace("#1",""+id);
                    sql = sql.replace("#2",""+item.getCodigo());
                    sql = sql.replace("#3",""+item.getQuantidade());
                    Banco.getCon().manipular(sql);
                }   
            }
            catch(Exception e)
            {
                b = false;
            }
            
        }
        catch(SQLException ex)
        {
            System.out.println(ex);
            b = false;
        }
        
        if(b)
            Banco.getCon().getConnect().commit();
        else
            Banco.getCon().getConnect().rollback();
        
        return b;
    }
    
    public boolean alterar(ListaEscola escola) throws SQLException
    {
        boolean b = true;
        
        try
        {
            Banco.getCon().getConnect().setAutoCommit(false);
            
            String sql;
            
            sql = "UPDATE listaescola SET lis_serie = '#1' WHERE lis_cod = "+escola.getCodigo()+"";
            
            sql = sql.replaceAll("#1",escola.getSerie());
            
            try
            {
                Banco.getCon().manipular(sql);
            }
            catch(Exception e)
            {
                b = false;
                System.out.println(e);
            }
            
            sql = "DELETE FROM listamateriais WHERE lis_cod = "+escola.getCodigo()+"";
            
            try
            {
                Banco.getCon().manipular(sql);
            }
            catch(Exception e)
            {
                b = false;
                System.out.println(e);
            }
            
            try
            {
                for (ListaItens item : escola.getProdutos()) 
                {
                    sql = "INSERT INTO listamateriais (lis_cod,pro_cod,lis_quantidade)"
                            + "VALUES (#1,#2,#3)";
                    sql = sql.replace("#1",""+escola.getCodigo());
                    sql = sql.replace("#2",""+item.getCodigo());
                    sql = sql.replace("#3",""+item.getQuantidade());
                    Banco.getCon().manipular(sql);
                }   
            }
            catch(Exception e)
            {
                b = false;
            }
            
        }
        catch(SQLException ex)
        {
            System.out.println(ex);
            b = false;
        }
        
        if(b)
            Banco.getCon().getConnect().commit();
        else
            Banco.getCon().getConnect().rollback();
        
        return b;
    }
}
