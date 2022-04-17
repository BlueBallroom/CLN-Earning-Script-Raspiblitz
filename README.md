# CLN-Earning-Script-Raspiblitz
Core Lightning (previously c-lightning) Earning Script for [Raspiblitz](https://github.com/rootzoll/raspiblitz).

When using Core Lightning in conjunction with the CLBOSS autpilot under Raspiblitz, this script will gather relevant information about the node's proftability.
It accounts for earnings and expenditures (caused by automatic rebalancing iniatiated by CLBOSS). It then prints out the net profit.

## Installation
Copy the earning.sh file into the directory
     
    /home/bitcoin
    
Make the file executable

    sudo chmod a+x earning.sh

## Operation
    
Run the script within the same directory

    sudo -u bitcoin ./earning.sh
