Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56128E20
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tc+T5RA6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7ZQ9sgh4lzc2YX0ii/mderRNgkEwLQ3NyMb5S4zuxgo=; b=Tc+T5RA6BDaqTNnhhYTDsxlKsG
	QIPlLn6En9iLL4X0g8GgjlODpQDN3vlPsNjbxiXAz2J0L3+YzhA50B8Dlgb2z34rsj0Q6mx3TRQCB
	Jwg/2hwZapx0fDWyW79247PjhjU4gcakX2RiCKVsVIbaF5llHeDUUN17cWr9KTtMH8UvxocRwevdW
	oEFyyW4iznoVqHGgrp18bu/crRMH6RD81ByBWZjvvgD/T/3b08j5JhRT872JfbwAZU23tUU/3XDqW
	ZOeiUtrAAxwToghAn1m9N6bgeHTlCQpCVw/bxaYiMJZFzMY/O70gjMi/WXi31ZXJmIm1EarwZzEIa
	4BTI37rA==;
Received: from 128.red-83-57-75.dynamicip.rima-tde.net ([83.57.75.128] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIQ8F-00EI3a-2d;
	Wed, 27 Dec 2023 09:23:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] null_blk: don't cap max_hw_sectors to BLK_DEF_MAX_SECTORS
Date: Wed, 27 Dec 2023 09:23:02 +0000
Message-Id: <20231227092305.279567-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231227092305.279567-1-hch@lst.de>
References: <20231227092305.279567-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

null_blk has some rather odd capping of the max_hw_sectors value to
BLK_DEF_MAX_SECTORS, which doesn't make sense - max_hw_sector is the
hardware limit, and BLK_DEF_MAX_SECTORS despite the confusing name is the
default cap for the max_sectors field used for normal file system I/O.

Remove all the capping, and simply leave it to the block layer or
user to take up or not all of that for file system I/O.

Fixes: ea17fd354ca8 ("null_blk: Allow controlling max_hw_sectors limit")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk/main.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3021d58ca51c1f..13ed446b5e198e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2186,10 +2186,8 @@ static int null_add_dev(struct nullb_device *dev)
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
-	if (!dev->max_sectors)
-		dev->max_sectors = queue_max_hw_sectors(nullb->q);
-	dev->max_sectors = min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
-	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
+	if (dev->max_sectors)
+		blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
 	if (dev->virt_boundary)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
@@ -2289,12 +2287,6 @@ static int __init null_init(void)
 		g_bs = PAGE_SIZE;
 	}
 
-	if (g_max_sectors > BLK_DEF_MAX_SECTORS) {
-		pr_warn("invalid max sectors\n");
-		pr_warn("defaults max sectors to %u\n", BLK_DEF_MAX_SECTORS);
-		g_max_sectors = BLK_DEF_MAX_SECTORS;
-	}
-
 	if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes) {
 		pr_err("invalid home_node value\n");
 		g_home_node = NUMA_NO_NODE;
-- 
2.39.2

