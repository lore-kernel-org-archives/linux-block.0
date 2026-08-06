Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D5145A1F
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984477; cv=none; b=jQlKRNxDUecdbzEI2L39meYN0s7hzlfLcKrAgl45Ven0Blv06wviECAw7Ng+5QIPEsIHUrXLSjPfhg1xcUnyHsFiMwmqSZw8c/h64uJZV3MT+KJ3Zpfr8mvEz/zPJks3LsoSF0Ta5EAK64Rvfgw5PtoXAB8kP8QSZtBqzl/cRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984477; c=relaxed/simple;
	bh=MXzHzuf0dFtsrsYLM+ZSdkW+QpEzZEOBIi5iQAdXI/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbpT8vHEgw0uozBT1FLbff4tdXJX5eUnIPJ8ED/4X/6w+K3u1uKOHGbFIWFmKgFmND8kATUaCHzVxKRmwAEiZcTdKus3BDG5VEpK2l2D1l5KIrby5A2ee1NARouvBBxj6ZErfq76ACgqfPtE2XUnmrlLNjcbsiH3iO+5iEvCLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 353f2f46914111f1aa26b74ffac11d73-20260806
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
X-CID-O-INFO: VERSION:1.3.12,REQID:5db77fe2-c0bf-489b-b894-1b10cc5d512e,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:5db77fe2-c0bf-489b-b894-1b10cc5d512e,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:cd9f173ad21c810817573a75a9eaf514,BulkI
	D:260806102007XF5NZSUG,BulkQuantity:1,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 353f2f46914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1216409502; Thu, 06 Aug 2026 10:47:47 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 3/4] block: factor out path limit stacking
Date: Thu,  6 Aug 2026 10:46:57 +0800
Message-Id: <20260806024658.4193386-4-sangyao@kylinos.cn>
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

Some queue limits are path limits: every queue that can execute an I/O
must support them, and they do not depend on start, the first data sector
used in a bottom device.

This includes BLK_FEAT_NOWAIT, BLK_FEAT_POLL, BLK_FEAT_PCI_P2PDMA,
max_hw_sectors, max_dev_sectors, seg_boundary_mask, virt_boundary_mask,
max_segments, max_integrity_segments, max_segment_size and dma_alignment.

Move these path limits into a static blk_stack_path_limits() helper and
call it from blk_stack_limits(). Keep topology, discard alignment, atomic
writes and other operation and resource limits in blk_stack_limits() where
the caller context is still available.

There is no behavior change.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 59 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1aff818aaaac..40cd3490f168 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -756,6 +756,36 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	t->atomic_write_hw_boundary = 0;
 }
 
+static void blk_stack_path_limits(struct queue_limits *t,
+		const struct queue_limits *b)
+{
+	/*
+	 * Some features need to be supported both by the stacking driver and all
+	 * underlying devices. The stacking driver sets these flags before
+	 * stacking the limits, and this will clear the flags if any of the
+	 * underlying devices does not support it.
+	 */
+	if (!(b->features & BLK_FEAT_NOWAIT))
+		t->features &= ~BLK_FEAT_NOWAIT;
+	if (!(b->features & BLK_FEAT_POLL))
+		t->features &= ~BLK_FEAT_POLL;
+	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
+		t->features &= ~BLK_FEAT_PCI_P2PDMA;
+
+	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
+	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
+	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
+					    b->seg_boundary_mask);
+	t->virt_boundary_mask = min_not_zero(t->virt_boundary_mask,
+					     b->virt_boundary_mask);
+	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
+	t->max_integrity_segments = min_not_zero(t->max_integrity_segments,
+						 b->max_integrity_segments);
+	t->max_segment_size = min_not_zero(t->max_segment_size,
+					   b->max_segment_size);
+	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
+}
+
 /*
  * Stack and check logical_block_size, physical_block_size, io_min, io_opt,
  * chunk_sectors and alignment_offset for a bottom-device range, then round
@@ -874,25 +904,11 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	int ret;
 
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
-
-	/*
-	 * Some feaures need to be supported both by the stacking driver and all
-	 * underlying devices.  The stacking driver sets these flags before
-	 * stacking the limits, and this will clear the flags if any of the
-	 * underlying devices does not support it.
-	 */
-	if (!(b->features & BLK_FEAT_NOWAIT))
-		t->features &= ~BLK_FEAT_NOWAIT;
-	if (!(b->features & BLK_FEAT_POLL))
-		t->features &= ~BLK_FEAT_POLL;
-	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
-		t->features &= ~BLK_FEAT_PCI_P2PDMA;
+	blk_stack_path_limits(t, b);
 
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_user_sectors = min_not_zero(t->max_user_sectors,
 			b->max_user_sectors);
-	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
-	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
 	t->max_user_wzeroes_unmap_sectors =
@@ -904,21 +920,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->max_hw_zone_append_sectors = min(t->max_hw_zone_append_sectors,
 					b->max_hw_zone_append_sectors);
-
-	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
-					    b->seg_boundary_mask);
-	t->virt_boundary_mask = min_not_zero(t->virt_boundary_mask,
-					    b->virt_boundary_mask);
-
-	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
 	t->max_discard_segments = min_not_zero(t->max_discard_segments,
 					       b->max_discard_segments);
-	t->max_integrity_segments = min_not_zero(t->max_integrity_segments,
-						 b->max_integrity_segments);
-
-	t->max_segment_size = min_not_zero(t->max_segment_size,
-					   b->max_segment_size);
-	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 
 	ret = blk_stack_topology_limits(t, b, start);
 
-- 
2.25.1

