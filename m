Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0916DEA5;
	Mon,  1 Jul 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852777; cv=none; b=M9mc7lY4en+2u0+k93odV4x7P3RqRF9A4JeCCuzc4kNY6ox0hzaR90lKmn6xSAYzPYurIBK+VKrW/eFrTn6H3xZVxkWAqnR+wcgh53FJQ4KVP6UhjKpXAFsvYXdVxDK05IYDvZYPcQcjjVy7i6MFMb5hn4ccqJw1Psb4vJFIkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852777; c=relaxed/simple;
	bh=dwSj8Gc+cBz9Gc10BRpSUyz98fbrdOxzE8JGD8FVWJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6z8DovwZR+PoHzNlI3n45kfJko4sVJ1DWgjtwPmhoKqlKof9BaaloU1qEt7U6aTTVOdAtfTsoWbgNvV7czjfsXI/rjEilsNAU1DEKzCfdndWfu9ZmOzNU+ZUIdduGoSePKW+twUvG80lgCQJ+fjsFAk5mql2I7hihhBxsk8Z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VfPIhM0u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfPIhM0u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e2syZyegMy+6QLFCmnnKgLtiBOVxozulluPqAHe5sQU=; b=VfPIhM0u71/aY0HFd81MOSF0y8
	ngTUpYFSLErZ6CVMtdIKpEu64c/sjUeBC4LKvCaIKop3DGxMjNcIw4Yx6Ah+pz8B1xbBTsfhWgwER
	zUx29Z16Daz84Lv90vdUxcHHQPbMGiMRkBDKQ26+RWSLNBkwkX0KPPh65kZ6Rqv0G8ZFvaB+voA75
	k3fFcIE+L6fNgQBcUN2m60HsASgHykupdWILQSw0Njtvrk3nOv6r42qIFZKvzcw1PmKvJXXd/J1O0
	rHKp2qwDXLU+7EFF4A6SH3eI8sjzht3vCMC1BBMgm7vvfGFBoY0FrJXJ+hDl5xY4E2AAl9gTj45C4
	6B7eqqWg==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGs-00000004BmI-2YtV;
	Mon, 01 Jul 2024 16:52:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 08/10] block: refacto blkdev_issue_zeroout
Date: Mon,  1 Jul 2024 18:51:18 +0200
Message-ID: <20240701165219.1571322-9-hch@lst.de>
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

Split out two well-defined helpers for hardware supported Write Zeroes
and manually writing zeroes using the Write command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 94 +++++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 10325e91560c40..9585178a51a60c 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -135,6 +135,32 @@ static void __blkdev_issue_write_zeroes(struct block_device *bdev,
 	*biop = bio;
 }
 
+static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp, unsigned flags)
+{
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret = 0;
+
+	blk_start_plug(&plug);
+	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio, flags);
+	if (bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	blk_finish_plug(&plug);
+
+	/*
+	 * For some devices there is no non-destructive way to verify whether
+	 * WRITE ZEROES is actually supported.  These will clear the capability
+	 * on an I/O error, in which case we'll turn any error into
+	 * "not supported" here.
+	 */
+	if (ret && !bdev_write_zeroes_sectors(bdev))
+		return -EOPNOTSUPP;
+	return ret;
+}
+
 /*
  * Convert a number of 512B sectors to a number of pages.
  * The result is limited to a number of pages that can fit into a BIO.
@@ -175,6 +201,27 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 	*biop = bio;
 }
 
+static int blkdev_issue_zero_pages(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp, unsigned flags)
+{
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret = 0;
+
+	if (flags & BLKDEV_ZERO_NOFALLBACK)
+		return -EOPNOTSUPP;
+
+	blk_start_plug(&plug);
+	__blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp, &bio);
+	if (bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+
 /**
  * __blkdev_issue_zeroout - generate number of zero filed write bios
  * @bdev:	blockdev to issue
@@ -230,52 +277,21 @@ EXPORT_SYMBOL(__blkdev_issue_zeroout);
 int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags)
 {
-	int ret = 0;
-	sector_t bs_mask;
-	struct bio *bio;
-	struct blk_plug plug;
-	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
+	int ret;
 
-	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	if ((sector | nr_sects) & bs_mask)
+	if ((sector | nr_sects) & ((bdev_logical_block_size(bdev) >> 9) - 1))
 		return -EINVAL;
 	if (bdev_read_only(bdev))
 		return -EPERM;
-	if ((flags & BLKDEV_ZERO_NOFALLBACK) && !try_write_zeroes)
-		return -EOPNOTSUPP;
 
-retry:
-	bio = NULL;
-	blk_start_plug(&plug);
-	if (try_write_zeroes) {
-		__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
-				&bio, flags);
-	} else {
-		__blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask,
-				&bio);
-	}
-	if (bio) {
-		ret = submit_bio_wait(bio);
-		bio_put(bio);
-	}
-	blk_finish_plug(&plug);
-	if (ret && try_write_zeroes) {
-		if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
-			try_write_zeroes = false;
-			goto retry;
-		}
-		if (!bdev_write_zeroes_sectors(bdev)) {
-			/*
-			 * Zeroing offload support was indicated, but the
-			 * device reported ILLEGAL REQUEST (for some devices
-			 * there is no non-destructive way to verify whether
-			 * WRITE ZEROES is actually supported).
-			 */
-			ret = -EOPNOTSUPP;
-		}
+	if (bdev_write_zeroes_sectors(bdev)) {
+		ret = blkdev_issue_write_zeroes(bdev, sector, nr_sects,
+				gfp_mask, flags);
+		if (!ret)
+			return ret;
 	}
 
-	return ret;
+	return blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask, flags);
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
 
-- 
2.43.0

