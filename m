Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32556C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9CC2084B
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Frf9eif4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfEDSjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:39:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43860 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfEDSiz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id z5so2743906lji.10
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ifluMSXfvXQssGIr/hJi3zrrEx5BWoQ2+WkMfkrOaA=;
        b=Frf9eif4tYuskF2lTMTHvzZb2KuwU9opeHMG0Kz4uG3aNdvfYIEpgA/8qeGAlgOeUp
         4KnqgBiHd8HboWsaMyHXXBuSkI7ikR45+OLHcmxY2fgbRyUjmz/nny31nzVqcSNN1aLB
         OpmKTk6o7o9mRx7xC/vB/a+XePAU8MPoL5oWDH7hCpX3QxXATqHufSCJqUCQYajuNVoJ
         bYtrRFSs0qOcB6T66XfIhZZBdXRon/tbAlX8qPJ7C5HWRA6Nedi8BKFUVJYsq/FKsydX
         EavqY3EqfM8LyLdNhXZsIxKJX+kZ/IgUNUWGPXi411wxaYSfG6HLYbMR06PUN9McHde3
         Hycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ifluMSXfvXQssGIr/hJi3zrrEx5BWoQ2+WkMfkrOaA=;
        b=SfwevJLfrOLVdzZlLIdFk9EsNw8roKmz7NkcCUVHJfmaSQU7o6khIh9FIW/QALAV8r
         +Tjy3iuN8zroewuN2B4O2JExAX3Q635QWgAjhuBmzAlYuihWVAcxY8rlWnRR+JUe33Fb
         vSQhnpzATONOypAAYuV8fiZH9wXMrVxKt+tcpL8OkDBMyZNQvpXpN73UDcLUsdk+BneH
         DGh+d9ltgGiZe4w1ISniBUgZmRqVbEBRnbaLi2NGoKW+5u+s2BCugKFYJNSwnm4Bgn8I
         QYqubVjRluIyJg7rqL2NZFYaM+rn/jZeocok6ocVYmpkNh2xDXLRYbN9g1x5fAMTdmyH
         G93Q==
X-Gm-Message-State: APjAAAWeHXz2vTCFf6nKsPVF4euZZAWLH3O6y7+BEo3jpqSwd2zKmhPr
        4FdJnRG9j6yYoaHmKqfhxDZ45d5rGicn1g==
X-Google-Smtp-Source: APXvYqw7GGvSR2XCr2Z+qPZ+Y9VdhytXlF94c3ntymWmlkb3Tcu6Th12BZou/nrdSsWP5cid9b7kqw==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr8776507ljg.25.1556995132078;
        Sat, 04 May 2019 11:38:52 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:51 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 26/26] lightnvm: pblk: use nvm_rq_to_ppa_list()
Date:   Sat,  4 May 2019 20:38:11 +0200
Message-Id: <20190504183811.18725-27-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

This patch replaces few remaining usages of rqd->ppa_list[] with
existing nvm_rq_to_ppa_list() helpers. This is needed for theoretical
devices with ws_min/ws_opt equal to 1.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 26 ++++++++++++++------------
 drivers/lightnvm/pblk-recovery.c | 13 ++++++++-----
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 07270ba1e95f..773537804319 100644
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
@@ -725,6 +723,7 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct bio *bio;
+	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	u64 paddr = pblk_line_smeta_start(pblk, line);
 	int i, ret;
@@ -748,9 +747,10 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 	rqd.opcode = NVM_OP_PREAD;
 	rqd.nr_ppas = lm->smeta_sec;
 	rqd.is_seq = 1;
+	ppa_list = nvm_rq_to_ppa_list(&rqd);
 
 	for (i = 0; i < lm->smeta_sec; i++, paddr++)
-		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
+		ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
 
 	ret = pblk_submit_io_sync(pblk, &rqd);
 	if (ret) {
@@ -777,6 +777,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct bio *bio;
+	struct ppa_addr *ppa_list;
 	struct nvm_rq rqd;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
@@ -801,12 +802,13 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	rqd.opcode = NVM_OP_PWRITE;
 	rqd.nr_ppas = lm->smeta_sec;
 	rqd.is_seq = 1;
+	ppa_list = nvm_rq_to_ppa_list(&rqd);
 
 	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
 		struct pblk_sec_meta *meta = pblk_get_meta(pblk,
 							   rqd.meta_list, i);
 
-		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
+		ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
 		meta->lba = lba_list[paddr] = addr_empty;
 	}
 
@@ -836,8 +838,9 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
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
@@ -853,7 +856,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	if (!meta_list)
 		return -ENOMEM;
 
-	ppa_list = meta_list + pblk_dma_meta_size(pblk);
+	ppa_list_buf = meta_list + pblk_dma_meta_size(pblk);
 	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
 
 next_rq:
@@ -874,11 +877,12 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 
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
@@ -906,7 +910,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 		}
 
 		for (j = 0; j < min; j++, i++, paddr++)
-			rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line_id);
+			ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line_id);
 	}
 
 	ret = pblk_submit_io_sync(pblk, &rqd);
@@ -1525,11 +1529,9 @@ void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
 
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
index a9085b0e6611..e6dda04de144 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -179,6 +179,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
 	struct bio *bio;
+	struct ppa_addr *ppa_list;
 	void *data;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	u64 w_ptr = line->cur_sec;
@@ -239,6 +240,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	rqd->end_io = pblk_end_io_recov;
 	rqd->private = pad_rq;
 
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 	meta_list = rqd->meta_list;
 
 	for (i = 0; i < rqd->nr_ppas; ) {
@@ -266,17 +268,17 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
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
@@ -420,6 +422,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	rqd->ppa_list = ppa_list;
 	rqd->dma_ppa_list = dma_ppa_list;
 	rqd->dma_meta_list = dma_meta_list;
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	if (pblk_io_aligned(pblk, rq_ppas))
 		rqd->is_seq = 1;
@@ -438,7 +441,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 		}
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++)
-			rqd->ppa_list[i] =
+			ppa_list[i] =
 				addr_to_gen_ppa(pblk, paddr + j, line->id);
 	}
 
@@ -486,7 +489,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 			continue;
 
 		line->nr_valid_lbas++;
-		pblk_update_map(pblk, lba, rqd->ppa_list[i]);
+		pblk_update_map(pblk, lba, ppa_list[i]);
 	}
 
 	left_ppas -= rq_ppas;
-- 
2.19.1

