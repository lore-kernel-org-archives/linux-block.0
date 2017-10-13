Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:47454 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932292AbdJMMrz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id t69so21256306wmt.2
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:54 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 50/58] lightnvm: pblk: shut down gc gracefully during exit
Date: Fri, 13 Oct 2017 14:46:39 +0200
Message-Id: <20171013124647.32668-51-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Shut down the GC workqueues and tasks in the right order.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-gc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 4bac9e1..e00e5a0 100644
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
@@ -630,9 +635,6 @@ void pblk_gc_exit(struct pblk *pblk)
 {
 	struct pblk_gc *gc = &pblk->gc;
 
-	flush_workqueue(gc->gc_reader_wq);
-	flush_workqueue(gc->gc_line_reader_wq);
-
 	gc->gc_enabled = 0;
 	del_timer_sync(&gc->gc_timer);
 	pblk_gc_stop(pblk, 1);
@@ -640,15 +642,17 @@ void pblk_gc_exit(struct pblk *pblk)
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
2.9.3
