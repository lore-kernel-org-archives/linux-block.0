Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36602 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeIQKzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Sep 2018 06:55:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so7096983pgo.3
        for <linux-block@vger.kernel.org>; Sun, 16 Sep 2018 22:29:59 -0700 (PDT)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org, hlitz@ucsc.edu
Cc: javier@cnexlabs.com, mb@lightnvm.io, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Subject: [RFC PATCH 4/6] lightnvm: pblk: Add pblk_submit_io_sem
Date: Sun, 16 Sep 2018 22:29:37 -0700
Message-Id: <20180917052939.4776-5-hlitz@ucsc.edu>
In-Reply-To: <20180917052939.4776-1-hlitz@ucsc.edu>
References: <20180917052939.4776-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation of supporting RAIL, add a new API pblk_submit_io_sem which
takes the lun semaphore before submitting the asynchronous request.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-core.c | 11 +++++++++++
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 2e40666fdf80..a31bf359f905 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -492,6 +492,17 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io(dev, rqd);
 }
 
+int pblk_submit_io_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
+	int ret;
+
+	pblk_down_chunk(pblk, ppa_list[0]);
+	ret = pblk_submit_io(pblk, rqd);
+
+	return ret;
+}
+
 void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 64d9c206ec52..bd88784e51d9 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -797,6 +797,7 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
 void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_sem(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
-- 
2.17.1
