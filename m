Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CEE2F2D
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412684; cv=none; b=CkLPgj4VYe8459Ri0t9F2FQhmvC/FSzTWthREooElTqpoq/4nc81iw0RN3a8w37FvyImX31/1O9UQVSOMEWJTx+Td4B9DaOk4AyYhuFmQwL2Idu/Vk5atZyUnS5FSmwt+JvGck9DT9wscr2ycFwZBhdzhYR2C+9TOv4XwUZeqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412684; c=relaxed/simple;
	bh=bziIAjADg4HXEJzvUHPvf0bvej+JDFZ8gRajvRoPKEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdOoBHmfKIY6btu7H/toFM7utw8JEr8slwvS7Mcvl4811l8gjqXJvwpRsDJ3v2BPqRsEBK0Gm2Nys5zb/zZfpcdyYRbrkk+xuMDcBqfzQ0+4cCElVLmxzZ+tIzM2ooTtpF+PXBWcXo/o/CUeX4wypxACp7yVf+54jRo14CQ5axg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzMHT1jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzMHT1jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF07C4CEDF;
	Thu,  9 Jan 2025 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736412684;
	bh=bziIAjADg4HXEJzvUHPvf0bvej+JDFZ8gRajvRoPKEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzMHT1jcfErHnuKsV+KE7ahDcV22fB1OiTMSenYok9iZNZg6e3xnnWPBXcXeFAhFs
	 HYAMcu7fZsHFhGDDnvV3tEGZjEyeOg2IqIDiCzdyrvcFxotHd9nsiXMzu2Qc0V6/xj
	 R/yPeiVCyBYnTAU40MKPrG5J1CwQDp0VMnN86tnfSC55F0I0Mru6yQGWIo5sZszLJ0
	 rOM4laJhKnhJ5f8G52+FaleLmwFP6JR5w0If+VRjf04DtKXF2lWCXdAqLW2w9w62Q/
	 H20kml/CEWE3eiOTQiUc7b8AH0u6bgl83AQpBLgJU17btR20sd751UeCzTfAtMkC5U
	 cNbmTA19vDBdg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/2] Documentation: Document the new zoned loop block device driver
Date: Thu,  9 Jan 2025 17:50:37 +0900
Message-ID: <20250109085037.407926-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109085037.407926-1-dlemoal@kernel.org>
References: <20250109085037.407926-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the zoned_loop.rst documentation file under
admin-guide/blockdev to document the zoned loop block device driver.
An overview of the driver is provided and its usage to create and delete
zoned devices described.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/admin-guide/blockdev/index.rst  |   1 +
 .../admin-guide/blockdev/zoned_loop.rst       | 168 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/block/Kconfig                         |   3 +
 4 files changed, 173 insertions(+)
 create mode 100644 Documentation/admin-guide/blockdev/zoned_loop.rst

diff --git a/Documentation/admin-guide/blockdev/index.rst b/Documentation/admin-guide/blockdev/index.rst
index 957ccf617797..3262397ebe8f 100644
--- a/Documentation/admin-guide/blockdev/index.rst
+++ b/Documentation/admin-guide/blockdev/index.rst
@@ -11,6 +11,7 @@ Block Devices
    nbd
    paride
    ramdisk
+   zoned_loop
    zram
 
    drbd/index
diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
new file mode 100644
index 000000000000..e437f501b0ae
--- /dev/null
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -0,0 +1,168 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Zoned Loop Block Device
+=======================
+
+.. Contents:
+
+	1) Overview
+	2) Creating a Zoned Device
+	3) Deleting a Zoned Device
+	4) Example
+
+
+1) Overview
+-----------
+
+The zoned loop block device driver (zloop) allows a user to create a zoned block
+device using one regular file per zone as backing storage. This driver does not
+directly control any hardware and uses read, write and truncate operations to
+regular files of a file system to emulate a zoned block device.
+
+Using zloop, zoned block devices with a configurable capacity, zone size and
+number of conventional zones can be created. The storage for each zone of the
+device is implemented using a regular file with a maximum size equal to the zone
+size. The size of a file backing a conventional zone is always equal to the zone
+size. The size of a file backing a sequential zone indicates the amount of data
+sequentially written to the file, that is, the size of the file directly
+indicates the position of the write pointer of the zone.
+
+When resetting a sequential zone, its backing file size is truncated to zero.
+Conversely, for a zone finish operation, the backing file is truncated to the
+zone size. With this, the maximum capacity of a zloop zoned block device created
+can be larger configured to be larger than the storage space available on the
+backing file system. Of course, for such configuration, writing more data than
+the storage space available on the backing file system will result in write
+errors.
+
+The zoned loop block device driver implements a complete zone transition state
+machine. That is, zones can be empty, implicitly opened, explicitly opened,
+closed or full. The current implementation does not support any limits on the
+maximum number of open and active zones.
+
+No user tools are necessary to create and delete zloop devices.
+
+2) Creating a Zoned Device
+--------------------------
+
+Once the zloop module is loaded (or if zloop is compiled in the kernel), the
+character device file /dev/zloop-control can be used to add a zloop device.
+This is done by writing an "add" command directly to the /dev/zloop-control
+device::
+
+	$ modprobe zloop
+        $ ls -l /dev/zloop*
+        crw-------. 1 root root 10, 123 Jan  6 19:18 /dev/zloop-control
+
+        $ mkdir -p <base directory/<device ID>
+        $ echo "add [options]" > /dev/zloop-control
+
+The options available for the add command can be listed by reading the
+/dev/zloop-control device::
+
+	$ cat /dev/zloop-control
+        add id=%d,capacity_mb=%u,zone_size_mb=%u,zone_capacity_mb=%u,conv_zones=%u,base_dir=%s,nr_queues=%u,queue_depth=%u
+        remove id=%d
+
+In more details, the options that can be used with the "add" command are as
+follows.
+
+================   ===========================================================
+id                 Device number (the X in /dev/zloopX).
+                   Default: automatically assigned.
+capacity_mb        Device total capacity in MiB. This is always rounded up to
+                   the nearest higher multiple of the zone size.
+                   Default: 16384 MiB (16 GiB).
+zone_size_mb       Device zone size in MiB. Default: 256 MiB.
+zone_capacity_mb   Device zone capacity (must always be equal to or lower than
+                   the zone size. Default: zone size.
+conv_zones         Total number of conventioanl zones starting from sector 0.
+                   Default: 8.
+base_dir           Path to the base directoy where to create the directory
+                   containing the zone files of the device.
+                   Default=/var/local/zloop.
+                   The device directory containing the zone files is always
+                   named with the device ID. E.g. the default zone file
+                   directory for /dev/zloop0 is /var/local/zloop/0.
+nr_queues          Number of I/O queues of the zoned block device. This value is
+                   always capped by the number of online CPUs
+                   Default: 1
+queue_depth        Maximum I/O queue depth per I/O queue.
+                   Default: 64
+================   ===========================================================
+
+3) Deleting a Zoned Device
+--------------------------
+
+Deleting an unused zoned loop block device is done by issuing the "remove"
+command to /dev/zloop-control, specifying the ID of the device to remove::
+
+        $ echo "remove id=X" > /dev/zloop-control
+
+The remove command does not have any option.
+
+A zoned device that was removed can be re-added again without any change to the
+state of the device zones: the device zones are restored to their last state
+before the device was removed. Adding again a zoned device after it was removed
+must always be done using the same configuration as when the device was first
+added. If a zone configuration change is detected, an error will be returned and
+the zoned device will not be created.
+
+To fully delete a zoned device, after executing the remove operation, the device
+base directory containing the backing files of the device zones must be deleted.
+
+4) Example
+----------
+
+The following sequence of commands creates a 2GB zoned device with zones of 64
+MB and a zone capacity of 63 MB::
+
+        $ modprobe zloop
+        $ mkdir -p /var/local/zloop/0
+        $ echo "add capacity_mb=2048,zone_size_mb=64,zone_capacity=63MB" > /dev/zloop-control
+
+For the device created (/dev/zloop0), the zone backing files are all created
+under the default base directory (/var/local/zloop)::
+
+        $ ls -l /var/local/zloop/0
+        total 0
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000000
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000001
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000002
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000003
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000004
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000005
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000006
+        -rw-------. 1 root root 67108864 Jan  6 22:23 cnv-000007
+        -rw-------. 1 root root        0 Jan  6 22:23 seq-000008
+        -rw-------. 1 root root        0 Jan  6 22:23 seq-000009
+        ...
+
+The zoned device created (/dev/zloop0) can then be used normally::
+
+        $ lsblk -z
+        NAME   ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
+        zloop0 host-managed     64M      32         0         0       1M         4K
+        $ blkzone report /dev/zloop0
+          start: 0x000000000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x000020000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x000040000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x000060000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x000080000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x0000a0000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x0000c0000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x0000e0000, len 0x020000, cap 0x020000, wptr 0x000000 reset:0 non-seq:0, zcond: 0(nw) [type: 1(CONVENTIONAL)]
+          start: 0x000100000, len 0x020000, cap 0x01f800, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
+          start: 0x000120000, len 0x020000, cap 0x01f800, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
+          ...
+
+Deleting this device is done using the command::
+
+        $ echo "remove id=0" > /dev/zloop-control
+
+The removed device can be re-added again using the same "add" command as when
+the device was first created. To fully delete a zoned device, its backing files
+should also be deleted after executing the remove command::
+
+        $ rm -r /var/local/zloop/0
diff --git a/MAINTAINERS b/MAINTAINERS
index 49076a506b6b..a61b5d2827af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25977,6 +25977,7 @@ M:	Damien Le Moal <dlemoal@kernel.org>
 R:	Christoph Hellwig <hch@lst.de>
 L:	linux-block@vger.kernel.org
 S:	Maintained
+F:	Documentation/admin-guide/blockdev/zoned_loop.rst
 F:	drivers/block/zloop.c
 
 ZONEFS FILESYSTEM
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index abdbe5d49026..3d8874128157 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -427,6 +427,9 @@ config BLK_DEV_ZONED_LOOP
 	  echo "add id=0,zone_size_mb=256,capacity_mb=16384,conv_zones=11" > \
 		/dev/zloop-control
 
+	  See Documentation/admin-guide/blockdev/zoned_loop.rst for usage
+	  details.
+
 	  If unsure, say N.
 
 endif # BLK_DEV
-- 
2.47.1

