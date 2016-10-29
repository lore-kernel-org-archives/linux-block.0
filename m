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
Subject: [PATCH 41/60] block: blk-merge: try to make front segments in full size
Date: Sat, 29 Oct 2016 16:08:40 +0800
Message-Id: <1477728600-12938-42-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
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
 block/blk-merge.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 465d9c65cb41..a6457e70dafc 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -99,6 +99,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	struct bio *new = NULL;
 	const unsigned max_sectors = get_max_io_size(q, bio);
 	unsigned bvecs = 0;
+	unsigned advance;
 
 	bio_for_each_segment(bv, bio, iter) {
 		/*
@@ -129,6 +130,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
 			goto split;
 
+		advance = 0;
 		if (sectors + (bv.bv_len >> 9) > max_sectors) {
 			/*
 			 * Consider this a new segment if we're splitting in
@@ -145,12 +147,24 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		}
 
 		if (bvprvp && blk_queue_cluster(q)) {
-			if (seg_size + bv.bv_len > queue_max_segment_size(q))
-				goto new_segment;
 			if (!BIOVEC_PHYS_MERGEABLE(bvprvp, &bv))
 				goto new_segment;
 			if (!BIOVEC_SEG_BOUNDARY(q, bvprvp, &bv))
 				goto new_segment;
+			if (seg_size + bv.bv_len > queue_max_segment_size(q)) {
+				advance = queue_max_segment_size(q) - seg_size;
+
+				if (advance > 0) {
+					seg_size += advance;
+					sectors += advance >> 9;
+					bv.bv_len -= advance;
+					bv.bv_offset += advance;
+				} else {
+					advance = 0;
+				}
+
+				goto new_segment;
+			}
 
 			seg_size += bv.bv_len;
 			bvprv = bv;
@@ -172,6 +186,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		seg_size = bv.bv_len;
 		sectors += bv.bv_len >> 9;
 
+		/* restore the bvec for iterator */
+		bv.bv_len += advance;
+		bv.bv_offset -= advance;
 	}
 
 	do_split = false;
@@ -371,16 +388,29 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 {
 
 	int nbytes = bvec->bv_len;
+	int advance = 0;
 
 	if (*sg && *cluster) {
-		if ((*sg)->length + nbytes > queue_max_segment_size(q))
-			goto new_segment;
-
 		if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
 			goto new_segment;
 		if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
 			goto new_segment;
 
+		/* try best to merge part of the bvec into previous seg */
+		if ((*sg)->length + nbytes > queue_max_segment_size(q)) {
+			advance = queue_max_segment_size(q) - (*sg)->length;
+			if (advance <= 0) {
+				advance = 0;
+				goto new_segment;
+			}
+
+			(*sg)->length += advance;
+
+			bvec->bv_offset += advance;
+			bvec->bv_len -= advance;
+			goto new_segment;
+		}
+
 		(*sg)->length += nbytes;
 	} else {
 new_segment:
@@ -403,6 +433,10 @@ __blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
 
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
