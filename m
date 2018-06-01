Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40737 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeFANFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:05:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so14743158lfc.7
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:05:05 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/18] lightnvn: pass flag on graceful teardown to targets
Date: Fri,  1 Jun 2018 15:04:24 +0200
Message-Id: <20180601130432.30866-11-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

If the namespace is unregistered before the LightNVM target is removed
(e.g., on hot unplug) it is too late for the target to store any metadata
on the device - any attempt to write to the device will fail. In this
case, pass on a "gracefull teardown" flag to the target to let it know
when this happens.

In the case of pblk, we pad the open line (close all open chunks) to
improve data retention. In the event of an ungraceful shutdown, avoid
this part and just clean up.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 10 +++++-----
 drivers/lightnvm/pblk-core.c | 13 ++++++++++++-
 drivers/lightnvm/pblk-gc.c   | 10 ++++++----
 drivers/lightnvm/pblk-init.c | 14 ++++++++------
 drivers/lightnvm/pblk.h      |  4 +++-
 include/linux/lightnvm.h     |  2 +-
 6 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 63171cdce270..60aa7bc5a630 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -431,7 +431,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	return 0;
 err_sysfs:
 	if (tt->exit)
-		tt->exit(targetdata);
+		tt->exit(targetdata, true);
 err_init:
 	blk_cleanup_queue(tqueue);
 	tdisk->queue = NULL;
@@ -446,7 +446,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	return ret;
 }
 
-static void __nvm_remove_target(struct nvm_target *t)
+static void __nvm_remove_target(struct nvm_target *t, bool graceful)
 {
 	struct nvm_tgt_type *tt = t->type;
 	struct gendisk *tdisk = t->disk;
@@ -459,7 +459,7 @@ static void __nvm_remove_target(struct nvm_target *t)
 		tt->sysfs_exit(tdisk);
 
 	if (tt->exit)
-		tt->exit(tdisk->private_data);
+		tt->exit(tdisk->private_data, graceful);
 
 	nvm_remove_tgt_dev(t->dev, 1);
 	put_disk(tdisk);
@@ -489,7 +489,7 @@ static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 		mutex_unlock(&dev->mlock);
 		return 1;
 	}
-	__nvm_remove_target(t);
+	__nvm_remove_target(t, true);
 	mutex_unlock(&dev->mlock);
 
 	return 0;
@@ -963,7 +963,7 @@ void nvm_unregister(struct nvm_dev *dev)
 	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
 		if (t->dev->parent != dev)
 			continue;
-		__nvm_remove_target(t);
+		__nvm_remove_target(t, false);
 	}
 	mutex_unlock(&dev->mlock);
 
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 4b10122aec89..5f1e5b1b3094 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1461,7 +1461,7 @@ static void pblk_line_close_meta_sync(struct pblk *pblk)
 	flush_workqueue(pblk->close_wq);
 }
 
-void pblk_pipeline_stop(struct pblk *pblk)
+void __pblk_pipeline_flush(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	int ret;
@@ -1486,6 +1486,11 @@ void pblk_pipeline_stop(struct pblk *pblk)
 
 	flush_workqueue(pblk->bb_wq);
 	pblk_line_close_meta_sync(pblk);
+}
+
+void __pblk_pipeline_stop(struct pblk *pblk)
+{
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 
 	spin_lock(&l_mg->free_lock);
 	pblk->state = PBLK_STATE_STOPPED;
@@ -1494,6 +1499,12 @@ void pblk_pipeline_stop(struct pblk *pblk)
 	spin_unlock(&l_mg->free_lock);
 }
 
+void pblk_pipeline_stop(struct pblk *pblk)
+{
+	__pblk_pipeline_flush(pblk);
+	__pblk_pipeline_stop(pblk);
+}
+
 struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 6851a5c67189..b0cc277bf972 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -649,7 +649,7 @@ int pblk_gc_init(struct pblk *pblk)
 	return ret;
 }
 
-void pblk_gc_exit(struct pblk *pblk)
+void pblk_gc_exit(struct pblk *pblk, bool graceful)
 {
 	struct pblk_gc *gc = &pblk->gc;
 
@@ -663,10 +663,12 @@ void pblk_gc_exit(struct pblk *pblk)
 	if (gc->gc_reader_ts)
 		kthread_stop(gc->gc_reader_ts);
 
-	flush_workqueue(gc->gc_reader_wq);
+	if (graceful) {
+		flush_workqueue(gc->gc_reader_wq);
+		flush_workqueue(gc->gc_line_reader_wq);
+	}
+
 	destroy_workqueue(gc->gc_reader_wq);
-
-	flush_workqueue(gc->gc_line_reader_wq);
 	destroy_workqueue(gc->gc_line_reader_wq);
 
 	if (gc->gc_writer_ts)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9e3a43346d4c..bfc488d0dda9 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1118,23 +1118,25 @@ static void pblk_free(struct pblk *pblk)
 	kfree(pblk);
 }
 
-static void pblk_tear_down(struct pblk *pblk)
+static void pblk_tear_down(struct pblk *pblk, bool graceful)
 {
-	pblk_pipeline_stop(pblk);
+	if (graceful)
+		__pblk_pipeline_flush(pblk);
+	__pblk_pipeline_stop(pblk);
 	pblk_writer_stop(pblk);
 	pblk_rb_sync_l2p(&pblk->rwb);
 	pblk_rl_free(&pblk->rl);
 
-	pr_debug("pblk: consistent tear down\n");
+	pr_debug("pblk: consistent tear down (graceful:%d)\n", graceful);
 }
 
-static void pblk_exit(void *private)
+static void pblk_exit(void *private, bool graceful)
 {
 	struct pblk *pblk = private;
 
 	down_write(&pblk_lock);
-	pblk_gc_exit(pblk);
-	pblk_tear_down(pblk);
+	pblk_gc_exit(pblk, graceful);
+	pblk_tear_down(pblk, graceful);
 
 #ifdef CONFIG_NVM_DEBUG
 	pr_info("pblk exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index dfbfe9e9a385..0c69eb880f56 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -771,6 +771,8 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_close(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_close_ws(struct work_struct *work);
 void pblk_pipeline_stop(struct pblk *pblk);
+void __pblk_pipeline_stop(struct pblk *pblk);
+void __pblk_pipeline_flush(struct pblk *pblk);
 void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
 		     void (*work)(struct work_struct *), gfp_t gfp_mask,
 		     struct workqueue_struct *wq);
@@ -864,7 +866,7 @@ int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
 #define PBLK_GC_RSV_LINE 1	/* Reserved lines for GC */
 
 int pblk_gc_init(struct pblk *pblk);
-void pblk_gc_exit(struct pblk *pblk);
+void pblk_gc_exit(struct pblk *pblk, bool graceful);
 void pblk_gc_should_start(struct pblk *pblk);
 void pblk_gc_should_stop(struct pblk *pblk);
 void pblk_gc_should_kick(struct pblk *pblk);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 6e0859b9d4d2..e9e0d1c7eaf5 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -489,7 +489,7 @@ typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
 				int flags);
-typedef void (nvm_tgt_exit_fn)(void *);
+typedef void (nvm_tgt_exit_fn)(void *, bool);
 typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
 typedef void (nvm_tgt_sysfs_exit_fn)(struct gendisk *);
 
-- 
2.11.0
