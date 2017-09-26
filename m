Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: Jens Axboe <axboe@kernel.dk>, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] block: consider merge of segments when merge bio into rq
Date: Tue, 26 Sep 2017 11:31:35 +0800
Message-Id: <1506396695-15858-1-git-send-email-jianchao.w.wang@oracle.com>
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

On my local mkfs.ext4 workload of 4.13.r7, the final size of rq issued
raise from 168 sectors (max_segmets is 168) to 2560 sectors
(max_sector_kb is 1280).

Change since v3:
Add the kernel version of which the test result is based on. On the
4.14.rc1, the per bio size has became 8 sectors in the sequential
workload of mkfs.ext4, instead of 1 sector in 4.13.rc7.

Change since v2:
Merge the duplicate code of segments merging check in
ll_front/back_merge_fn() together into ll_new_hw_segment().

Change since v1:
Add more comment to elaborate how this issue found and result after
apply the patch.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-merge.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index aa524ca..8dacedb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -474,28 +474,50 @@ EXPORT_SYMBOL(blk_rq_map_sg);
 
 static inline int ll_new_hw_segment(struct request_queue *q,
 				    struct request *req,
-				    struct bio *bio)
+				    struct bio *bio,
+				    bool at_head)
 {
-	int nr_phys_segs = bio_phys_segments(q, bio);
+	unsigned int seg_size;
+	int total_nr_phys_segs;
+	bool contig;
 
-	if (req->nr_phys_segments + nr_phys_segs > queue_max_segments(q))
+	if (blk_integrity_merge_bio(q, req, bio) == false)
 		goto no_merge;
 
-	if (blk_integrity_merge_bio(q, req, bio) == false)
+	total_nr_phys_segs = req->nr_phys_segments + bio_phys_segments(q, bio);
+	if (at_head) {
+		seg_size = bio->bi_seg_back_size + req->bio->bi_seg_front_size;
+		contig = blk_phys_contig_segment(q, bio, req->bio);
+	} else {
+		seg_size = req->biotail->bi_seg_back_size + bio->bi_seg_front_size;
+		contig = blk_phys_contig_segment(q, req->biotail, bio);
+	}
+	if (contig)
+		total_nr_phys_segs--;
+
+	if (unlikely(total_nr_phys_segs > queue_max_segments(q)))
 		goto no_merge;
 
-	/*
-	 * This will form the start of a new hw segment.  Bump both
-	 * counters.
-	 */
-	req->nr_phys_segments += nr_phys_segs;
-	return 1;
+	if (contig) {
+		if (at_head) {
+			if (bio->bi_phys_segments == 1)
+				bio->bi_seg_front_size = seg_size;
+			if (req->nr_phys_segments == 1)
+				req->biotail->bi_seg_back_size = seg_size;
+		} else {
+			if (req->nr_phys_segments == 1)
+				req->bio->bi_seg_front_size = seg_size;
+			if (bio->bi_phys_segments == 1)
+				bio->bi_seg_back_size = seg_size;
+		}
+	}
 
+	req->nr_phys_segments = total_nr_phys_segs;
+	return 1;
 no_merge:
 	req_set_nomerge(q, req);
 	return 0;
 }
-
 int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		     struct bio *bio)
 {
@@ -514,13 +536,12 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 	if (!bio_flagged(bio, BIO_SEG_VALID))
 		blk_recount_segments(q, bio);
 
-	return ll_new_hw_segment(q, req, bio);
+	return ll_new_hw_segment(q, req, bio, false);
 }
 
 int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		      struct bio *bio)
 {
-
 	if (req_gap_front_merge(req, bio))
 		return 0;
 	if (blk_integrity_rq(req) &&
@@ -536,7 +557,7 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 	if (!bio_flagged(req->bio, BIO_SEG_VALID))
 		blk_recount_segments(q, req->bio);
 
-	return ll_new_hw_segment(q, req, bio);
+	return ll_new_hw_segment(q, req, bio, true);
 }
 
 /*
-- 
2.7.4
