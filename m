Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B04476CCA
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307182; cv=none; b=NayGaC32vL9l7/cAZW+h8l6QJfoVZEsGjoaVj1O2fHMgSzhhtcO+r4FAup7W7YtOwBG3LKSq5n75PrNJVoG8gM2ix5xs29xvnbQiieMgfA9hEIHnSOXd0N1fXgx0tLdn/2oVfl690KYSc1+u5e5qUpQhggrvNCZK9W7Cwhk0cvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307182; c=relaxed/simple;
	bh=SEO6eBupGPzCuV4jTbqIZwMGIlRi/oGMMzHopVq8A9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unnHEJNXhq29xf2U0oljNtKe4HrYzLhpZt6mhGomImeevQFWXvRZ1+ZSeBtQwH5WbWsm/GZUhYbsNYV6KV8ZAl3PRvHO9xhL9POrWd4yn9z11rrKbdN7NdLpWPSaA10HxOZvSxrWlbSb+/4snFLxXOrw3h6vp9Buno0QIs9pyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d6ec77aa9d4811f19a56ed5b684f684d-20260821
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
X-CID-O-INFO: VERSION:1.3.19,REQID:ec57f6a9-5355-45e6-acfe-4a9308b43b75,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:ec57f6a9-5355-45e6-acfe-4a9308b43b75,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:30380d92299aaf49dfed99345025fbe0,BulkI
	D:260821181243QOG2I3OQ,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|136|850
	|865|898,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d6ec77aa9d4811f19a56ed5b684f684d-20260821
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1930899336; Fri, 21 Aug 2026 18:12:39 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: john.g.garry@oracle.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3 1/5] nvme: factor namespace-head queue-limit update
Date: Fri, 21 Aug 2026 18:10:46 +0800
Message-Id: <20260821101050.1464087-2-sangyao@kylinos.cn>
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

Move the namespace-head queue-limit update out of nvme_update_ns_info().
The update is self-contained, and moving it into a separate helper makes
the namespace scan easier to follow.

There is no behavior change.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 103 +++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb..8e2b44ed4366 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2538,6 +2538,59 @@ static void nvme_stack_zone_resources(struct queue_limits *t,
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
+	 * queue_limits mixes hardware limitations for bio splitting with device
+	 * configuration.
+	 *
+	 * For NVMe the device configuration can change after e.g. a Format
+	 * command, and we really want to pick up the new format value here. But
+	 * we must still stack the queue limits to the least common denominator
+	 * for multipathing to split the bios properly.
+	 *
+	 * To work around this, we explicitly set the device configuration to
+	 * those that we just queried, but only stack the splitting limits in to
+	 * make sure we still obey possibly lower limitations of other
+	 * controllers.
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
@@ -2576,54 +2629,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
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

