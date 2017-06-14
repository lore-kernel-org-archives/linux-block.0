Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/10] block: add support for carrying stream information in a bio
Date: Tue, 13 Jun 2017 22:01:50 -0600
Message-Id: <1497412919-19400-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, but it allows each bio to
carry a stream ID and disallows merging of bio's with different
stream IDs.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c               |  2 ++
 block/blk-merge.c         | 14 ++++++++++++++
 include/linux/blk_types.h | 17 +++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 888e7801c638..77f4be1f7428 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -595,6 +595,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
+	bio->bi_stream = bio_src->bi_stream;
 
 	bio_clone_blkcg_association(bio, bio_src);
 }
@@ -678,6 +679,7 @@ struct bio *bio_clone_bioset(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_opf		= bio_src->bi_opf;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
+	bio->bi_stream		= bio_src->bi_stream;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3990ae406341..28998acdd675 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -693,6 +693,13 @@ static struct request *attempt_merge(struct request_queue *q,
 		return NULL;
 
 	/*
+	 * Don't allow merge of different streams, or for a stream with
+	 * non-stream IO.
+	 */
+	if (req->bio->bi_stream != next->bio->bi_stream)
+		return NULL;
+
+	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
 	 * will have updated segment counts, update sector
@@ -811,6 +818,13 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	    !blk_write_same_mergeable(rq->bio, bio))
 		return false;
 
+	/*
+	 * Don't allow merge of different streams, or for a stream with
+	 * non-stream IO.
+	 */
+	if (rq->bio->bi_stream != bio->bi_stream)
+		return false;
+
 	return true;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 61339bc44400..1940876a7fa7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -36,6 +36,8 @@ struct bio {
 	unsigned short		bi_flags;	/* status, etc and bvec pool number */
 	unsigned short		bi_ioprio;
 
+	unsigned int		bi_stream;	/* write life time hint */
+
 	struct bvec_iter	bi_iter;
 
 	/* Number of segments in this BIO after
@@ -312,4 +314,19 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+static inline void bio_set_streamid(struct bio *bio, unsigned int stream)
+{
+	bio->bi_stream = stream;
+}
+
+static inline bool bio_stream_valid(struct bio *bio)
+{
+	return bio->bi_stream != 0;
+}
+
+static inline unsigned int bio_stream(struct bio *bio)
+{
+	return bio->bi_stream;
+}
+
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.7.4
