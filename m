Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8926A0D5
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984468; cv=none; b=bXDP/hO9jDtR+ZTW800kM+fqIFVznXk6SzJBZ1kAmKS1n7IYIjcMCeUHQjtBZjx2gL8cI2rGUoGswZW789mLpVBXPQq7rR25vJRt+zQPF1hqa6ahMA5TUNtNLWbdoA5A/CrttM85ZaQEkQU5VFMoS4wq3IXl//ICzSIOGDqafnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984468; c=relaxed/simple;
	bh=Afjx7UE5mTamxAV3poAtqqO4UeA2ar2/DALGBq607c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pN/kb4P2zuhHt/LQ3YiBhvjoIdyO/9POnWxPL/Eu0KHCelUEo3PwiJ2NjWZ7FuPq/wzCLlz93QW5ik3sP2aSBCaQjK03A7ipFjXksE/eO2ckIDBokIoAfRkFBW07dcq5Gqp2Sfx91QlOx2r0PzBJkye3nUZtJtOMbkm/gX/2RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2f43a2e8914111f1aa26b74ffac11d73-20260806
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
X-CID-O-INFO: VERSION:1.3.12,REQID:44dc73f2-efb9-4882-a671-6d9907bdd905,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:44dc73f2-efb9-4882-a671-6d9907bdd905,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:9bee64b52ec2cd609e7e9d9bea0f0120,BulkI
	D:2608061020071ICVMFH9,BulkQuantity:1,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f43a2e8914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 253893869; Thu, 06 Aug 2026 10:47:37 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 2/4] block: factor block size and alignment handling out of blk_stack_limits
Date: Thu,  6 Aug 2026 10:46:56 +0800
Message-Id: <20260806024658.4193386-3-sangyao@kylinos.cn>
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

Topology limits are the block size and alignment limits that the top
device exposes after its data is placed at an offset on a bottom device.
blk_stack_limits() uses start, the first data sector in the bottom device
used by the top device, to calculate alignment_offset.

It then stacks logical_block_size, physical_block_size, io_min, io_opt and
chunk_sectors, checks that they are compatible, and rounds max_sectors,
max_hw_sectors and max_dev_sectors down to the final logical_block_size.

Keep these operations together because the checks and rounding must run
after the final logical and physical block sizes are known. Factor them
into a static blk_stack_topology_limits() helper.

There is no behavior change.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 block/blk-settings.c | 169 ++++++++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 76 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8274631290db..1aff818aaaac 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -756,6 +756,96 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	t->atomic_write_hw_boundary = 0;
 }
 
+/*
+ * Stack and check logical_block_size, physical_block_size, io_min, io_opt,
+ * chunk_sectors and alignment_offset for a bottom-device range, then round
+ * max_sectors, max_hw_sectors and max_dev_sectors to logical_block_size.
+ */
+static int blk_stack_topology_limits(struct queue_limits *t,
+		const struct queue_limits *b, sector_t start)
+{
+	unsigned int top, bottom, alignment;
+	int ret = 0;
+
+	t->flags |= b->flags & BLK_FLAG_MISALIGNED;
+
+	alignment = queue_limit_alignment_offset(b, start);
+
+	/*
+	 * The bottom device has a different alignment. Check that it is
+	 * compatible with the current top alignment.
+	 */
+	if (t->alignment_offset != alignment) {
+		top = max(t->physical_block_size, t->io_min) +
+			t->alignment_offset;
+		bottom = max(b->physical_block_size, b->io_min) + alignment;
+
+		/* Verify that top and bottom intervals line up. */
+		if (max(top, bottom) % min(top, bottom)) {
+			t->flags |= BLK_FLAG_MISALIGNED;
+			ret = -1;
+		}
+	}
+
+	t->logical_block_size = max(t->logical_block_size,
+				    b->logical_block_size);
+	t->physical_block_size = max(t->physical_block_size,
+				     b->physical_block_size);
+	t->io_min = max(t->io_min, b->io_min);
+	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+
+	/* Set non-power-of-2 compatible chunk_sectors boundary. */
+	if (b->chunk_sectors)
+		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
+
+	/* Physical block size a multiple of the logical block size? */
+	if (t->physical_block_size & (t->logical_block_size - 1)) {
+		t->physical_block_size = t->logical_block_size;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* Minimum I/O a multiple of the physical block size? */
+	if (t->io_min & (t->physical_block_size - 1)) {
+		t->io_min = t->physical_block_size;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* Optimal I/O a multiple of the physical block size? */
+	if (t->io_opt & (t->physical_block_size - 1)) {
+		t->io_opt = 0;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* chunk_sectors a multiple of the physical block size? */
+	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
+		t->chunk_sectors = 0;
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	/* Find lowest common alignment_offset. */
+	t->alignment_offset = lcm_not_zero(t->alignment_offset, alignment) %
+		max(t->physical_block_size, t->io_min);
+
+	/* Verify that new alignment_offset is on a logical block boundary. */
+	if (t->alignment_offset & (t->logical_block_size - 1)) {
+		t->flags |= BLK_FLAG_MISALIGNED;
+		ret = -1;
+	}
+
+	t->max_sectors = blk_round_down_sectors(t->max_sectors,
+						t->logical_block_size);
+	t->max_hw_sectors = blk_round_down_sectors(t->max_hw_sectors,
+						   t->logical_block_size);
+	t->max_dev_sectors = blk_round_down_sectors(t->max_dev_sectors,
+						    t->logical_block_size);
+
+	return ret;
+}
+
 /**
  * blk_stack_limits - adjust queue_limits for stacked devices
  * @t:	the stacking driver limits (top device)
@@ -780,8 +870,8 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment;
-	int ret = 0;
+	unsigned int alignment;
+	int ret;
 
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
 
@@ -798,8 +888,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	if (!(b->features & BLK_FEAT_PCI_P2PDMA))
 		t->features &= ~BLK_FEAT_PCI_P2PDMA;
 
-	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
-
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_user_sectors = min_not_zero(t->max_user_sectors,
 			b->max_user_sectors);
@@ -830,80 +918,9 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->max_segment_size = min_not_zero(t->max_segment_size,
 					   b->max_segment_size);
-
-	alignment = queue_limit_alignment_offset(b, start);
-
-	/* Bottom device has different alignment.  Check that it is
-	 * compatible with the current top alignment.
-	 */
-	if (t->alignment_offset != alignment) {
-
-		top = max(t->physical_block_size, t->io_min)
-			+ t->alignment_offset;
-		bottom = max(b->physical_block_size, b->io_min) + alignment;
-
-		/* Verify that top and bottom intervals line up */
-		if (max(top, bottom) % min(top, bottom)) {
-			t->flags |= BLK_FLAG_MISALIGNED;
-			ret = -1;
-		}
-	}
-
-	t->logical_block_size = max(t->logical_block_size,
-				    b->logical_block_size);
-
-	t->physical_block_size = max(t->physical_block_size,
-				     b->physical_block_size);
-
-	t->io_min = max(t->io_min, b->io_min);
-	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
 	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 
-	/* Set non-power-of-2 compatible chunk_sectors boundary */
-	if (b->chunk_sectors)
-		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
-
-	/* Physical block size a multiple of the logical block size? */
-	if (t->physical_block_size & (t->logical_block_size - 1)) {
-		t->physical_block_size = t->logical_block_size;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* Minimum I/O a multiple of the physical block size? */
-	if (t->io_min & (t->physical_block_size - 1)) {
-		t->io_min = t->physical_block_size;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* Optimal I/O a multiple of the physical block size? */
-	if (t->io_opt & (t->physical_block_size - 1)) {
-		t->io_opt = 0;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* chunk_sectors a multiple of the physical block size? */
-	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
-		t->chunk_sectors = 0;
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	/* Find lowest common alignment_offset */
-	t->alignment_offset = lcm_not_zero(t->alignment_offset, alignment)
-		% max(t->physical_block_size, t->io_min);
-
-	/* Verify that new alignment_offset is on a logical block boundary */
-	if (t->alignment_offset & (t->logical_block_size - 1)) {
-		t->flags |= BLK_FLAG_MISALIGNED;
-		ret = -1;
-	}
-
-	t->max_sectors = blk_round_down_sectors(t->max_sectors, t->logical_block_size);
-	t->max_hw_sectors = blk_round_down_sectors(t->max_hw_sectors, t->logical_block_size);
-	t->max_dev_sectors = blk_round_down_sectors(t->max_dev_sectors, t->logical_block_size);
+	ret = blk_stack_topology_limits(t, b, start);
 
 	/* Discard alignment and granularity */
 	if (b->discard_granularity) {
-- 
2.25.1

