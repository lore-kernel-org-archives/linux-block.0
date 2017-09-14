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
Subject: [PATCH V3 3/4] block: make blkcg aware of kthread stored original cgroup info
Date: Thu, 14 Sep 2017 14:02:06 -0700
Message-Id: <b01ad425de5d9590b3b3c0fbc3afa736f3f3ee44.1505422351.git.shli@fb.com>
In-Reply-To: <cover.1505422351.git.shli@fb.com>
References: <cover.1505422351.git.shli@fb.com>
In-Reply-To: <cover.1505422351.git.shli@fb.com>
References: <cover.1505422351.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

bio_blkcg is the only API to get cgroup info for a bio right now. If
bio_blkcg finds current task is a kthread and has original blkcg
associated, it will use the css instead of associating the bio to
current task. This makes it possible that kthread dispatches bios on
behalf of other threads.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 include/linux/blk-cgroup.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 0cfa8d2..f57e54d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -19,6 +19,7 @@
 #include <linux/radix-tree.h>
 #include <linux/blkdev.h>
 #include <linux/atomic.h>
+#include <linux/kthread.h>
 
 /* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
 #define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
@@ -223,16 +224,16 @@ static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
 	return css ? container_of(css, struct blkcg, css) : NULL;
 }
 
-static inline struct blkcg *task_blkcg(struct task_struct *tsk)
-{
-	return css_to_blkcg(task_css(tsk, io_cgrp_id));
-}
-
 static inline struct blkcg *bio_blkcg(struct bio *bio)
 {
+	struct cgroup_subsys_state *css;
+
 	if (bio && bio->bi_css)
 		return css_to_blkcg(bio->bi_css);
-	return task_blkcg(current);
+	css = kthread_blkcg();
+	if (css)
+		return css_to_blkcg(css);
+	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
 /**
-- 
2.9.5
