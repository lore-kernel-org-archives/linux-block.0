Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C3502BE;
	Tue, 18 Jun 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728857; cv=none; b=Zz1iYqu33HCFpnqqPTTCQNHy1V0TKQv80/PAYd96CVYXyLCP64qydmWLV+XJ1Fo9Xukhq5Z2xh5WxG8n/2c4eztvAi1Bf6LAyKn2B1iSvpMJOzN2GLiUwyhkNmaH+tMVXZGpRes5fAbSQyrzduUHpkWMt6oWdlhi/Yfr5Op4XD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728857; c=relaxed/simple;
	bh=Yp/E2oSSl060NTRGp1qLKA+aOxOaUik7haSzpCCGALk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEm9z5EJjJ5iim+5pycMBJX7IFPo0Hv+17DVs1obozMaWy29c5u48UUh5KwjPfW5oOhgYJGeu/nCzmL9gnHBis9n9GZyuz4biph6ojeWbsY/nwsvZ89QIFdoFUrISR9TXWi8dBnhXMxlAvA6xysHcGB5PlOPbxrzxMW6VRdRruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k23lQkPe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k23lQkPe"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IGPoac004277;
	Tue, 18 Jun 2024 16:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=Fa4CExB9eYtlzv
	TePQbr8jlpZ2Tbnf1tzxNMpMLDGDE=; b=k23lQkPeeZS7KT+bWJl8+Tjt1iZJdr
	zDQbu8rQTdjEWc5aqXFkM8T2D6WWWMH1a6IqBkFwB7ao9E3zKfgS43TmFkaXiIle
	impMx2rN1eYY28E2WEM9qleqJCgYwa9ZuaqXGmzrpvpCjtKeiN2hJVT9PEv+MmDk
	t4QntqXF8uaTgizhvz51+g88Z4kXpJbSQVoQHsKyY29H22mffZG0Yy1POadVVWo5
	kdzXJAXXI0ANAhZ7MUgel+XZIiPDkSqNiM3cjMshdFYjzvJprPtzTfe/ilVWxSik
	ok2l1FuHUOmRUgI/JPTSLxQn0jjTU64CgtQg6aiGxYLkvgVmIzmQn3IQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc5b6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:40:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IFR5r4034676;
	Tue, 18 Jun 2024 16:40:42 GMT
Received: from gms-ol9-loop-1.osdevelopmeniad.oraclevcn.com (gms-ol9-loop-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.182])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ys1denh9x-1;
	Tue, 18 Jun 2024 16:40:42 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach and loop open
Date: Tue, 18 Jun 2024 16:40:42 +0000
Message-ID: <20240618164042.343777-1-gulam.mohamed@oracle.com>
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
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180125
X-Proofpoint-ORIG-GUID: KPSEe7AR6xDfuihPxaqFg1NEiSlS2YkV
X-Proofpoint-GUID: KPSEe7AR6xDfuihPxaqFg1NEiSlS2YkV

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
v6<-v5:
Set the loop state Lo_rundown only when there is a single opener of the
loop device

 drivers/block/loop.c | 75 +++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 93780f41646b..6fa19aa7c913 100644
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
@@ -1233,24 +1219,16 @@ static int loop_clr_fd(struct loop_device *lo)
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
-	lo->lo_state = Lo_rundown;
+
+	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
+	if (disk_openers(lo->lo_disk) == 1)
+		lo->lo_state = Lo_rundown;
 	loop_global_unlock(lo, true);
 
-	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1717,25 +1695,43 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
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
@@ -1752,6 +1748,7 @@ static void lo_free_disk(struct gendisk *disk)
 
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
+	.open =         lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0

