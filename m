Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63F19E97B
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984466; cv=none; b=K3V1fcciRZoN4fJQLzk6REm4XBpjL0iOgsPQXOom1HDElfGJZiSxqQePPbNodiut6sphEUFYSfWWyXKIDc+eLDY7TL223G+HjcPE/SJP5cdsV7oW27r/9thzDgQoD3C1kFcOz7yKL0SFIfnlgQawkzgzCKHR0xUKROlaEB7RVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984466; c=relaxed/simple;
	bh=KEOsPVnv9+QgqjXLA5ZaNnG3C0eZDIyuIclYiLRhSiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7sL4SYTv2hniTPKD5niCsGIy3TbeJSa77aaUOBNBGXIq2SWooLB7h61UZRNYW2bCSntYo8aJUtTqadwrg+Lti7p/2oOTmn2Su0eLv0vmtUGGuu+KJbFFZXDuIz5d2spRx4PqiPmpc8aue1amQukbAT+NoKrfcCdT2PF1mb8F6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2cfa1882914111f1aa26b74ffac11d73-20260806
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
X-CID-O-INFO: VERSION:1.3.12,REQID:a027dfa6-c262-417c-8cce-16ecc6c87673,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:a027dfa6-c262-417c-8cce-16ecc6c87673,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:c03467de46b45fe85e373a49bfd9b583,BulkI
	D:260806104738XNN5D7JN,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2cfa1882914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 866893979; Thu, 06 Aug 2026 10:47:33 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 1/4] nvme: factor namespace-head queue-limit update
Date: Thu,  6 Aug 2026 10:46:55 +0800
Message-Id: <20260806024658.4193386-2-sangyao@kylinos.cn>
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

Move the namespace head queue-limit update out of nvme_update_ns_info().
The new helper keeps the current queue_limits_stack_bdev() based behavior
intact, including zoned resource handling, write-stream assignment,
integrity setup, capacity and readonly updates, path revalidation, and
namespace-head zone revalidation.

Keep queue-limit commit failures on the existing short-circuit path so
capacity and namespace-head state are only updated after a successful
limits update.

The helper gives namespace-head queue-limit updates a single NVMe-local
entry point while keeping the namespace information refresh sequencing
unchanged.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 104 +++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb93ada4376a..e3d27c0440db 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2528,6 +2528,60 @@ static void nvme_stack_zone_resources(struct queue_limits *t,
 		min_not_zero(t->max_active_zones, b->max_active_zones);
 }
 
+static int nvme_update_ns_head_limits(struct nvme_ns *ns,
+		struct nvme_ns_info *info, bool unsupported)
+{
+	struct queue_limits *ns_lim = &ns->disk->queue->limits;
+	struct request_queue *head_q = ns->head->disk->queue;
+	struct queue_limits lim;
+	unsigned int memflags;
+	int ret;
+
+	lim = queue_limits_start_update(head_q);
+	memflags = blk_mq_freeze_queue(head_q);
+	/*
+	 * queue_limits mixes values that are the hardware limitations
+	 * for bio splitting with what is the device configuration.
+	 *
+	 * For NVMe the device configuration can change after e.g. a
+	 * Format command, and we really want to pick up the new format
+	 * value here. But we must still stack the queue limits to the
+	 * least common denominator for multipathing to split the bios
+	 * properly.
+	 *
+	 * To work around this, we explicitly set the device
+	 * configuration to those that we just queried, but only stack
+	 * the splitting limits in to make sure we still obey possibly
+	 * lower limitations of other controllers.
+	 */
+	lim.logical_block_size = ns_lim->logical_block_size;
+	lim.physical_block_size = ns_lim->physical_block_size;
+	lim.io_min = ns_lim->io_min;
+	lim.io_opt = ns_lim->io_opt;
+	queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
+				ns->head->disk->disk_name);
+	if (lim.features & BLK_FEAT_ZONED)
+		nvme_stack_zone_resources(&lim, ns_lim);
+	if (unsupported)
+		ns->head->disk->flags |= GENHD_FL_HIDDEN;
+	else
+		nvme_init_integrity(ns->head, &lim, info);
+	lim.max_write_streams = ns_lim->max_write_streams;
+	lim.write_stream_granularity = ns_lim->write_stream_granularity;
+	ret = queue_limits_commit_update(head_q, &lim);
+	if (ret)
+		goto unfreeze_head_queue;
+
+	set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
+	set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
+	nvme_mpath_revalidate_paths(ns->head);
+	ret = nvme_mpath_revalidate_zones(ns->head);
+
+unfreeze_head_queue:
+	blk_mq_unfreeze_queue(head_q, memflags);
+	return ret;
+}
+
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	bool unsupported = false;
@@ -2566,54 +2620,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		ret = 0;
 	}
 
-	if (!ret && nvme_ns_head_multipath(ns->head)) {
-		struct queue_limits *ns_lim = &ns->disk->queue->limits;
-		struct queue_limits lim;
-		unsigned int memflags;
-
-		lim = queue_limits_start_update(ns->head->disk->queue);
-		memflags = blk_mq_freeze_queue(ns->head->disk->queue);
-		/*
-		 * queue_limits mixes values that are the hardware limitations
-		 * for bio splitting with what is the device configuration.
-		 *
-		 * For NVMe the device configuration can change after e.g. a
-		 * Format command, and we really want to pick up the new format
-		 * value here.  But we must still stack the queue limits to the
-		 * least common denominator for multipathing to split the bios
-		 * properly.
-		 *
-		 * To work around this, we explicitly set the device
-		 * configuration to those that we just queried, but only stack
-		 * the splitting limits in to make sure we still obey possibly
-		 * lower limitations of other controllers.
-		 */
-		lim.logical_block_size = ns_lim->logical_block_size;
-		lim.physical_block_size = ns_lim->physical_block_size;
-		lim.io_min = ns_lim->io_min;
-		lim.io_opt = ns_lim->io_opt;
-		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
-					ns->head->disk->disk_name);
-		if (lim.features & BLK_FEAT_ZONED)
-			nvme_stack_zone_resources(&lim, ns_lim);
-		if (unsupported)
-			ns->head->disk->flags |= GENHD_FL_HIDDEN;
-		else
-			nvme_init_integrity(ns->head, &lim, info);
-		lim.max_write_streams = ns_lim->max_write_streams;
-		lim.write_stream_granularity = ns_lim->write_stream_granularity;
-		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
-		if (ret)
-			goto unfreeze_head_queue;
-
-		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns->head);
-		ret = nvme_mpath_revalidate_zones(ns->head);
-
-unfreeze_head_queue:
-		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
-	}
+	if (!ret && nvme_ns_head_multipath(ns->head))
+		ret = nvme_update_ns_head_limits(ns, info, unsupported);
 
 	return ret;
 }
-- 
2.25.1

