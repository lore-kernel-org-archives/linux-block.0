Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41565 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753692AbeDPKZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 06:25:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id v24so7380946wra.8
        for <linux-block@vger.kernel.org>; Mon, 16 Apr 2018 03:25:44 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 04/11] lightnvn: pblk: improve error msg on corrupted LBAs
Date: Mon, 16 Apr 2018 12:25:25 +0200
Message-Id: <1523874332-6272-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In the event of a mismatch between the read LBA and the metadata pointer
reported by the device, improve the error message to be able to detect
the offending physical address (PPA) mapped to the corrupted LBA.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-read.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 0d45d4ffc370..89aed634333a 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -113,10 +113,11 @@ static int pblk_submit_read_io(struct pblk *pblk, struct nvm_rq *rqd)
 	return NVM_IO_OK;
 }
 
-static void pblk_read_check_seq(struct pblk *pblk, void *meta_list,
-				sector_t blba, int nr_lbas)
+static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
+				sector_t blba)
 {
-	struct pblk_sec_meta *meta_lba_list = meta_list;
+	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
+	int nr_lbas = rqd->nr_ppas;
 	int i;
 
 	for (i = 0; i < nr_lbas; i++) {
@@ -125,17 +126,27 @@ static void pblk_read_check_seq(struct pblk *pblk, void *meta_list,
 		if (lba == ADDR_EMPTY)
 			continue;
 
-		WARN(lba != blba + i, "pblk: corrupted read LBA\n");
+		if (lba != blba + i) {
+#ifdef CONFIG_NVM_DEBUG
+			struct ppa_addr *p;
+
+			p = (nr_lbas == 1) ? &rqd->ppa_list[i] : &rqd->ppa_addr;
+			print_ppa(&pblk->dev->geo, p, "seq", i);
+#endif
+			pr_err("pblk: corrupted read LBA (%llu/%llu)\n",
+							lba, (u64)blba + i);
+			WARN_ON(1);
+		}
 	}
 }
 
 /*
  * There can be wholes in the lba list.
  */
-static void pblk_read_check_rand(struct pblk *pblk, void *meta_list,
-				u64 *lba_list, int nr_lbas)
+static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
+				 u64 *lba_list, int nr_lbas)
 {
-	struct pblk_sec_meta *meta_lba_list = meta_list;
+	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
 	int i, j;
 
 	for (i = 0, j = 0; i < nr_lbas; i++) {
@@ -145,14 +156,25 @@ static void pblk_read_check_rand(struct pblk *pblk, void *meta_list,
 		if (lba == ADDR_EMPTY)
 			continue;
 
-		meta_lba = le64_to_cpu(meta_lba_list[j++].lba);
+		meta_lba = le64_to_cpu(meta_lba_list[j].lba);
 
 		if (lba != meta_lba) {
+#ifdef CONFIG_NVM_DEBUG
+			struct ppa_addr *p;
+			int nr_ppas = rqd->nr_ppas;
+
+			p = (nr_ppas == 1) ? &rqd->ppa_list[j] : &rqd->ppa_addr;
+			print_ppa(&pblk->dev->geo, p, "seq", j);
+#endif
 			pr_err("pblk: corrupted read LBA (%llu/%llu)\n",
 								lba, meta_lba);
 			WARN_ON(1);
 		}
+
+		j++;
 	}
+
+	WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
 }
 
 static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
@@ -197,7 +219,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 		WARN_ONCE(bio->bi_status, "pblk: corrupted read error\n");
 #endif
 
-	pblk_read_check_seq(pblk, rqd->meta_list, r_ctx->lba, rqd->nr_ppas);
+	pblk_read_check_seq(pblk, rqd, r_ctx->lba);
 
 	bio_put(bio);
 	if (r_ctx->private)
@@ -610,7 +632,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 		goto err_free_bio;
 	}
 
-	pblk_read_check_rand(pblk, rqd.meta_list, gc_rq->lba_list, rqd.nr_ppas);
+	pblk_read_check_rand(pblk, &rqd, gc_rq->lba_list, gc_rq->nr_secs);
 
 	atomic_dec(&pblk->inflight_io);
 
-- 
2.7.4
