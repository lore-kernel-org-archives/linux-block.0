Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0C4438F
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714969241; cv=none; b=FwKSeG9v9Ctge61ZNgZy434PO0rtKb5z4IGC4tQF0dqzDFSLs47CsVGaANArcF+60bBxkB9K0uZyfF0iwpxYj76ErSodgNf0P56jm6V6ZjLvcOPYBwCtarrsXEo+xX/ZHauTwBJ+V20z6OVOOyHCujXEoINIaswthx6Im2dxggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714969241; c=relaxed/simple;
	bh=lZ2aYOiOeiS/dZxOf3HMKTIfQMlYbmtUo0dTbY4rvWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7qjOjGYxo07UziT34zk1HR6fbL46noz3x3ExfvOAcreR+XwgfbYrAbaWu1MRgaLWDiIcvUrf9qoq1Jh21MxwwgHnzx57hAMrjfEdK2WU/btMxgHXi4svV6/Ps9RTvNU2tvoD00UOazsoR5TCG2e2rxOaEJ0FDgRmpOrrkcaxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4BpneM7p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4BpneM7p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fMnFSEDCUvnQjVZZmZCJLOtQ7q7a0ZyHj9ZXK9KdIFM=; b=4BpneM7pV/+lgUF+uJgy60OBFb
	6KEHG7eS8MDUi+cTCQYLHKXk0BmsauyTqPQUNjiPlJk/yDVUPqPXUwENknf1RCsh6fWYAeKqk23wu
	gX+5ROCjJ5UxqDsq+rA6QV+fX1e49ALJ9Ns81JafiWVvwu7xMdHKNOh1JOWY64VFuIlFbQmNye4ek
	wsUN2CcqaAP6yAUGQjh5CAVUraIUogE4BY8jjvW++1cPg234Xdm8I86r/iRQGrHGueiqZ4DppW7/C
	Jf4hg5VLNvI3/qEPGJe+2lrnDWZSNhZOaIVjZNvzD1TWTzGhUMrQBSDJHvz3nJdaZ9Aja22dmLDks
	duwA6P1g==;
Received: from [2001:4bb8:188:7ba8:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3pqB-000000060Ll-1lLu;
	Mon, 06 May 2024 04:20:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: add a blk_alloc_discard_bio helper
Date: Mon,  6 May 2024 06:20:25 +0200
Message-Id: <20240506042027.2289826-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506042027.2289826-1-hch@lst.de>
References: <20240506042027.2289826-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Factor out a helper from __blkdev_issue_discard that chews off as much as
possible from a discard range and allocates a bio for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c     | 50 ++++++++++++++++++++++++++-------------------
 include/linux/bio.h |  3 +++
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 6e54ef140bab12..442da9dad04213 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -35,31 +35,39 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
 
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
+struct bio *blk_alloc_discard_bio(struct block_device *bdev,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask)
 {
-	struct bio *bio = *biop;
+	sector_t bio_sects = min(*nr_sects, bio_discard_limit(bdev, *sector));
+	struct bio *bio;
 
-	while (nr_sects) {
-		sector_t req_sects =
-			min(nr_sects, bio_discard_limit(bdev, sector));
+	if (!bio_sects)
+		return NULL;
 
-		bio = blk_next_bio(bio, bdev, 0, REQ_OP_DISCARD, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio->bi_iter.bi_size = req_sects << 9;
-		sector += req_sects;
-		nr_sects -= req_sects;
-
-		/*
-		 * We can loop for a long time in here, if someone does
-		 * full device discards (like mkfs). Be nice and allow
-		 * us to schedule out to avoid softlocking if preempt
-		 * is disabled.
-		 */
-		cond_resched();
-	}
+	bio = bio_alloc(bdev, 0, REQ_OP_DISCARD, gfp_mask);
+	if (!bio)
+		return NULL;
+	bio->bi_iter.bi_sector = *sector;
+	bio->bi_iter.bi_size = bio_sects << SECTOR_SHIFT;
+	*sector += bio_sects;
+	*nr_sects -= bio_sects;
+	/*
+	 * We can loop for a long time in here if someone does full device
+	 * discards (like mkfs).  Be nice and allow us to schedule out to avoid
+	 * softlocking if preempt is disabled.
+	 */
+	cond_resched();
+	return bio;
+}
 
-	*biop = bio;
+int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
+{
+	struct bio *bio;
+
+	while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
+			gfp_mask)))
+		*biop = bio_chain_and_submit(*biop, bio);
 	return 0;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 283a0dcbd1de61..d5379548d684e1 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -833,4 +833,7 @@ struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp);
 struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new);
 
+struct bio *blk_alloc_discard_bio(struct block_device *bdev,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
+
 #endif /* __LINUX_BIO_H */
-- 
2.39.2

