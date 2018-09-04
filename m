Return-Path: <BATV+97b555f176c451e34851+5490+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-block@vger.kernel.org,
	xen-devel@lists.xen.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/13] block: move req_gap_{back,front}_merge to blk-merge.c
Date: Tue,  4 Sep 2018 12:14:23 -0700
Message-Id: <20180904191431.20102-6-hch@lst.de>
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Keep it close to the actual users instead of exposing the function to all
drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c      | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 69 ------------------------------------------
 2 files changed, 65 insertions(+), 69 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index aaec38cc37b8..ad8a226347a6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -12,6 +12,71 @@
 
 #include "blk.h"
 
+/*
+ * Check if the two bvecs from two bios can be merged to one segment.  If yes,
+ * no need to check gap between the two bios since the 1st bio and the 1st bvec
+ * in the 2nd bio can be handled in one segment.
+ */
+static inline bool bios_segs_mergeable(struct request_queue *q,
+		struct bio *prev, struct bio_vec *prev_last_bv,
+		struct bio_vec *next_first_bv)
+{
+	if (!BIOVEC_PHYS_MERGEABLE(prev_last_bv, next_first_bv))
+		return false;
+	if (!BIOVEC_SEG_BOUNDARY(q, prev_last_bv, next_first_bv))
+		return false;
+	if (prev->bi_seg_back_size + next_first_bv->bv_len >
+			queue_max_segment_size(q))
+		return false;
+	return true;
+}
+
+static inline bool bio_will_gap(struct request_queue *q,
+		struct request *prev_rq, struct bio *prev, struct bio *next)
+{
+	struct bio_vec pb, nb;
+
+	if (!bio_has_data(prev) || !queue_virt_boundary(q))
+		return false;
+
+	/*
+	 * Don't merge if the 1st bio starts with non-zero offset, otherwise it
+	 * is quite difficult to respect the sg gap limit.  We work hard to
+	 * merge a huge number of small single bios in case of mkfs.
+	 */
+	if (prev_rq)
+		bio_get_first_bvec(prev_rq->bio, &pb);
+	else
+		bio_get_first_bvec(prev, &pb);
+	if (pb.bv_offset)
+		return true;
+
+	/*
+	 * We don't need to worry about the situation that the merged segment
+	 * ends in unaligned virt boundary:
+	 *
+	 * - if 'pb' ends aligned, the merged segment ends aligned
+	 * - if 'pb' ends unaligned, the next bio must include
+	 *   one single bvec of 'nb', otherwise the 'nb' can't
+	 *   merge with 'pb'
+	 */
+	bio_get_last_bvec(prev, &pb);
+	bio_get_first_bvec(next, &nb);
+	if (bios_segs_mergeable(q, prev, &pb, &nb))
+		return false;
+	return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
+}
+
+static inline bool req_gap_back_merge(struct request *req, struct bio *bio)
+{
+	return bio_will_gap(req->q, req, req->biotail, bio);
+}
+
+static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
+{
+	return bio_will_gap(req->q, NULL, bio, req->bio);
+}
+
 static struct bio *blk_bio_discard_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc534c857344..b7e676bb01bc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1695,75 +1695,6 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
-/*
- * Check if the two bvecs from two bios can be merged to one segment.
- * If yes, no need to check gap between the two bios since the 1st bio
- * and the 1st bvec in the 2nd bio can be handled in one segment.
- */
-static inline bool bios_segs_mergeable(struct request_queue *q,
-		struct bio *prev, struct bio_vec *prev_last_bv,
-		struct bio_vec *next_first_bv)
-{
-	if (!BIOVEC_PHYS_MERGEABLE(prev_last_bv, next_first_bv))
-		return false;
-	if (!BIOVEC_SEG_BOUNDARY(q, prev_last_bv, next_first_bv))
-		return false;
-	if (prev->bi_seg_back_size + next_first_bv->bv_len >
-			queue_max_segment_size(q))
-		return false;
-	return true;
-}
-
-static inline bool bio_will_gap(struct request_queue *q,
-				struct request *prev_rq,
-				struct bio *prev,
-				struct bio *next)
-{
-	if (bio_has_data(prev) && queue_virt_boundary(q)) {
-		struct bio_vec pb, nb;
-
-		/*
-		 * don't merge if the 1st bio starts with non-zero
-		 * offset, otherwise it is quite difficult to respect
-		 * sg gap limit. We work hard to merge a huge number of small
-		 * single bios in case of mkfs.
-		 */
-		if (prev_rq)
-			bio_get_first_bvec(prev_rq->bio, &pb);
-		else
-			bio_get_first_bvec(prev, &pb);
-		if (pb.bv_offset)
-			return true;
-
-		/*
-		 * We don't need to worry about the situation that the
-		 * merged segment ends in unaligned virt boundary:
-		 *
-		 * - if 'pb' ends aligned, the merged segment ends aligned
-		 * - if 'pb' ends unaligned, the next bio must include
-		 *   one single bvec of 'nb', otherwise the 'nb' can't
-		 *   merge with 'pb'
-		 */
-		bio_get_last_bvec(prev, &pb);
-		bio_get_first_bvec(next, &nb);
-
-		if (!bios_segs_mergeable(q, prev, &pb, &nb))
-			return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
-	}
-
-	return false;
-}
-
-static inline bool req_gap_back_merge(struct request *req, struct bio *bio)
-{
-	return bio_will_gap(req->q, req, req->biotail, bio);
-}
-
-static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
-{
-	return bio_will_gap(req->q, NULL, bio, req->bio);
-}
-
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_work_on(int cpu, struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
-- 
2.18.0
