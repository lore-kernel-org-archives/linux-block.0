Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458C16DEA5;
	Mon,  1 Jul 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852759; cv=none; b=PJIIXMwOuZBT+ESwKWeoF7A7Q66xPw8hxLa0ruRimeNg6kWMrCwq0MkpzszPris1OdSyO4S2ogMd2tW3DB/l0VKZUvUuMNdspG8gQpCyQBeqZcS/BTkhK/XtJzhYedbEJJZdkEatOCh2YrHONMCN3noq1icPBs5KNKOuBOqcS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852759; c=relaxed/simple;
	bh=G5L5Plq19X5GAfeTFNcX9uW9PU0zoLG5mzqe5KDW/+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIcRAC9+Yl0eKiYVE8jWRaQdnNxOc/ad46+nq1cpFbECkcGuNI7lfhdVjsZHmdiz/ZPCe5DVy1EkJBPChzc1evnHn9P/ujVrq1tXMsX8KmCsP9mUs0H0UsvKUOAaJnW0PMk742Aj0do9rOv+OWnw9fE92VLPFOorMiBAucnuhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=34MTjUIP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="34MTjUIP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DwD7MjTvJx+hlHOHPGd5dcyVJZrseYQmaHXTz3yhQ8Y=; b=34MTjUIPfC/B8bUTCiroNNKR+9
	yir0icGQTNEiZnH+dfKQO58vG0s4AH3KUiWkMWtkfwXOA1X7XmnYxzRnGo3hj9IBz3EMBg2rcf+dj
	SIP2yT4eThKCMjqHmQCyPASi/7RtLzLQZNs5wbFlmhpxqYtuhdvjb86O5rbWCSnmlB+5aB7yuQnuf
	vfnAoi1rNai4sUKWS7yOI+aghKOHoGtg7nJrETtTKOTYiti8C6+qYKMqY1lcBmr8O+DZy0DeGmaoZ
	5DEFrr9K6gWiApsVt2/UMlKv1wr4H+Cla2zEamyD9Nn9OeZ9t+hvQTzIaZc6QNKpobd9JEJvIyEHQ
	x8Y0wlUQ==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGZ-00000004Bcj-33T6;
	Mon, 01 Jul 2024 16:52:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 03/10] block: add a blk_alloc_secure_erase_bio helper
Date: Mon,  1 Jul 2024 18:51:13 +0200
Message-ID: <20240701165219.1571322-4-hch@lst.de>
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

Factor out a helper from blkdev_issue_secure_erase that chews off as much
as possible from a secure_erase range and allocates a bio for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c     | 36 +++++++++++++++++++++++-------------
 include/linux/bio.h |  2 ++
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index ff12c3d2de5aae..cf4f0ee6b14503 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -293,26 +293,36 @@ static sector_t bio_secure_erase_limit(struct block_device *bdev)
 		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
 }
 
+struct bio *blk_alloc_secure_erase_bio(struct block_device *bdev,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp)
+{
+	sector_t bio_sects = min(*nr_sects, bio_secure_erase_limit(bdev));
+	struct bio *bio;
+
+	if (!bio_sects)
+		return NULL;
+	bio = bio_alloc(bdev, 0, REQ_OP_SECURE_ERASE, gfp);
+	if (!bio)
+		return NULL;
+	bio->bi_iter.bi_sector = *sector;
+	bio->bi_iter.bi_size = bio_sects << SECTOR_SHIFT;
+	*sector += bio_sects;
+	*nr_sects -= bio_sects;
+	cond_resched();
+	return bio;
+}
+
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp)
 {
-	unsigned int max_sectors = bio_secure_erase_limit(bdev);
-	struct bio *bio = NULL;
+	struct bio *bio = NULL, *next;
 	struct blk_plug plug;
 	int ret = 0;
 
 	blk_start_plug(&plug);
-	while (nr_sects) {
-		unsigned int len = min_t(sector_t, nr_sects, max_sectors);
-
-		bio = blk_next_bio(bio, bdev, 0, REQ_OP_SECURE_ERASE, gfp);
-		bio->bi_iter.bi_sector = sector;
-		bio->bi_iter.bi_size = len << SECTOR_SHIFT;
-
-		sector += len;
-		nr_sects -= len;
-		cond_resched();
-	}
+	while ((next = blk_alloc_secure_erase_bio(bdev, &sector, &nr_sects,
+			gfp)))
+		bio = bio_chain_and_submit(bio, next);
 	if (bio) {
 		ret = submit_bio_wait(bio);
 		bio_put(bio);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d5379548d684e1..e1da5fe49baca1 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -835,5 +835,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new);
 
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,
 		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask);
+struct bio *blk_alloc_secure_erase_bio(struct block_device *bdev,
+		sector_t *sector, sector_t *nr_sects, gfp_t gfp);
 
 #endif /* __LINUX_BIO_H */
-- 
2.43.0

