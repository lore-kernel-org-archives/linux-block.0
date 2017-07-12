Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbdGLSB1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 14:01:27 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, Shaohua Li <shli@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] block: delete bio_uninit
Date: Wed, 12 Jul 2017 11:00:53 -0700
Message-Id: <094050f349fdf7eed4a20335e9a7573d7c8c9b35.1499881589.git.shli@fb.com>
In-Reply-To: <cover.1499881589.git.shli@fb.com>
References: <cover.1499881589.git.shli@fb.com>
In-Reply-To: <cover.1499881589.git.shli@fb.com>
References: <cover.1499881589.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

bio_uninit only calls bio_disassociate_task now. It's meaningless to
have a wrap.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ce078fb..8773d1b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -240,17 +240,12 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsigned long *idx,
 	return bvl;
 }
 
-static void bio_uninit(struct bio *bio)
-{
-	bio_disassociate_task(bio);
-}
-
 static void bio_free(struct bio *bio)
 {
 	struct bio_set *bs = bio->bi_pool;
 	void *p;
 
-	bio_uninit(bio);
+	bio_disassociate_task(bio);
 
 	if (bs) {
 		bvec_free(bs->bvec_pool, bio->bi_io_vec, BVEC_POOL_IDX(bio));
@@ -294,7 +289,7 @@ void bio_reset(struct bio *bio)
 {
 	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);
 
-	bio_uninit(bio);
+	bio_disassociate_task(bio);
 
 	memset(bio, 0, BIO_RESET_BYTES);
 	bio->bi_flags = flags;
@@ -1828,7 +1823,7 @@ void bio_endio(struct bio *bio)
 
 	blk_throtl_bio_endio(bio);
 	/* release cgroup info */
-	bio_uninit(bio);
+	bio_disassociate_task(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
-- 
2.9.3
