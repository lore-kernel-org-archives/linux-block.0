Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIENJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Sep 2018 09:09:36 -0400
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: mb@lightnvm.io, javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two sleep-in-atomic-context bugs
Date: Wed,  5 Sep 2018 16:40:17 +0800
Message-Id: <20180905084017.27593-1-baijiaju1990@gmail.com>
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

To fix these bugs, the call to pblk_line_replace_data() 
is moved out of the spinlock protection.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Move the call to pblk_line_replace_data() out of the spinlock 
  protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
  the calls to bio_map_kern() and nvm_dev_dma_alloc().
  Thanks Javier for good advice.
---
 drivers/lightnvm/pblk-recovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3a5069183859..5fde414d78bb 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		}
 	}
 
-	spin_lock(&l_mg->free_lock);
 	if (!open_lines) {
+		spin_lock(&l_mg->free_lock);
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
 							&l_mg->meta_bitmap));
+		spin_unlock(&l_mg->free_lock);
 		pblk_line_replace_data(pblk);
 	} else {
+		spin_lock(&l_mg->free_lock);
 		/* Allocate next line for preparation */
 		l_mg->data_next = pblk_line_get(pblk);
 		if (l_mg->data_next) {
@@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			l_mg->data_next->type = PBLK_LINETYPE_DATA;
 			is_next = 1;
 		}
+		spin_unlock(&l_mg->free_lock);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	if (is_next)
 		pblk_line_erase(pblk, l_mg->data_next);
-- 
2.17.0
