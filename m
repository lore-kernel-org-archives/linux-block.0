Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 22/54] block: bounce: convert multipage bvecs into singlepage
Date: Tue, 27 Dec 2016 23:56:11 +0800
Message-Id: <1482854250-13481-23-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

This patch trys to split the incoming multipage bvecs bio, so
that the splitted bio can be held into one singlepage bvecs bio.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/bounce.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index a42f7b98b7e6..08841ed4cdae 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -187,22 +187,33 @@ static void bounce_end_io_read_isa(struct bio *bio)
 	__bounce_end_io_read(bio, isa_page_pool);
 }
 
+static inline bool need_bounce(struct request_queue *q, struct bio *bio)
+{
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	bio_for_each_segment_mp(bv, bio, iter) {
+		unsigned nr = (bv.bv_offset + bv.bv_len - 1) >>
+			PAGE_SHIFT;
+
+		if (page_to_pfn(bv.bv_page) + nr > queue_bounce_pfn(q))
+			return true;
+	}
+	return false;
+}
+
 static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 			       mempool_t *pool)
 {
 	struct bio *bio;
 	int rw = bio_data_dir(*bio_orig);
-	struct bio_vec *to, from;
-	struct bvec_iter iter;
+	struct bio_vec *to;
 	unsigned i;
 
-	bio_for_each_segment(from, *bio_orig, iter)
-		if (page_to_pfn(from.bv_page) > queue_bounce_pfn(q))
-			goto bounce;
+	if (!need_bounce(q, *bio_orig))
+		return;
 
-	return;
-bounce:
-	bio = bio_clone_bioset(*bio_orig, GFP_NOIO, fs_bio_set);
+	bio = bio_clone_bioset_sp(*bio_orig, GFP_NOIO, fs_bio_set);
 
 	bio_for_each_segment_all(to, bio, i) {
 		struct page *page = to->bv_page;
@@ -246,6 +257,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 void blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 {
 	mempool_t *pool;
+	unsigned sectors;
 
 	/*
 	 * Data-less bio, nothing to bounce
@@ -267,9 +279,22 @@ void blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 		pool = isa_page_pool;
 	}
 
+	if (!need_bounce(q, *bio_orig))
+		return;
+
 	/*
 	 * slow path
+	 *
+	 * REQ_PC bio won't reach splitting because multipage bvec
+	 * isn't enabled for REQ_PC.
 	 */
+	if (!bio_can_convert_to_sp(*bio_orig, &sectors)) {
+		struct bio *split = bio_split(*bio_orig, sectors,
+					      GFP_NOIO, q->bio_split);
+		bio_chain(split, *bio_orig);
+		generic_make_request(*bio_orig);
+		*bio_orig = split;
+	}
 	__blk_queue_bounce(q, bio_orig, pool);
 }
 
-- 
2.7.4
