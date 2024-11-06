Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A67D3F4;
	Wed,  6 Nov 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882125; cv=none; b=F8LKGgX9x3Yxbm9idKe/a8Bv/YSaRfS5YqZ7n9Lh4hFVFq+jJf8KhwP+swPnFU2nH+aD5k9G+MYvo9NPcirC/nC3PYHUFVf313omJacACowRMw1K8dxopY6SUkAbfBF2Jomuqf/S9pUe3d09fGRjRd+5DeRP2LMYjTHUsWdfdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882125; c=relaxed/simple;
	bh=kUqqIKgiFFJzv4HHJPiP76Qc9eSoiFnLNkgz2X/wvhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KczLn5bG4gOvk5uKFMldmhM1wbvhF7jjUvhTEYRlVNdX0piYW5PffpcDAvMpoecgmZSBXXcpDH8OL5fpvkdU45P4tnpWzTrQXeNiZ2+g8unklf+dkj+0qAP/HnK2eu9/ueTQ26jeZLOb8b5YWRRLgYeD+ESURmyIddiIsIT0wTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0afa3f969c1a11efa216b1d71e6e1362-20241106
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fef56355-aea7-4b62-830e-eb23ce805836,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.38,REQID:fef56355-aea7-4b62-830e-eb23ce805836,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:82c5f88,CLOUDID:4455244deb510a9d99aeef8ea48b9635,BulkI
	D:241106163515CSSO1HLZ,BulkQuantity:0,Recheck:0,SF:44|66|841|38|24|72|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0afa3f969c1a11efa216b1d71e6e1362-20241106
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1740170890; Wed, 06 Nov 2024 16:35:13 +0800
From: zhangguopeng <zhangguopeng@kylinos.cn>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: hch@lst.de,
	ming.lei@redhat.com,
	yukuai3@huawei.com,
	linux-kernel@vger.kernel.org,
	zhangguopeng <zhangguopeng@kylinos.cn>
Subject: [PATCH] block: Replace sprintf() with sysfs_emit()
Date: Wed,  6 Nov 2024 16:34:54 +0800
Message-Id: <20241106083454.45887-1-zhangguopeng@kylinos.cn>
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
---
 block/blk-sysfs.c | 24 ++++++++++++------------
 block/genhd.c     | 30 +++++++++++++++---------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d9f22122ae2f..6f25d2ca76c0 100644
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
+	return sysfs_emit(page, "%llu\n",					\
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

