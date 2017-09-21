Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: Jens Axboe <axboe@kernel.dk>, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [V2] block: consider merge of segments when merge bio into rq
Date: Fri, 22 Sep 2017 01:29:09 +0800
Message-Id: <1506014949-24184-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When account the nr_phys_segments during merging bios into rq,
only consider segments merging in individual bio but not all
the bios in a rq. This leads to the bigger nr_phys_segments of
rq than the real one when the segments of bios in rq are
contiguous and mergeable. The nr_phys_segments of rq will exceed
max_segmets of q and stop merging while the sectors of rq maybe
far away from the max_sectors of q.

In practice, the merging will stop due to max_segmets limit while
the segments in the rq are contiguous and mergeable during the
mkfs.ext4 workload on my local. This could be harmful to the
performance of sequential operations.

To fix it, consider the segments merge when account nr_phys_segments
of rq during merging bio into rq. Decrease the nr_phys_segments of rq
by 1 when the adjacent segments in bio and rq are contiguous and
mergeable. Consequently get more fully merging and better performance
in sequential operations. In addition, it could eliminate the wasting of
scatterlist structure.

On my local mkfs.ext4 workload, the final size of rq issued raise from
168 sectors (max_segmets is 168) to 2560 sectors (max_sector_kb is 1280).

V2 : Add more comment to elaborate how this issue found and result after
apply the patch.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-merge.c | 98 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 34 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 14b6e37..b2f54fd 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -472,54 +472,60 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL(blk_rq_map_sg);
 
-static inline int ll_new_hw_segment(struct request_queue *q,
-				    struct request *req,
-				    struct bio *bio)
-{
-	int nr_phys_segs = bio_phys_segments(q, bio);
-
-	if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(q))
-		goto no_merge;
-
-	if (blk_integrity_merge_bio(q, req, bio) == false)
-		goto no_merge;
-
-	/*
-	 * This will form the start of a new hw segment.  Bump both
-	 * counters.
-	 */
-	req->nr_phys_segments += nr_phys_segs;
-	return 1;
-
-no_merge:
-	req_set_nomerge(q, req);
-	return 0;
-}
-
 int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		     struct bio *bio)
 {
+	unsigned int seg_size;
+	int total_nr_phys_segs;
+	bool contig;
+
 	if (req_gap_back_merge(req, bio))
 		return 0;
 	if (blk_integrity_rq(req) &&
 	    integrity_req_gap_back_merge(req, bio))
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
-	    blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
-		req_set_nomerge(q, req);
-		return 0;
-	}
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
+		goto no_merge;
+
 	if (!bio_flagged(req->biotail, BIO_SEG_VALID))
 		blk_recount_segments(q, req->biotail);
 	if (!bio_flagged(bio, BIO_SEG_VALID))
 		blk_recount_segments(q, bio);
 
-	return ll_new_hw_segment(q, req, bio);
+	if (blk_integrity_merge_bio(q, req, bio) == false)
+		goto no_merge;
+
+	seg_size = req->biotail->bi_seg_back_size + bio->bi_seg_front_size;
+	total_nr_phys_segs = req->nr_phys_segments + bio_phys_segments(q, bio);
+
+	contig = blk_phys_contig_segment(q, req->biotail, bio);
+	if (contig)
+		total_nr_phys_segs--;
+
+	if (unlikely(total_nr_phys_segs > queue_max_segments(q)))
+		goto no_merge;
+
+	if (contig) {
+		if (req->nr_phys_segments == 1)
+			req->bio->bi_seg_front_size = seg_size;
+		if (bio->bi_phys_segments == 1)
+			bio->bi_seg_back_size = seg_size;
+	}
+	req->nr_phys_segments = total_nr_phys_segs;
+	return 1;
+
+no_merge:
+	req_set_nomerge(q, req);
+	return 0;
 }
 
 int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		      struct bio *bio)
 {
+	unsigned int seg_size;
+	int total_nr_phys_segs;
+	bool contig;
 
 	if (req_gap_front_merge(req, bio))
 		return 0;
@@ -527,16 +533,40 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 	    integrity_req_gap_front_merge(req, bio))
 		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
-	    blk_rq_get_max_sectors(req, bio->bi_iter.bi_sector)) {
-		req_set_nomerge(q, req);
-		return 0;
-	}
+	    blk_rq_get_max_sectors(req, bio->bi_iter.bi_sector))
+		goto no_merge;
+
 	if (!bio_flagged(bio, BIO_SEG_VALID))
 		blk_recount_segments(q, bio);
 	if (!bio_flagged(req->bio, BIO_SEG_VALID))
 		blk_recount_segments(q, req->bio);
 
-	return ll_new_hw_segment(q, req, bio);
+	if (blk_integrity_merge_bio(q, req, bio) == false)
+		goto no_merge;
+
+	seg_size = req->bio->bi_seg_front_size + bio->bi_seg_back_size;
+	total_nr_phys_segs = req->nr_phys_segments + bio_phys_segments(q, bio);
+
+	contig = blk_phys_contig_segment(q, bio, req->bio);
+	if (contig)
+		total_nr_phys_segs--;
+
+	if (unlikely(total_nr_phys_segs > queue_max_segments(q)))
+		goto no_merge;
+
+	if (contig) {
+		if (req->nr_phys_segments == 1)
+			req->biotail->bi_seg_back_size = seg_size;
+		if (bio->bi_phys_segments == 1)
+			bio->bi_seg_front_size = seg_size;
+	}
+
+	req->nr_phys_segments = total_nr_phys_segs;
+	return 1;
+
+no_merge:
+	req_set_nomerge(q, req);
+	return 0;
 }
 
 /*
-- 
2.7.4
