Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802F5476CC4
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307201; cv=none; b=r/M3H7WkKupyUqu5anurpzWAMYVVRrNMWyQ7mOtrfowfqraWkxldnn00oGsIvjIRqY26g5WaO7OtHEiwrhRmVQXsLEzMgUTpl4hxXQxHvxeFLYmXNLoDqNypyWfIxvHUIcCt1K+PLOL2f3NP9cGCqsJriB4b1hJ8bQkZTT/ZBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307201; c=relaxed/simple;
	bh=1kgWKmgZ3AXcPVQSWwtw7+639g9rIpY7KUGi0X/l4UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZDKIWxbpGEA3Jd7V5vcfvwhYc2OAyKphJ+qImWnt6tNchCL7zIgexy2aMeazuRyB6OqiDQzlKzUdGXlmjYDucYUUV4NW63F34n0BbivcYC0Dlwvso753g9GnOcd3OSiMxq8kB4Hb1d5iKFvf15hpQUieYIi2o73aIG0YA/tdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e02595369d4811f19a56ed5b684f684d-20260821
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:03e0e475-b79d-45cc-9eca-cd22afba690a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:03e0e475-b79d-45cc-9eca-cd22afba690a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:df5cc0341e5d0c6d6e9f7283223e139b,BulkI
	D:260821181258VGCIJP3I,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e02595369d4811f19a56ed5b684f684d-20260821
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 382005632; Fri, 21 Aug 2026 18:12:54 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3 5/5] block, nvme: add same-LBA multipath limit helpers
Date: Fri, 21 Aug 2026 18:10:50 +0800
Message-Id: <20260821101050.1464087-6-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821101050.1464087-1-sangyao@kylinos.cn>
References: <20260821101050.1464087-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A same-LBA multipath head and its paths address the same logical block
space, so they do not need mapped-range topology calculations.

Add blk_stack_mpath_limits() to stack limits that may differ between
paths, and blk_set_mpath_head_limits() to set head limits that are
expected to be identical across paths. Export both helpers and use them
for NVMe namespace heads.

Initialize max_hw_discard_sectors to UINT_MAX before stacking the first
path. A zero limit means that a path does not support discard, so it
disables discard for the head.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c          | 58 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      | 34 ++-------------------
 drivers/nvme/host/multipath.c |  2 ++
 include/linux/blkdev.h        |  3 ++
 4 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index eaba38370657..8f70bab0a814 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -800,6 +800,64 @@ static void blk_stack_path_limits(struct queue_limits *t,
 	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 }
 
+/**
+ * blk_set_mpath_head_limits - set head limits common to all paths
+ * @t: limits for the multipath head
+ * @b: limits for one path
+ *
+ * Set head limits that are expected to be identical across paths. Stack
+ * limits that may differ between paths with blk_stack_mpath_limits().
+ */
+void blk_set_mpath_head_limits(struct queue_limits *t,
+			       struct queue_limits *b)
+{
+	t->logical_block_size = b->logical_block_size;
+	t->physical_block_size = b->physical_block_size;
+	t->alignment_offset = b->alignment_offset;
+	t->io_min = b->io_min;
+	t->io_opt = b->io_opt;
+	t->discard_granularity = b->discard_granularity;
+	t->discard_alignment = b->discard_alignment;
+	t->zone_write_granularity = b->zone_write_granularity;
+	t->max_write_streams = b->max_write_streams;
+	t->write_stream_granularity = b->write_stream_granularity;
+}
+EXPORT_SYMBOL_GPL(blk_set_mpath_head_limits);
+
+/**
+ * blk_stack_mpath_limits - stack limits across same-LBA multipath paths
+ * @t: limits for the multipath head
+ * @b: limits for one path
+ *
+ * Stack limits in @b that may differ between paths. Unlike
+ * blk_stack_limits(), this does not apply mapped-range topology or a mapping
+ * offset. Set limits that are expected to be identical across paths with
+ * blk_set_mpath_head_limits().
+ *
+ * Initialize @t with blk_set_stacking_limits() and set features that require
+ * support from every path before the first call. Set
+ * @t->max_hw_discard_sectors to UINT_MAX and call once for each path. A zero
+ * discard limit disables discard for the head.
+ */
+void blk_stack_mpath_limits(struct queue_limits *t, struct queue_limits *b)
+{
+	if (b->chunk_sectors)
+		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
+
+	t->features |= b->features &
+		(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
+		 BLK_FEAT_ROTATIONAL | BLK_FEAT_STABLE_WRITES);
+	blk_stack_path_limits(t, b);
+	STACK_MIN(t, b, max_hw_discard_sectors);
+	blk_stack_atomic_writes_hw_limits(t, b);
+
+	if (t->features & BLK_FEAT_ZONED) {
+		STACK_MIN_NOT_ZERO(t, b, max_open_zones);
+		STACK_MIN_NOT_ZERO(t, b, max_active_zones);
+	}
+}
+EXPORT_SYMBOL_GPL(blk_stack_mpath_limits);
+
 /*
  * Stack block sizes, I/O granularities, chunk boundaries and alignment for a
  * bottom-device range mapped at @start. Round maximum sector limits after the
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e2b44ed4366..a16986ec1c8e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2530,14 +2530,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	return ret;
 }
 
-static void nvme_stack_zone_resources(struct queue_limits *t,
-				      const struct queue_limits *b)
-{
-	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
-	t->max_active_zones =
-		min_not_zero(t->max_active_zones, b->max_active_zones);
-}
-
 static int nvme_update_ns_head_limits(struct nvme_ns *ns,
 		struct nvme_ns_info *info, bool unsupported)
 {
@@ -2549,34 +2541,12 @@ static int nvme_update_ns_head_limits(struct nvme_ns *ns,
 
 	lim = queue_limits_start_update(head_q);
 	memflags = blk_mq_freeze_queue(head_q);
-	/*
-	 * queue_limits mixes hardware limitations for bio splitting with device
-	 * configuration.
-	 *
-	 * For NVMe the device configuration can change after e.g. a Format
-	 * command, and we really want to pick up the new format value here. But
-	 * we must still stack the queue limits to the least common denominator
-	 * for multipathing to split the bios properly.
-	 *
-	 * To work around this, we explicitly set the device configuration to
-	 * those that we just queried, but only stack the splitting limits in to
-	 * make sure we still obey possibly lower limitations of other
-	 * controllers.
-	 */
-	lim.logical_block_size = ns_lim->logical_block_size;
-	lim.physical_block_size = ns_lim->physical_block_size;
-	lim.io_min = ns_lim->io_min;
-	lim.io_opt = ns_lim->io_opt;
-	queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
-				ns->head->disk->disk_name);
-	if (lim.features & BLK_FEAT_ZONED)
-		nvme_stack_zone_resources(&lim, ns_lim);
+	blk_set_mpath_head_limits(&lim, ns_lim);
+	blk_stack_mpath_limits(&lim, ns_lim);
 	if (unsupported)
 		ns->head->disk->flags |= GENHD_FL_HIDDEN;
 	else
 		nvme_init_integrity(ns->head, &lim, info);
-	lim.max_write_streams = ns_lim->max_write_streams;
-	lim.write_stream_granularity = ns_lim->write_stream_granularity;
 	ret = queue_limits_commit_update(head_q, &lim);
 	if (ret)
 		goto unfreeze_head_queue;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..448c7f33c687 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -760,6 +760,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		return 0;
 
 	blk_set_stacking_limits(&lim);
+	/* No path discard limit has been stacked yet. */
+	lim.max_hw_discard_sectors = UINT_MAX;
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
 		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES | BLK_FEAT_PCI_P2PDMA;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..2fe711c196c9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1153,6 +1153,9 @@ static inline void blk_queue_disable_write_zeroes(struct request_queue *q)
  */
 extern void blk_set_queue_depth(struct request_queue *q, unsigned int depth);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
+void blk_set_mpath_head_limits(struct queue_limits *t,
+			       struct queue_limits *b);
+void blk_stack_mpath_limits(struct queue_limits *t, struct queue_limits *b);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
 void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
-- 
2.25.1
