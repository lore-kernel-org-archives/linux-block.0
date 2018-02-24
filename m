Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00272701.pphosted.com ([208.86.201.61]:36720 "EHLO
        mx0b-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752052AbeBXDXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 22:23:00 -0500
From: Steve Kenton <skenton@ou.edu>
To: linux-block@vger.kernel.org
Cc: Steve Kenton <skenton@ou.edu>, Thomas Schmitt <scdbackup@gmx.net>
Subject: [PATCH 1/1] extend BLKRRPART to update the readable size of media
Date: Fri, 23 Feb 2018 21:02:11 -0600
Message-Id: <20180224030211.2541-1-skenton@ou.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The readable size of new, factory blank, optical media can change via user
space ioctl(SG_IO) commands to format overwritable media such as DVD+RW for
a UDF filesystem or write to sequential media such as DVD-R for an ISO-9660
filesystem. However there appears to be no easy way to update the size used
by the block layer from the initial value of zero. Traditionally, ejecting and
reinserting the media is the workaround to this long standing issue which 
programs such as growisofs use by automatically opening and closing the tray
at the end of a session so the newly created filesystem becomes mountable
and readable. This can be problematic when using a slot load drive.

An even more heavy handed approach is to delete and then rescan the drive
using sysfs. echo offline > state  echo 1 > delete  echo - - - > scan
without ever ejecting the media. It works but is slow and rather ugly.

Reading a factory blank DVD+RW needing to be "de-iced" gives this result
both before *AND* after formatting with $ xorriso -dev /dev/sr0 -format full

$ dd if=/dev/sr0 of=/dev/null bs=2k
dd: error reading ‘/dev/sr0’: Input/output error
0+0 records in
0+0 records out
0 bytes (0 B) copied, 0.0275589 s, 0.0 kB/s

The crux of the problem being the readable size after formatting is still zero
which does not change to the correct value without ejecting and reinserting
the newly formatted media to force a call to fops->revalidate_disk().

hdi@hdi-H110N:/sys/block/sr0$ cat size
0
hdi@hdi-H110N:/sys/block/sr0$ cat size
9180416

Making the BLKRRPART ioctl call fops->revalidate_disk() => sr_revalidate_disk()
in sr.c resolves the issue for optical media and should be a benign and
potentially useful operation if ever called for non-optical media =>
sd_revalidate_disk() in sd.c for any other devices which change size.
Programs would have to "opt in" to use ioctl(BLKRRPART) on optial media.

The down side is that BLKRRPART requires CAP_SYSADMIN for userspace programs.

Signed-off-by: Steve Kenton <skenton@ou.edu>
Signed-off-by: Thomas Schmitt <scdbackup@gmx.net>
---
I discussed this with Thomas Schmitt the maintainer of the xorriso burner
program to define the problem and suggest a fix.

V2: Add NULL pointer check
Checkpatch wrapping and update commit message
Send to linux-block@vger.kernel.org instead of linux-fsdevel@vger.kernel.org

V3: Fix stupid copy paste omission of return value and build test again
Burn another DVD-R and verify size change after blkrrpart /dev/sr0

 block/ioctl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

 block/ioctl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 1668506d8ed8..8486389855d5 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -163,14 +163,20 @@ int __blkdev_reread_part(struct block_device *bdev)
 {
 	struct gendisk *disk = bdev->bd_disk;
 
-	if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
+	if (bdev != bdev->bd_contains) /* must be whole disk */
 		return -EINVAL;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-	return rescan_partitions(disk, bdev);
+	if (disk_part_scan_enabled(disk))
+		return rescan_partitions(disk, bdev); /* update partitions */
+	else if (disk->fops->revalidate_disk) /* could be sr or sd */
+		return disk->fops->revalidate_disk(disk); /* update size */
+	else
+		return -EINVAL;
 }
 EXPORT_SYMBOL(__blkdev_reread_part);
 
-- 
2.16.1.72.g5be1f00
