Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37007 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbdIFKwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:44 -0400
Received: by mail-wm0-f43.google.com with SMTP id u26so29535744wma.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:43 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 07/18] lightnvm: pblk: use constant for GC parameter
Date: Wed,  6 Sep 2017 12:51:00 +0200
Message-Id: <1504695071-25928-8-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use a constant instead of using meaningless tuning parameters on the
garbage collector algorithms.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 4 ++--
 drivers/lightnvm/pblk.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 6090d28f7995..92694e35afde 100644
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
index 08a463fe855f..b7f5fa8b49d0 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -818,7 +818,7 @@ int pblk_recov_setup_rq(struct pblk *pblk, struct pblk_c_ctx *c_ctx,
  * pblk gc
  */
 #define PBLK_GC_MAX_READERS 8	/* Max number of outstanding GC reader jobs */
-#define PBLK_GC_W_QD 128	/* Queue depth for inflight GC write I/Os */
+#define PBLK_GC_RQ_QD 128	/* Queue depth for inflight GC requests */
 #define PBLK_GC_L_QD 4		/* Queue depth for inflight GC lines */
 #define PBLK_GC_RSV_LINE 1	/* Reserved lines for GC */
 
-- 
2.7.4
