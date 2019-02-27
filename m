Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A92DC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0252183F
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfB0RS2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:18:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:13465 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RS2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:18:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129819652"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 09:18:25 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 12/13] lightnvm: pblk: close opened chunks
Date:   Wed, 27 Feb 2019 18:14:41 +0100
Message-Id: <20190227171442.11853-13-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190227171442.11853-1-igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we creating pblk instance with factory
flag, there is a possibility that some chunks
are in open state, which does not allow to
issue erase request to them directly. Such a
chunk should be filled with some empty data in
order to achieve close state. Without that we
are risking that some erase operation will be
rejected by the drive due to inproper chunk
state.

This patch implements closing chunk logic in pblk
for that case, when creating instance with factory
flag in order to fix that issue

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c | 114 +++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-init.c |  14 ++++-
 drivers/lightnvm/pblk.h      |   2 +
 3 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index fa4dc05608ff..d3c45393f093 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -161,6 +161,120 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
 	return meta + ch_off + lun_off + chk_off;
 }
 
+static void pblk_close_chunk(struct pblk *pblk, struct ppa_addr ppa, int count)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct bio *bio;
+	struct ppa_addr *ppa_list;
+	struct nvm_rq rqd;
+	void *meta_list, *data;
+	dma_addr_t dma_meta_list, dma_ppa_list;
+	int i, rq_ppas, rq_len, ret;
+
+	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
+	if (!meta_list)
+		return;
+
+	ppa_list = meta_list + pblk_dma_meta_size(pblk);
+	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
+
+	rq_ppas = pblk_calc_secs(pblk, count, 0, false);
+	if (!rq_ppas)
+		rq_ppas = pblk->min_write_pgs;
+	rq_len = rq_ppas * geo->csecs;
+
+	data = kzalloc(rq_len, GFP_KERNEL);
+	if (!data)
+		goto free_meta_list;
+
+	memset(&rqd, 0, sizeof(struct nvm_rq));
+	rqd.opcode = NVM_OP_PWRITE;
+	rqd.nr_ppas = rq_ppas;
+	rqd.meta_list = meta_list;
+	rqd.ppa_list = ppa_list;
+	rqd.dma_ppa_list = dma_ppa_list;
+	rqd.dma_meta_list = dma_meta_list;
+
+next_rq:
+	bio = bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
+	if (IS_ERR(bio))
+		goto out_next;
+
+	bio->bi_iter.bi_sector = 0; /* artificial bio */
+	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+
+	rqd.bio = bio;
+	for (i = 0; i < rqd.nr_ppas; i++) {
+		rqd.ppa_list[i] = ppa;
+		rqd.ppa_list[i].m.sec += i;
+		pblk_get_meta(pblk, meta_list, i)->lba =
+					cpu_to_le64(ADDR_EMPTY);
+	}
+
+	ret = nvm_submit_io_sync(dev, &rqd);
+	if (ret) {
+		bio_put(bio);
+		goto out_next;
+	}
+
+	if (rqd.error)
+		goto free_data;
+
+out_next:
+	count -= rqd.nr_ppas;
+	ppa.m.sec += rqd.nr_ppas;
+	if (count > 0)
+		goto next_rq;
+
+free_data:
+	kfree(data);
+free_meta_list:
+	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
+}
+
+void pblk_close_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *meta)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct nvm_chk_meta *chunk_meta;
+	struct ppa_addr ppa;
+	int i, j, k, count;
+
+	for (i = 0; i < geo->num_chk; i++) {
+		for (j = 0; j < geo->num_lun; j++) {
+			for (k = 0; k < geo->num_ch; k++) {
+				ppa.ppa = 0;
+				ppa.m.grp = k;
+				ppa.m.pu = j;
+				ppa.m.chk = i;
+
+				chunk_meta = pblk_chunk_get_off(pblk,
+								meta, ppa);
+				if (chunk_meta->state == NVM_CHK_ST_OPEN) {
+					ppa.m.sec = chunk_meta->wp;
+					count = geo->clba - chunk_meta->wp;
+					pblk_close_chunk(pblk, ppa, count);
+				}
+			}
+		}
+	}
+}
+
+bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *meta)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	int i;
+
+	for (i = 0; i < geo->all_luns; i++) {
+		if (meta[i].state == NVM_CHK_ST_OPEN)
+			return true;
+	}
+
+	return false;
+}
+
 void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
 			   u64 paddr)
 {
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9913a4514eb6..83abe6960b46 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1028,13 +1028,14 @@ static int pblk_line_meta_init(struct pblk *pblk)
 	return 0;
 }
 
-static int pblk_lines_init(struct pblk *pblk)
+static int pblk_lines_init(struct pblk *pblk, bool factory_init)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *line;
 	void *chunk_meta;
 	int nr_free_chks = 0;
 	int i, ret;
+	bool retry = false;
 
 	ret = pblk_line_meta_init(pblk);
 	if (ret)
@@ -1048,12 +1049,21 @@ static int pblk_lines_init(struct pblk *pblk)
 	if (ret)
 		goto fail_free_meta;
 
+get_chunk_meta:
 	chunk_meta = pblk_get_chunk_meta(pblk);
 	if (IS_ERR(chunk_meta)) {
 		ret = PTR_ERR(chunk_meta);
 		goto fail_free_luns;
 	}
 
+	if (factory_init && !retry &&
+	    pblk_are_opened_chunks(pblk, chunk_meta)) {
+		pblk_close_opened_chunks(pblk, chunk_meta);
+		retry = true;
+		vfree(chunk_meta);
+		goto get_chunk_meta;
+	}
+
 	pblk->lines = kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
 								GFP_KERNEL);
 	if (!pblk->lines) {
@@ -1244,7 +1254,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		goto fail;
 	}
 
-	ret = pblk_lines_init(pblk);
+	ret = pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
 	if (ret) {
 		pblk_err(pblk, "could not initialize lines\n");
 		goto fail_free_core;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index b266563508e6..b248642c4dfb 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -793,6 +793,8 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk);
 struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
 					      struct nvm_chk_meta *lp,
 					      struct ppa_addr ppa);
+void pblk_close_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *_meta);
+bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *_meta);
 void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
-- 
2.17.1

