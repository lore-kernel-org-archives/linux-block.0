Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdGLSB1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 14:01:27 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, Shaohua Li <shli@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] block: delete bio_uninit in blockdev
Date: Wed, 12 Jul 2017 11:00:52 -0700
Message-Id: <b8d987eda4989ad4586620278c53130a61cd715c.1499881589.git.shli@fb.com>
In-Reply-To: <cover.1499881589.git.shli@fb.com>
References: <cover.1499881589.git.shli@fb.com>
In-Reply-To: <cover.1499881589.git.shli@fb.com>
References: <cover.1499881589.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

This is to partially revert commit 9ae3b3f52c62 (block: provide
bio_uninit() free freeing integrity/task associations). With commit
b222dd2 (block: call bio_uninit in bio_endio) and 7c20f11(bio-integrity:
stop abusing bi_end_io), integrity/cgroup info is freed in bio_endio. We
don't need to call bio_unit in other places

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c         | 8 +-------
 fs/block_dev.c      | 4 +---
 include/linux/bio.h | 1 -
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9a63597..ce078fb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -240,11 +240,10 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 	return bvl;
 }
 
-void bio_uninit(struct bio *bio)
+static void bio_uninit(struct bio *bio)
 {
 	bio_disassociate_task(bio);
 }
-EXPORT_SYMBOL(bio_uninit);
 
 static void bio_free(struct bio *bio)
 {
@@ -269,11 +268,6 @@ static void bio_free(struct bio *bio)
 	}
 }
 
-/*
- * Users of this function have their own bio allocation. Subsequently,
- * they must remember to pair any call to bio_init() with bio_uninit()
- * when IO has completed, or when the bio is released.
- */
 void bio_init(struct bio *bio, struct bio_vec *table,
 	      unsigned short max_vecs)
 {
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9941dc8..673536e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -264,9 +264,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		kfree(vecs);
 
 	if (unlikely(bio.bi_status))
-		ret = blk_status_to_errno(bio.bi_status);
-
-	bio_uninit(&bio);
+		return blk_status_to_errno(bio.bi_status);
 
 	return ret;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7b1cf4b..8a56a50 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -444,7 +444,6 @@ extern void bio_advance(struct bio *, unsigned);
 
 extern void bio_init(struct bio *bio, struct bio_vec *table,
 		     unsigned short max_vecs);
-extern void bio_uninit(struct bio *);
 extern void bio_reset(struct bio *);
 void bio_chain(struct bio *, struct bio *);
 
-- 
2.9.3
