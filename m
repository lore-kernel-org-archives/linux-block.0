Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 27/54] block: use bio_for_each_segment_mp() to compute segments count
Date: Tue, 27 Dec 2016 23:56:16 +0800
Message-Id: <1482854250-13481-28-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
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
 block/blk-merge.c | 98 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 05b6a3ef63f6..a0e97959db7b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -82,6 +82,63 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 	return sectors;
 }
 
+/*
+ * Split the bvec @bv into segments, and update all kinds of
+ * variables.
+ */
+static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
+		unsigned *nsegs, unsigned *last_seg_size,
+		unsigned *front_seg_size, unsigned *sectors)
+{
+	bool need_split = false;
+	unsigned len = bv->bv_len;
+	unsigned total_len = 0;
+	unsigned new_nsegs = 0, seg_size = 0;
+	int idx;
+
+	if ((*nsegs >= queue_max_segments(q)) || !len)
+		return need_split;
+
+	/*
+	 * Multipage bvec may be too big to hold in one segment,
+	 * so the current bvec has to be splitted as multiple
+	 * segments.
+	 */
+	while (new_nsegs + *nsegs < queue_max_segments(q)) {
+		seg_size = min(queue_max_segment_size(q), len);
+
+		new_nsegs++;
+		total_len += seg_size;
+		len -= seg_size;
+
+		if ((queue_virt_boundary(q) && ((bv->bv_offset +
+		    total_len) & queue_virt_boundary(q))) || !len)
+			break;
+	}
+
+	/* split in the middle of the bvec */
+	if (len)
+		need_split = true;
+
+	/* update front segment size */
+	if (!*nsegs) {
+		unsigned first_seg_size = seg_size;
+
+		if (new_nsegs > 1)
+			first_seg_size = queue_max_segment_size(q);
+		if (*front_seg_size < first_seg_size)
+			*front_seg_size = first_seg_size;
+	}
+
+	/* update other varibles */
+	*last_seg_size = seg_size;
+	*nsegs += new_nsegs;
+	if (sectors)
+		*sectors += total_len >> 9;
+
+	return need_split;
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
@@ -97,7 +154,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	unsigned bvecs = 0;
 	unsigned advance = 0;
 
-	bio_for_each_segment(bv, bio, iter) {
+	bio_for_each_segment_mp(bv, bio, iter) {
 		/*
 		 * With arbitrary bio size, the incoming bio may be very
 		 * big. We have to split the bio into small bios so that
@@ -133,8 +190,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
 			goto split;
 		}
@@ -146,10 +207,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 				goto new_segment;
 			if (seg_size + bv.bv_len > queue_max_segment_size(q)) {
 				/*
-				 * On assumption is that initial value of
-				 * @seg_size(equals to bv.bv_len) won't be
-				 * bigger than max segment size, but will
-				 * becomes false after multipage bvec comes.
+				 * The initial value of @seg_size won't be
+				 * bigger than max segment size, because we
+				 * split the bvec via bvec_split_segs().
 				 */
 				advance = queue_max_segment_size(q) - seg_size;
 
@@ -181,11 +241,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
 		if (advance) {
@@ -261,6 +322,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	struct bio_vec bv, bvprv = { NULL };
 	int cluster, prev = 0;
 	unsigned int seg_size, nr_phys_segs;
+	unsigned front_seg_size = bio->bi_seg_front_size;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
 
@@ -281,7 +343,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	seg_size = 0;
 	nr_phys_segs = 0;
 	for_each_bio(bio) {
-		bio_for_each_segment(bv, bio, iter) {
+		bio_for_each_segment_mp(bv, bio, iter) {
 			/*
 			 * If SG merging is disabled, each bio vector is
 			 * a segment
@@ -303,20 +365,20 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
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
