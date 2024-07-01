Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8516D4F4;
	Mon,  1 Jul 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852766; cv=none; b=h2TjbfpJUgy/7X1yqs95PUoasUFgPHrYCxhjyJl1mzbmqOJlQMx//hpV97qs+HNoVG/XF9pYjcpCiY1QqONKmi2YgzICap6kPPEQ5j4hbv0CmFOAPNA48Dv0d3A0f1wFtOOtZXnLQSyae553PJkZBF5ULe/r1Uk1oVadwXNUk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852766; c=relaxed/simple;
	bh=bkBqvU8+udzDY3YWr9bvQ3s+zzZXwra3PaEaBxKtj2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lghOv3QssqZ/KLj4DBoWEPCtiMF92IZrIaXYJjXY1Pg9uYyQhQha75FwKkUB4QCbC05ukadpMYEgklyoq2zH5OJ2W4hcJtL3dMwtDCGJgMVYa6Ry1s8OSCgysJv+Pi2KzfmMGwGif+TlTyTEemFwHiyHqFM3uhLvz3M8Do46hC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CfPrCIkd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CfPrCIkd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PF/pH6GqS8l9M6N2BcoMrMWTHNBHwOz4qGTXXLsturA=; b=CfPrCIkdMKmx7SlbwEi8FaDRfc
	Cvrq2It5W1Vv/d3nw4XoJCmR51wq0K3AMzS3V7uilHuU20fFnydJJZJNRpjwZ3Ngn+jQfg3kMiu1l
	6TdB1RkiMROvxBGoX6YP5PNq/jLndh/wICFKNw+5HgT1U3Ljgs5yOM0471rajytsAPmgaoaacR/Li
	EMxbR88bn6hySGuiAB0uIhItMZd78eiacGI3pBNgD+IlSvQgPfS/JG4+XWrcqky3qwyVMYhcKB21W
	DBVR8lu131AgKbhSnT/QAmiLOjuzsxhwp48RocKdOCe2wemOubuUDtcgxJVyre/SuvdA1eTEGuaa6
	F8el2uOw==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGh-00000004BfP-1HbS;
	Mon, 01 Jul 2024 16:52:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 05/10] block: factor out a blk_write_zeroes_limit helper
Date: Mon,  1 Jul 2024 18:51:15 +0200
Message-ID: <20240701165219.1571322-6-hch@lst.de>
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

Contrary to the comment in __blkdev_issue_write_zeroes, nothing here
checks for a potential bi_size overflow.  Add a helper mirroring
the secure erase code for the check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index cf4f0ee6b14503..f338709aef0c30 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -103,24 +103,28 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+static sector_t bio_write_zeroes_limit(struct block_device *bdev)
+{
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+
+	return min(bdev_write_zeroes_sectors(bdev),
+		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
+}
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
 {
 	struct bio *bio = *biop;
-	unsigned int max_sectors;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
-
-	/* Ensure that max_sectors doesn't overflow bi_size */
-	max_sectors = bdev_write_zeroes_sectors(bdev);
-
-	if (max_sectors == 0)
+	if (!bdev_write_zeroes_sectors(bdev))
 		return -EOPNOTSUPP;
 
 	while (nr_sects) {
-		unsigned int len = min_t(sector_t, nr_sects, max_sectors);
+		unsigned int len = min_t(sector_t, nr_sects,
+				bio_write_zeroes_limit(bdev));
 
 		bio = blk_next_bio(bio, bdev, 0, REQ_OP_WRITE_ZEROES, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
-- 
2.43.0

