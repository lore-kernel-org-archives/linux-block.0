Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:49809 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758316AbdJMMr5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id b189so21117759wmd.4
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:56 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 52/58] lightnvm: pblk: gc all lines in the pipeline before exit
Date: Fri, 13 Oct 2017 14:46:41 +0200
Message-Id: <20171013124647.32668-53-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Finish garbage collect of the lines that are in the gc pipeline
before exiting. Ensure that all lines already in in the pipeline
goes through, from read to write.

Do this by keeping track of how many lines are in the pipeline
and waiting for that number to reach zero before exiting the gc
reader task.

Since we're adding a new gc line counter, change the name of
inflight_gc to read_inflight_gc to make the distinction clear.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-core.c  |  3 +++
 drivers/lightnvm/pblk-gc.c    | 31 ++++++++++++++++++++++++-------
 drivers/lightnvm/pblk-sysfs.c |  2 +-
 drivers/lightnvm/pblk.h       |  5 ++++-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 43866ad..1cd27e3 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1465,6 +1465,7 @@ void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
 static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	struct pblk_gc *gc = &pblk->gc;
 
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
@@ -1473,6 +1474,8 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 	pblk_line_free(pblk, line);
 	spin_unlock(&line->lock);
 
+	atomic_dec(&gc->pipeline_gc);
+
 	spin_lock(&l_mg->free_lock);
 	list_add_tail(&line->list, &l_mg->free_list);
 	l_mg->nr_free_lines++;
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index e00e5a0..e6fae19 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -234,7 +234,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	kfree(invalid_bitmap);
 
 	kref_put(&line->ref, pblk_line_put);
-	atomic_dec(&gc->inflight_gc);
+	atomic_dec(&gc->read_inflight_gc);
 
 	return;
 
@@ -249,7 +249,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 
 	pblk_put_line_back(pblk, line);
 	kref_put(&line->ref, pblk_line_put);
-	atomic_dec(&gc->inflight_gc);
+	atomic_dec(&gc->read_inflight_gc);
 
 	pr_err("pblk: Failed to GC line %d\n", line->id);
 }
@@ -268,6 +268,7 @@ static int pblk_gc_line(struct pblk *pblk, struct pblk_line *line)
 	line_ws->pblk = pblk;
 	line_ws->line = line;
 
+	atomic_inc(&gc->pipeline_gc);
 	INIT_WORK(&line_ws->ws, pblk_gc_line_prepare_ws);
 	queue_work(gc->gc_reader_wq, &line_ws->ws);
 
@@ -333,6 +334,7 @@ static bool pblk_gc_should_run(struct pblk_gc *gc, struct pblk_rl *rl)
 void pblk_gc_free_full_lines(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line *line;
 
 	do {
@@ -353,6 +355,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk)
 		list_del(&line->list);
 		spin_unlock(&l_mg->gc_lock);
 
+		atomic_inc(&gc->pipeline_gc);
 		kref_put(&line->ref, pblk_line_put);
 	} while (1);
 }
@@ -370,12 +373,12 @@ static void pblk_gc_run(struct pblk *pblk)
 	struct pblk_line *line;
 	struct list_head *group_list;
 	bool run_gc;
-	int inflight_gc, gc_group = 0, prev_group = 0;
+	int read_inflight_gc, gc_group = 0, prev_group = 0;
 
 	pblk_gc_free_full_lines(pblk);
 
 	run_gc = pblk_gc_should_run(&pblk->gc, &pblk->rl);
-	if (!run_gc || (atomic_read(&gc->inflight_gc) >= PBLK_GC_L_QD))
+	if (!run_gc || (atomic_read(&gc->read_inflight_gc) >= PBLK_GC_L_QD))
 		return;
 
 next_gc_group:
@@ -402,14 +405,14 @@ static void pblk_gc_run(struct pblk *pblk)
 		list_add_tail(&line->list, &gc->r_list);
 		spin_unlock(&gc->r_lock);
 
-		inflight_gc = atomic_inc_return(&gc->inflight_gc);
+		read_inflight_gc = atomic_inc_return(&gc->read_inflight_gc);
 		pblk_gc_reader_kick(gc);
 
 		prev_group = 1;
 
 		/* No need to queue up more GC lines than we can handle */
 		run_gc = pblk_gc_should_run(&pblk->gc, &pblk->rl);
-		if (!run_gc || inflight_gc >= PBLK_GC_L_QD)
+		if (!run_gc || read_inflight_gc >= PBLK_GC_L_QD)
 			break;
 	} while (1);
 
@@ -470,6 +473,7 @@ static int pblk_gc_writer_ts(void *data)
 static int pblk_gc_reader_ts(void *data)
 {
 	struct pblk *pblk = data;
+	struct pblk_gc *gc = &pblk->gc;
 
 	while (!kthread_should_stop()) {
 		if (!pblk_gc_read(pblk))
@@ -478,6 +482,18 @@ static int pblk_gc_reader_ts(void *data)
 		io_schedule();
 	}
 
+#ifdef CONFIG_NVM_DEBUG
+	pr_info("pblk: flushing gc pipeline, %d lines left\n",
+		atomic_read(&gc->pipeline_gc));
+#endif
+
+	do {
+		if (!atomic_read(&gc->pipeline_gc))
+			break;
+
+		schedule();
+	} while (1);
+
 	return 0;
 }
 
@@ -586,7 +602,8 @@ int pblk_gc_init(struct pblk *pblk)
 	gc->gc_forced = 0;
 	gc->gc_enabled = 1;
 	gc->w_entries = 0;
-	atomic_set(&gc->inflight_gc, 0);
+	atomic_set(&gc->read_inflight_gc, 0);
+	atomic_set(&gc->pipeline_gc, 0);
 
 	/* Workqueue that reads valid sectors from a line and submit them to the
 	 * GC writer to be recycled.
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 95fb434..cd49e88 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -253,7 +253,7 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 	sz += snprintf(page + sz, PAGE_SIZE - sz,
 		"GC: full:%d, high:%d, mid:%d, low:%d, empty:%d, queue:%d\n",
 			gc_full, gc_high, gc_mid, gc_low, gc_empty,
-			atomic_read(&pblk->gc.inflight_gc));
+			atomic_read(&pblk->gc.read_inflight_gc));
 
 	sz += snprintf(page + sz, PAGE_SIZE - sz,
 		"data (%d) cur:%d, left:%d, vsc:%d, s:%d, map:%d/%d (%d)\n",
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 29ba7ec..c6f8841 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -238,7 +238,10 @@ struct pblk_gc {
 	struct timer_list gc_timer;
 
 	struct semaphore gc_sem;
-	atomic_t inflight_gc;
+	atomic_t read_inflight_gc; /* Number of lines with inflight GC reads */
+	atomic_t pipeline_gc;	   /* Number of lines in the GC pipeline -
+				    * started reads to finished writes
+				    */
 	int w_entries;
 
 	struct list_head w_list;
-- 
2.9.3
