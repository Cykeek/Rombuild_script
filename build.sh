while true; do
  read -p "Locate Your Source Folder: " SOURCE

  if [ -d "$SOURCE" ]; then
    echo "$SOURCE Folder Available!!"
    echo
    cd "$SOURCE"
    break  # Exit the loop if a valid folder is provided
  else
    echo "There is no such folder!!"
    echo
  fi
done

# Read Values from Users
# Read device_codename and buildtype
read -p "What's Your Device Name: " DEVICE
sleep 1s
echo
read -p "What Buildtype do you want to use? 1.user 2.userdebug 3.eng: " BUILDTYPE
echo
sleep 1s

# rom production function when it's going to be called!!!
ROM_PRODUCTION() {
        # Creating database for ROM build Commands
        # 1. Lineage
        # 2. AOSPA
        # 3. Evolution-X
        # 4. Pixel Experience / Pixel OS
        # 5. VoltageOS
        # 6. ProtonPlus
        # 7. OctaviOS
        # 8. HavocOS

        # Lineage Build
        LINEAGE() {
                echo "LINEAGEOS Choosen!!"
                sleep 1s
                echo
                source build/envsetup.sh
                lunch lineage_"$DEVICE"-"$BUILDTYPE"
                make bacon
        }
        # AOSPA Build
        AOSPA() {
                echo "AOSPA Choosen!!"
                sleep 1s
                echo
                source rom-build.sh "$DEVICE"
        }

        # Evolution-X Build
        EVOLUTION() {
                echo "EVOLUTION-X Choosen!!"
                sleep 1s
                echo
                source build/envsetup.sh
                lunch evolution_"$DEVICE"-"$BUILDTYPE"
                m evolution
        }

        # AOSP/Pixel Based Build
        PIXEL() {
                echo "PIXEL Choosen!!"
                sleep 1s
                echo
                source build/envsetup.sh
                lunch aosp_"$DEVICE"-"$BUILDTYPE"
                make bacon
        }

        # VoltageOS Build
        VOLTAGE() {
                echo "VoltageOS Choosen!!"
                sleep 1s
                echo
                source build/envsetup.sh
                brunch "$DEVICE"
        }

        # ProtonPlus Build
        PROTON() {
                echo "ProtonPlus Choosen!!"
                sleep 1s
                echo
                source build/envsetup.sh
                lunch "$DEVICE"-"$BUILDTYPE"
                m otapackage
        }

        # OctaviOS Build
        OCTAVI() {
                echo "OctaviOS Choosen!!"
                sleep 1s
                echo
                source build/envsetup.sh
                lunch octavi_"$DEVICE"-"$BUILDTYPE"
                brunch "$DEVICE"
        }

        # HavocOS Build
        HAVOC() {
                echo "HavocOS Choosen!!"
                sleep 1s
                echo
                source build/envsetup.sh
                brunch "$DEVICE"
        }

        banner() {
                echo "########################"
                sleep 1s
                echo "#        lineage       #"
                sleep 1s
                echo "#         aospa        #"
                sleep 1s
                echo "#       evolution      #"
                sleep 1s
                echo "#         pixel        #"
                sleep 1s
                echo "#        voltage       #"
                sleep 1s
                echo "#         proton       #"
                sleep 1s
                echo "#         octavi       #"
                sleep 1s
                echo "#         Havoc        #"
                sleep 1s
                echo "########################"
                sleep 1s
                echo  
        }
        banner

        # User choice 
        read -p "What's Your Rom Name: " ROMNAME
        message() {
                echo "Your Device Name is $DEVICE And You Choose to Build $BUILDTYPE for $ROMNAME"
                sleep 1s
                echo
        }

        # Check whether user choice is valid or not!!
        if [ "$ROMNAME" == "lineage" ]; then
                message
                LINEAGE
        elif [ "$ROMNAME" == "aospa" ]; then
                message
                AOSPA
        elif [ "$ROMNAME" == "evolution" ]; then
                message
                EVOLUTION
        elif [ "$ROMNAME" == "pixel" ]; then
                message
                PIXEL
        elif [ "$ROMNAME" == "voltage" ]; then
                message
                VOLTAGE
        elif [ "$ROMNAME" == "proton" ]; then
                message
                PROTON
        elif [ "$ROMNAME" == "octavi" ]; then
                message
                OCTAVI
        elif ["$ROMNAME" == "havoc" ]; then
                message
                HAVOC
        else
                echo "No ROM/Source found. Please ask the administrator to add it!!"
                exit 1
        fi
}

# Ask users what's he supposed to build
while true; do
  clear  # Clear the screen
  read -p "You're Building? [rom] or [recovery]: " CHOICE1

  if [ "$CHOICE1" == "rom" ]; then
    ROM_PRODUCTION
    break  # Exit the loop if "rom" is selected
  elif [ "$CHOICE1" == "recovery" ]; then
    RECOVERY_PRODUCTION
    break  # Exit the loop if "recovery" is selected
  else
    echo "Wrong option!! Please choose either 'rom' or 'recovery'."
    read -p "Press Enter to continue..."
  fi
done
