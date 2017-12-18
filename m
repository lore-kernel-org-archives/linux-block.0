Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758489AbdLRMYN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Dec 2017 07:24:13 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 05/45] block: bounce: don't access bio->bi_io_vec in copy_to_high_bio_irq
Date: Mon, 18 Dec 2017 20:22:07 +0800
Message-Id: <20171218122247.3488-6-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Firstly this patch introduce BVEC_ITER_ALL_INIT for iterating one bio
from start to end.

As we need to support multipage bvecs, so don't access bio->bi_io_vec
in copy_to_high_bio_irq(), and just use the standard iterator to do that.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bounce.c       | 16 +++++++++++-----
 include/linux/bvec.h |  9 +++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 0274c31d6c05..c35a3d7f0528 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -113,24 +113,30 @@ int init_emergency_isa_pool(void)
 static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 {
 	unsigned char *vfrom;
-	struct bio_vec tovec, *fromvec = from->bi_io_vec;
+	struct bio_vec tovec, fromvec;
 	struct bvec_iter iter;
+	/*
+	 * The bio of @from is created by bounce, so we can iterate
+	 * its bvec from start to end, but the @from->bi_iter can't be
+	 * trusted because it might be changed by splitting.
+	 */
+	struct bvec_iter from_iter = BVEC_ITER_ALL_INIT;
 
 	bio_for_each_segment(tovec, to, iter) {
-		if (tovec.bv_page != fromvec->bv_page) {
+		fromvec = bio_iter_iovec(from, from_iter);
+		if (tovec.bv_page != fromvec.bv_page) {
 			/*
 			 * fromvec->bv_offset and fromvec->bv_len might have
 			 * been modified by the block layer, so use the original
 			 * copy, bounce_copy_vec already uses tovec->bv_len
 			 */
-			vfrom = page_address(fromvec->bv_page) +
+			vfrom = page_address(fromvec.bv_page) +
 				tovec.bv_offset;
 
 			bounce_copy_vec(&tovec, vfrom);
 			flush_dcache_page(tovec.bv_page);
 		}
-
-		fromvec++;
+		bio_advance_iter(from, &from_iter, tovec.bv_len);
 	}
 }
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ec8a4d7af6bd..fe7a22dd133b 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -125,4 +125,13 @@ static inline bool bvec_iter_rewind(const struct bio_vec *bv,
 		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance((bio_vec), &(iter), (bvl).bv_len))
 
+/* for iterating one bio from start to end */
+#define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
+{									\
+	.bi_sector	= 0,						\
+	.bi_size	= UINT_MAX,					\
+	.bi_idx		= 0,						\
+	.bi_bvec_done	= 0,						\
+}
+
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.9.5
