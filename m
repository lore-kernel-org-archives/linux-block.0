Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759046AbdLRM20 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Dec 2017 07:28:26 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 20/45] block: use bio_for_each_segment() to compute segments count
Date: Mon, 18 Dec 2017 20:22:22 +0800
Message-Id: <20171218122247.3488-21-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Firstly it is more efficient to use bio_for_each_segment() in both
blk_bio_segment_split() and __blk_recalc_rq_segments() to compute how many
segments there are in the bio.

Secondaly once bio_for_each_segment() is used, the bvec may need to
be splitted because its length can be very longer than max segment size,
so we have to split the big bvec into several segments.

Thirdly during splitting multipage bvec into segments, max segment number
may be reached, then the bio need to be splitted when this happens.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 25ffb84be058..f65546b46fff 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -97,6 +97,62 @@ static inline unsigned get_max_io_size(struct request_queue *q,
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
@@ -111,7 +167,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	const unsigned max_sectors = get_max_io_size(q, bio);
 	unsigned advance = 0;
 
-	bio_for_each_page(bv, bio, iter) {
+	bio_for_each_segment(bv, bio, iter) {
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -126,8 +182,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
@@ -139,10 +199,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
 
@@ -174,11 +233,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
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
@@ -252,6 +312,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	struct bio_vec bv, bvprv = { NULL };
 	int cluster, prev = 0;
 	unsigned int seg_size, nr_phys_segs;
+	unsigned front_seg_size = bio->bi_seg_front_size;
 	struct bio *fbio, *bbio;
 	struct bvec_iter iter;
 
@@ -272,7 +333,7 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	seg_size = 0;
 	nr_phys_segs = 0;
 	for_each_bio(bio) {
-		bio_for_each_page(bv, bio, iter) {
+		bio_for_each_segment(bv, bio, iter) {
 			/*
 			 * If SG merging is disabled, each bio vector is
 			 * a segment
@@ -294,20 +355,20 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
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
2.9.5
