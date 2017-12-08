Return-Path: <axboe@kernel.dk>
Subject: Re: block: oopses on 4.13.*, 4.14.* and 4.15-rc2 (bisected)
To: Michele Ballabio <barra_cuda@katamail.com>, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
References: <20171208163851.0f3823b6@darkstar.example.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f59e66c4-e09b-95aa-a5a5-f26288beb3f0@kernel.dk>
Date: Fri, 8 Dec 2017 13:08:37 -0700
MIME-Version: 1.0
In-Reply-To: <20171208163851.0f3823b6@darkstar.example.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/08/2017 08:38 AM, Michele Ballabio wrote:
> Hi,
> 	kernels 4.13.*, 4.14.* 4.15-rc2 crash on occasion, especially
> on x86-32 systems. To trigger the problem, run as root:
> 
> while true
> do
>         /sbin/udevadm trigger --type=subsystems --action=change
>         /sbin/udevadm trigger --type=devices --action=change
>         /sbin/udevadm settle --timeout=120
> done
> 
> (Thanks to Patrick Volkerding for the reproducer).
> 
> Sometimes the kernel oopses immediately, sometimes a bit later (less than
> five minutes).
> 
> The bisection pointed to commit caa4b02476e31fc7933d2138062f7f355d3cd8f7
> (blk-map: call blk_queue_bounce from blk_rq_append_bio). A revert
> fixes the problem (tested on 4.13 and master).

Thanks for your report - can you try the below patch? Totally
untested...


diff --git a/block/blk-map.c b/block/blk-map.c
index b21f8e86f120..ad970719a1fc 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -12,22 +12,22 @@
 #include "blk.h"
 
 /*
- * Append a bio to a passthrough request.  Only works can be merged into
- * the request based on the driver constraints.
+ * Append a bio to a passthrough request.  Only works if the bio can be merged
+ * into the request based on the driver constraints.
  */
-int blk_rq_append_bio(struct request *rq, struct bio *bio)
+int blk_rq_append_bio(struct request *rq, struct bio **bio)
 {
-	blk_queue_bounce(rq->q, &bio);
+	blk_queue_bounce(rq->q, bio);
 
 	if (!rq->bio) {
-		blk_rq_bio_prep(rq->q, rq, bio);
+		blk_rq_bio_prep(rq->q, rq, *bio);
 	} else {
-		if (!ll_back_merge_fn(rq->q, rq, bio))
+		if (!ll_back_merge_fn(rq->q, rq, *bio))
 			return -EINVAL;
 
-		rq->biotail->bi_next = bio;
-		rq->biotail = bio;
-		rq->__data_len += bio->bi_iter.bi_size;
+		rq->biotail->bi_next = *bio;
+		rq->biotail = *bio;
+		rq->__data_len += (*bio)->bi_iter.bi_size;
 	}
 
 	return 0;
@@ -73,8 +73,9 @@ static int __blk_rq_map_user_iov(struct request *rq,
 	 * We link the bounce buffer in and could have to traverse it
 	 * later so we have to get a ref to prevent it from being freed
 	 */
-	ret = blk_rq_append_bio(rq, bio);
 	bio_get(bio);
+
+	ret = blk_rq_append_bio(rq, &bio);
 	if (ret) {
 		bio_endio(bio);
 		__blk_rq_unmap_user(orig_bio);
@@ -236,7 +237,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 	if (do_copy)
 		rq->rq_flags |= RQF_COPY_USER;
 
-	ret = blk_rq_append_bio(rq, bio);
+	ret = blk_rq_append_bio(rq, &bio);
 	if (unlikely(ret)) {
 		/* request is too big */
 		bio_put(bio);
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index a4f28b7e4c65..e18877177f1b 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -1576,7 +1576,9 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
 		return req;
 
 	for_each_bio(bio) {
-		ret = blk_rq_append_bio(req, bio);
+		struct bio *bounce_bio = bio;
+
+		ret = blk_rq_append_bio(req, &bounce_bio);
 		if (ret)
 			return ERR_PTR(ret);
 	}
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 7c69b4a9694d..0d99b242e82e 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -920,7 +920,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 					" %d i: %d bio: %p, allocating another"
 					" bio\n", bio->bi_vcnt, i, bio);
 
-				rc = blk_rq_append_bio(req, bio);
+				rc = blk_rq_append_bio(req, &bio);
 				if (rc) {
 					pr_err("pSCSI: failed to append bio\n");
 					goto fail;
@@ -938,7 +938,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	}
 
 	if (bio) {
-		rc = blk_rq_append_bio(req, bio);
+		rc = blk_rq_append_bio(req, &bio);
 		if (rc) {
 			pr_err("pSCSI: failed to append bio\n");
 			goto fail;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8089ca17db9a..06b88d38f611 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -948,7 +948,7 @@ extern int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 extern void blk_rq_unprep_clone(struct request *rq);
 extern blk_status_t blk_insert_cloned_request(struct request_queue *q,
 				     struct request *rq);
-extern int blk_rq_append_bio(struct request *rq, struct bio *bio);
+extern int blk_rq_append_bio(struct request *rq, struct bio **bio);
 extern void blk_delay_queue(struct request_queue *, unsigned long);
 extern void blk_queue_split(struct request_queue *, struct bio **);
 extern void blk_recount_segments(struct request_queue *, struct bio *);

-- 
Jens Axboe
