{ pkgs }:
pkgs.writeShellScriptBin "testme" ''
echo $(lsblk) >block-devices.txt

for i in $(seq 0 11); do
    echo "nvme''${i}n1: $(cat /sys/block/nvme''${i}n1/device/serial)" >> nvme-serials.txt
done

echo $(zpool status) > zpool-status.txt

echo $(mc admin info minio) > minio-status.txt

''