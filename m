Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18582C2CD;
	Mon, 12 Feb 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720393; cv=none; b=bto5xwwCBOHSuWSeiWA1HkQY+Bmw6FlIgdQnOtU2KlloftehmdFflTb70B9qVF8yq9PM2N5l4Zv+CdXBbS8fGXMSP7xWHztagjiJ/zVxb1afkUXDz5j55sBLbyyhhiO3qDIaWcsc/DunNTVci02YjUiEESnIZFyNDn2lrZUdW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720393; c=relaxed/simple;
	bh=CKgpclj+vim48ZzXigNly6i3DBy7x2MQkLbp82JytWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0CLSKbfFfbn2zeGLyBpEH3P4pJzMiga/0vs6tovduM81qykXLOHNKebznFQk+HxdbHQMnI3iifAhJFPrc7r2CR4wg6R2Q5QBUVnc/q0fnhAjUT+q+wkHF3cM9M3nuUW4XO2N2xHg+Z9DlAmspaW9sKKriTqcOylrB9lagpao1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DoULLL3a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DoULLL3a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p6HSM27GbKcz02IsFZ1aYD7BVqR49cLm+9QPOfHJCYE=; b=DoULLL3aoXgF1aARVqiks3lSig
	Sw9qi06txzfy2f9e4+HGojqTX3463o8Ncg0PTOWWIsmw4hbry17wq338ChdOUBfVXi7RITtIDlUB1
	IarEdPnnQxr3q5IIGowRAcFnZA4J+q0krFoPiCF3xcBohKiISsZu5HSM2/o3yVGNn1kqzu4Nq2F8T
	CI+Lr0kW+UdP9o2lQ8puo9qcyLeIzbq3RT7HqoOyL3FNRwTIbxLUqRYs9L5Z5v2PWOHoKYvf4WN8S
	8/+QdLbL3Rn976wkZpR1TiNl+NbBER8P3rLNBJFJfQrVgP0JTh8wDhOk8GcfAK1qX/wm+uJdURrmk
	fU4m4n6Q==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5C-00000004Pa7-1s0g;
	Mon, 12 Feb 2024 06:46:27 +0000
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
	virtualization@lists.linux.dev
Subject: [PATCH 03/15] block: decouple blk_set_stacking_limits from blk_set_default_limits
Date: Mon, 12 Feb 2024 07:45:57 +0100
Message-Id: <20240212064609.1327143-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
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
---
 block/blk-settings.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f16d3fec6658e5..1cae2db41490d2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -65,13 +65,16 @@ void blk_set_default_limits(struct queue_limits *lim)
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
+	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
+	lim->discard_granularity = 512;
+	lim->dma_alignment = 511;
+	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
 
 	/* Inherit limits from component devices */
 	lim->max_segments = USHRT_MAX;
-- 
2.39.2

