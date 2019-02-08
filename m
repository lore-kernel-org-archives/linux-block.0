Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACEAC282CC
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 23:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF6321841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 23:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eL4bOZXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBHXii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:38:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHXii (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 18:38:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x18NTJBc185026;
        Fri, 8 Feb 2019 23:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=ZkIMWKmca3vaJxXrj51L4nPxPdd961wBcET0N/Dg3ss=;
 b=eL4bOZXe5jTDoFfuL5fiGhKKFdREHSoEOXebCQjfQGlNd5OemwY/SNcRJI+PopegYGl0
 uvYwvDG6H56H7/wRzi8AQsPPnABxAI3VUAf0vd3T/ySwN9qIa+qfDEk1RcQediCkx5De
 GwjAJiwFKsvlpTHkByemtZic+Jc0y8OnxQikQEbzu9y1ED6h0gcsJQ/I9axi9va6+JD1
 I1dZiQI7JbT5AxZZG8Dr3WuxsXkFbkZJoZOR5WJP0fDDsjSXiyz9e39wgz5oJ2nRiDKS
 Y/+0JZeNPpIeFmw3pZ4DNq6jpQHs3Hi28RzM4roTr90d/35EVlrQoMHNKgk5LAw+Jdky nA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qd9aryad6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Feb 2019 23:38:34 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x18NcXj8017471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 23:38:33 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x18NcWtF028909;
        Fri, 8 Feb 2019 23:38:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Feb 2019 15:38:32 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: [PATCH] scsi: sd: block: Handle cases where devices come online read-only
Date:   Fri,  8 Feb 2019 18:38:31 -0500
Message-Id: <20190208233831.31377-1-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902080158
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some devices come online in write protected state and switch to
read-write once they are ready to process I/O requests. These devices
broke with commit 20bd1d026aac ("scsi: sd: Keep disk read-only when
re-reading partition") because we have no way to distinguish between a
user decision to set a block_device read-only and the disk being write
protected as a result of the hardware state.

To overcome this we add a third state to the gendisk read-only
policy. This flag is exlusively used when the user forces a struct
block_device read-only via BLKROSET. We currently don't allow
switching ro state in sysfs so the ioctl is the only entry point for
this new state.

In set_disk_ro() we check whether the user override flag is in effect
for a disk before changing read-only state based on the device
settings. This means that devices that have a delay before going
read-write will now be able to clear the read-only state. And devices
where the admin or udev has forced the disk read-only will not cause
the gendisk policy to reflect the mode reported by the device.

Cc: Jeremy Cline <jeremy@jcline.org>
Cc: Oleksii Kurochko <olkuroch@cisco.com>
Cc: stable@vger.kernel.org # v4.16+
Reported-by: Oleksii Kurochko <olkuroch@cisco.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201221
Fixes: 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading partition")
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

---

I have verified that get_disk_ro() and bdev_read_only() callers all
handle the additional value correctly. Same is true for "ro" in
sysfs.

Note that per-partition ro settings are lost on revalidate. This has
been broken for at least a decade and it will require major surgery to
fix. To my knowledge nobody has complained about being unable to make
partition read-only settings stick through a revalidate. So hopefully
this patch will suffice as a simple fix for stable.
---
 block/genhd.c         | 13 ++++++++++++-
 block/ioctl.c         |  3 ++-
 drivers/scsi/sd.c     |  4 +---
 include/linux/genhd.h |  6 ++++++
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1dd8fd6613b8..e29805bfa989 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1549,11 +1549,22 @@ void set_disk_ro(struct gendisk *disk, int flag)
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
+	/*
+	 * If the user has forced disk read-only with BLKROSET, ignore
+	 * any device state change requested by the driver.
+	 */
+	if (disk->part0.policy == DISK_POLICY_USER_WRITE_PROTECT)
+		return;
 	if (disk->part0.policy != flag) {
 		set_disk_ro_uevent(disk, flag);
 		disk->part0.policy = flag;
 	}
-
+	/*
+	 * If set_disk_ro() is called from revalidate, all partitions
+	 * have already been dropped at this point and thus any
+	 * per-partition user setting lost. Each partition will
+	 * inherit part0 policy when subsequently re-added.
+	 */
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
 		part->policy = flag;
diff --git a/block/ioctl.c b/block/ioctl.c
index 4825c78a6baa..16c42e1b18c8 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -451,7 +451,8 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		return ret;
 	if (get_user(n, (int __user *)arg))
 		return -EFAULT;
-	set_device_ro(bdev, n);
+	set_device_ro(bdev, n ? DISK_POLICY_USER_WRITE_PROTECT :
+		      DISK_POLICY_WRITABLE);
 	return 0;
 }
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b2da8a00ec33..9aa409b38765 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2591,10 +2591,8 @@ sd_read_write_protect_flag(struct scsi_disk *sdkp, unsigned char *buffer)
 	int res;
 	struct scsi_device *sdp = sdkp->device;
 	struct scsi_mode_data data;
-	int disk_ro = get_disk_ro(sdkp->disk);
 	int old_wp = sdkp->write_prot;
 
-	set_disk_ro(sdkp->disk, 0);
 	if (sdp->skip_ms_page_3f) {
 		sd_first_printk(KERN_NOTICE, sdkp, "Assuming Write Enabled\n");
 		return;
@@ -2632,7 +2630,7 @@ sd_read_write_protect_flag(struct scsi_disk *sdkp, unsigned char *buffer)
 			  "Test WP failed, assume Write Enabled\n");
 	} else {
 		sdkp->write_prot = ((data.device_specific & 0x80) != 0);
-		set_disk_ro(sdkp->disk, sdkp->write_prot || disk_ro);
+		set_disk_ro(sdkp->disk, sdkp->write_prot);
 		if (sdkp->first_scan || old_wp != sdkp->write_prot) {
 			sd_printk(KERN_NOTICE, sdkp, "Write Protect is %s\n",
 				  sdkp->write_prot ? "on" : "off");
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 06c0fd594097..2bef434d4dff 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -150,6 +150,12 @@ enum {
 	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
 };
 
+enum {
+	DISK_POLICY_WRITABLE			= 0, /* Default */
+	DISK_POLICY_DEVICE_WRITE_PROTECT	= 1, /* Set by device driver */
+	DISK_POLICY_USER_WRITE_PROTECT		= 2, /* Set via BLKROSET */
+};
+
 struct disk_part_tbl {
 	struct rcu_head rcu_head;
 	int len;
-- 
2.19.2

