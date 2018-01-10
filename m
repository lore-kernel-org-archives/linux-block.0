Return-Path: <xuejiufei@gmail.com>
Return-Path: <xuejiufei@gmail.com>
From: xuejiufei <xuejiufei@gmail.com>
Subject: [PATCH] blk-throttle: avoid double counted
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: jiufei.xjf@alibaba-inc.com, Shaohua Li <shli@kernel.org>
Message-ID: <4448dd08-74b5-ef8f-e227-49c8e3dbe3eb@gmail.com>
Date: Wed, 10 Jan 2018 13:02:29 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Jiufei Xue <jiufei.xjf@alibaba-inc.com>

If a bio is split after counted to the stat_bytes and stat_ios in
blkcg_bio_issue_check(), the bio could be resubmited and enters the
block throttle layer again. This will cause the part of the bio is
counted twice.

The flag BIO_THROTTLED can not be used to fix this problem considering the
following two cases.
1. The bio is throttled and resubmited to the block throttle layer. It
has the flag BIO_THROTTLED and should be counted.
2. The bio can be dispathed and has counted, and then is split and
resubmitted to the block throttle layer. It also has the flag
BIO_THROTTLED but should not be counted again.

So we add another flag BIO_THROTL_COUNTED to avoid double counted.

Signed-off-by: Jiufei Xue <jiufei.xjf@alibaba-inc.com>
---
 block/bio.c                | 2 ++
 include/linux/bio.h        | 6 ++++--
 include/linux/blk-cgroup.h | 3 ++-
 include/linux/blk_types.h  | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9ef6cf3..4594c2e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -601,6 +601,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
+	if (bio_flagged(bio_src, BIO_THROTL_COUNTED))
+		bio_set_flag(bio, BIO_THROTL_COUNTED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 23d29b3..aefc24c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -492,8 +492,10 @@ extern struct bio *bio_copy_user_iov(struct request_queue *,
 
 #define bio_set_dev(bio, bdev) 			\
 do {						\
-	if ((bio)->bi_disk != (bdev)->bd_disk)	\
-		bio_clear_flag(bio, BIO_THROTTLED);\
+	if ((bio)->bi_disk != (bdev)->bd_disk)	{	\
+		bio_clear_flag(bio, BIO_THROTTLED);	\
+		bio_clear_flag(bio, BIO_THROTL_COUNTED);\
+	}					\
 	(bio)->bi_disk = (bdev)->bd_disk;	\
 	(bio)->bi_partno = (bdev)->bd_partno;	\
 } while (0)
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e9825ff..c151bc9 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -701,11 +701,12 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	throtl = blk_throtl_bio(q, blkg, bio);
 
-	if (!throtl) {
+	if (!throtl && !bio_flagged(bio, BIO_THROTL_COUNTED)) {
 		blkg = blkg ?: q->root_blkg;
 		blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
 				bio->bi_iter.bi_size);
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
+		bio_set_flag(bio, BIO_THROTL_COUNTED);
 	}
 
 	rcu_read_unlock();
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 9e7d8bd..7a3890a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -135,6 +135,7 @@ struct bio {
 				 * throttling rules. Don't do it again. */
 #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
 				 * of this bio. */
+#define BIO_THROTL_COUNTED 11	/* This bio has already counted to rwstat. */
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
 /*
-- 
1.8.3.1
