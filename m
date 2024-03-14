Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D934C96
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382588; cv=none; b=HQQusfCD+NpJjXg2605G3depG4YTeTcKLG6xM+BRlGdysb7rYZoBmOAHSt/VHkgMy46N9NDynHnluLUx4EEhPBKZjIXhCcDjL1qc8bbxusH9yobxaIhcis1SSHpwLZw0zO/D7PB0WvSPPx9/tAjCst9xaafTVH0f4jmQDogvlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382588; c=relaxed/simple;
	bh=5FXD/7guzBCxT9w7m6PkeRMe2t0JNtMzxTFKfh0O36I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cm370rS2Kn2O2tfT8kFa6bGQGtEyQppfKp076VgManSv/3e+PCJW5dbx4cfdULPXYcIkRqT14HG8VzSq7p6Xc86seWKM7oN4HcHQ0XnSbFnHLL3/6TsKdJxyOg9TqnpS5ePnM7y22rSbIef+JMucefLheLzWHdCObU77AMqgIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1WZ4a5WF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1WZ4a5WF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RvDjdXLzZyIm+BeZ02gOnd4g5pBaNrTaR56MpS6Fztc=; b=1WZ4a5WFFtcY0XBvnuGp4+yfzn
	JwhQyI8V5KCRk0uhBPj0UIRose/JDazeoYNSEUBWcmrcV3Ftho9MiPzAsNcURCxJjKXbzC6m7UdoC
	ci7Wq8nzcyNf6rxT/VxxBNSfsFvtFdSZIjsK7pa1Z8hwZvjCfXtEeCrjYTETogcz1UI8uaF+ZB45a
	WmFcMLr7zeWz2I+sDeHQG9putXyiroyA9NdUxi3pyifVdy6J/AZxoXO9+DgIzetHxzaypX+5k0UYv
	jwTkug67THm6DnBHNgxsgcALYpPxfJlMGXFEaVQVwb0Oz85uHup0TplSaV89bL/mE36vq0GkJAjT5
	Aqrzs+EA==;
Received: from [165.225.242.162] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkads-0000000CerZ-1vUO;
	Thu, 14 Mar 2024 02:16:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	linux-block@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH] Revert "blk-lib: check for kill signal"
Date: Wed, 13 Mar 2024 19:16:23 -0700
Message-Id: <20240314021623.1908895-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This reverts commit 8a08c5fd89b447a7de7eb293a7a274c46b932ba2.

It turns out while this is a perfectly valid and long overdue thing to do
for user initiated discards / zeroing from the ioctl handler, it actually
breaks file system use of the discard helper by interrupting in places
the file system doesn't expect, and by leaving the bio chain in a state
that the file system callers of (at least) __blkdev_issue_discard do
not expect.

Revert the change for now, we'll redo it for the next merge window
after refactoring the code to better split the file system vs ioctl
callers and cleaning up a few other loose ends.

Reported-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index dc8e35d0a51d6d..a6954eafb8c8af 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -35,26 +35,6 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
 
-static void await_bio_endio(struct bio *bio)
-{
-	complete(bio->bi_private);
-	bio_put(bio);
-}
-
-/*
- * await_bio_chain - ends @bio and waits for every chained bio to complete
- */
-static void await_bio_chain(struct bio *bio)
-{
-	DECLARE_COMPLETION_ONSTACK_MAP(done,
-			bio->bi_bdev->bd_disk->lockdep_map);
-
-	bio->bi_private = &done;
-	bio->bi_end_io = await_bio_endio;
-	bio_endio(bio);
-	blk_wait_io(&done);
-}
-
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
@@ -97,10 +77,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		 * is disabled.
 		 */
 		cond_resched();
-		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
-			return -EINTR;
-		}
 	}
 
 	*biop = bio;
@@ -167,10 +143,6 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		nr_sects -= len;
 		sector += len;
 		cond_resched();
-		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
-			return -EINTR;
-		}
 	}
 
 	*biop = bio;
@@ -215,10 +187,6 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 				break;
 		}
 		cond_resched();
-		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
-			return -EINTR;
-		}
 	}
 
 	*biop = bio;
@@ -309,7 +277,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		bio_put(bio);
 	}
 	blk_finish_plug(&plug);
-	if (ret && ret != -EINTR && try_write_zeroes) {
+	if (ret && try_write_zeroes) {
 		if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
 			try_write_zeroes = false;
 			goto retry;
@@ -361,12 +329,6 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector += len;
 		nr_sects -= len;
 		cond_resched();
-		if (fatal_signal_pending(current)) {
-			await_bio_chain(bio);
-			ret = -EINTR;
-			bio = NULL;
-			break;
-		}
 	}
 	if (bio) {
 		ret = submit_bio_wait(bio);
-- 
2.39.2

