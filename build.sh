# Locate Source Folder
read -p "Locate Your Source Folder: " SOURCE

# Checking User folder is present or not
if [ -d "$SOURCE" ]; then
        echo "$SOURCE Folder Available!!"
        cd "$SOURCE"
else
        echo "There is no such folder!!"
        exit 1
fi

# Creating database for ROM build Commands
# 1. Lineage
# 2. AOSPA
# 3. Evolution-X
# 4. Pixel Experience / Pixel OS
# 5. VoltageOS
LINEAGE() {
  echo "LINEAGEOS Choosen!!"
  source build/envsetup.sh
  lunch lineage_"$DEVICE"-"$BUILDTYPE"
  make bacon
}

AOSPA() {
  echo "AOSPA Choosen!!"
  source rom-build.sh "$DEVICE"
}

EVOLUTION() {
  echo "EVOLUTION-X Choosen!!"
  source build/envsetup.sh
  lunch evolution_"$DEVICE"-"$BUILDTYPE"
  m evolution
}

PIXEL() {
  echo "PIXEL Choosen!!"
  source build/envsetup.sh
  lunch aosp_"$DEVICE"-"$BUILDTYPE"
  make bacon
}

VOLTAGE() {
  echo "VoltageOS Choosen!!"
  source build/envsetup.sh
  brunch "$DEVICE"
}

PROTON() {
  echo "ProtonPlus Choosen!!"
  source build/envsetup.sh
  lunch "$DEVICE"-"$BUILDTYPE"
  m otapackage
}

read -p "What's Your Device Name: " DEVICE
sleep 1s
echo
read -p "What Buildtype do you want to use? 1.user 2.userdebug 3.eng: " BUILDTYPE
echo
sleep 1s
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
echo "########################"
sleep 1s
echo

read -p "What's Your Rom Name: " ROMNAME

# Check for user choice
if [ "$ROMNAME" == "lineage" ]; then
        LINEAGE
elif [ "$ROMNAME" == "aospa" ]; then
        AOSPA
elif [ "$ROMNAME" == "evolution" ]; then
        EVOLUTION
elif [ "$ROMNAME" == "pixel" ]; then
        PIXEL
elif [ "$ROMNAME" == "voltage" ]; then
        VOLTAGE
elif [ "$ROMNAME" == "proton" ]; then
        PROTON
else
        echo "No ROM/Source found. Please ask the administrator to add it!!"
fi
