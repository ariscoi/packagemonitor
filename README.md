# PackageMonitor

<h3>Prezentare generala</h3> </br>
    Script-ul este format din 2 componente: 
<h4>1. Monitor </h4></br>
    Parseaza si organizeaza informatiile din fisierul /var/log/dpkg.log </br>
<h4>2. Frontend </h4></br>
    Reprezinta user interface-ul programului, oferind mai multe functionalitati. </br> 
    
<h2>Functionalitati</h2> </br>
<h4>1. Lista pachetelor curent instalate</h4> </br>
Afiseasa numele tuturor pachetelor instalate la momentul actual. </br>
<h4>2. Lista pachetelor sterse</h4> </br>
Afiseaza numele tuturor pachetelor sterse pana la momentul actual. </br>
<h4>3. Istoricul unui pachet</h4> </br>
Afiseaza istoricul operatiilor de install si remove al unui pachet specific. </br>
<h4>4. Operatii dintr-un interval de timp </h4> </br>
Afiseaza o lista cu toate pachetele instalate si sterse intr-un interval de timp specificat de utilizator. </br>

<h2> Setup </h2> </br> 
<h4> Configurati Cron pentru o executie periodica a monitorului.</h4> </br>
` crontab -e * * * * * /monitor.sh ` </br>
<h4> Rulati scriptul Front-End </h4> </br>
`./frontend.sh`
