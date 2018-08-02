Return-Path: <wgh@torlan.ru>
To: axboe@kernel.dk, idryomov@gmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 sagi@grimberg.me
From: WGH <wgh@torlan.ru>
Subject: LVM snapshot broke between 4.14 and 4.16
Message-ID: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
Date: Thu, 2 Aug 2018 15:26:13 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

(I originally reported this problem here:
https://bugzilla.kernel.org/show_bug.cgi?id=200439)

When I updated from 4.14 to 4.16, my LVM snapshotting script broke for
no apparent reason.

My script has the following line, and it fails like this:
+ lvcreate --size 5G --snapshot --name snap0 --permission r
/dev/mapper/vg0-lvol_rootfs
  device-mapper: create ioctl on
vg0-snap0-cowLVM-sDdIeh9cecWdaNyRfZC31mxgfwTa4sOeHMJXVOykGVRtfP6Aii7IHvwS066AOLOM-cow
failed: Device or resource busy
  Failed to lock logical volume vg0/lvol_rootfs.
  Aborting. Manual intervention required.

At the same time, some errors appear in dmesg as well:
[   26.145279] generic_make_request: Trying to write to read-only
block-device dm-3 (partno 0)
[   26.145288] device-mapper: persistent snapshot: write_header failed
[   26.145847] device-mapper: table: 253:4: snapshot: Failed to read
snapshot metadata
[   26.145851] device-mapper: ioctl: error adding target to table

I bisected the vanilla kernel, and the first bad commit is
[721c7fc701c71f693307d274d2b346a1ecd4a534] block: fail op_is_write()
requests to read-only partitions
