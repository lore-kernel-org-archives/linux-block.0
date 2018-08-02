Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35792 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeHBPjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Aug 2018 11:39:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so982503edr.2
        for <linux-block@vger.kernel.org>; Thu, 02 Aug 2018 06:48:24 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: take write semaphore on metadata
Date: Thu,  2 Aug 2018 15:47:54 +0200
Message-Id: <1533217674-9514-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Take the write semaphore on metadata I/Os too.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 72acf2f6dbd6..73edb2d8104f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io_sync(dev, rqd);
 }
 
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	if (rqd->opcode != NVM_OP_PWRITE)
+		pblk_submit_io_sync(pblk, rqd);
+
+	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_submit_io_sync(pblk, rqd);
+	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+}
+
 static void pblk_bio_map_addr_endio(struct bio *bio)
 {
 	bio_put(bio);
@@ -735,7 +745,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 		}
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
@@ -837,7 +847,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	 * the write thread is the only one sending write and erase commands,
 	 * there is no need to take the LUN semaphore.
 	 */
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 48b3035df3c4..81401dd88951 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -782,6 +782,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
-- 
2.7.4
