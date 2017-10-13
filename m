Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55024 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdJMMrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id i124so21518541wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:50 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 45/58] lightnvm: pblk: prevent gc kicks when gc is not operational
Date: Fri, 13 Oct 2017 14:46:34 +0200
Message-Id: <20171013124647.32668-46-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

GC can be kicked after it has been shut down when closing the last
line during exit, resulting in accesses to freed structures.

Make sure that GC is not triggered while it is not operational.
Also make sure that GC won't be re-activated during exit when
running on another processor by using timer_del_sync.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
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
index 2e59973..27eb430 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -931,6 +931,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->dev = dev;
 	pblk->disk = tdisk;
 	pblk->state = PBLK_STATE_RUNNING;
+	pblk->gc.gc_enabled = 0;
 
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
-- 
2.9.3
