Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4275148822;
	Tue, 21 May 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331383; cv=none; b=pkMKBCMEKsmMZChjOb2jolKBXzn2TURv1NnqfjtrIjJRuaj2HkWuxMESrmkEXaCvAjWVVNdiS6ytziE7L0NGJIHRjrUYKYdRYUQCEOgBHOlafiBhGBG9Mmp6hHyAgfVRamECX14/KXsJxfgsR3OKDhDiHdQEoUxb3wKVGnD8rhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331383; c=relaxed/simple;
	bh=HOlB3ZecCxj8ivbGAJlk8GYdk2c092iUpt0dBwX1EM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLfZCrboj4gzlzgTEoPzP7vsqTMvVuUIsk0Af/j+oicuDSq1ogwzdjro7KUL4z27xpKJSRJJbIdXj9Uw1skOWCK3em8+j6pCbsIKAJO5enhwzUe+YInBFYEnRVUSemfUrqBVfWyaJmDoOREhW7HPviYONbf+ryKEo4F0q5uon+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wqcd3Tfh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wqcd3Tfh"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJi2QT005412;
	Tue, 21 May 2024 22:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=h/aKpvCUkFlWxbtyI98X6dTGVAY7OaogODfh6KxYNpc=;
 b=Wqcd3TfheJF5SSeh5aaZMa7RbO6S7fc7lsIC8PwrzNg9Ku+NA+zFYnyZiUrb2uokpnY5
 RwxKz+2892fyXwzXEI63Xe+Ejre3CFWYVBB5S71sgJJuB/4GhedXRW8XR9FAFHwhypfc
 7QzAIxpWJl6t9mnNnPmRWF64BhfhmX1NB7vwaVZH1Qg32/EV7FWR41dR7ZMkBzdj6fBU
 +VJTxsM+DP0nqtpgzhPZ6fyClyxmKsVGCxxjmkdPaFmiei+pLWkX0/8EJRXzmEhIClE/
 1TpdVD+UUC4XzYN06PwDbonLR1rZQZDEDKnbUWn2qFr7fYPxts5/v/R2bdQTw9Qmfr/J 2g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv6hys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 22:42:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LLIjjr019519;
	Tue, 21 May 2024 22:42:50 GMT
Received: from gms-lo-open-test.osdevelopmeniad.oraclevcn.com (gms-lo-open-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.129])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8ef4q-1;
	Tue, 21 May 2024 22:42:50 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
        hch@lst.de
Subject: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop detach and loop open
Date: Tue, 21 May 2024 22:42:48 +0000
Message-Id: <20240521224249.7389-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_14,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210172
X-Proofpoint-GUID: 0bLT9saxes5WIghY_9ks7iWIe4Q4ii7U
X-Proofpoint-ORIG-GUID: 0bLT9saxes5WIghY_9ks7iWIe4Q4ii7U

Description
===========

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

Fix
---
Re-introduce the lo_open() call to restrict any process to open the loop
device when its being detached

Test case
=========
Test case involves the following two scripts:

script1.sh
----------
while [ 1 ];
do
	losetup -P -f /home/opt/looptest/test10.img
	blkid /dev/loop0p1
done

script2.sh
----------
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

V1->V2:
	Added a test case, 010, in blktests in tests/loop/
Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 drivers/block/loop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..9a235d8c062d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1717,6 +1717,24 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 }
 #endif
 
+static int lo_open(struct gendisk *disk, blk_mode_t mode)
+{
+        struct loop_device *lo = disk->private_data;
+        int err;
+
+        if (!lo)
+                return -ENXIO;
+
+        err = mutex_lock_killable(&lo->lo_mutex);
+        if (err)
+                return err;
+
+        if (lo->lo_state == Lo_rundown)
+                err = -ENXIO;
+        mutex_unlock(&lo->lo_mutex);
+	return err;
+}
+
 static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
@@ -1752,6 +1770,7 @@ static void lo_free_disk(struct gendisk *disk)
 
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
+	.open = 	lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.39.3

