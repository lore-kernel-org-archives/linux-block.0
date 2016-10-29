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
Subject: [PATCH 42/60] block: use bio_for_each_segment_mp() to compute segments count
Date: Sat, 29 Oct 2016 16:08:41 +0800
Message-Id: <1477728600-12938-43-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Firstly it is more efficient to use bio_for_each_segment_mp()
in both blk_bio_segment_split() and __blk_recalc_rq_segments()
to compute how many segments there are in the bio.

Secondaly once bio_for_each_segment_mp() is used, the bvec
may need to be splitted because its length can be very long
and more than max segment size, so we have to split one bvec
into several segments.

Thirdly during splitting mp bvec into segments, max segment
number may be reached, then the bio need to be splitted.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-merge.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a6457e70dafc..9142f1fc914b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -86,6 +86,61 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 	return sectors;
 }
 
+static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
+		unsigned *nsegs, unsigned *last_seg_size,
+		unsigned *front_seg_size, unsigned *sectors)
+{
+	bool need_split = false;
+	unsigned old_nsegs = *nsegs;
+	unsigned new_nsegs, seg_size;
+
+	WARN_ON(old_nsegs == queue_max_segments(q));
+	WARN_ON(bv->bv_len == 0);
+
+	/*
+	 * Multipage bvec is too big to hold in one segment,
+	 * so the current bvec has to be splitted as multiple
+	 * segments.
+	 *
+	 * @seg_size is segment size of last segment in this bvec
+	 * @new_nsegs is segment count of this bvec
+	 */
+	seg_size = bv->bv_len % queue_max_segment_size(q);
+	new_nsegs = bv->bv_len / queue_max_segment_size(q);
+	if (!seg_size)
+		seg_size = queue_max_segment_size(q);
+	else
+		new_nsegs += 1;
+
+	/* need splitting if max segs is reached */
+	if (old_nsegs + new_nsegs > queue_max_segments(q)) {
+		new_nsegs = queue_max_segments(q) - old_nsegs;
+
+		/* split the bvec */
+		if (bv->bv_len > queue_max_segment_size(q))
+			seg_size = queue_max_segment_size(q);
+		need_split = true;
+	}
+
+	/* update front segment size */
+	if (!old_nsegs) {
+		unsigned first_seg_size = seg_size;
+		if (new_nsegs > 1)
+			first_seg_size = queue_max_segment_size(q);
+		if (*front_seg_size < first_seg_size)
+			*front_seg_size = first_seg_size;
+	}
+
+	*last_seg_size = seg_size;
+	*nsegs += new_nsegs;
+
+	if (sectors)
+		*sectors += ((new_nsegs - 1) *
+				queue_max_segment_size(q) + seg_size) >> 9;
+
+	return need_split;
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
@@ -101,7 +156,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	unsigned bvecs = 0;
 	unsigned advance;
 
-	bio_for_each_segment(bv, bio, iter) {
+	bio_for_each_segment_mp(bv, bio, iter) {
 		/*
 		 * With arbitrary bio size, the incoming bio may be very
 		 * big. We have to split the bio into small bios so that
@@ -138,8 +193,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 			 */
 			if (nsegs < queue_max_segments(q) &&
 			    sectors < max_sectors) {
-				nsegs++;
-				sectors = max_sectors;
+				/* split in the middle of bvec */
+				bv.bv_len = (max_sectors - sectors) << 9;
+				bvec_split_segs(q, &bv, &nsegs,
+						&seg_size,
+						&front_seg_size,
+						&sectors);
 			}
 			if (sectors)
 				goto split;
@@ -180,11 +239,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		if (nsegs == 1 && seg_size > front_seg_size)
 			front_seg_size = seg_size;
 
-		nsegs++;
 		bvprv = bv;
 		bvprvp = &bvprv;
-		seg_size = bv.bv_len;
-		sectors += bv.bv_len >> 9;
+
+		if (bvec_split_segs(q, &bv, &nsegs, &seg_size,
+					&front_seg_size, &sectors))
+			goto split;
 
 		/* restore the bvec for iterator */
 		bv.bv_len += advance;
@@ -253,6 +313,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	struct bio_vec bv, bvprv = { NULL };
 	int cluster, prev = 0;
 	unsigned int seg_size, nr_phys_segs;
+	unsigned front_seg_size = bio->bi_seg_front_size;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
 
@@ -274,7 +335,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	seg_size = 0;
 	nr_phys_segs = 0;
 	for_each_bio(bio) {
-		bio_for_each_segment(bv, bio, iter) {
+		bio_for_each_segment_mp(bv, bio, iter) {
 			/*
 			 * If SG merging is disabled, each bio vector is
 			 * a segment
@@ -296,20 +357,20 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 				continue;
 			}
 new_segment:
-			if (nr_phys_segs == 1 && seg_size >
-			    fbio->bi_seg_front_size)
-				fbio->bi_seg_front_size = seg_size;
+			if (nr_phys_segs == 1 && seg_size > front_seg_size)
+				front_seg_size = seg_size;
 
-			nr_phys_segs++;
 			bvprv = bv;
 			prev = 1;
-			seg_size = bv.bv_len;
+			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
+					&front_seg_size, NULL);
 		}
 		bbio = bio;
 	}
 
-	if (nr_phys_segs == 1 && seg_size > fbio->bi_seg_front_size)
-		fbio->bi_seg_front_size = seg_size;
+	if (nr_phys_segs == 1 && seg_size > front_seg_size)
+		front_seg_size = seg_size;
+	fbio->bi_seg_front_size = front_seg_size;
 	if (seg_size > bbio->bi_seg_back_size)
 		bbio->bi_seg_back_size = seg_size;
 
-- 
2.7.4
