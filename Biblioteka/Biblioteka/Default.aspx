<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Biblioteka._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-md-12">
            <h2>Wyszukiwanie</h2>
            <div class="col-md-4 input-group">
                Kategorie:<br />
                  <select name="cars">
                    <option value="volvo">Volvo</option>
                    <option value="saab">Saab</option>
                    <option value="fiat">Fiat</option>
                    <option value="audi">Audi</option>
                  </select>

            </div>
            <div class="col-md-4 input-group">
                Wybierz co chcesz szukać:<br />
                <select name="selectfield">
                    <option value="tytul">Tytul</option>
                    <option value="autor">Autor</option>
                  </select>            
            </div> 
            <div class="col-md-4 input-group">
                Wyszukiwanie:
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Szukaj">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="button">Szukaj</button>
                    </span>
                </div>
            </div>            
        </div>
    </div>

</asp:Content>
