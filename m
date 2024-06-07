Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952161FF6;
	Fri,  7 Jun 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787184; cv=none; b=hnYCEqSyCV2FHGYPsf0HXz3jB9EPNPK3+tXs9bNwBcq+LXcHD9HkEkg6zHFbRlzf8qSu5MhHDj630keaUGVm4kCuCXgGF1ocB0x9KPYX2h4nxxX0VPIAUYqyf1R8gqWhWgzydIdaWI+iq60k9vR1y3/+aWAVqtOI/2XzTA+Pp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787184; c=relaxed/simple;
	bh=POh3YrHn4q54h+Qa6SohM8DHib0BNm73vJtFcOXO9c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjnuYvu0KsQcIccVNIRhI/DSIv/MoqTmtjYIH9DdxvcC0NMsvvWX5H9Gcd3BGBl2sH0ITT+N7deQ6vG3DXcomd/3wrqVaeO0VyuJNjvYkJaXT6DUfXRlUVX7IBX706hXbajyO9ie/QsYANbZsH+rXdj8Ol5MkqATWMTXga2ZTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0YJQbpI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0YJQbpI"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuVjQ023604;
	Fri, 7 Jun 2024 19:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=corp-2023-11-20;
 bh=bavZSgWNlH5AnIMvg1whudm4Kfg9OnMmT+mI9SLCa5U=;
 b=T0YJQbpI7dYm0rus9Kl4t81q/Czx64VkApsS40l/bzqlw+3wW5vuERSxQnzZKcnfQ/kl
 H+aXxMekGknuj6wlKJUu69KiU/FxQQGZ0E+DrRPVlEqeQP4GHtB+obpp3JEm9XbmHs4u
 kdL/z5xchvIBa4/X6bZ2SNw4risilVg6yvB0fAys8XnIhkfq8Xp5VJglFbyX9mRQ+b/l
 Kb8RJPeK0Ii/4kbAUE/MBCkLVqK6I+6NkqLzXuAzw6nNY7kn0DLX4rbPoKWNjSoITsPk
 cSGz//EXKijq6HM3A2QcolxP5Y54+uoxUqWvBrvVnftnLR+eVyQuGePVyzarQxB5zR2l Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrse68b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 19:06:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457HVcLm015675;
	Fri, 7 Jun 2024 19:06:08 GMT
Received: from gms-ol9-loop-1.osdevelopmeniad.oraclevcn.com (gms-ol9-loop-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ygrjh0we9-1;
	Fri, 07 Jun 2024 19:06:08 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach and loop open
Date: Fri,  7 Jun 2024 19:06:07 +0000
Message-ID: <20240607190607.17705-1-gulam.mohamed@oracle.com>
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
 definitions=2024-06-07_12,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070139
X-Proofpoint-ORIG-GUID: -zGvZEA1eWq0U0JukinkUsG3FlJmG7VZ
X-Proofpoint-GUID: -zGvZEA1eWq0U0JukinkUsG3FlJmG7VZ

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
Defer the detach of loop device to release function, which is called
when the last close happens, by setting the lo_flags to LO_FLAGS_AUTOCLEAR
at the time of detach i.e in loop_clr_fd() function.

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
v4<-v3:
1. Defer the loop detach to last close of loop device
2. Removed the use of lo_open due to following reasons:

Setting the lo_state to Lo_rundown in loop_clr_fd() may not help in
stopping the incoming open(), when the loop is being detached, as the
open() could invoke the lo_open() before the lo_state is set to Lo_rundown
and increment the disk_openers refcnt later.
As the actual cleanup is deferred to last close, in release, there is no
chance for the open() to kick in to take the reference. Because both open()
and release() are protected by open_mutex and hence they cannot run in
parallel.
So, lo_open() and setting lo_state to Lo_rundown is not needed. Removing
the loop state Lo_rundown as its not used anymore.

 drivers/block/loop.c | 44 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..4936cadc1a63 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -41,7 +41,6 @@
 enum {
 	Lo_unbound,
 	Lo_bound,
-	Lo_rundown,
 	Lo_deleting,
 };
 
@@ -1131,7 +1130,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo, bool release)
+static void __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1139,14 +1138,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
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
@@ -1164,8 +1155,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	if (!release)
-		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk);
 
@@ -1180,11 +1169,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
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
@@ -1232,25 +1217,8 @@ static int loop_clr_fd(struct loop_device *lo)
 		loop_global_unlock(lo, true);
 		return -ENXIO;
 	}
-	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
-	 */
-	if (disk_openers(lo->lo_disk) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		loop_global_unlock(lo, true);
-		return 0;
-	}
-	lo->lo_state = Lo_rundown;
+	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 	loop_global_unlock(lo, true);
-
-	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1724,15 +1692,19 @@ static void lo_release(struct gendisk *disk)
 	if (disk_openers(disk) > 0)
 		return;
 
+	/*
+	 * Clear the backing device information if this is the last close of
+	 * a device that's been marked for auto clear, or on which LOOP_CLR_FD
+	 * has been called.
+	 */
 	mutex_lock(&lo->lo_mutex);
 	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
-		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		__loop_clr_fd(lo, true);
+		__loop_clr_fd(lo);
 		return;
 	}
 	mutex_unlock(&lo->lo_mutex);
-- 
2.43.0

