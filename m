Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44874 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeJISal (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:30:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id p25-v6so658751pli.11
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:15 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 18/45] lightnvm: pblk: remove unused parameters in pblk_up_rq
Date: Tue,  9 Oct 2018 13:11:48 +0200
Message-Id: <20181009111215.7653-19-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The parameters nr_ppas and ppa_list are not used, so remove them.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 3 +--
 drivers/lightnvm/pblk-write.c | 5 ++---
 drivers/lightnvm/pblk.h       | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e1207a4f9d54..bb1a7cc24cbb 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1929,8 +1929,7 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
 	up(&rlun->wr_sem);
 }
 
-void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
-		unsigned long *lun_bitmap)
+void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index c20bb7f6d703..cd579b440b56 100644
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
@@ -215,7 +214,7 @@ static void pblk_submit_rec(struct work_struct *work)
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
 
-	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	pblk_up_rq(pblk, c_ctx->lun_bitmap);
 	if (c_ctx->nr_padded)
 		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
 							c_ctx->nr_padded);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 9068b158de22..0ca67e8f99d5 100644
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
2.17.1
