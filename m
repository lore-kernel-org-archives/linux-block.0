Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1E1EE033;
	Thu,  7 Nov 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976229; cv=none; b=EEEAO8Vf06ZSgw4xpoevM7RoXZEcTPTsaeIydYFcFdGx03tdn9VucS9uFo31UJgKkbIFnr9VNlcC3iB3p/JFPY3Q5uXJjhE6vNgpUc1Hmj5wlXwh/61eRKOGEYUFDu0upq7NOlSc+HWrADzS8ZFyf+7YedU42VL/+ZTGLsXl9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976229; c=relaxed/simple;
	bh=L9SlpVVxhEf4ykrNQlx8s/8fkzEjJrdsxBO6Bi35ipo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JrT4lvOo0GFibYb3s/UpiHfNhcJxOtUcnqDO/8uTxn6Ry/lWIMoBthcH6c80SrawcO/tFw8ptudyrIDhbXe3pGO2Jpu6cs1CSQnIAggAi4ayh2kCEwqN3fyE1r6TR5FSxvIY1YFIV6jTkAc4BGGfSzRVXsho+SSQ+7a2G2aUQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 23b7d5e49cf511efa216b1d71e6e1362-20241107
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:790f96ec-7982-4f4d-8a07-9b4e5a4b20f5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.38,REQID:790f96ec-7982-4f4d-8a07-9b4e5a4b20f5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:82c5f88,CLOUDID:5e9ba0a28072d0f3d0f9ad7e1f42203a,BulkI
	D:241107184337PPJZK148,BulkQuantity:0,Recheck:0,SF:841|38|24|72|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS
X-UUID: 23b7d5e49cf511efa216b1d71e6e1362-20241107
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 420261564; Thu, 07 Nov 2024 18:43:35 +0800
From: zhangguopeng <zhangguopeng@kylinos.cn>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: hch@lst.de,
	ming.lei@redhat.com,
	yukuai3@huawei.com,
	linux-kernel@vger.kernel.org,
	zhangguopeng <zhangguopeng@kylinos.cn>
Subject: [PATCH v2] block: Replace sprintf() with sysfs_emit()
Date: Thu,  7 Nov 2024 18:42:58 +0800
Message-Id: <20241107104258.29742-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per Documentation/filesystems/sysfs.rst, show() should only use
sysfs_emit() or sysfs_emit_at() when formatting the value to be
returned to user space.

No functional change intended.

Signed-off-by: zhangguopeng <zhangguopeng@kylinos.cn>
Suggested-by: Christoph Hellwig <hch@lst.de>
---
v2: keep the \ aligned for all the multi-line macros,as Suggested by
https://lore.kernel.org/all/20241107054420.GA2336@lst.de/
---
 block/blk-sysfs.c | 24 ++++++++++++------------
 block/genhd.c     | 30 +++++++++++++++---------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d9f22122ae2f..d80a202cd170 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -30,7 +30,7 @@ struct queue_sysfs_entry {
 static ssize_t
 queue_var_show(unsigned long var, char *page)
 {
-	return sprintf(page, "%lu\n", var);
+	return sysfs_emit(page, "%lu\n", var);
 }
 
 static ssize_t
@@ -121,7 +121,7 @@ QUEUE_SYSFS_LIMIT_SHOW(atomic_write_unit_max)
 #define QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(_field)			\
 static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 {									\
-	return sprintf(page, "%llu\n",					\
+	return sysfs_emit(page, "%llu\n",				\
 		(unsigned long long)disk->queue->limits._field <<	\
 			SECTOR_SHIFT);					\
 }
@@ -145,7 +145,7 @@ QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_hw_sectors)
 #define QUEUE_SYSFS_SHOW_CONST(_name, _val)				\
 static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 {									\
-	return sprintf(page, "%d\n", _val);				\
+	return sysfs_emit(page, "%d\n", _val);				\
 }
 
 /* deprecated fields */
@@ -224,7 +224,7 @@ static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
 #define QUEUE_SYSFS_FEATURE(_name, _feature)				\
 static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 {									\
-	return sprintf(page, "%u\n",					\
+	return sysfs_emit(page, "%u\n",					\
 		!!(disk->queue->limits.features & _feature));		\
 }									\
 static ssize_t queue_##_name##_store(struct gendisk *disk,		\
@@ -241,7 +241,7 @@ QUEUE_SYSFS_FEATURE(stable_writes, BLK_FEAT_STABLE_WRITES);
 #define QUEUE_SYSFS_FEATURE_SHOW(_name, _feature)			\
 static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 {									\
-	return sprintf(page, "%u\n",					\
+	return sysfs_emit(page, "%u\n",					\
 		!!(disk->queue->limits.features & _feature));		\
 }
 
@@ -252,8 +252,8 @@ QUEUE_SYSFS_FEATURE_SHOW(dax, BLK_FEAT_DAX);
 static ssize_t queue_zoned_show(struct gendisk *disk, char *page)
 {
 	if (blk_queue_is_zoned(disk->queue))
-		return sprintf(page, "host-managed\n");
-	return sprintf(page, "none\n");
+		return sysfs_emit(page, "host-managed\n");
+	return sysfs_emit(page, "none\n");
 }
 
 static ssize_t queue_nr_zones_show(struct gendisk *disk, char *page)
@@ -366,7 +366,7 @@ static ssize_t queue_poll_store(struct gendisk *disk, const char *page,
 
 static ssize_t queue_io_timeout_show(struct gendisk *disk, char *page)
 {
-	return sprintf(page, "%u\n", jiffies_to_msecs(disk->queue->rq_timeout));
+	return sysfs_emit(page, "%u\n", jiffies_to_msecs(disk->queue->rq_timeout));
 }
 
 static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
@@ -387,8 +387,8 @@ static ssize_t queue_io_timeout_store(struct gendisk *disk, const char *page,
 static ssize_t queue_wc_show(struct gendisk *disk, char *page)
 {
 	if (blk_queue_write_cache(disk->queue))
-		return sprintf(page, "write back\n");
-	return sprintf(page, "write through\n");
+		return sysfs_emit(page, "write back\n");
+	return sysfs_emit(page, "write through\n");
 }
 
 static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
@@ -519,9 +519,9 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
 		return -EINVAL;
 
 	if (wbt_disabled(disk->queue))
-		return sprintf(page, "0\n");
+		return sysfs_emit(page, "0\n");
 
-	return sprintf(page, "%llu\n",
+	return sysfs_emit(page, "%llu\n",
 		div_u64(wbt_get_min_lat(disk->queue), 1000));
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index dfee66146bd1..1971c91d6f72 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -783,7 +783,7 @@ static ssize_t disk_badblocks_show(struct device *dev,
 	struct gendisk *disk = dev_to_disk(dev);
 
 	if (!disk->bb)
-		return sprintf(page, "\n");
+		return sysfs_emit(page, "\n");
 
 	return badblocks_show(disk->bb, page, 0);
 }
@@ -931,7 +931,7 @@ static ssize_t disk_range_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", disk->minors);
+	return sysfs_emit(buf, "%d\n", disk->minors);
 }
 
 static ssize_t disk_ext_range_show(struct device *dev,
@@ -939,7 +939,7 @@ static ssize_t disk_ext_range_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		(disk->flags & GENHD_FL_NO_PART) ? 1 : DISK_MAX_PARTS);
 }
 
@@ -948,7 +948,7 @@ static ssize_t disk_removable_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		       (disk->flags & GENHD_FL_REMOVABLE ? 1 : 0));
 }
 
@@ -957,7 +957,7 @@ static ssize_t disk_hidden_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		       (disk->flags & GENHD_FL_HIDDEN ? 1 : 0));
 }
 
@@ -966,13 +966,13 @@ static ssize_t disk_ro_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", get_disk_ro(disk) ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", get_disk_ro(disk) ? 1 : 0);
 }
 
 ssize_t part_size_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", bdev_nr_sectors(dev_to_bdev(dev)));
+	return sysfs_emit(buf, "%llu\n", bdev_nr_sectors(dev_to_bdev(dev)));
 }
 
 ssize_t part_stat_show(struct device *dev,
@@ -989,7 +989,7 @@ ssize_t part_stat_show(struct device *dev,
 		part_stat_unlock();
 	}
 	part_stat_read_all(bdev, &stat);
-	return sprintf(buf,
+	return sysfs_emit(buf,
 		"%8lu %8lu %8llu %8u "
 		"%8lu %8lu %8llu %8u "
 		"%8u %8u %8u "
@@ -1031,14 +1031,14 @@ ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 	else
 		part_in_flight_rw(bdev, inflight);
 
-	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
+	return sysfs_emit(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
 
 static ssize_t disk_capability_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	dev_warn_once(dev, "the capability attribute has been deprecated.\n");
-	return sprintf(buf, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 
 static ssize_t disk_alignment_offset_show(struct device *dev,
@@ -1047,7 +1047,7 @@ static ssize_t disk_alignment_offset_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", bdev_alignment_offset(disk->part0));
+	return sysfs_emit(buf, "%d\n", bdev_alignment_offset(disk->part0));
 }
 
 static ssize_t disk_discard_alignment_show(struct device *dev,
@@ -1056,7 +1056,7 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", bdev_alignment_offset(disk->part0));
+	return sysfs_emit(buf, "%d\n", bdev_alignment_offset(disk->part0));
 }
 
 static ssize_t diskseq_show(struct device *dev,
@@ -1064,13 +1064,13 @@ static ssize_t diskseq_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%llu\n", disk->diskseq);
+	return sysfs_emit(buf, "%llu\n", disk->diskseq);
 }
 
 static ssize_t partscan_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", disk_has_partscan(dev_to_disk(dev)));
+	return sysfs_emit(buf, "%u\n", disk_has_partscan(dev_to_disk(dev)));
 }
 
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
@@ -1092,7 +1092,7 @@ static DEVICE_ATTR(partscan, 0444, partscan_show, NULL);
 ssize_t part_fail_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		       bdev_test_flag(dev_to_bdev(dev), BD_MAKE_IT_FAIL));
 }
 
-- 
2.25.1

