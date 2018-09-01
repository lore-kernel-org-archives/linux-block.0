Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36736 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIAQFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Sep 2018 12:05:12 -0400
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in pblk_line_submit_smeta_io()
Date: Sat,  1 Sep 2018 19:53:18 +0800
Message-Id: <20180901115318.30416-1-baijiaju1990@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 754: 
	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048: 
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434: 
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980: 
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976: 
	spin_lock in pblk_recov_l2p

[FUNC] bio_map_kern(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 762: 
	bio_map_kern in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048: 
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434: 
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980: 
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976: 
	spin_lock in pblk_recov_l2p

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/lightnvm/pblk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ed9cc977c8b3..5d915c93b6cf 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_ATOMIC,
 							&rqd.dma_meta_list);
 	if (!rqd.meta_list)
 		return -ENOMEM;
@@ -810,7 +810,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
 	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
 
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
+	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_ATOMIC);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto free_ppa_list;
-- 
2.17.0
