Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 36/60] block: bounce: avoid direct access to bvec from bio->bi_io_vec
Date: Sat, 29 Oct 2016 16:08:35 +0800
Message-Id: <1477728600-12938-37-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

We will support multipage bvecs in the future, so change to
iterator way for getting bv_page of bvec from original bio.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/bounce.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 1cb5dd3a5da1..babd3f224ca0 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -126,21 +126,23 @@ static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 static void bounce_end_io(struct bio *bio, mempool_t *pool)
 {
 	struct bio *bio_orig = bio->bi_private;
-	struct bio_vec *bvec, *org_vec;
+	struct bio_vec *bvec, orig_vec;
 	int i;
-	int start = bio_orig->bi_iter.bi_idx;
+	struct bvec_iter orig_iter = bio_orig->bi_iter;
 
 	/*
 	 * free up bounce indirect pages used
 	 */
 	bio_for_each_segment_all(bvec, bio, i) {
-		org_vec = bio_orig->bi_io_vec + i + start;
 
-		if (bvec->bv_page == org_vec->bv_page)
-			continue;
+		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
+		if (bvec->bv_page == orig_vec.bv_page)
+			goto next;
 
 		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
 		mempool_free(bvec->bv_page, pool);
+ next:
+		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
 	}
 
 	bio_orig->bi_error = bio->bi_error;
-- 
2.7.4
