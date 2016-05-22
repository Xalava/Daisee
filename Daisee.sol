contract Daisee {

    Usager[] public usagers;
    uint public currentTime;
    uint prixKwh;

    /* Contributeurs */
    struct Usager {
        address addr;
        uint[] conso;
        uint[] prod;
        uint[] disponible;

        string nom;
        uint credit;
    }

    /*  Initialisation */
    function Daisee() {
        currentTime = 0;
    }   


    function () {
        bool trouve=false;

        for (uint i = 0; i < contributors.length; ++i) {
            if(usagers[i].addr == msg.sender){
                usagers[i].credit = usagers[i].credit + msg.value;
                trouve=true;
            }
        }  
        if(trouve){

        }else {
            throw;
        }

    }

    function sajouterUsager(
        string name
        ) {

        usagers[usagers.length++] = Usager({addr: msg.sender, credit: msg.value, nom: name});
        for (uint i = 0; i < currentTime; ++i) {
            usagers[usagers.length].conso[i]=0;  
            usagers[usagers.length].prod[i]=0;
            usagers[usagers.length].disponible[i]=0;
        } 
    }

    function publier(uint consoActuelle, uint prodActuelle) {
        prodDiff = prodActuelle - consoActuelle;
        address vendeur;
        bool trouve;

        for (uint i = 0; i < usagers.length; ++i) {
            if(usagers[i].addr == msg.sender){
                usagers[i].conso[currentTime] = consoActuelle;
                usagers[i].prod[currentTime] = prodActuelle;

                if(prodDiff>0){
                    usagers[i].disponible[currentTime] = prodDiff;
                } else {
                    for (uint j = 0; j < usagers.length; ++j) {
                        if(usagers[j].disponible[currentTime-1]>= prodDiff){
                            vendeur = usagers[j].addr;
                            trouve = true;
                        }
                    }
                    if(trouve){
                        usagers[j].disponible[currentTime-1] -= prodDiff;
                        usagers[j].credit +=  prodDiff * prixKwh;
                        usagers[i].credit -=  prodDiff * prixKwh;

                    }else{
                        /*Acheter hors reseau ou tenter achat par fractions*/
                    }


                }

            }
        } 



    }

}