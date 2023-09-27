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
        read -p "What Buildtype do you want to use? [user] , [userdebug] [eng]: " BUILDTYPE
        echo
        sleep 1s
        message() {
                echo "Your Device Name is $DEVICE And You Choose $BUILDTYPE for $ROMNAME"
                sleep 1s
                echo
        }

        while true; do
                read -p "What's Your Rom Name: " ROMNAME
                echo

                # Check whether user choice is valid or not!!
                if [ "$ROMNAME" == "lineage" ]; then
                        clear
                        message
                        LINEAGE
                        break
                elif [ "$ROMNAME" == "aospa" ]; then
                        clear
                        message
                        AOSPA
                        break
                elif [ "$ROMNAME" == "evolution" ]; then
                        clear
                        message
                        EVOLUTION
                        break
                elif [ "$ROMNAME" == "pixel" ]; then
                        clear
                        message
                        PIXEL
                        break
                elif [ "$ROMNAME" == "voltage" ]; then
                        clear
                        message
                        VOLTAGE
                        break
                elif [ "$ROMNAME" == "proton" ]; then
                        clear
                        message
                        PROTON
                        break
                elif [ "$ROMNAME" == "octavi" ]; then
                        clear
                        message
                        OCTAVI
                        break
                elif [ "$ROMNAME" == "havoc" ]; then
                        clear
                        message
                        HAVOC
                        break
                else
                        echo "No ROM/Source found. Please ask the administrator to add it!!"
                        echo
                fi
        done
}

RECOVERY_PRODUCTION() {

        echo "You Choosen Recovery building!!"
        sleep 1s
        clear

        while true; do
        read -p "Enter your choice (1 for boot.img, 2 for vendor_boot.img, 3 for recovery.img): " OPTIONS

                if [ "$OPTIONS" = "1" ]; then
                        echo "boot.img is in Process!!"
                        sleep 1s
                        TWRP
                        mka bootimage
                        clear
                        break  # Exit the loop if a valid option is provided
                elif [ "$OPTIONS" = "2" ]; then
                        echo "vendor_boot.img is in Process!!"
                        sleep 1s
                        TWRP
                        mka vendorbootimage
                        clear
                        break  # Exit the loop if a valid option is provided
                elif [ "$OPTIONS" = "3" ]; then
                        echo "Recovery.img is in Process!!"
                        sleep 1s
                        TWRP
                        mka recoveryimage
                        clear
                        break  # Exit the loop if a valid option is provided
                else
                        echo "Wrong Option!! Please enter 1, 2, or 3."
                        echo
                fi
        done


        # Creating database for recovery
        # 1. TWRP
        # 2. Orangefox
        # 3. PitchBlack

        TWRP() {
                export ALLOW_MISSING_DEPENDENCIES=true;
                source build/envsetup.sh;
                lunch twrp_$DEVICE-eng
        }

        ORANGEFOX() {
                export ALLOW_MISSING_DEPENDENCIES=true;
                source build/envsetup.sh;
                lunch omni_$DEVICE-eng
        }

        PITCHBLACK() {
                export ALLOW_MISSING_DEPENDENCIES=true;
                source build/envsetup.sh;
                lunch omni_$DEVICE-eng
        }
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
