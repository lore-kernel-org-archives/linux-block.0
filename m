Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeIQKzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Sep 2018 06:55:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so6976895pfo.12
        for <linux-block@vger.kernel.org>; Sun, 16 Sep 2018 22:29:57 -0700 (PDT)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org, hlitz@ucsc.edu
Cc: javier@cnexlabs.com, mb@lightnvm.io, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Subject: [RFC PATCH 3/6] lightnvm: pblk: Refactor end_io function in pblk_submit_io_set
Date: Sun, 16 Sep 2018 22:29:36 -0700
Message-Id: <20180917052939.4776-4-hlitz@ucsc.edu>
In-Reply-To: <20180917052939.4776-1-hlitz@ucsc.edu>
References: <20180917052939.4776-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation of supporting RAIL, refactor pblk_submit_io_set in the write
path so that the end_io function can be specified when setting up the
request.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-write.c | 11 ++++++-----
 drivers/lightnvm/pblk.h       |  3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 1ce03d7c873b..6eba38b83acd 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -309,7 +309,7 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 }
 
 static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			   struct ppa_addr *erase_ppa)
+			   struct ppa_addr *erase_ppa, nvm_end_io_fn(*end_io))
 {
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line *e_line = pblk_line_get_erase(pblk);
@@ -325,7 +325,7 @@ static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		return -ENOMEM;
 	c_ctx->lun_bitmap = lun_bitmap;
 
-	ret = pblk_alloc_w_rq(pblk, rqd, nr_secs, pblk_end_io_write);
+	ret = pblk_alloc_w_rq(pblk, rqd, nr_secs, end_io);
 	if (ret) {
 		kfree(lun_bitmap);
 		return ret;
@@ -500,7 +500,8 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
 	return meta_line;
 }
 
-int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
+int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd,
+		       nvm_end_io_fn(*end_io))
 {
 	struct ppa_addr erase_ppa;
 	struct pblk_line *meta_line;
@@ -509,7 +510,7 @@ int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 	pblk_ppa_set_empty(&erase_ppa);
 
 	/* Assign lbas to ppas and populate request structure */
-	err = pblk_setup_w_rq(pblk, rqd, &erase_ppa);
+	err = pblk_setup_w_rq(pblk, rqd, &erase_ppa, end_io);
 	if (err) {
 		pblk_err(pblk, "could not setup write request: %d\n", err);
 		return NVM_IO_ERR;
@@ -631,7 +632,7 @@ static int pblk_submit_write(struct pblk *pblk)
 		goto fail_put_bio;
 	}
 
-	if (pblk_submit_io_set(pblk, rqd))
+	if (pblk_submit_io_set(pblk, rqd, pblk_end_io_write))
 		goto fail_free_bio;
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 87dc24772dad..64d9c206ec52 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -870,7 +870,8 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio,
 			unsigned long flags);
 int pblk_write_gc_to_cache(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
 void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd);
-int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd,
+		       nvm_end_io_fn(*end_io));
 
 /*
  * pblk map
-- 
2.17.1
