Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB281C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 04:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D2820C01
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 04:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xbAjFRE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfB0ETs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:19:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39556 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbfB0ETr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 23:19:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1R4J5s7016891;
        Wed, 27 Feb 2019 04:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Ob3kXOMCN4f7Uv+nhltsCnCmhnlqIlIc9uOttq8LVjk=;
 b=xbAjFRE0DGBXK7nzomqhLyRLA/gorDJpN52VmsjS59uVkziFVusYzmhHg5wa+8Oq6G2c
 jmxommlPUr92zPEUWyz8+YCxpjrgNHO7iLLt/bnMlEM0esTg/P00lXlf6hmC2QaK30AM
 td+nR8roR7xwOX/BWKq7bO1feNr+5mBSoAHoxMoZiyaXKqCrJqnE+5Ka2qS/te34H6cZ
 imQRmvTxacdUGrRHLnXHBLCZm+M7aDLit6gVf0zSEl2g1FXDqNrU6IJybJwReKgrtwO3
 NjMqAcMQfZeaabmtIrT99xxWj8TH1lIrhXvBF322IJyxWlZDci+jF7b/dTZrbV2tmwfv ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qtxtrrcbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 04:19:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1R4Jgq6030300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 04:19:43 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1R4JgjX026704;
        Wed, 27 Feb 2019 04:19:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 20:19:42 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: [PATCH v3] scsi: sd: block: Fix regressions in read-only block device handling
Date:   Tue, 26 Feb 2019 23:19:41 -0500
Message-Id: <20190227041941.1568-1-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222142957.GA17324@infradead.org>
References: <20190222142957.GA17324@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some devices come online in write protected state and switch to
read-write once they are ready to process I/O requests. These devices
broke with commit 20bd1d026aac ("scsi: sd: Keep disk read-only when
re-reading partition") because we had no way to distinguish between a
user decision to set a block_device read-only and the actual hardware
device being write-protected.

Because partitions are dropped and recreated on revalidate we are
unable to persist any user-provided policy in hd_struct. Introduce a
bitmap in struct gendisk to track the user configuration. This bitmap
is updated when BLKROSET is called on a given disk or partition.

A helper function, get_user_ro(), is provided to determine whether the
ioctl has forced read-only state for a given block device. This helper
is used by set_disk_ro() and add_partition() to ensure that both
existing and newly created partitions will get the correct state.

 - If BLKROSET sets a whole disk device read-only, all partitions will
   now end up in a read-only state.

 - If BLKROSET sets a given partition read-only, that partition will
   remain read-only post revalidate.

 - Otherwise both the whole disk device and any partitions will
   reflect the write protect state of the underlying device.

Since nobody knows what "policy" means, rename the field to
"read_only" for clarity.

Cc: Jeremy Cline <jeremy@jcline.org>
Cc: Oleksii Kurochko <olkuroch@cisco.com>
Cc: stable@vger.kernel.org # v4.16+
Reported-by: Oleksii Kurochko <olkuroch@cisco.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201221
Fixes: 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading partition")
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

---

v3:
	- Drop ?: since gcc complains about mixing int and bool (zeroday)
	- Drop EXPORT_SYMBOL (hch)
	- s/policy/read_only/ and make it a boolean

v2:
	- Track user read-only state in a bitmap

	- Work around the regression that caused us to drop user
	  preferences on revalidate
---
 block/blk-core.c          |  2 +-
 block/genhd.c             | 34 ++++++++++++++++++++++++----------
 block/ioctl.c             |  4 ++++
 block/partition-generic.c |  7 +++++--
 drivers/scsi/sd.c         |  4 +---
 include/linux/genhd.h     | 11 +++++++----
 6 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c78042975737..c28d7ee3a05e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -790,7 +790,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 {
 	const int op = bio_op(bio);
 
-	if (part->policy && op_is_write(op)) {
+	if (part->read_only && op_is_write(op)) {
 		char b[BDEVNAME_SIZE];
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
diff --git a/block/genhd.c b/block/genhd.c
index 1dd8fd6613b8..c07037c0b03f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1537,26 +1537,40 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
 }
 
-void set_device_ro(struct block_device *bdev, int flag)
+void set_device_ro(struct block_device *bdev, bool state)
 {
-	bdev->bd_part->policy = flag;
+	bdev->bd_part->read_only = state;
 }
 
 EXPORT_SYMBOL(set_device_ro);
 
-void set_disk_ro(struct gendisk *disk, int flag)
+bool get_user_ro(struct gendisk *disk, unsigned int partno)
+{
+	/* Is the user read-only bit set for the whole disk device? */
+	if (test_bit(0, disk->user_ro_bitmap))
+		return true;
+
+	/* Is the user read-only bit set for this particular partition? */
+	if (test_bit(partno, disk->user_ro_bitmap))
+		return true;
+
+	return false;
+}
+
+void set_disk_ro(struct gendisk *disk, bool state)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
-	if (disk->part0.policy != flag) {
-		set_disk_ro_uevent(disk, flag);
-		disk->part0.policy = flag;
-	}
+	if (disk->part0.read_only != state)
+		set_disk_ro_uevent(disk, state);
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
+	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY_PART0);
 	while ((part = disk_part_iter_next(&piter)))
-		part->policy = flag;
+		if (get_user_ro(disk, part->partno))
+			part->read_only = true;
+		else
+			part->read_only = state;
 	disk_part_iter_exit(&piter);
 }
 
@@ -1566,7 +1580,7 @@ int bdev_read_only(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return bdev->bd_part->policy;
+	return bdev->bd_part->read_only;
 }
 
 EXPORT_SYMBOL(bdev_read_only);
diff --git a/block/ioctl.c b/block/ioctl.c
index 4825c78a6baa..41206df89485 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -451,6 +451,10 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		return ret;
 	if (get_user(n, (int __user *)arg))
 		return -EFAULT;
+	if (n)
+		set_bit(bdev->bd_partno, bdev->bd_disk->user_ro_bitmap);
+	else
+		clear_bit(bdev->bd_partno, bdev->bd_disk->user_ro_bitmap);
 	set_device_ro(bdev, n);
 	return 0;
 }
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 8e596a8dff32..2bade849cc5c 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -98,7 +98,7 @@ static ssize_t part_ro_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%d\n", p->policy ? 1 : 0);
+	return sprintf(buf, "%u\n", p->read_only ? 1 : 0);
 }
 
 static ssize_t part_alignment_offset_show(struct device *dev,
@@ -338,7 +338,10 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		queue_limit_discard_alignment(&disk->queue->limits, start);
 	p->nr_sects = len;
 	p->partno = partno;
-	p->policy = get_disk_ro(disk);
+	if (get_user_ro(disk, partno))
+		p->read_only = true;
+	else
+		p->read_only = get_disk_ro(disk);
 
 	if (info) {
 		struct partition_meta_info *pinfo = alloc_part_info(disk);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 67cc439b86e4..5dfe37b08d3b 100644
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
index 06c0fd594097..1abde0e88ccb 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -118,7 +118,8 @@ struct hd_struct {
 	unsigned int discard_alignment;
 	struct device __dev;
 	struct kobject *holder_dir;
-	int policy, partno;
+	bool read_only;
+	int partno;
 	struct partition_meta_info *info;
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	int make_it_fail;
@@ -194,6 +195,7 @@ struct gendisk {
 	 */
 	struct disk_part_tbl __rcu *part_tbl;
 	struct hd_struct part0;
+	DECLARE_BITMAP(user_ro_bitmap, DISK_MAX_PARTS);
 
 	const struct block_device_operations *fops;
 	struct request_queue *queue;
@@ -431,12 +433,13 @@ extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
-extern void set_device_ro(struct block_device *bdev, int flag);
-extern void set_disk_ro(struct gendisk *disk, int flag);
+extern void set_device_ro(struct block_device *bdev, bool state);
+extern void set_disk_ro(struct gendisk *disk, bool state);
+extern bool get_user_ro(struct gendisk *disk, unsigned int partno);
 
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0.policy;
+	return disk->part0.read_only;
 }
 
 extern void disk_block_events(struct gendisk *disk);
-- 
2.19.2

