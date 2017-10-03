Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51486 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdJCKGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:06:53 -0400
Received: by mail-wm0-f51.google.com with SMTP id f4so7618436wme.0
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:06:52 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 3/9] lightnvm: pblk: free full lines during recovery
Date: Tue,  3 Oct 2017 12:05:07 +0200
Message-Id: <1507025113-13351-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When rebuilding the L2P table, any full lines(lines without any
valid sectors) will be identified. If these lines are not freed,
we risk not being able to allocate the first data line.

This patch refactors the part of GC that frees empty lines
into a separate function and adds a call to this after the
L2P table has been rebuilt.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c   | 32 ++++++++++++++++++++------------
 drivers/lightnvm/pblk-init.c |  3 +++
 drivers/lightnvm/pblk.h      |  1 +
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 81efac1..374089f 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -330,26 +330,16 @@ static bool pblk_gc_should_run(struct pblk_gc *gc, struct pblk_rl *rl)
 	return ((gc->gc_active) && (nr_blocks_need > nr_blocks_free));
 }
 
-/*
- * Lines with no valid sectors will be returned to the free list immediately. If
- * GC is activated - either because the free block count is under the determined
- * threshold, or because it is being forced from user space - only lines with a
- * high count of invalid sectors will be recycled.
- */
-static void pblk_gc_run(struct pblk *pblk)
+void pblk_gc_free_full_lines(struct pblk *pblk)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line *line;
-	struct list_head *group_list;
-	bool run_gc;
-	int inflight_gc, gc_group = 0, prev_group = 0;
 
 	do {
 		spin_lock(&l_mg->gc_lock);
 		if (list_empty(&l_mg->gc_full_list)) {
 			spin_unlock(&l_mg->gc_lock);
-			break;
+			return;
 		}
 
 		line = list_first_entry(&l_mg->gc_full_list,
@@ -365,6 +355,24 @@ static void pblk_gc_run(struct pblk *pblk)
 
 		kref_put(&line->ref, pblk_line_put);
 	} while (1);
+}
+
+/*
+ * Lines with no valid sectors will be returned to the free list immediately. If
+ * GC is activated - either because the free block count is under the determined
+ * threshold, or because it is being forced from user space - only lines with a
+ * high count of invalid sectors will be recycled.
+ */
+static void pblk_gc_run(struct pblk *pblk)
+{
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	struct pblk_gc *gc = &pblk->gc;
+	struct pblk_line *line;
+	struct list_head *group_list;
+	bool run_gc;
+	int inflight_gc, gc_group = 0, prev_group = 0;
+
+	pblk_gc_free_full_lines(pblk);
 
 	run_gc = pblk_gc_should_run(&pblk->gc, &pblk->rl);
 	if (!run_gc || (atomic_read(&gc->inflight_gc) >= PBLK_GC_L_QD))
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ec7974b..1cc3de4 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -508,6 +508,9 @@ static int pblk_lines_configure(struct pblk *pblk, int flags)
 		}
 	}
 
+	/* Free full lines directly as GC has not been started yet */
+	pblk_gc_free_full_lines(pblk);
+
 	if (!line) {
 		/* Configure next line for user data */
 		line = pblk_line_get_first_data(pblk);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index eaf5397..f76583b 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -831,6 +831,7 @@ void pblk_gc_should_start(struct pblk *pblk);
 void pblk_gc_should_stop(struct pblk *pblk);
 void pblk_gc_should_kick(struct pblk *pblk);
 void pblk_gc_kick(struct pblk *pblk);
+void pblk_gc_free_full_lines(struct pblk *pblk);
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
 			      int *gc_active);
 int pblk_gc_sysfs_force(struct pblk *pblk, int force);
-- 
2.7.4
