Return-Path: <linux-scsi-owner@vger.kernel.org>
To: linux-raid@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, kernel@gpiccoli.net
In-Reply-To: 
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Should a raid-0 array immediately stop if a component disk is
 removed?
Message-ID: <301f2a37-81ea-938b-3bd1-947f716c0f63@canonical.com>
Date: Fri, 27 Apr 2018 18:49:21 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hello, we've noticed an interesting behavior when using a raid-0 md
array. Suppose we have a 2-disk raid-0 array that has a mount point
set - in our tests, we've used ext4 filesystem. If we remove one of
the component disks via sysfs[0], userspace is notified, but mdadm tool
fails to stop the array[1] (it cannot open the array device node with
O_EXCL flag, hence it fails to issue the STOP_ARRAY ioctl). Even if we
circumvent the mdadm O_EXCL open, md driver will fail to execute the
ioctl given the array is mounted.

As a result, the array keeps mounted and we can even read/write from
it, although it's possible to observe filesystem errors on dmesg[2].
Eventually, after some _minutes_, the filesystem gets remounted as
read-only.

During this weird window in which the array had a component disk removed
but is still mounted/active (and accepting read/writes), we tried to
perform reads and writes and sync command, which "succeed" (meaning the
commands themselves didn't fail, although the errors were observed in
dmesg). When "dd" was executed with "oflag=direct", the writes failed
immediately. This was observed with both nvme and scsi disks composing
the raid-0 array.

We've started to pursue a solution to this, which seems to be an odd
behavior. But worth to check in the CC'ed lists if perhaps this is "by
design" or if it was already discussed in the past (maybe an idea was
proposed). Tests were executed with v4.17-rc2 and upstream mdadm tool.

Thanks in advance,


Guilherme


[0] To remove the array component disk, we've used:

a) For nvme: "echo 1 > /sys/block/nvme0n1/device/device/remove"
b) For scsi: "echo 1 > /sys/block/sda/device/delete"


[1] mdadm tool tries to fail the array by executing: "mdadm -If
<component_block_device>"


[2] Example:
[...]
[88.719] Buffer I/O error on device md0, logical block 157704
[88.722] Buffer I/O error on device md0, logical block 157705
[88.725] EXT4-fs warning (device md0): ext4_end_bio:323: I/O error 10
writing to inode 14 (offset 0 size 8388608 starting block 79744)
[88.725] EXT4-fs warning (device md0): ext4_end_bio:323: I/O error 10
writing to inode 14 (offset 0 size 8388608 starting block 80000)
[...]
