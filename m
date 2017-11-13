Return-Path: <prvs=2490de8c9e=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, <Kernel-team@fb.com>,
        Tejun Heo
	<tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <stable@vger.kernel.org>
Subject: [PATCH V2] block-throttle: avoid double charge
Date: Mon, 13 Nov 2017 12:37:10 -0800
Message-ID: <23857cbf1d586e904bd01196fa05705fb0161785.1510605343.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If a bio is throttled and splitted after throttling, the bio could be
resubmited and enters the throttling again. This will cause part of the
bio is charged multiple times. If the cgroup has an IO limit, the double
charge will significantly harm the performance. The bio split becomes
quite common after arbitrary bio size change.

To fix this, we always set the BIO_THROTTLED flag if a bio is throttled.
If the bio is cloned/slitted, we copy the flag to new bio too to avoid
double charge. However cloned bio could be directed to a new disk,
keeping the flag will have problem. The observation is we always set new
disk for the bio in this case, so we can clear the flag in
bio_set_dev().

This issue exists a long time, arbitrary bio size change makes it worse,
so this should go into stable at least since v4.2.

V1-> V2: Not add extra field in bio based on discussion with Tejun

Cc: Tejun Heo <tj@kernel.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c          | 2 ++
 block/blk-throttle.c | 8 +-------
 include/linux/bio.h  | 2 ++
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8338304..d1d4d51 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -598,6 +598,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	 */
 	bio->bi_disk = bio_src->bi_disk;
 	bio_set_flag(bio, BIO_CLONED);
+	if (bio_flagged(bio_src, BIO_THROTTLED))
+		bio_set_flag(bio, BIO_THROTTLED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ee6d7b0..f90fec1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2222,13 +2222,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 out_unlock:
 	spin_unlock_irq(q->queue_lock);
 out:
-	/*
-	 * As multiple blk-throtls may stack in the same issue path, we
-	 * don't want bios to leave with the flag set.  Clear the flag if
-	 * being issued.
-	 */
-	if (!throttled)
-		bio_clear_flag(bio, BIO_THROTTLED);
+	bio_set_flag(bio, BIO_THROTTLED);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9c75f58..27b5bac 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -504,6 +504,8 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
 
 #define bio_set_dev(bio, bdev) 			\
 do {						\
+	if ((bio)->bi_disk != (bdev)->bd_disk)	\
+		bio_clear_flag(bio, BIO_THROTTLED);\
 	(bio)->bi_disk = (bdev)->bd_disk;	\
 	(bio)->bi_partno = (bdev)->bd_partno;	\
 } while (0)
-- 
2.9.5
