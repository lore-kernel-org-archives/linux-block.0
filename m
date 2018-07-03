Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 01/14] block: add bi_blkg to the bio for cgroups
Date: Tue,  3 Jul 2018 11:14:50 -0400
Message-Id: <20180703151503.2549-2-josef@toxicpanda.com>
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

Currently io.low uses a bi_cg_private to stash its private data for the
blkg, however other blkcg policies may want to use this as well.  Since
we can get the private data out of the blkg, move this to bi_blkg in the
bio and make it generic, then we can use bio_associate_blkg() to attach
the blkg to the bio.

Theoretically we could simply replace the bi_css with this since we can
get to all the same information from the blkg, however you have to
lookup the blkg, so for example wbc_init_bio() would have to lookup and
possibly allocate the blkg for the css it was trying to attach to the
bio.  This could be problematic and result in us either not attaching
the css at all to the bio, or falling back to the root blkcg if we are
unable to allocate the corresponding blkg.

So for now do this, and in the future if possible we could just replace
the bi_css with bi_blkg and update the helpers to do the correct
translation.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c               | 23 +++++++++++++++++++++++
 block/blk-throttle.c      | 21 +++++++--------------
 include/linux/bio.h       |  1 +
 include/linux/blk_types.h |  2 +-
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f7e3d88bd0b6..c9072a54395e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -28,6 +28,7 @@
 #include <linux/mempool.h>
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -2036,6 +2037,24 @@ int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkcg);
 
+/**
+ * bio_associate_blkg - associate a bio with the specified blkg
+ * @bio: target bio
+ * @blkg: the blkg to associate
+ *
+ * Associate @bio with the blkg specified by @blkg.  This is the queue specific
+ * blkcg information associated with the @bio, a reference will be taken on the
+ * @blkg and will be freed when the bio is freed.
+ */
+int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
+{
+	if (unlikely(bio->bi_blkg))
+		return -EBUSY;
+	blkg_get(blkg);
+	bio->bi_blkg = blkg;
+	return 0;
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
@@ -2050,6 +2069,10 @@ void bio_disassociate_task(struct bio *bio)
 		css_put(bio->bi_css);
 		bio->bi_css = NULL;
 	}
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
 }
 
 /**
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 82282e6fdcf8..06f42b92fe10 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2132,12 +2132,8 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (bio->bi_css) {
-		if (bio->bi_cg_private)
-			blkg_put(tg_to_blkg(bio->bi_cg_private));
-		bio->bi_cg_private = tg;
-		blkg_get(tg_to_blkg(tg));
-	}
+	if (bio->bi_css)
+		bio_associate_blkg(bio, tg_to_blkg(tg));
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
@@ -2285,6 +2281,7 @@ void blk_throtl_stat_add(struct request *rq, u64 time_ns)
 
 void blk_throtl_bio_endio(struct bio *bio)
 {
+	struct blkcg_gq *blkg;
 	struct throtl_grp *tg;
 	u64 finish_time_ns;
 	unsigned long finish_time;
@@ -2292,20 +2289,18 @@ void blk_throtl_bio_endio(struct bio *bio)
 	unsigned long lat;
 	int rw = bio_data_dir(bio);
 
-	tg = bio->bi_cg_private;
-	if (!tg)
+	blkg = bio->bi_blkg;
+	if (!blkg)
 		return;
-	bio->bi_cg_private = NULL;
+	tg = blkg_to_tg(blkg);
 
 	finish_time_ns = ktime_get_ns();
 	tg->last_finish_time = finish_time_ns >> 10;
 
 	start_time = bio_issue_time(&bio->bi_issue) >> 10;
 	finish_time = __bio_issue_time(finish_time_ns) >> 10;
-	if (!start_time || finish_time <= start_time) {
-		blkg_put(tg_to_blkg(tg));
+	if (!start_time || finish_time <= start_time)
 		return;
-	}
 
 	lat = finish_time - start_time;
 	/* this is only for bio based driver */
@@ -2334,8 +2329,6 @@ void blk_throtl_bio_endio(struct bio *bio)
 		tg->bio_cnt /= 2;
 		tg->bad_bio_cnt /= 2;
 	}
-
-	blkg_put(tg_to_blkg(tg));
 }
 #endif
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f08f5fe7bd08..a279ba384da9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -555,6 +555,7 @@ do {						\
 
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
+int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3c4f390aea4b..3364d42ebe08 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -179,8 +179,8 @@ struct bio {
 	 */
 	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
+	struct blkcg_gq		*bi_blkg;
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	void			*bi_cg_private;
 	struct bio_issue	bi_issue;
 #endif
 #endif
-- 
2.14.3
