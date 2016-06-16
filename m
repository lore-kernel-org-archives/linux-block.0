Return-Path: <BATV+d68c80116f0bf241093e+4680+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/7] block: simplify and export blk_rq_append_bio
Date: Thu, 16 Jun 2016 11:14:28 +0200
Message-Id: <1466068471-15746-5-git-send-email-hch@lst.de>
In-Reply-To: <1466068471-15746-1-git-send-email-hch@lst.de>
References: <1466068471-15746-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The target SCSI passthrough backend is much better served with the low-level
blk_rq_append_bio construct then the helpers built on top of it, so export it.

Also use the opportunity to remove the pointless request_queue argument and
make the code flow a little more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  2 +-
 block/blk-map.c        | 25 +++++++++++++++----------
 block/blk.h            |  2 --
 include/linux/blkdev.h |  1 +
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8416c4a..1952c52 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1363,7 +1363,7 @@ struct request *blk_make_request(struct request_queue *q, struct bio *bio,
 		int ret;
 
 		blk_queue_bounce(q, &bounce_bio);
-		ret = blk_rq_append_bio(q, rq, bounce_bio);
+		ret = blk_rq_append_bio(rq, bounce_bio);
 		if (unlikely(ret)) {
 			blk_put_request(rq);
 			return ERR_PTR(ret);
diff --git a/block/blk-map.c b/block/blk-map.c
index 61733a6..b8657fa 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -9,21 +9,26 @@
 
 #include "blk.h"
 
-int blk_rq_append_bio(struct request_queue *q, struct request *rq,
-		      struct bio *bio)
+/*
+ * Append a bio to a passthrough request.  Only works can be merged into
+ * the request based on the driver constraints.
+ */
+int blk_rq_append_bio(struct request *rq, struct bio *bio)
 {
-	if (!rq->bio)
-		blk_rq_bio_prep(q, rq, bio);
-	else if (!ll_back_merge_fn(q, rq, bio))
-		return -EINVAL;
-	else {
+	if (!rq->bio) {
+		blk_rq_bio_prep(rq->q, rq, bio);
+	} else {
+		if (!ll_back_merge_fn(rq->q, rq, bio))
+			return -EINVAL;
+
 		rq->biotail->bi_next = bio;
 		rq->biotail = bio;
-
 		rq->__data_len += bio->bi_iter.bi_size;
 	}
+
 	return 0;
 }
+EXPORT_SYMBOL(blk_rq_append_bio);
 
 static int __blk_rq_unmap_user(struct bio *bio)
 {
@@ -71,7 +76,7 @@ static int __blk_rq_map_user_iov(struct request *rq,
 	 */
 	bio_get(bio);
 
-	ret = blk_rq_append_bio(q, rq, bio);
+	ret = blk_rq_append_bio(rq, bio);
 	if (ret) {
 		bio_endio(bio);
 		__blk_rq_unmap_user(orig_bio);
@@ -229,7 +234,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 	if (do_copy)
 		rq->cmd_flags |= REQ_COPY_USER;
 
-	ret = blk_rq_append_bio(q, rq, bio);
+	ret = blk_rq_append_bio(rq, bio);
 	if (unlikely(ret)) {
 		/* request is too big */
 		bio_put(bio);
diff --git a/block/blk.h b/block/blk.h
index 70e4aee..c37492f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -64,8 +64,6 @@ void blk_exit_rl(struct request_list *rl);
 void init_request_from_bio(struct request *req, struct bio *bio);
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 			struct bio *bio);
-int blk_rq_append_bio(struct request_queue *q, struct request *rq,
-		      struct bio *bio);
 void blk_queue_bypass_start(struct request_queue *q);
 void blk_queue_bypass_end(struct request_queue *q);
 void blk_dequeue_request(struct request *rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9d1e0a4..07176f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -801,6 +801,7 @@ extern int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 extern void blk_rq_unprep_clone(struct request *rq);
 extern int blk_insert_cloned_request(struct request_queue *q,
 				     struct request *rq);
+extern int blk_rq_append_bio(struct request *rq, struct bio *bio);
 extern void blk_delay_queue(struct request_queue *, unsigned long);
 extern void blk_queue_split(struct request_queue *, struct bio **,
 			    struct bio_set *);
-- 
2.1.4
