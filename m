Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9733187332;
	Wed, 29 May 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012979; cv=none; b=hMns+i16ZcmewyXNgYZJA+0Lxw5avGlEy3njXu78NWT5h9Ct1GdMsL/cJZJxMNzd1hRmHABARWCusIXzKrN86fcGfzgim2wHDhbiYlSXXMaP5xBYmtiG2XQeoyLPtZKXdtYDepQU3ccYzl5IIP3ahf2WFjS1yeITb2d273aFVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012979; c=relaxed/simple;
	bh=X2RQi0NOLcPcrfdOF3NrnLma9C9vB2J+1tJMamZmH9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7ua5AO2VnUd7PRdfGw07lsqxFL21KDGBUFCilcuf0oWhqesBxzaCU2MN4TF7ZGB8DzB1pWxzJaMO4YaGrkBsJpdo2gvex13aHYTOBTa0gPl0JG483cs9FqYg+3IVsBf6bhTCLmy4vYy/4B3AImfeU2K8VERANRYJlSetdNEFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TGY3tD010185;
	Wed, 29 May 2024 20:02:42 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:message-id:mime-versi?=
 =?UTF-8?Q?on:subject:to;_s=3Dcorp-2023-11-20;_bh=3DiQczFnhB4Xb+Ei9v4Ql3OL?=
 =?UTF-8?Q?2sETfx7U3jlfcP2jEQWxA=3D;_b=3DeeSdVI7kAieOgmTY/I37LgIYv88eRkJ3C?=
 =?UTF-8?Q?oj2OPgj+/66jOnUdL9kju5sp7KJJGAvY4zL_Q83BPsd5vc5jFiZzjYxJl/3PyY9?=
 =?UTF-8?Q?qrRmaGP95VRCjP2vZnDCtX6EqdBkI8dHDAyJd0zJ4_qcfppo6qOybCC3M128JsT?=
 =?UTF-8?Q?xHB3G59b3khRlTF9gObLcK2y64UFLS6usXy5yzcUdpNIfi/_ijDQ7aQ9hAqGb83?=
 =?UTF-8?Q?vVPaDOFRsyjH2or+xhJl9OJCQ2UKdmjGdCINYATaaKH5+d4qverFo_8v5eeiH6k?=
 =?UTF-8?Q?tTqwbV7XvO4Oj3J3pXvBJicS79MD6TemlVZPdGcI/UT9nVcm5yMMzJLFv6t_+w?=
 =?UTF-8?Q?=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fcfhpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 20:02:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TIMOmN015118;
	Wed, 29 May 2024 20:02:41 GMT
Received: from gms-ol9-loop-1.osdevelopmeniad.oraclevcn.com (gms-ol9-loop-1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.182])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5377v65-1;
	Wed, 29 May 2024 20:02:41 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: [PATCH V3 for-6.10/block] loop: Fix a race between loop detach and loop open
Date: Wed, 29 May 2024 20:02:40 +0000
Message-ID: <20240529200240.133331-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290140
X-Proofpoint-GUID: 0Hjw5EWBYruN0qXLbweEMmyTGbjtfS3_
X-Proofpoint-ORIG-GUID: 0Hjw5EWBYruN0qXLbweEMmyTGbjtfS3_

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
Re-introduce the lo_open() call to restrict any process to open the loop
device when its being detached

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
v3<-v2:
Re-introduced the loop->lo_refcnt to take care of the case where we race
when the Lo_rundown is set after the lo_open() function releases the
lo_mutex lock

 drivers/block/loop.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..60f61bf8dbd1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -49,6 +49,7 @@ struct loop_func_table;
 
 struct loop_device {
 	int		lo_number;
+	atomic_t        lo_refcnt;
 	loff_t		lo_offset;
 	loff_t		lo_sizelimit;
 	int		lo_flags;
@@ -1242,7 +1243,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
 	 * command to fail with EBUSY.
 	 */
-	if (disk_openers(lo->lo_disk) > 1) {
+	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 		loop_global_unlock(lo, true);
 		return 0;
@@ -1717,14 +1718,31 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 }
 #endif
 
-static void lo_release(struct gendisk *disk)
+static int lo_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
+	int err;
 
-	if (disk_openers(disk) > 0)
-		return;
+	err = mutex_lock_killable(&lo->lo_mutex);
+	if (err)
+		return err;
+
+	if (lo->lo_state == Lo_deleting || lo->lo_state == Lo_rundown)
+		err = -ENXIO;
+	else
+		atomic_inc(&lo->lo_refcnt);
+	mutex_unlock(&lo->lo_mutex);
+	return err;
+}
+
+static void lo_release(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
 
 	mutex_lock(&lo->lo_mutex);
+	if (atomic_dec_return(&lo->lo_refcnt))
+		goto out_unlock;
+
 	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
@@ -1735,6 +1753,7 @@ static void lo_release(struct gendisk *disk)
 		__loop_clr_fd(lo, true);
 		return;
 	}
+out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 }
 
@@ -1752,6 +1771,7 @@ static void lo_free_disk(struct gendisk *disk)
 
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
+	.open =         lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
@@ -2064,6 +2084,7 @@ static int loop_add(int i)
 	 */
 	if (!part_shift)
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+	atomic_set(&lo->lo_refcnt, 0);
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -2158,7 +2179,7 @@ static int loop_control_remove(int idx)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		goto mark_visible;
-	if (lo->lo_state != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
+	if (lo->lo_state != Lo_unbound || atomic_read(&lo->lo_refcnt) > 0) {
 		mutex_unlock(&lo->lo_mutex);
 		ret = -EBUSY;
 		goto mark_visible;
-- 
2.43.0

