Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0010F7;
	Sat, 15 Jun 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718414516; cv=none; b=l49siW+z0Xhe6cNVH0JIilLhmzmzDZNHLHxlSNKL+5m/FellBDGcpFM9g+mfJyg5NXtyv7/TTZgAfIQvyrHsfc/0Qs/vQWMQ6iu3LBEUxoo6NcKXf3yNNKR0xXhK/UDqXgG3q2HXiXE0DkbcMESYrvPEcX6er88i+ZO9zJ2CN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718414516; c=relaxed/simple;
	bh=6hcdQDxYt7wkpqPicpmiKM/5NbLScKPDE7Gr8WLHzZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqMiuJFL0DMA5kUQnUjiT5m/LTGP7UR02I/OuNYYgMldRjwFijXsHTQgqEBzq0aoXtGPbvb0oaz5Uhb27P2fOthdlTrqaGPm7bG6jEH0n4oLaCT7t01ijhzMT5uVPpq33I0PGu4oTfUiZosOvqVQDUzNnuG9PH/FmvoSiDnNs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nsGAvjxX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nsGAvjxX"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EMGPMX026842;
	Sat, 15 Jun 2024 01:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=nUEG7nc72Pb4qM
	FWnH+i7N0SgkgYLubTxhxZ24OeGb0=; b=nsGAvjxX/oqkShstJU356vmShgeaFe
	waM9Fm/RbTLoV9G8bVNuogcZzBcyEgDA070mItNnilol/vhoniuQN0Kj79qT1Y43
	3rNKDFJZ0xK7cLltFGiyHtCJNedXiquF0hKBov7n7deVmHcm3EgRzvA8tl03HzsI
	YYBjVunGngs4G8XHnFP+jR8Ns2RHuMzeFCpLZaJPbH79sf2Lt/qgFxtHRHBnWl4d
	sUXI1mXEy8m5/hFmjP4gyVVC0Grn8GNMPjc0LxcA2EUn3L4J8KkzD9UgkOrQryld
	btBQ0mq/Jb7UquI+B902+cDH/FWu4VmVAZeM9r2HNYwjcqd8CuYErfdw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhajctep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Jun 2024 01:21:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45EMdBij036656;
	Sat, 15 Jun 2024 01:21:39 GMT
Received: from gms-ol9-loop-1.osdevelopmeniad.oraclevcn.com (gms-ol9-loop-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.182])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ynce2dmr0-1;
	Sat, 15 Jun 2024 01:21:39 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: [PATCH V5 for-6.11/block] loop: Fix a race between loop detach and loop open
Date: Sat, 15 Jun 2024 01:21:38 +0000
Message-ID: <20240615012138.120364-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_19,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406150009
X-Proofpoint-GUID: JPQuSHusPaqr9jnY3bx7XVb60JcCci-J
X-Proofpoint-ORIG-GUID: JPQuSHusPaqr9jnY3bx7XVb60JcCci-J

1. Userspace sends the command "losetup -d" which uses the open() call
   to open the device
2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
   function loop_clr_fd()
3. If LOOP_CLR_FD is the first command received at the time, then the
   AUTOCLEAR flag is not set and deletion of the
   loop device proceeds ahead and scans the partitions (drop/add
   partitions)

        if (disk_openers(lo->lo_disk) > 1) {
                lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
                loop_global_unlock(lo, true);
                return 0;
        }

 4. Before scanning partitions, it will check to see if any partition of
    the loop device is currently opened
 5. If any partition is opened, then it will return EBUSY:

    if (disk->open_partitions)
                return -EBUSY;
 6. So, after receiving the "LOOP_CLR_FD" command and just before the above
    check for open_partitions, if any other command
    (like blkid) opens any partition of the loop device, then the partition
    scan will not proceed and EBUSY is returned as shown in above code
 7. But in "__loop_clr_fd()", this EBUSY error is not propagated
 8. We have noticed that this is causing the partitions of the loop to
    remain stale even after the loop device is detached resulting in the
    IO errors on the partitions

Fix:

Defer the detach of loop device to release function, which is called when
the last close happens, by setting the lo_flags to LO_FLAGS_AUTOCLEAR at
the time of detach i.e in loop_clr_fd() function.

Test case involves the following two scripts:

script1.sh:

while [ 1 ];
do
        losetup -P -f /home/opt/looptest/test10.img
        blkid /dev/loop0p1
done

script2.sh:

while [ 1 ];
do
        losetup -d /dev/loop0
done

Without fix, the following IO errors have been observed:

kernel: __loop_clr_fd: partition scan of loop0 failed (rc=-16)
kernel: I/O error, dev loop0, sector 20971392 op 0x0:(READ) flags 0x80700
        phys_seg 1 prio class 0
kernel: I/O error, dev loop0, sector 108868 op 0x0:(READ) flags 0x0
        phys_seg 1 prio class 0
kernel: Buffer I/O error on dev loop0p1, logical block 27201, async page
        read

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
v5<-v4:
1. Re-introduced the setting of Lo_rundown flag while loop detach
2. Re-introduced the lo_open to prevent the new incoming openers when
   Lo_rundown is set

 drivers/block/loop.c | 72 +++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93780f41646b..cba64799811c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1131,7 +1131,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo, bool release)
+static void __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1139,14 +1139,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
-	/*
-	 * Freeze the request queue when unbinding on a live file descriptor and
-	 * thus an open device.  When called from ->release we are guaranteed
-	 * that there is no I/O in progress already.
-	 */
-	if (!release)
-		blk_mq_freeze_queue(lo->lo_queue);
-
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
@@ -1164,8 +1156,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	if (!release)
-		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk);
 
@@ -1180,11 +1170,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		if (!release)
-			mutex_lock(&lo->lo_disk->open_mutex);
 		err = bdev_disk_changed(lo->lo_disk, false);
-		if (!release)
-			mutex_unlock(&lo->lo_disk->open_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
 				__func__, lo->lo_number, err);
@@ -1233,24 +1219,15 @@ static int loop_clr_fd(struct loop_device *lo)
 		return -ENXIO;
 	}
 	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
+	 * Mark the device for removing the backing device on last close.
+	 * If we are the only opener, also switch the state to roundown here to
+	 * prevent new openers from coming in.
 	 */
-	if (disk_openers(lo->lo_disk) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		loop_global_unlock(lo, true);
-		return 0;
-	}
+
+	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 	lo->lo_state = Lo_rundown;
 	loop_global_unlock(lo, true);
 
-	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1717,25 +1694,43 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 }
 #endif
 
+static int lo_open(struct gendisk *disk, blk_mode_t mode)
+{
+	struct loop_device *lo = disk->private_data;
+	int err;
+
+	err = mutex_lock_killable(&lo->lo_mutex);
+	if (err)
+		return err;
+
+	if (lo->lo_state == Lo_deleting || lo->lo_state == Lo_rundown)
+		err = -ENXIO;
+	mutex_unlock(&lo->lo_mutex);
+	return err;
+}
+
 static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
+	bool need_clear = false;
 
 	if (disk_openers(disk) > 0)
 		return;
+	/*
+	 * Clear the backing device information if this is the last close of
+	 * a device that's been marked for auto clear, or on which LOOP_CLR_FD
+	 * has been called.
+	 */
 
 	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
+	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
 		lo->lo_state = Lo_rundown;
-		mutex_unlock(&lo->lo_mutex);
-		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
-		 */
-		__loop_clr_fd(lo, true);
-		return;
-	}
+
+	need_clear = (lo->lo_state == Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
+
+	if (need_clear)
+		__loop_clr_fd(lo);
 }
 
 static void lo_free_disk(struct gendisk *disk)
@@ -1752,6 +1747,7 @@ static void lo_free_disk(struct gendisk *disk)
 
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
+	.open =         lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0

