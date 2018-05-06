Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43232 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeEFSug (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 May 2018 14:50:36 -0400
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Cai Zhiyong <caizhiyong@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: block: cmdline-partition.txt fixes and
 additions
Message-ID: <dba389fc-2745-34b1-e33e-fc83f53eaf42@infradead.org>
Date: Sun, 6 May 2018 11:50:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Make the description of the kernel command line option "blkdevparts"
a bit more flowing and readable.

Fix a few typos.
Add the optional <size> and <offset> suffixes.
Note that size can be "-" to indicate all of the remaining space.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Cai Zhiyong <caizhiyong@huawei.com>
---
Should the "ro" and "lk" flags options be described?

 Documentation/block/cmdline-partition.txt |   21 +++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- linux-next-20180504.orig/Documentation/block/cmdline-partition.txt
+++ linux-next-20180504/Documentation/block/cmdline-partition.txt
@@ -1,7 +1,9 @@
 Embedded device command line partition parsing
 =====================================================================
 
-Support for reading the block device partition table from the command line.
+The "blkdevparts" command line option adds support for reading the
+block device partition table from the kernel command line.
+
 It is typically used for fixed block (eMMC) embedded devices.
 It has no MBR, so saves storage space. Bootloader can be easily accessed
 by absolute address of data on the block device.
@@ -14,22 +16,27 @@ blkdevparts=<blkdev-def>[;<blkdev-def>]
     <partdef> := <size>[@<offset>](part-name)
 
 <blkdev-id>
-    block device disk name, embedded device used fixed block device,
-    it's disk name also fixed. such as: mmcblk0, mmcblk1, mmcblk0boot0.
+    block device disk name. Embedded device uses fixed block device.
+    Its disk name is also fixed, such as: mmcblk0, mmcblk1, mmcblk0boot0.
 
 <size>
     partition size, in bytes, such as: 512, 1m, 1G.
+    size may contain an optional suffix of (upper or lower case):
+      K, M, G, T, P, E.
+    "-" is used to denote all remaining space.
 
 <offset>
     partition start address, in bytes.
+    offset may contain an optional suffix of (upper or lower case):
+      K, M, G, T, P, E.
 
 (part-name)
-    partition name, kernel send uevent with "PARTNAME". application can create
-    a link to block device partition with the name "PARTNAME".
-    user space application can access partition by partition name.
+    partition name. Kernel sends uevent with "PARTNAME". Application can
+    create a link to block device partition with the name "PARTNAME".
+    User space application can access partition by partition name.
 
 Example:
-    eMMC disk name is "mmcblk0" and "mmcblk0boot0"
+    eMMC disk names are "mmcblk0" and "mmcblk0boot0".
 
   bootargs:
     'blkdevparts=mmcblk0:1G(data0),1G(data1),-;mmcblk0boot0:1m(boot),-(kernel)'
