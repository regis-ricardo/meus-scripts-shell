#!/bin/bash

#SCRIPT CRIADO Régis Almeida Ricardo#


DIRORI="/nfs"
DIRDEST=/backup/NFS_DIF
BKP_NAME="BKP_NFS_DIF.tar.gz"
DATA=`date +%d-%m-%Y-%H%M`
DATAIN=`date +%d-%m-%Y-%H%M`
DATAFIN=`date +%d-%m-%Y-%H%M`
TIME=-1380


cd $DIRDEST


#### Procura as últimas alterações de 23:50 horas atrás faz o backup e compacta #############

find $DIRORI -type f -cmin $TIME -exec tar -rvf $BKP_NAME.$DATA {} ";"

#############################################################################################


### Envia e-mail do Backup ###########################################
   
LOG_DEST="/backup/log/"
LOG="backup_nfs_diferencial.log"
LOGTAR="info_backup_dif.log"

/bin/echo "To: regis.ricardo@ios.com.br " >> $LOG_DEST/$LOG.$DATA
/bin/echo "Subject: Rotina de Backup Diario" $DATA >> $LOG_DEST/$LOG.$DATA
/bin/echo "" >> $LOG_DEST/$LOG.$DATA
/bin/echo "=============================================" >> $LOG_DEST/$LOG.$DATA
/bin/echo "Inicio do Backup " >> $LOG_DEST/$LOG.$DATA
/bin/echo `date`  >> $LOG_DEST/$LOG.$DATA
/bin/echo "Final do Backup " >> $LOG_DEST/$LOG.$DATA
/bin/echo `date`  >> $LOG_DEST/$LOG.$DATA
/bin/echo "Nome do arquivo" >> $LOG_DEST/$LOG.$DATA
/bin/echo $BKP_NAME.$DATA.tar.gz >> $LOG_DEST/$LOG.$DATA
/bin/echo "Volume copiado para /backup/NFS_DIF" >> $LOG_DEST/$LOG.$DATA
/bin/echo "Tamanho:" `du -sh $BKP_NAME.$DATA` >> $LOG_DEST/$LOG.$DATA
/bin/echo "==============================================" >> $LOG_DEST/$LOG.$DATA


tar -tvf $BKP_NAME.$DATA >> $LOG_DEST/$LOGTAR.$DATA


#ssmtp regis.ricardo@ios.com.br < $LOG_DEST/$LOG.$DATA


########################################################################





