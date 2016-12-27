Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 25/54] block: blk-merge: try to make front segments in full size
Date: Tue, 27 Dec 2016 23:56:14 +0800
Message-Id: <1482854250-13481-26-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

When merging one bvec into segment, if the bvec is too big
to merge, current policy is to move the whole bvec into another
new segment.

This patchset changes the policy into trying to maximize size of
front segments, that means in above situation, part of bvec
is merged into current segment, and the remainder is put
into next segment.

This patch prepares for support multipage bvec because
it can be quite common to see this case and we should try
to make front segments in full size.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-merge.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e3abc835e4b7..a801f62a104b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -95,6 +95,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio *new = NULL;
 	const unsigned max_sectors = get_max_io_size(q, bio);
 	unsigned bvecs = 0;
+	unsigned advance = 0;
 
 	bio_for_each_segment(bv, bio, iter) {
 		/*
@@ -141,12 +142,32 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		}
 
 		if (bvprvp && blk_queue_cluster(q)) {
-			if (seg_size + bv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
 			if (!BIOVEC_PHYS_MERGEABLE(bvprvp, &bv))
 				goto new_segment;
 			if (!BIOVEC_SEG_BOUNDARY(q, bvprvp, &bv))
 				goto new_segment;
+			if (seg_size + bv.bv_len > queue_max_segment_size(q)) {
+				/*
+				 * On assumption is that initial value of
+				 * @seg_size(equals to bv.bv_len) won't be
+				 * bigger than max segment size, but will
+				 * becomes false after multipage bvec comes.
+				 */
+				advance = queue_max_segment_size(q) - seg_size;
+
+				if (advance > 0) {
+					seg_size += advance;
+					sectors += advance >> 9;
+					bv.bv_len -= advance;
+					bv.bv_offset += advance;
+				}
+
+				/*
+				 * Still need to put remainder of current
+				 * bvec into a new segment.
+				 */
+				goto new_segment;
+			}
 
 			seg_size += bv.bv_len;
 			bvprv = bv;
@@ -168,6 +189,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		seg_size = bv.bv_len;
 		sectors += bv.bv_len >> 9;
 
+		/* restore the bvec for iterator */
+		if (advance) {
+			bv.bv_len += advance;
+			bv.bv_offset -= advance;
+			advance = 0;
+		}
 	}
 
 	do_split = false;
@@ -370,16 +397,29 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 {
 
 	int nbytes = bvec->bv_len;
+	unsigned advance = 0;
 
 	if (*sg && *cluster) {
-		if ((*sg)->length + nbytes > queue_max_segment_size(q))
-			goto new_segment;
-
 		if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
 			goto new_segment;
 		if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
 			goto new_segment;
 
+		/*
+		 * try best to merge part of the bvec into previous
+		 * segment and follow same policy with
+		 * blk_bio_segment_split()
+		 */
+		if ((*sg)->length + nbytes > queue_max_segment_size(q)) {
+			advance = queue_max_segment_size(q) - (*sg)->length;
+			if (advance) {
+				(*sg)->length += advance;
+				bvec->bv_offset += advance;
+				bvec->bv_len -= advance;
+			}
+			goto new_segment;
+		}
+
 		(*sg)->length += nbytes;
 	} else {
 new_segment:
@@ -402,6 +442,10 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 
 		sg_set_page(*sg, bvec->bv_page, nbytes, bvec->bv_offset);
 		(*nsegs)++;
+
+		/* for making iterator happy */
+		bvec->bv_offset -= advance;
+		bvec->bv_len += advance;
 	}
 	*bvprv = *bvec;
 }
-- 
2.7.4
