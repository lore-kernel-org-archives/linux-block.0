Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38774 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbeJYJO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Oct 2018 05:14:29 -0400
From: Zhoujie Wu <zjwu@marvell.com>
To: <mb@lightnvm.io>, <javier@cnexlabs.com>,
        <linux-block@vger.kernel.org>
CC: <hongd@marvell.com>, Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH] lightnvm: pblk: ignore the smeta oob area scan
Date: Wed, 24 Oct 2018 17:46:44 -0700
Message-ID: <1540428404-30196-1-git-send-email-zjwu@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The smeta area l2p mapping is empty, and actually the
recovery procedure only need to restore data sector's l2p
mapping. So ignore the smeta oob scan.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
 drivers/lightnvm/pblk-recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 5740b75..30f2616 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -334,6 +334,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 			       struct pblk_recov_alloc p)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
 	struct pblk_sec_meta *meta_list;
@@ -342,12 +343,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	__le64 *lba_list;
-	u64 paddr = 0;
+	u64 paddr = lm->smeta_sec;
 	bool padded = false;
 	int rq_ppas, rq_len;
 	int i, j;
 	int ret;
-	u64 left_ppas = pblk_sec_in_open_line(pblk, line);
+	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
 
 	if (pblk_line_wp_is_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
-- 
1.9.1
