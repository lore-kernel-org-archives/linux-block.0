Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2C17574;
	Tue, 13 Feb 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809699; cv=none; b=DroobdQd0fZ8CJ6VloO+9jf0+YqPdSLC3p7V/xgyRJHNQdqXbvC6n+2z1qJ0Yu1oaJy5A4Uv6hRvQ828Rl7QowNkic4giwwB/GVNxdJYOTh1bC6t+wHTYnn5uTNAsqYZbF98OcDKBzr3nq3ucA8hD+b/W74WlA+9b4T7/Evh6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809699; c=relaxed/simple;
	bh=IZV14AC9WwvOfBgvKoE5zSJC6qsCUd0KkQWOerLZHXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2D8t1iVOI1IfuUox8hXjzUwqqjp138GXp1+nCaBu25FD6zkfo1hvEfXtCIdBep8qAB65F0rysFf7AtI7DSpKGbGjl7xNaQk0fzPHWqr8v7bGGiVTkeJQEXmxFPCCbjl0+G5ABv49fQLr5Buuk0NKcmE286muWqwAAaqcHTEdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sBKDAHIh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sBKDAHIh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6gmEEgchAPPO8mcnoSMt3cYSx4rpjOlnGmkpMNUkCUI=; b=sBKDAHIheJja6mqT3EZ/HQ3Xt5
	va9K8jdDEIxPTKQj06IGRFu+sa0y/bG4kBdsXdvrmV/+DIh+tjpgLrHqFxL0s/NNsmeC34ri3450C
	BrD65ahbd2VQptODQiUSbsTMK0aIjclLp8vZ4TikONGtQy84E2CbQG7P39q/SnyiP+bCZSjFuI2xi
	B/QncuC0nu5oc4Wlv97MYABYIWTorMWHgTu8zidbbsD9l5dBvr+j3m9MW3ZG4toeR+YEboovXQcKo
	ghqc9rgwnNq7I55eRqfxAzdjNFi9Q3eF3u9LjgYrxzvfif43WSTCj8AZ2WubltOutPueS0XM1r+CQ
	rv1yiSLg==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnJc-00000008GAm-1TaA;
	Tue, 13 Feb 2024 07:34:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/15] block: decouple blk_set_stacking_limits from blk_set_default_limits
Date: Tue, 13 Feb 2024 08:34:13 +0100
Message-Id: <20240213073425.1621680-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_set_stacking_limits uses very little from blk_set_default_limits.
Open code these initializations in preparation for rewriting
blk_set_default_limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-settings.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f16d3fec6658e5..24042f6b33d54e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -65,13 +65,18 @@ void blk_set_default_limits(struct queue_limits *lim)
  * blk_set_stacking_limits - set default limits for stacking devices
  * @lim:  the queue_limits structure to reset
  *
- * Description:
- *   Returns a queue_limit struct to its default state. Should be used
- *   by stacking drivers like DM that have no internal limits.
+ * Prepare queue limits for applying limits from underlying devices using
+ * blk_stack_limits().
  */
 void blk_set_stacking_limits(struct queue_limits *lim)
 {
-	blk_set_default_limits(lim);
+	memset(lim, 0, sizeof(*lim));
+	lim->logical_block_size = SECTOR_SIZE;
+	lim->physical_block_size = SECTOR_SIZE;
+	lim->io_min = SECTOR_SIZE;
+	lim->discard_granularity = SECTOR_SIZE;
+	lim->dma_alignment = SECTOR_SIZE - 1;
+	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
 
 	/* Inherit limits from component devices */
 	lim->max_segments = USHRT_MAX;
-- 
2.39.2

