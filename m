Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51356 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeD3JKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:10:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4so11904920wme.1
        for <linux-block@vger.kernel.org>; Mon, 30 Apr 2018 02:10:19 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 03/11] lightnvm: pblk: check read lba on gc path
Date: Mon, 30 Apr 2018 11:10:01 +0200
Message-Id: <1525079409-6588-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Check that the lba stored in the LBA metadata is correct in the GC path
too. This requires a new helper function to check random reads in the
vector read.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 9eee10f69df0..1f699c09e0ea 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -113,15 +113,14 @@ static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
 	return NVM_IO_OK;
 }
 
-static void pblk_read_check(struct pblk *pblk, struct nvm_rq *rqd,
-			   sector_t blba)
+static void pblk_read_check_seq(struct pblk *pblk, void *meta_list,
+				sector_t blba, int nr_lbas)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
-	int nr_lbas = rqd->nr_ppas;
+	struct pblk_sec_meta *meta_lba_list = meta_list;
 	int i;
 
 	for (i = 0; i < nr_lbas; i++) {
-		u64 lba = le64_to_cpu(meta_list[i].lba);
+		u64 lba = le64_to_cpu(meta_lba_list[i].lba);
 
 		if (lba == ADDR_EMPTY)
 			continue;
@@ -130,6 +129,32 @@ static void pblk_read_check(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 }
 
+/*
+ * There can be holes in the lba list.
+ */
+static void pblk_read_check_rand(struct pblk *pblk, void *meta_list,
+				u64 *lba_list, int nr_lbas)
+{
+	struct pblk_sec_meta *meta_lba_list = meta_list;
+	int i, j;
+
+	for (i = 0, j = 0; i < nr_lbas; i++) {
+		u64 lba = lba_list[i];
+		u64 meta_lba;
+
+		if (lba == ADDR_EMPTY)
+			continue;
+
+		meta_lba = le64_to_cpu(meta_lba_list[j++].lba);
+
+		if (lba != meta_lba) {
+			pr_err("pblk: corrupted read LBA (%llu/%llu)\n",
+								lba, meta_lba);
+			WARN_ON(1);
+		}
+	}
+}
+
 static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct ppa_addr *ppa_list;
@@ -172,7 +197,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 		WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
 #endif
 
-	pblk_read_check(pblk, rqd, r_ctx->lba);
+	pblk_read_check_seq(pblk, rqd->meta_list, r_ctx->lba, rqd->nr_ppas);
 
 	bio_put(bio);
 	if (r_ctx->private)
@@ -585,6 +610,8 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 		goto err_free_bio;
 	}
 
+	pblk_read_check_rand(pblk, rqd.meta_list, gc_rq->lba_list, rqd.nr_ppas);
+
 	atomic_dec(&pblk->inflight_io);
 
 	if (rqd.error) {
-- 
2.7.4
