Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115716EB50;
	Mon,  1 Jul 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852774; cv=none; b=hJm5emx/S9Ktte0Q1cq4+DmlaS8o8ebU6LrWP5xfvQeG/zw7/oK+enTtiAQ+ZME4kasUegDhVR9rSgbJPqU3bppnIHJpET5x8K1GJWQr7Wrm2CXyEom+5PpLDXBHPcarXiA2S8/cnWdbeqXBvP2E22yew8rMxVlfAcXFqMljkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852774; c=relaxed/simple;
	bh=haVnCrXI7l5VqKshprgf/Vvng8QVSo7+nHtSNKu31Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmWDQxWoBmfog14seZ0uj6Mg+t5pJOmvtf6bMOgPs/4sO8QME7MM6QDQkwHFA9p77OkTnRPgFTwXSXJBU1K/3fd3RSRabxotHx8qHExY6+oGoppFt93by1pAgLwyFWkRi1ADr0RoGr7CjTkkkuCVXyZxQ6aB6AgzNoOLE1JKwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WYuQf/YP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYuQf/YP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E+iu7V6wdisaIDGgCfPAf3w+L8HZpEVxSAbA2UeloJU=; b=WYuQf/YPkaJk/GtSc4dJw304sL
	2iSJppd8O2Zt0Q99bj8t1BiubBaKHXo/RA0h2opL8rvZeIEfnTB+nTip/xFR3TrcpluRD7Ak/TJmW
	qj0YUFtcqkBp4Oq4JKD0WDxbnm2ceIZmZjBmP6X+wI59Jtb7Gd3q4tc1w/cebGuGbCI3nS/Q+ALjh
	u5DqI2NUV+YkL4y9+BC4KR31iJQon/uHe3yIW1e3sJQsxed5BwLI2i/UIqf/ypcKswe5OiRT9l9UY
	5CCijurGc9CTtvRBpNAmA4vsYXTX8qLNKErm/SB1ElsxDVCuT7hPKu1tsaDbK1X6lfRLMr/vjsUE9
	esDIDi2g==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGo-00000004Bk0-48lJ;
	Mon, 01 Jul 2024 16:52:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 07/10] block: move read-only and supported checks into (__)blkdev_issue_zeroout
Date: Mon,  1 Jul 2024 18:51:17 +0200
Message-ID: <20240701165219.1571322-8-hch@lst.de>
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

Move these checks out of the lower level helpers and into the higher level
ones to prepare for refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 51 ++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7aa7937c34201d..10325e91560c40 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -111,17 +111,12 @@ static sector_t bio_write_zeroes_limit(struct block_device *bdev)
 		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
 }
 
-static int __blkdev_issue_write_zeroes(struct block_device *bdev,
+static void __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
 {
 	struct bio *bio = *biop;
 
-	if (bdev_read_only(bdev))
-		return -EPERM;
-	if (!bdev_write_zeroes_sectors(bdev))
-		return -EOPNOTSUPP;
-
 	while (nr_sects) {
 		unsigned int len = min_t(sector_t, nr_sects,
 				bio_write_zeroes_limit(bdev));
@@ -138,7 +133,6 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	}
 
 	*biop = bio;
-	return 0;
 }
 
 /*
@@ -154,7 +148,7 @@ static unsigned int __blkdev_sectors_to_bio_pages(sector_t nr_sects)
 	return min(pages, (sector_t)BIO_MAX_VECS);
 }
 
-static int __blkdev_issue_zero_pages(struct block_device *bdev,
+static void __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop)
 {
@@ -162,9 +156,6 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 	int bi_size = 0;
 	unsigned int sz;
 
-	if (bdev_read_only(bdev))
-		return -EPERM;
-
 	while (nr_sects != 0) {
 		bio = blk_next_bio(bio, bdev, __blkdev_sectors_to_bio_pages(nr_sects),
 				   REQ_OP_WRITE, gfp_mask);
@@ -182,7 +173,6 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 	}
 
 	*biop = bio;
-	return 0;
 }
 
 /**
@@ -208,15 +198,19 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
 		unsigned flags)
 {
-	int ret;
-
-	ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
-			biop, flags);
-	if (ret != -EOPNOTSUPP || (flags & BLKDEV_ZERO_NOFALLBACK))
-		return ret;
+	if (bdev_read_only(bdev))
+		return -EPERM;
 
-	return __blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask,
-					 biop);
+	if (bdev_write_zeroes_sectors(bdev)) {
+		__blkdev_issue_write_zeroes(bdev, sector, nr_sects,
+				gfp_mask, biop, flags);
+	} else {
+		if (flags & BLKDEV_ZERO_NOFALLBACK)
+			return -EOPNOTSUPP;
+		__blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask,
+				biop);
+	}
+	return 0;
 }
 EXPORT_SYMBOL(__blkdev_issue_zeroout);
 
@@ -245,21 +239,22 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
+	if (bdev_read_only(bdev))
+		return -EPERM;
+	if ((flags & BLKDEV_ZERO_NOFALLBACK) && !try_write_zeroes)
+		return -EOPNOTSUPP;
 
 retry:
 	bio = NULL;
 	blk_start_plug(&plug);
 	if (try_write_zeroes) {
-		ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects,
-						  gfp_mask, &bio, flags);
-	} else if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
-		ret = __blkdev_issue_zero_pages(bdev, sector, nr_sects,
-						gfp_mask, &bio);
+		__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
+				&bio, flags);
 	} else {
-		/* No zeroing offload support */
-		ret = -EOPNOTSUPP;
+		__blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask,
+				&bio);
 	}
-	if (ret == 0 && bio) {
+	if (bio) {
 		ret = submit_bio_wait(bio);
 		bio_put(bio);
 	}
-- 
2.43.0

