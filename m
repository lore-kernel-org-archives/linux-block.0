Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:48265 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdIOMZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 08:25:45 -0400
Received: by mail-wm0-f43.google.com with SMTP id r68so7877308wmg.3
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2017 05:25:44 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 01/11] lightnvm: pblk: use constant for GC max inflight
Date: Fri, 15 Sep 2017 14:25:29 +0200
Message-Id: <1505478339-13089-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
References: <1505478339-13089-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use a constant to set the maximum number of inflight GC requests
allowed.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 4 ++--
 drivers/lightnvm/pblk.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index f163829ecca8..c21b2077432a 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -93,7 +93,7 @@ static int pblk_gc_move_valid_secs(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 retry:
 	spin_lock(&gc->w_lock);
-	if (gc->w_entries >= PBLK_GC_W_QD) {
+	if (gc->w_entries >= PBLK_GC_RQ_QD) {
 		spin_unlock(&gc->w_lock);
 		pblk_gc_writer_kick(&pblk->gc);
 		usleep_range(128, 256);
@@ -602,7 +602,7 @@ int pblk_gc_init(struct pblk *pblk)
 	spin_lock_init(&gc->w_lock);
 	spin_lock_init(&gc->r_lock);
 
-	sema_init(&gc->gc_sem, 128);
+	sema_init(&gc->gc_sem, PBLK_GC_RQ_QD);
 
 	INIT_LIST_HEAD(&gc->w_list);
 	INIT_LIST_HEAD(&gc->r_list);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 469976a20421..afd967b55d94 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -815,7 +815,7 @@ int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
  * pblk gc
  */
 #define PBLK_GC_MAX_READERS 8	/* Max number of outstanding GC reader jobs */
-#define PBLK_GC_W_QD 128	/* Queue depth for inflight GC write I/Os */
+#define PBLK_GC_RQ_QD 128	/* Queue depth for inflight GC requests */
 #define PBLK_GC_L_QD 4		/* Queue depth for inflight GC lines */
 #define PBLK_GC_RSV_LINE 1	/* Reserved lines for GC */
 
-- 
2.7.4
