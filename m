Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:46138 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdJCKGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:06:55 -0400
Received: by mail-wm0-f48.google.com with SMTP id m72so15604336wmc.1
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:06:55 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 6/9] lightnvm: pblk: shut down gc gracefully during exit
Date: Tue,  3 Oct 2017 12:05:10 +0200
Message-Id: <1507025113-13351-7-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Shut down the GC workqueues and tasks in the right order.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 374089f..f343f90 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -422,10 +422,15 @@ void pblk_gc_kick(struct pblk *pblk)
 {
 	struct pblk_gc *gc = &pblk->gc;
 
-	wake_up_process(gc->gc_ts);
 	pblk_gc_writer_kick(gc);
 	pblk_gc_reader_kick(gc);
-	mod_timer(&gc->gc_timer, jiffies + msecs_to_jiffies(GC_TIME_MSECS));
+
+	/* If we're shutting down GC, let's not start it up again */
+	if (gc->gc_enabled) {
+		wake_up_process(gc->gc_ts);
+		mod_timer(&gc->gc_timer,
+			  jiffies + msecs_to_jiffies(GC_TIME_MSECS));
+	}
 }
 
 static void pblk_gc_timer(unsigned long data)
@@ -625,9 +630,6 @@ void pblk_gc_exit(struct pblk *pblk)
 {
 	struct pblk_gc *gc = &pblk->gc;
 
-	flush_workqueue(gc->gc_reader_wq);
-	flush_workqueue(gc->gc_line_reader_wq);
-
 	gc->gc_enabled = 0;
 	del_timer_sync(&gc->gc_timer);
 	pblk_gc_stop(pblk, 1);
@@ -635,15 +637,17 @@ void pblk_gc_exit(struct pblk *pblk)
 	if (gc->gc_ts)
 		kthread_stop(gc->gc_ts);
 
+	if (gc->gc_reader_ts)
+		kthread_stop(gc->gc_reader_ts);
+
+	flush_workqueue(gc->gc_reader_wq);
 	if (gc->gc_reader_wq)
 		destroy_workqueue(gc->gc_reader_wq);
 
+	flush_workqueue(gc->gc_line_reader_wq);
 	if (gc->gc_line_reader_wq)
 		destroy_workqueue(gc->gc_line_reader_wq);
 
 	if (gc->gc_writer_ts)
 		kthread_stop(gc->gc_writer_ts);
-
-	if (gc->gc_reader_ts)
-		kthread_stop(gc->gc_reader_ts);
 }
-- 
2.7.4
