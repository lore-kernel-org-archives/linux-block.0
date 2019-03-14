Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9745C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B542184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCNQJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:11635 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQJW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073350"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:09:20 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 16/18] lightnvm: pblk: use nvm_rq_to_ppa_list()
Date:   Thu, 14 Mar 2019 17:04:26 +0100
Message-Id: <20190314160428.3559-17-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch replaces few remaining usages of rqd->ppa_list[] with
existing nvm_rq_to_ppa_list() helpers. This is needed for theoretical
devices with ws_min/ws_opt equal to 1.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     | 26 ++++++++++++++------------
 drivers/lightnvm/pblk-recovery.c | 13 ++++++++-----
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6817f8f..7338a44 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -562,11 +562,9 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 
 int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
 {
-	struct ppa_addr *ppa_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int ret;
 
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
 	pblk_down_chunk(pblk, ppa_list[0]);
 	ret = pblk_submit_io_sync(pblk, rqd);
 	pblk_up_chunk(pblk, ppa_list[0]);
@@ -727,6 +725,7 @@ static int pblk_line_smeta_read_copy(struct pblk *pblk,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct bio *bio;
+	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	int i, ret;
 
@@ -750,6 +749,7 @@ static int pblk_line_smeta_read_copy(struct pblk *pblk,
 	rqd.opcode = NVM_OP_PREAD;
 	rqd.nr_ppas = lm->smeta_sec / lm->smeta_copies;
 	rqd.is_seq = 1;
+	ppa_list = nvm_rq_to_ppa_list(&rqd);
 
 	for (i = 0; i < rqd.nr_ppas; i++, paddr++) {
 		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line->id);
@@ -761,7 +761,7 @@ static int pblk_line_smeta_read_copy(struct pblk *pblk,
 			pos = pblk_ppa_to_pos(geo, ppa);
 		}
 
-		rqd.ppa_list[i] = ppa;
+		ppa_list[i] = ppa;
 		pblk_get_meta(pblk, rqd.meta_list, i)->lba =
 				  cpu_to_le64(ADDR_EMPTY);
 	}
@@ -812,6 +812,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line)
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct bio *bio;
+	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
@@ -863,6 +864,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line)
 	rqd.opcode = NVM_OP_PWRITE;
 	rqd.nr_ppas = smeta_cpy_sec;
 	rqd.is_seq = 1;
+	ppa_list = nvm_rq_to_ppa_list(&rqd);
 
 	for (i = 0; i < rqd.nr_ppas; i++, paddr++) {
 		void *meta_list = rqd.meta_list;
@@ -875,7 +877,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line)
 			pos = pblk_ppa_to_pos(geo, ppa);
 		}
 
-		rqd.ppa_list[i] = ppa;
+		ppa_list[i] = ppa;
 		pblk_get_meta(pblk, meta_list, i)->lba = addr_empty;
 		lba_list[paddr] = addr_empty;
 	}
@@ -911,8 +913,9 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
-	void *ppa_list, *meta_list;
+	void *ppa_list_buf, *meta_list;
 	struct bio *bio;
+	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	u64 paddr = line->emeta_ssec;
 	dma_addr_t dma_ppa_list, dma_meta_list;
@@ -928,7 +931,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	if (!meta_list)
 		return -ENOMEM;
 
-	ppa_list = meta_list + pblk_dma_meta_size(pblk);
+	ppa_list_buf = meta_list + pblk_dma_meta_size(pblk);
 	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
 
 next_rq:
@@ -949,11 +952,12 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 
 	rqd.bio = bio;
 	rqd.meta_list = meta_list;
-	rqd.ppa_list = ppa_list;
+	rqd.ppa_list = ppa_list_buf;
 	rqd.dma_meta_list = dma_meta_list;
 	rqd.dma_ppa_list = dma_ppa_list;
 	rqd.opcode = NVM_OP_PREAD;
 	rqd.nr_ppas = rq_ppas;
+	ppa_list = nvm_rq_to_ppa_list(&rqd);
 
 	for (i = 0; i < rqd.nr_ppas; ) {
 		struct ppa_addr ppa = addr_to_gen_ppa(pblk, paddr, line_id);
@@ -981,7 +985,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 		}
 
 		for (j = 0; j < min; j++, i++, paddr++)
-			rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line_id);
+			ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line_id);
 	}
 
 	ret = pblk_submit_io_sync(pblk, &rqd);
@@ -1608,11 +1612,9 @@ void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
 
 void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd)
 {
-	struct ppa_addr *ppa_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int i;
 
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
 	for (i = 0; i < rqd->nr_ppas; i++)
 		pblk_ppa_to_line_put(pblk, ppa_list[i]);
 }
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 4e4db38..4051b93 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -185,6 +185,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
 	struct bio *bio;
+	struct ppa_addr *ppa_list;
 	void *data;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	u64 w_ptr = line->cur_sec;
@@ -245,6 +246,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	rqd->end_io = pblk_end_io_recov;
 	rqd->private = pad_rq;
 
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 	meta_list = rqd->meta_list;
 
 	for (i = 0; i < rqd->nr_ppas; ) {
@@ -272,17 +274,17 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 			lba_list[w_ptr] = addr_empty;
 			meta = pblk_get_meta(pblk, meta_list, i);
 			meta->lba = addr_empty;
-			rqd->ppa_list[i] = dev_ppa;
+			ppa_list[i] = dev_ppa;
 		}
 	}
 
 	kref_get(&pad_rq->ref);
-	pblk_down_chunk(pblk, rqd->ppa_list[0]);
+	pblk_down_chunk(pblk, ppa_list[0]);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
-		pblk_up_chunk(pblk, rqd->ppa_list[0]);
+		pblk_up_chunk(pblk, ppa_list[0]);
 		kref_put(&pad_rq->ref, pblk_recov_complete);
 		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 		bio_put(bio);
@@ -426,6 +428,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	rqd->ppa_list = ppa_list;
 	rqd->dma_ppa_list = dma_ppa_list;
 	rqd->dma_meta_list = dma_meta_list;
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	if (pblk_io_aligned(pblk, rq_ppas))
 		rqd->is_seq = 1;
@@ -444,7 +447,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 		}
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++)
-			rqd->ppa_list[i] =
+			ppa_list[i] =
 				addr_to_gen_ppa(pblk, paddr + j, line->id);
 	}
 
@@ -500,7 +503,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 			continue;
 
 		line->nr_valid_lbas++;
-		pblk_update_map(pblk, lba, rqd->ppa_list[i]);
+		pblk_update_map(pblk, lba, ppa_list[i]);
 	}
 
 	left_ppas -= rq_ppas;
-- 
2.9.5

