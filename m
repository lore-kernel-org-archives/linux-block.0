Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
From: Dennis Zhou <dennis@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	kernel-team@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 2/2] blkcg: reassociate bios when make_request() is called recursively
Date: Sat, 20 Oct 2018 14:56:12 -0400
Message-Id: <20181020185612.51587-3-dennis@kernel.org>
In-Reply-To: <20181020185612.51587-1-dennis@kernel.org>
References: <20181020185612.51587-1-dennis@kernel.org>
List-ID: <linux-block@vger.kernel.org>

When submitting a bio, multiple recursive calls to make_request() may
occur. This causes the initial associate done in blkcg_bio_issue_check()
to be incorrect and reference the prior request_queue. This introduces
a helper to do reassociation when make_request() is recursively called.

Fixes: a7b39b4e961c ("blkcg: always associate a bio with a blkg")
Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
 block/bio.c         | 20 ++++++++++++++++++++
 block/blk-core.c    |  1 +
 include/linux/bio.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 17a8b0aa7050..bbfeb4ee2892 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2083,6 +2083,26 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 	return ret;
 }
 
+/**
+ * bio_reassociate_blkg - reassociate a bio with a blkg from q
+ * @q: request_queue where bio is going
+ * @bio: target bio
+ *
+ * When submitting a bio, multiple recursive calls to make_request() may occur.
+ * This causes the initial associate done in blkcg_bio_issue_check() to be
+ * incorrect and reference the prior request_queue.  This performs reassociation
+ * when this situation happens.
+ */
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+
+	return bio_associate_create_blkg(q, bio);
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..3ed60723e242 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2433,6 +2433,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 			if (q)
 				blk_queue_exit(q);
 			q = bio->bi_disk->queue;
+			bio_reassociate_blkg(q, bio);
 			flags = 0;
 			if (bio->bi_opf & REQ_NOWAIT)
 				flags = BLK_MQ_REQ_NOWAIT;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f447b0ebb288..b47c7f716731 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -514,6 +514,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
 int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css);
 int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
@@ -522,6 +523,8 @@ static inline int bio_associate_blkg_from_css(struct bio *bio,
 { return 0; }
 static inline int bio_associate_create_blkg(struct request_queue *q,
 					    struct bio *bio) { return 0; }
+static inline int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{ return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
-- 
2.17.1
