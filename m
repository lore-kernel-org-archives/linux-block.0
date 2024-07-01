Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B315E5DC;
	Mon,  1 Jul 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852785; cv=none; b=tplQi4zZK6uVRNLdLb+L4CsYEsRGi4KSxKoI6kL9dFyZHQqTUq2n/6ton2nWehNQbflOlQweeI67w1fUGYZvj+lzUz9RuOT3X9MSG6wqQoMOENqovh9idbWAp7JEjrher1sLoXz/O1ifV7SrIXPB2MhHhdsY0Nzl7abJc67R1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852785; c=relaxed/simple;
	bh=OsCtO5bX5Zh7jx6XhKJoZDIlc/TsSDiOuwMVUSQJ11A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5BRrcIbz1KpTA/Al/Ofsd0AwXG2Q0+sGVGkC7ctGlDUCiavRfMGmHi3VDyTtIoOnMCPxFtAbecD9cxeicvyW7AeLzipEwPjvkpgLQ0UuSA6avv72FSBHiHOyNlibeDCiNhTQ6i4mqf4dYNgu1xaZONJqA5/Ujv9Iq2u8QGDmyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WszWtJzm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WszWtJzm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W3UEqxM+W8WMDFLwQ70hzXAIh72AVtbpUh2WCLbswBM=; b=WszWtJzmd939XviNuIChjlFDqX
	hwKZsEv64eV1dzTFGxcZAhpVenbgBIvnj9khD4pSHwRC3JipXQ16Ijtswqm7Wkryx0E1FTAr7SphQ
	9Ma0PhDDvRQma8oUVFLrcff7+3v9jsmnHvM46S6qMzTO8ZxJP3MXK1tFbur1t4BGeyv3c7BPdi75+
	RRA9Un8GRsPP2EYVQBxWfSc1PAFn17NfLQXNobKx+eSBdNEXRwnsCfeX/hkFD8p3W+5MGNy3pdjZG
	ROKrjmlLiaDEri7qc/tU0DfM8i5DjjyY2Js5RDYxnsJNSaV0HmTFiTSaQlXbPzIX/7UblOQ0/ixjM
	gMfY3MmQ==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGz-00000004Bq6-2fTK;
	Mon, 01 Jul 2024 16:53:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 10/10] blk-lib: check for kill signal in ioctl BLKZEROOUT
Date: Mon,  1 Jul 2024 18:51:20 +0200
Message-ID: <20240701165219.1571322-11-hch@lst.de>
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

Zeroout can access a significant capacity and take longer than the user
expected.  A user may change their mind about wanting to run that
command and attempt to kill the process and do something else with their
device. But since the task is uninterruptable, they have to wait for it
to finish, which could be many hours.

Add a new BLKDEV_ZERO_KILLABLE flag for blkdev_issue_zeroout that checks
for a fatal signal at each iteration so the user doesn't have to wait for
their regretted operation to complete naturally.

Heavily based on an earlier patch from Keith Busch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c        | 66 +++++++++++++++++++++++++++---------------
 block/ioctl.c          |  2 +-
 include/linux/blkdev.h |  1 +
 3 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 95a22e7b1d3b85..729a2669681773 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,24 +115,27 @@ static void __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
 {
-	struct bio *bio = *biop;
-
 	while (nr_sects) {
 		unsigned int len = min_t(sector_t, nr_sects,
 				bio_write_zeroes_limit(bdev));
+		struct bio *bio;
+
+		if ((flags & BLKDEV_ZERO_KILLABLE) &&
+		    fatal_signal_pending(current))
+			break;
 
-		bio = blk_next_bio(bio, bdev, 0, REQ_OP_WRITE_ZEROES, gfp_mask);
+		bio = bio_alloc(bdev, 0, REQ_OP_WRITE_ZEROES, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
 
 		bio->bi_iter.bi_size = len << SECTOR_SHIFT;
+		*biop = bio_chain_and_submit(*biop, bio);
+
 		nr_sects -= len;
 		sector += len;
 		cond_resched();
 	}
-
-	*biop = bio;
 }
 
 static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t sector,
@@ -145,6 +148,12 @@ static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t sector,
 	blk_start_plug(&plug);
 	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio, flags);
 	if (bio) {
+		if ((flags & BLKDEV_ZERO_KILLABLE) &&
+		    fatal_signal_pending(current)) {
+			bio_await_chain(bio);
+			blk_finish_plug(&plug);
+			return -EINTR;
+		}
 		ret = submit_bio_wait(bio);
 		bio_put(bio);
 	}
@@ -176,29 +185,34 @@ static unsigned int __blkdev_sectors_to_bio_pages(sector_t nr_sects)
 
 static void __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
-		struct bio **biop)
+		struct bio **biop, unsigned int flags)
 {
-	struct bio *bio = *biop;
-	int bi_size = 0;
-	unsigned int sz;
+	while (nr_sects) {
+		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
+		struct bio *bio;
 
-	while (nr_sects != 0) {
-		bio = blk_next_bio(bio, bdev, __blkdev_sectors_to_bio_pages(nr_sects),
-				   REQ_OP_WRITE, gfp_mask);
+		bio = bio_alloc(bdev, nr_vecs, REQ_OP_WRITE, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 
-		while (nr_sects != 0) {
-			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
-			bi_size = bio_add_page(bio, ZERO_PAGE(0), sz, 0);
-			nr_sects -= bi_size >> 9;
-			sector += bi_size >> 9;
-			if (bi_size < sz)
+		if ((flags & BLKDEV_ZERO_KILLABLE) &&
+		    fatal_signal_pending(current))
+			break;
+
+		do {
+			unsigned int len, added;
+
+			len = min_t(sector_t,
+				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
+			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
+			if (added < len)
 				break;
-		}
+			nr_sects -= added >> SECTOR_SHIFT;
+			sector += added >> SECTOR_SHIFT;
+		} while (nr_sects);
+
+		*biop = bio_chain_and_submit(*biop, bio);
 		cond_resched();
 	}
-
-	*biop = bio;
 }
 
 static int blkdev_issue_zero_pages(struct block_device *bdev, sector_t sector,
@@ -212,8 +226,14 @@ static int blkdev_issue_zero_pages(struct block_device *bdev, sector_t sector,
 		return -EOPNOTSUPP;
 
 	blk_start_plug(&plug);
-	__blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp, &bio);
+	__blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp, &bio, flags);
 	if (bio) {
+		if ((flags & BLKDEV_ZERO_KILLABLE) &&
+		    fatal_signal_pending(current)) {
+			bio_await_chain(bio);
+			blk_finish_plug(&plug);
+			return -EINTR;
+		}
 		ret = submit_bio_wait(bio);
 		bio_put(bio);
 	}
@@ -255,7 +275,7 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		if (flags & BLKDEV_ZERO_NOFALLBACK)
 			return -EOPNOTSUPP;
 		__blkdev_issue_zero_pages(bdev, sector, nr_sects, gfp_mask,
-				biop);
+				biop, flags);
 	}
 	return 0;
 }
diff --git a/block/ioctl.c b/block/ioctl.c
index 45668a21cdb374..83899d06a9d30d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -258,7 +258,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		goto fail;
 
 	err = blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
-				   BLKDEV_ZERO_NOUNMAP);
+				   BLKDEV_ZERO_NOUNMAP | BLKDEV_ZERO_KILLABLE);
 
 fail:
 	filemap_invalidate_unlock(bdev->bd_mapping);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4d0d4b83bc740f..538bb9b9b6cb32 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1100,6 +1100,7 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
+#define BLKDEV_ZERO_KILLABLE	(1 << 2)  /* interruptible by fatal signals */
 
 extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
-- 
2.43.0

