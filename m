Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:57286 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758204AbdJMMr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id l68so21510635wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:28 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 22/58] lightnvm: pblk: use constant for GC max inflight
Date: Fri, 13 Oct 2017 14:46:11 +0200
Message-Id: <20171013124647.32668-23-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Use a constant to set the maximum number of inflight GC requests
allowed.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-gc.c | 4 ++--
 drivers/lightnvm/pblk.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index f163829..c21b207 100644
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
index 60edcda..baa6a63 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -816,7 +816,7 @@ int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
  * pblk gc
  */
 #define PBLK_GC_MAX_READERS 8	/* Max number of outstanding GC reader jobs */
-#define PBLK_GC_W_QD 128	/* Queue depth for inflight GC write I/Os */
+#define PBLK_GC_RQ_QD 128	/* Queue depth for inflight GC requests */
 #define PBLK_GC_L_QD 4		/* Queue depth for inflight GC lines */
 #define PBLK_GC_RSV_LINE 1	/* Reserved lines for GC */
 
-- 
2.9.3
