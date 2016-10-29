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
Subject: [PATCH 37/60] block: bounce: don't access bio->bi_io_vec in copy_to_high_bio_irq
Date: Sat, 29 Oct 2016 16:08:36 +0800
Message-Id: <1477728600-12938-38-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

As we need to support multipage bvecs, so don't access bio->bi_io_vec
in copy_to_high_bio_irq(), and just use the standard iterator
to do that.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/bounce.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index babd3f224ca0..a42f7b98b7e6 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -102,24 +102,30 @@ int init_emergency_isa_pool(void)
 static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 {
 	unsigned char *vfrom;
-	struct bio_vec tovec, *fromvec = from->bi_io_vec;
+	struct bio_vec tovec, fromvec;
 	struct bvec_iter iter;
+	/*
+	 * @from bio is created by bounce, so we can iterate from
+	 * start and can't trust @from->bi_iter because it might be
+	 * changed by splitting.
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
 
-- 
2.7.4
