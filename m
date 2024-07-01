Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61816DC28;
	Mon,  1 Jul 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852755; cv=none; b=bAMWNukrIcEqP4t8hwei1DeZTWfiD+Pru6g6SatGbHZcM00QX4I9gD5eBpua4jmbAHherB7etrO+oMI/QovjLmfuS7gx5KOM6ci+CHv7YZKHyqHFyl4/0sit9WqvaHbJie/q2h2en1LP+S8xMH6LSglZtCOipqdJEabJq7z0sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852755; c=relaxed/simple;
	bh=VCx3oj3J1gwuO8Ki+SrjUqw3M0UviFUVVT2vZ0j7I2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf/pKReGeX+kO+ZBYrxpvpDqN5+qsuR93Htm6te8TjmspjYne85upd1MYNmhA2vjq3N8s7EYqn+RSqkCN4n3SDx9U16i9Q2kXmbCjF/SsZHJXYH0lQJuJc3HxUwpFTT6v8l8RvvvOWdZPxoR4aWGodrUROZwtjSwuCk1iEYUz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lroJqfFj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lroJqfFj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Q9sAMTxUEzTcvcgUTbBquYG+NeVvB6IffN/QzKQPocs=; b=lroJqfFjKDjvg1tX+YakPJXKmt
	6guRRbdfGA7qFGmZZvcgl6VYe9tOzrZa+IARKFL/MsDC67yNDz1EYCHFYroSwPkZAvLWgdnAqa4Tk
	WSrx2PoR4xqSQYFCCifv6k/zYDFD9sSwu7WsAfc6VsIZ/2ppBVKLiXko3YTs1fKlrUx3DSMFCHqAI
	kbViVSRuBKkxFrlfFrWyWNKTGmDd9Y5Kg0QtXvrrUa6sWODMDBH8hdHsYesMF7NF9rCY6ahv+snlF
	mf82Wsg1i7sXG8cy4zZhBTQaqPuLlDo9SRsg/oS3fRZfJjYgIMW5DFr/VfCbAu8e61Tw0OmFTXOLb
	bZDwYlxw==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGV-00000004Bam-3wSu;
	Mon, 01 Jul 2024 16:52:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 02/10] block: factor out a bio_secure_erase_limit helper
Date: Mon,  1 Jul 2024 18:51:12 +0200
Message-ID: <20240701165219.1571322-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701165219.1571322-1-hch@lst.de>
References: <20240701165219.1571322-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to size the maximum secure erase bio without exceeding the
queue limit or overlowing the bi_size member.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4aabfc4a7eaa20..ff12c3d2de5aae 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -285,20 +285,22 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
 
+static sector_t bio_secure_erase_limit(struct block_device *bdev)
+{
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+
+	return min(bdev_max_secure_erase_sectors(bdev),
+		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
+}
+
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp)
 {
-	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	unsigned int max_sectors = bdev_max_secure_erase_sectors(bdev);
+	unsigned int max_sectors = bio_secure_erase_limit(bdev);
 	struct bio *bio = NULL;
 	struct blk_plug plug;
 	int ret = 0;
 
-	/* make sure that "len << SECTOR_SHIFT" doesn't overflow */
-	if (max_sectors > UINT_MAX >> SECTOR_SHIFT)
-		max_sectors = UINT_MAX >> SECTOR_SHIFT;
-	max_sectors &= ~bs_mask;
-
 	blk_start_plug(&plug);
 	while (nr_sects) {
 		unsigned int len = min_t(sector_t, nr_sects, max_sectors);
-- 
2.43.0

