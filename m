Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39875 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeHTP1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 11:27:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id a134-v6so10724106lfe.6
        for <linux-block@vger.kernel.org>; Mon, 20 Aug 2018 05:12:24 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
Date: Mon, 20 Aug 2018 14:12:17 +0200
Message-Id: <20180820121217.11393-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There is a number of places in the lightnvm subsystem where the user
iterates over the ppa list. Before iterating, the user must know if it
is a single or multiple LBAs due to vector commands using either the
nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
leads to open-coding the if/else statement.

Instead of having multiple if/else's, move it into a function that can
be called by its users.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c  | 4 +---
 drivers/lightnvm/pblk-write.c | 5 +----
 drivers/lightnvm/pblk.h       | 4 +---
 include/linux/lightnvm.h      | 5 +++++
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f275c7e5abe4..696d3a9c9cf0 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -175,11 +175,9 @@ static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr ppa)
 
 static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
 {
-	struct ppa_addr *ppa_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int i;
 
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
 	for (i = 0; i < rqd->nr_ppas; i++)
 		__pblk_read_put_line(pblk, ppa_list[i]);
 }
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index df99c45778d4..a92450ec7698 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -212,10 +212,7 @@ static void pblk_submit_rec(struct work_struct *work)
 
 	pblk_log_write_err(pblk, rqd);
 
-	if (rqd->nr_ppas == 1)
-		ppa_list = &rqd->ppa_addr;
-	else
-		ppa_list = rqd->ppa_list;
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 64ae0c7ed3bb..bda098c7cc3b 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1335,9 +1335,7 @@ static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
 static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
-	struct ppa_addr *ppa_list;
-
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
 		WARN_ON(1);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 0106984400bc..1497e275f90f 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -487,6 +487,11 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 	return l;
 }
 
+static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
+{
+	return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+}
+
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.11.0
