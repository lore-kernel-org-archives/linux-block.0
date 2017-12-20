Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46647 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbdLTRWb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so11361414wme.5
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:30 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 16/25] lightnvm: pblk: remove pblk_gc_stop
Date: Wed, 20 Dec 2017 18:21:56 +0100
Message-Id: <20171220172205.26464-17-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

pblk_gc_stop just sets pblk->gc->gc_active to zero, ignoring
the flush parameter. This is plain confusing, so remove the
function and set the gc active flag at the call points instead.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-gc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 9e3f22b..8f71898 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -526,22 +526,12 @@ void pblk_gc_should_start(struct pblk *pblk)
 	}
 }
 
-/*
- * If flush_wq == 1 then no lock should be held by the caller since
- * flush_workqueue can sleep
- */
-static void pblk_gc_stop(struct pblk *pblk, int flush_wq)
-{
-	pblk->gc.gc_active = 0;
-	pr_debug("pblk: gc stop\n");
-}
-
 void pblk_gc_should_stop(struct pblk *pblk)
 {
 	struct pblk_gc *gc = &pblk->gc;
 
 	if (gc->gc_active && !gc->gc_forced)
-		pblk_gc_stop(pblk, 0);
+		gc->gc_active = 0;
 }
 
 void pblk_gc_should_kick(struct pblk *pblk)
@@ -667,7 +657,7 @@ void pblk_gc_exit(struct pblk *pblk)
 
 	gc->gc_enabled = 0;
 	del_timer_sync(&gc->gc_timer);
-	pblk_gc_stop(pblk, 1);
+	gc->gc_active = 0;
 
 	if (gc->gc_ts)
 		kthread_stop(gc->gc_ts);
-- 
2.9.3
