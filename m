Return-Path: <prvs=0442dc73e6=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH] block: fix a build error
Date: Tue, 26 Sep 2017 11:02:12 -0700
Message-ID: <c729033f4073c8dd324d74ad02e4426e89f6ee8c.1506448764.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The code is only for blkcg not for all cgroups

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c    | 2 +-
 include/linux/kthread.h | 2 +-
 kernel/kthread.c        | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 37c4da7..7269341 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1695,7 +1695,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	/* always use the first bio's css */
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_BLK_CGROUP
 	if (cmd->use_aio && cmd->rq->bio && cmd->rq->bio->bi_css) {
 		cmd->css = cmd->rq->bio->bi_css;
 		css_get(cmd->css);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index bd4369c..fb20184 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -199,7 +199,7 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_BLK_CGROUP
 void kthread_associate_blkcg(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *kthread_blkcg(void);
 #else
diff --git a/kernel/kthread.c b/kernel/kthread.c
index a8b4e83..ed95828 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -46,7 +46,7 @@ struct kthread {
 	void *data;
 	struct completion parked;
 	struct completion exited;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_BLK_CGROUP
 	struct cgroup_subsys_state *blkcg_css;
 #endif
 };
@@ -83,7 +83,7 @@ void free_kthread_struct(struct task_struct *k)
 	 * or if kmalloc() in kthread() failed.
 	 */
 	kthread = to_kthread(k);
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_BLK_CGROUP
 	WARN_ON_ONCE(kthread && kthread->blkcg_css);
 #endif
 	kfree(kthread);
@@ -224,7 +224,7 @@ static int kthread(void *_create)
 	self->data = data;
 	init_completion(&self->exited);
 	init_completion(&self->parked);
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_BLK_CGROUP
 	self->blkcg_css = NULL;
 #endif
 	current->vfork_done = &self->exited;
@@ -1165,7 +1165,7 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
 
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_BLK_CGROUP
 /**
  * kthread_associate_blkcg - associate blkcg to current kthread
  * @css: the cgroup info
-- 
2.9.5
