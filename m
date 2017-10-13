Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45161 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932224AbdJMMrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id q124so21263266wmb.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:52 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 47/58] lightnvm: pblk: free full lines during recovery
Date: Fri, 13 Oct 2017 14:46:36 +0200
Message-Id: <20171013124647.32668-48-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When rebuilding the L2P table, any full lines (lines without any
valid sectors) will be identified. If these lines are not freed,
we risk not being able to allocate the first data line.

This patch refactors the part of GC that frees empty lines
into a separate function and adds a call to this after the
L2P table has been rebuilt.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-gc.c   | 48 ++++++++++++++++++++++++++------------------
 drivers/lightnvm/pblk-init.c |  3 +++
 drivers/lightnvm/pblk.h      |  1 +
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 81efac1..374089f 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -330,6 +330,33 @@ static bool pblk_gc_should_run(struct pblk_gc *gc, struct pblk_rl *rl)
 	return ((gc->gc_active) && (nr_blocks_need > nr_blocks_free));
 }
 
+void pblk_gc_free_full_lines(struct pblk *pblk)
+{
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	struct pblk_line *line;
+
+	do {
+		spin_lock(&l_mg->gc_lock);
+		if (list_empty(&l_mg->gc_full_list)) {
+			spin_unlock(&l_mg->gc_lock);
+			return;
+		}
+
+		line = list_first_entry(&l_mg->gc_full_list,
+							struct pblk_line, list);
+
+		spin_lock(&line->lock);
+		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
+		line->state = PBLK_LINESTATE_GC;
+		spin_unlock(&line->lock);
+
+		list_del(&line->list);
+		spin_unlock(&l_mg->gc_lock);
+
+		kref_put(&line->ref, pblk_line_put);
+	} while (1);
+}
+
 /*
  * Lines with no valid sectors will be returned to the free list immediately. If
  * GC is activated - either because the free block count is under the determined
@@ -345,26 +372,7 @@ static void pblk_gc_run(struct pblk *pblk)
 	bool run_gc;
 	int inflight_gc, gc_group = 0, prev_group = 0;
 
-	do {
-		spin_lock(&l_mg->gc_lock);
-		if (list_empty(&l_mg->gc_full_list)) {
-			spin_unlock(&l_mg->gc_lock);
-			break;
-		}
-
-		line = list_first_entry(&l_mg->gc_full_list,
-							struct pblk_line, list);
-
-		spin_lock(&line->lock);
-		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
-		line->state = PBLK_LINESTATE_GC;
-		spin_unlock(&line->lock);
-
-		list_del(&line->list);
-		spin_unlock(&l_mg->gc_lock);
-
-		kref_put(&line->ref, pblk_line_put);
-	} while (1);
+	pblk_gc_free_full_lines(pblk);
 
 	run_gc = pblk_gc_should_run(&pblk->gc, &pblk->rl);
 	if (!run_gc || (atomic_read(&gc->inflight_gc) >= PBLK_GC_L_QD))
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 27eb430..f08fa20 100644
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
index 191b1ec..21438d1 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -831,6 +831,7 @@ void pblk_gc_exit(struct pblk *pblk);
 void pblk_gc_should_start(struct pblk *pblk);
 void pblk_gc_should_stop(struct pblk *pblk);
 void pblk_gc_kick(struct pblk *pblk);
+void pblk_gc_free_full_lines(struct pblk *pblk);
 void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
 			      int *gc_active);
 int pblk_gc_sysfs_force(struct pblk *pblk, int force);
-- 
2.9.3
