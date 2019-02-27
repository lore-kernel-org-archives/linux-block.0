Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EFBC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202BB2183F
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfB0RSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:18:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:25365 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RSN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:18:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129819551"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 09:18:11 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 10/13] lightnvm: pblk: Reduce L2P DRAM footprint
Date:   Wed, 27 Feb 2019 18:14:39 +0100
Message-Id: <20190227171442.11853-11-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190227171442.11853-1-igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently L2P map size is calculated based on
the total number of available sectors, which is
redundant, since it contains some number of
over provisioning (11% by default).

The goal of this patch is to change this size
to the real capacity and thus reduce the DRAM
footprint significantly - with default op value
it is approx. 110MB of DRAM less for every 1TB
of pblk drive.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     | 8 ++++----
 drivers/lightnvm/pblk-init.c     | 7 +++----
 drivers/lightnvm/pblk-read.c     | 2 +-
 drivers/lightnvm/pblk-recovery.c | 2 +-
 drivers/lightnvm/pblk.h          | 1 -
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index f48f2e77f770..2e424c0275c1 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -2024,7 +2024,7 @@ void pblk_update_map(struct pblk *pblk, sector_t lba, struct ppa_addr ppa)
 	struct ppa_addr ppa_l2p;
 
 	/* logic error: lba out-of-bounds. Ignore update */
-	if (!(lba < pblk->rl.nr_secs)) {
+	if (!(lba < pblk->capacity)) {
 		WARN(1, "pblk: corrupted L2P map request\n");
 		return;
 	}
@@ -2064,7 +2064,7 @@ int pblk_update_map_gc(struct pblk *pblk, sector_t lba, struct ppa_addr ppa_new,
 #endif
 
 	/* logic error: lba out-of-bounds. Ignore update */
-	if (!(lba < pblk->rl.nr_secs)) {
+	if (!(lba < pblk->capacity)) {
 		WARN(1, "pblk: corrupted L2P map request\n");
 		return 0;
 	}
@@ -2110,7 +2110,7 @@ void pblk_update_map_dev(struct pblk *pblk, sector_t lba,
 	}
 
 	/* logic error: lba out-of-bounds. Ignore update */
-	if (!(lba < pblk->rl.nr_secs)) {
+	if (!(lba < pblk->capacity)) {
 		WARN(1, "pblk: corrupted L2P map request\n");
 		return;
 	}
@@ -2168,7 +2168,7 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
 		lba = lba_list[i];
 		if (lba != ADDR_EMPTY) {
 			/* logic error: lba out-of-bounds. Ignore update */
-			if (!(lba < pblk->rl.nr_secs)) {
+			if (!(lba < pblk->capacity)) {
 				WARN(1, "pblk: corrupted L2P map request\n");
 				continue;
 			}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e553105b7ba1..9913a4514eb6 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -105,7 +105,7 @@ static size_t pblk_trans_map_size(struct pblk *pblk)
 	if (pblk->addrf_len < 32)
 		entry_size = 4;
 
-	return entry_size * pblk->rl.nr_secs;
+	return entry_size * pblk->capacity;
 }
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -175,7 +175,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 
 	pblk_ppa_set_empty(&ppa);
 
-	for (i = 0; i < pblk->rl.nr_secs; i++)
+	for (i = 0; i < pblk->capacity; i++)
 		pblk_trans_map_set(pblk, i, ppa);
 
 	ret = pblk_l2p_recover(pblk, factory_init);
@@ -706,7 +706,6 @@ static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
 	 * on user capacity consider only provisioned blocks
 	 */
 	pblk->rl.total_blocks = nr_free_chks;
-	pblk->rl.nr_secs = nr_free_chks * geo->clba;
 
 	/* Consider sectors used for metadata */
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
@@ -1289,7 +1288,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 
 	pblk_info(pblk, "luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
 			geo->all_luns, pblk->l_mg.nr_lines,
-			(unsigned long long)pblk->rl.nr_secs,
+			(unsigned long long)pblk->capacity,
 			pblk->rwb.nr_entries);
 
 	wake_up_process(pblk->writer_ts);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 39c1d6ccaedb..65697463def8 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -561,7 +561,7 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 		goto out;
 
 	/* logic error: lba out-of-bounds */
-	if (lba >= pblk->rl.nr_secs) {
+	if (lba >= pblk->capacity) {
 		WARN(1, "pblk: read lba out of bounds\n");
 		goto out;
 	}
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index d86f580036d3..83b467b5edc7 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -474,7 +474,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 		lba_list[paddr++] = cpu_to_le64(lba);
 
-		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
+		if (lba == ADDR_EMPTY || lba >= pblk->capacity)
 			continue;
 
 		line->nr_valid_lbas++;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a6386d5acd73..a92377530930 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -305,7 +305,6 @@ struct pblk_rl {
 
 	struct timer_list u_timer;
 
-	unsigned long long nr_secs;
 	unsigned long total_blocks;
 
 	atomic_t free_blocks;		/* Total number of free blocks (+ OP) */
-- 
2.17.1

