Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5A145A1F
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984480; cv=none; b=H4iHvvCqlMh4BafdocqOADFXKU5Id7Yp1ZQKrLu48qWb1IBr0miMh2hvykeAxlNTxMsGT55H+b5V7bM/b0JnxcIrdU0Ao90sNqjUjfNNADTRxJ2ImnYVbrwLjU5IZgH/smz4+wrv+qa6zNSdu0oodAERUQGGAzxtgDCzGPGc4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984480; c=relaxed/simple;
	bh=zMUneItkQT4ap6NHXrIGS3NLD2eqq50u/DIsyQnmPsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fn4WtGzgtFvLDL+HFgVqW6aSJTCFa1esfbu5Ef4RavJcSWDegxCk413QhkDWqUqa3kHm5F1acydpdRdvVmQUePHVek6gpZ3z7ZjsRHOhber23SzXRDTlTVEi9ANyyGGD2AcZR87SKvxv32HEHfkb8u1e09E23SEvo5ot5egjH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3684f8cc914111f1aa26b74ffac11d73-20260806
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4f58fb76-ed6c-45e0-9ceb-17c53064162f,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:4f58fb76-ed6c-45e0-9ceb-17c53064162f,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:5c52547a3a1c626f87d5a788f3e6c566,BulkI
	D:26080610475311K4PVD8,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3684f8cc914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 445037446; Thu, 06 Aug 2026 10:47:49 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 4/4] block, nvme: use lower-level limit helpers for namespace heads
Date: Thu,  6 Aug 2026 10:46:58 +0800
Message-Id: <20260806024658.4193386-5-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806024658.4193386-1-sangyao@kylinos.cn>
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An NVMe namespace head and each path refer to the same namespace.
queue_limits_stack_bdev() treats the path as a bottom-device range and
applies all of blk_stack_limits(), including topology rules and start-based
atomic write checks. These mapped-device rules should not be used when
updating the namespace head.

Make blk_stack_path_limits() and the existing
blk_stack_atomic_writes_limits() public when adding their first caller
outside the block layer. Keep the existing names and parameter types.

Refresh logical_block_size, physical_block_size, io_min, io_opt,
discard_granularity, zone_write_granularity and the write stream limits
from the namespace that was just scanned. Keep chunk_sectors conservative
for non-zoned namespaces because NVME_QUIRK_STRIPE_SIZE can make it
controller-specific, while zoned namespaces refresh the zone size directly.

Use blk_stack_path_limits() for the all-path execution feature bits and
hardware limits that must work for every path, and use
blk_stack_atomic_writes_limits() with a zero start sector. Keep the
non-path feature handling in NVMe: the namespace head needs only inherited
features that can describe an NVMe path. Zoned is handled with the
namespace layout, and RAID partial stripes are not an NVMe namespace-head
property.

Keep max_user_* from queue_limits_start_update(), rebuild the integrity
profile with nvme_init_integrity(), and retain the existing write zeroes,
discard and zone resource updates in NVMe.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c     |  23 +++++++-
 drivers/nvme/host/core.c | 115 +++++++++++++++++++++++++++++----------
 include/linux/blkdev.h   |   4 ++
 3 files changed, 109 insertions(+), 33 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 40cd3490f168..877834e88745 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -726,8 +726,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 	return true;
 }
 
-static void blk_stack_atomic_writes_limits(struct queue_limits *t,
-				struct queue_limits *b, sector_t start)
+/**
+ * blk_stack_atomic_writes_limits - stack atomic write limits
+ * @t: the stacking driver limits (top device)
+ * @b: the underlying queue limits (bottom device)
+ * @start: first data sector within bottom device
+ */
+void blk_stack_atomic_writes_limits(struct queue_limits *t,
+		struct queue_limits *b, sector_t start)
 {
 	if (!(b->features & BLK_FEAT_ATOMIC_WRITES))
 		goto unsupported;
@@ -755,8 +761,18 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	t->atomic_write_hw_unit_min = 0;
 	t->atomic_write_hw_boundary = 0;
 }
+EXPORT_SYMBOL_GPL(blk_stack_atomic_writes_limits);
 
-static void blk_stack_path_limits(struct queue_limits *t,
+/**
+ * blk_stack_path_limits - update limits that must hold for every I/O path
+ * @t: the queue limits to update
+ * @b: the queue limits for an I/O path
+ *
+ * Clear BLK_FEAT_NOWAIT, BLK_FEAT_POLL and BLK_FEAT_PCI_P2PDMA when they
+ * are not set in @b. Stack the sector, segment, integrity segment and DMA
+ * alignment limits that every path must support.
+ */
+void blk_stack_path_limits(struct queue_limits *t,
 		const struct queue_limits *b)
 {
 	/*
@@ -785,6 +801,7 @@ static void blk_stack_path_limits(struct queue_limits *t,
 					   b->max_segment_size);
 	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 }
+EXPORT_SYMBOL_GPL(blk_stack_path_limits);
 
 /*
  * Stack and check logical_block_size, physical_block_size, io_min, io_opt,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e3d27c0440db..181394380510 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -11,6 +11,7 @@
 #include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/gcd.h>
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -2520,12 +2521,89 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	return ret;
 }
 
-static void nvme_stack_zone_resources(struct queue_limits *t,
-				      const struct queue_limits *b)
+static void nvme_apply_ns_head_identify_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
 {
-	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
-	t->max_active_zones =
-		min_not_zero(t->max_active_zones, b->max_active_zones);
+	/*
+	 * The namespace scan sets these values from Identify data and limits
+	 * calculated from it. Refresh them instead of combining them with values
+	 * left from an earlier namespace scan.
+	 */
+	lim->features &= ~BLK_FEAT_ZONED;
+	lim->features |= ns_lim->features & BLK_FEAT_ZONED;
+	lim->logical_block_size = ns_lim->logical_block_size;
+	lim->physical_block_size = ns_lim->physical_block_size;
+	lim->io_min = ns_lim->io_min;
+	lim->io_opt = ns_lim->io_opt;
+	/* A non-zoned path may have a controller-specific stripe size. */
+	if (ns_lim->features & BLK_FEAT_ZONED)
+		lim->chunk_sectors = ns_lim->chunk_sectors;
+	else if (ns_lim->chunk_sectors)
+		lim->chunk_sectors = gcd(lim->chunk_sectors,
+					 ns_lim->chunk_sectors);
+	lim->alignment_offset = 0;
+	lim->discard_alignment = 0;
+	lim->flags &= ~BLK_FLAG_MISALIGNED;
+	lim->discard_granularity = ns_lim->discard_granularity;
+	lim->zone_write_granularity = ns_lim->zone_write_granularity;
+	lim->max_write_streams = ns_lim->max_write_streams;
+	lim->write_stream_granularity = ns_lim->write_stream_granularity;
+}
+
+static void nvme_apply_ns_head_operation_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
+{
+	/* Keep the existing minimums for controller command limits. */
+	lim->max_write_zeroes_sectors =
+		min(lim->max_write_zeroes_sectors,
+		    ns_lim->max_write_zeroes_sectors);
+	lim->max_hw_wzeroes_unmap_sectors =
+		min(lim->max_hw_wzeroes_unmap_sectors,
+		    ns_lim->max_hw_wzeroes_unmap_sectors);
+	lim->max_discard_segments =
+		min_not_zero(lim->max_discard_segments,
+			     ns_lim->max_discard_segments);
+	if (ns_lim->discard_granularity)
+		lim->max_hw_discard_sectors =
+			min_not_zero(lim->max_hw_discard_sectors,
+				     ns_lim->max_hw_discard_sectors);
+	blk_stack_atomic_writes_limits(lim, ns_lim, 0);
+}
+
+static void nvme_apply_ns_head_zone_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
+{
+	/*
+	 * Zone geometry was set above. max_hw_zone_append_sectors must work
+	 * for every path, while max_open_zones and max_active_zones are
+	 * namespace resources.
+	 */
+	lim->max_hw_zone_append_sectors =
+		min(lim->max_hw_zone_append_sectors,
+		    ns_lim->max_hw_zone_append_sectors);
+	lim->max_open_zones = min_not_zero(lim->max_open_zones,
+					   ns_lim->max_open_zones);
+	lim->max_active_zones =
+		min_not_zero(lim->max_active_zones,
+			     ns_lim->max_active_zones);
+}
+
+static void nvme_apply_ns_head_limits(struct queue_limits *lim,
+		const struct queue_limits *ns_lim)
+{
+	nvme_apply_ns_head_identify_limits(lim, ns_lim);
+	/*
+	 * Keep inherited non-path features that can describe an NVMe path.
+	 * Zoned was handled as namespace layout above, and the RAID partial
+	 * stripes flag is not an NVMe namespace-head property.
+	 */
+	lim->features |= ns_lim->features &
+		(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
+		 BLK_FEAT_ROTATIONAL | BLK_FEAT_STABLE_WRITES);
+	blk_stack_path_limits(lim, ns_lim);
+	nvme_apply_ns_head_operation_limits(lim, ns_lim);
+	if (lim->features & BLK_FEAT_ZONED)
+		nvme_apply_ns_head_zone_limits(lim, ns_lim);
 }
 
 static int nvme_update_ns_head_limits(struct nvme_ns *ns,
@@ -2539,35 +2617,12 @@ static int nvme_update_ns_head_limits(struct nvme_ns *ns,
 
 	lim = queue_limits_start_update(head_q);
 	memflags = blk_mq_freeze_queue(head_q);
-	/*
-	 * queue_limits mixes values that are the hardware limitations
-	 * for bio splitting with what is the device configuration.
-	 *
-	 * For NVMe the device configuration can change after e.g. a
-	 * Format command, and we really want to pick up the new format
-	 * value here. But we must still stack the queue limits to the
-	 * least common denominator for multipathing to split the bios
-	 * properly.
-	 *
-	 * To work around this, we explicitly set the device
-	 * configuration to those that we just queried, but only stack
-	 * the splitting limits in to make sure we still obey possibly
-	 * lower limitations of other controllers.
-	 */
-	lim.logical_block_size = ns_lim->logical_block_size;
-	lim.physical_block_size = ns_lim->physical_block_size;
-	lim.io_min = ns_lim->io_min;
-	lim.io_opt = ns_lim->io_opt;
-	queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
-				ns->head->disk->disk_name);
-	if (lim.features & BLK_FEAT_ZONED)
-		nvme_stack_zone_resources(&lim, ns_lim);
+
+	nvme_apply_ns_head_limits(&lim, ns_lim);
 	if (unsupported)
 		ns->head->disk->flags |= GENHD_FL_HIDDEN;
 	else
 		nvme_init_integrity(ns->head, &lim, info);
-	lim.max_write_streams = ns_lim->max_write_streams;
-	lim.write_stream_granularity = ns_lim->write_stream_granularity;
 	ret = queue_limits_commit_update(head_q, &lim);
 	if (ret)
 		goto unfreeze_head_queue;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..b89930f1f7a6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1153,6 +1153,10 @@ static inline void blk_queue_disable_write_zeroes(struct request_queue *q)
  */
 extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
+void blk_stack_path_limits(struct queue_limits *t,
+		const struct queue_limits *b);
+void blk_stack_atomic_writes_limits(struct queue_limits *t,
+		struct queue_limits *b, sector_t start);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
 void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
-- 
2.25.1

