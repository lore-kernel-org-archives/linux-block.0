Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43273 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeH2QUi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so3758618edb.10
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 05:23:57 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 5/7] lightnvm: pblk: remove unused parameters in pblk_up_rq
Date: Wed, 29 Aug 2018 14:23:32 +0200
Message-Id: <1535545414-550-6-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The parameters nr_ppas and ppa_list are not used, so remove them.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 3 +--
 drivers/lightnvm/pblk-write.c | 5 ++---
 drivers/lightnvm/pblk.h       | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a1033d82b9cc..f7bff3ae52ac 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1920,8 +1920,7 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
 	up(&rlun->wr_sem);
 }
 
-void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
-		unsigned long *lun_bitmap)
+void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index fd67325f6e54..8aa4b9ee5092 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -81,8 +81,7 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_sub(c_ctx->nr_valid, &pblk->inflight_writes);
 #endif
-
-	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	pblk_up_rq(pblk, c_ctx->lun_bitmap);
 
 	pos = pblk_rb_sync_init(&pblk->rwb, &flags);
 	if (pos == c_ctx->sentry) {
@@ -242,7 +241,7 @@ static void pblk_submit_rec(struct work_struct *work)
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
 
-	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	pblk_up_rq(pblk, c_ctx->lun_bitmap);
 	if (c_ctx->nr_padded)
 		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
 							c_ctx->nr_padded);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 1a31fda3a9f2..1bdac22e7897 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -827,8 +827,7 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
 void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 		  unsigned long *lun_bitmap);
 void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
-void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
-		unsigned long *lun_bitmap);
+void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
 int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 		       int nr_pages);
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
-- 
2.7.4
