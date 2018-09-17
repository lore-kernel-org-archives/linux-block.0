Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35178 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeIQKzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Sep 2018 06:55:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so6853681plo.2
        for <linux-block@vger.kernel.org>; Sun, 16 Sep 2018 22:29:53 -0700 (PDT)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org, hlitz@ucsc.edu
Cc: javier@cnexlabs.com, mb@lightnvm.io, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Subject: [RFC PATCH 1/6] lightnvm: pblk: refactor read and write APIs
Date: Sun, 16 Sep 2018 22:29:34 -0700
Message-Id: <20180917052939.4776-2-hlitz@ucsc.edu>
In-Reply-To: <20180917052939.4776-1-hlitz@ucsc.edu>
References: <20180917052939.4776-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In prepartion of supporting RAIL, expose read and write APIs so their
functionality can be leveraged by RAIL.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-read.c  | 8 +++-----
 drivers/lightnvm/pblk-write.c | 4 ++--
 drivers/lightnvm/pblk.h       | 7 +++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 6d13763f2f6a..67d44caefff4 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -170,8 +170,7 @@ static void pblk_end_user_read(struct bio *bio)
 	bio_endio(bio);
 }
 
-static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
-			       bool put_line)
+void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd, bool put_line)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
@@ -285,10 +284,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	__pblk_end_io_read(pblk, rqd, false);
 }
 
-static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
+int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 			    unsigned int bio_init_idx,
-			    unsigned long *read_bitmap,
-			    int nr_holes)
+			    unsigned long *read_bitmap, int nr_holes)
 {
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 9554febee480..1ce03d7c873b 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -217,7 +217,7 @@ static void pblk_submit_rec(struct work_struct *work)
 }
 
 
-static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
+void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct pblk_rec_ctx *recovery;
 
@@ -500,7 +500,7 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
 	return meta_line;
 }
 
-static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
+int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct ppa_addr erase_ppa;
 	struct pblk_line *meta_line;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 3596043332f2..eab50df70ae6 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -861,6 +861,8 @@ void pblk_lookup_l2p_seq(struct pblk *pblk, struct ppa_addr *ppas,
 int pblk_write_to_cache(struct pblk *pblk, struct bio *bio,
 			unsigned long flags);
 int pblk_write_gc_to_cache(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
+void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd);
 
 /*
  * pblk map
@@ -886,6 +888,11 @@ void pblk_write_kick(struct pblk *pblk);
 extern struct bio_set pblk_bio_set;
 int pblk_submit_read(struct pblk *pblk, struct bio *bio);
 int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
+void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd, bool put_line);
+int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
+			    unsigned int bio_init_idx,
+			    unsigned long *read_bitmap, int nr_holes);
+
 /*
  * pblk recovery
  */
-- 
2.17.1
