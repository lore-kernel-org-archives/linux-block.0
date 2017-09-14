Return-Path: <SRS0=TWoo=AP=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: tj@kernel.org,
	lizefan@huawei.com,
	tglx@linutronix.de,
	kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 2/4] blkcg: delete unused APIs
Date: Thu, 14 Sep 2017 14:02:05 -0700
Message-Id: <08bb68c7d6f48c39907aaec834e4feecb0efcfd0.1505422351.git.shli@fb.com>
In-Reply-To: <cover.1505422351.git.shli@fb.com>
References: <cover.1505422351.git.shli@fb.com>
In-Reply-To: <cover.1505422351.git.shli@fb.com>
References: <cover.1505422351.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Nobody uses the APIs right now.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c                | 31 -------------------------------
 include/linux/bio.h        |  2 --
 include/linux/blk-cgroup.h | 12 ------------
 3 files changed, 45 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 6745759..9271fa3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2033,37 +2033,6 @@ int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
 EXPORT_SYMBOL_GPL(bio_associate_blkcg);
 
 /**
- * bio_associate_current - associate a bio with %current
- * @bio: target bio
- *
- * Associate @bio with %current if it hasn't been associated yet.  Block
- * layer will treat @bio as if it were issued by %current no matter which
- * task actually issues it.
- *
- * This function takes an extra reference of @task's io_context and blkcg
- * which will be put when @bio is released.  The caller must own @bio,
- * ensure %current->io_context exists, and is responsible for synchronizing
- * calls to this function.
- */
-int bio_associate_current(struct bio *bio)
-{
-	struct io_context *ioc;
-
-	if (bio->bi_css)
-		return -EBUSY;
-
-	ioc = current->io_context;
-	if (!ioc)
-		return -ENOENT;
-
-	get_io_context_active(ioc);
-	bio->bi_ioc = ioc;
-	bio->bi_css = task_get_css(current, io_cgrp_id);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bio_associate_current);
-
-/**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
  */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a8fe793..d795cdd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -514,13 +514,11 @@ do {						\
 
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
-int bio_associate_current(struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
-static inline int bio_associate_current(struct bio *bio) { return -ENOENT; }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkcg_association(struct bio *dst,
 			struct bio *src) { }
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 9d92153..0cfa8d2 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -235,12 +235,6 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return task_blkcg(current);
 }
 
-static inline struct cgroup_subsys_state *
-task_get_blkcg_css(struct task_struct *task)
-{
-	return task_get_css(task, io_cgrp_id);
-}
-
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
@@ -735,12 +729,6 @@ struct blkcg_policy {
 
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
 
-static inline struct cgroup_subsys_state *
-task_get_blkcg_css(struct task_struct *task)
-{
-	return NULL;
-}
-
 #ifdef CONFIG_BLOCK
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-- 
2.9.5
