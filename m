Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54739 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdJCKGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:06:51 -0400
Received: by mail-wm0-f54.google.com with SMTP id i124so15677942wmf.3
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:06:50 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <jg@lightnvm.io>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 1/9] lightnvm: pblk: prevent gc kicks when gc is not operational
Date: Tue,  3 Oct 2017 12:05:05 +0200
Message-Id: <1507025113-13351-2-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

GC can be kicked after it has been shut down when closing the last
line during exit, resulting in accesses to freed structures.

Make sure that GC is not triggered while it is not operational.
Also make sure that GC won't be re-activated during exit when
running on another processor by using timer_del_sync.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c   | 9 +++++----
 drivers/lightnvm/pblk-init.c | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 7b103bc..81efac1 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -478,10 +478,10 @@ void pblk_gc_should_start(struct pblk *pblk)
 {
 	struct pblk_gc *gc = &pblk->gc;
 
-	if (gc->gc_enabled && !gc->gc_active)
+	if (gc->gc_enabled && !gc->gc_active) {
 		pblk_gc_start(pblk);
-
-	pblk_gc_kick(pblk);
+		pblk_gc_kick(pblk);
+	}
 }
 
 /*
@@ -620,7 +620,8 @@ void pblk_gc_exit(struct pblk *pblk)
 	flush_workqueue(gc->gc_reader_wq);
 	flush_workqueue(gc->gc_line_reader_wq);
 
-	del_timer(&gc->gc_timer);
+	gc->gc_enabled = 0;
+	del_timer_sync(&gc->gc_timer);
 	pblk_gc_stop(pblk, 1);
 
 	if (gc->gc_ts)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 0163914..ec7974b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -928,6 +928,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->dev = dev;
 	pblk->disk = tdisk;
 	pblk->state = PBLK_STATE_RUNNING;
+	pblk->gc.gc_enabled = 0;
 
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
-- 
2.7.4
