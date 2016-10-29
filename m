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
Subject: [PATCH 43/60] block: use bio_for_each_segment_mp() to map sg
Date: Sat, 29 Oct 2016 16:08:42 +0800
Message-Id: <1477728600-12938-44-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

It is more efficient to use bio_for_each_segment_mp()
for mapping sg, meantime we have to consider splitting
multipage bvec as done in blk_bio_segment_split().

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-merge.c | 72 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9142f1fc914b..e3b8cbc8b675 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -442,6 +442,56 @@ static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
 	return 0;
 }
 
+static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
+		struct scatterlist *sglist)
+{
+	if (!*sg)
+		return sglist;
+	else {
+		/*
+		 * If the driver previously mapped a shorter
+		 * list, we could see a termination bit
+		 * prematurely unless it fully inits the sg
+		 * table on each mapping. We KNOW that there
+		 * must be more entries here or the driver
+		 * would be buggy, so force clear the
+		 * termination bit to avoid doing a full
+		 * sg_init_table() in drivers for each command.
+		 */
+		sg_unmark_end(*sg);
+		return sg_next(*sg);
+	}
+}
+
+static inline unsigned
+blk_bvec_map_sg(struct request_queue *q, struct bio_vec *bvec,
+		struct scatterlist *sglist, struct scatterlist **sg)
+{
+	unsigned nbytes = bvec->bv_len;
+	unsigned nsegs = 0, total = 0;
+
+	while (nbytes > 0) {
+		unsigned seg_size;
+		struct page *pg;
+		unsigned offset, idx;
+
+		*sg = blk_next_sg(sg, sglist);
+
+		seg_size = min(nbytes, queue_max_segment_size(q));
+		offset = (total + bvec->bv_offset) % PAGE_SIZE;
+		idx = (total + bvec->bv_offset) / PAGE_SIZE;
+		pg = nth_page(bvec->bv_page, idx);
+
+		sg_set_page(*sg, pg, seg_size, offset);
+
+		total += seg_size;
+		nbytes -= seg_size;
+		nsegs++;
+	}
+
+	return nsegs;
+}
+
 static inline void
 __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		     struct scatterlist *sglist, struct bio_vec *bvprv,
@@ -475,25 +525,7 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 		(*sg)->length += nbytes;
 	} else {
 new_segment:
-		if (!*sg)
-			*sg = sglist;
-		else {
-			/*
-			 * If the driver previously mapped a shorter
-			 * list, we could see a termination bit
-			 * prematurely unless it fully inits the sg
-			 * table on each mapping. We KNOW that there
-			 * must be more entries here or the driver
-			 * would be buggy, so force clear the
-			 * termination bit to avoid doing a full
-			 * sg_init_table() in drivers for each command.
-			 */
-			sg_unmark_end(*sg);
-			*sg = sg_next(*sg);
-		}
-
-		sg_set_page(*sg, bvec->bv_page, nbytes, bvec->bv_offset);
-		(*nsegs)++;
+		(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
 
 		/* for making iterator happy */
 		bvec->bv_offset -= advance;
@@ -536,7 +568,7 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 	}
 
 	for_each_bio(bio)
-		bio_for_each_segment(bvec, bio, iter)
+		bio_for_each_segment_mp(bvec, bio, iter)
 			__blk_segment_map_sg(q, &bvec, sglist, &bvprv, sg,
 					     &nsegs, &cluster);
 
-- 
2.7.4
