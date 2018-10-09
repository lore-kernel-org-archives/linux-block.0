Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38457 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbeJISbV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so679392pff.5
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:14:54 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 30/45] lightnvm: pblk: fix two sleep-in-atomic-context bugs
Date: Tue,  9 Oct 2018 13:12:00 +0200
Message-Id: <20181009111215.7653-31-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

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
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 8036c3eb6372..2526722304bb 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -966,12 +966,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
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
@@ -979,8 +981,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			l_mg->data_next->type = PBLK_LINETYPE_DATA;
 			is_next = 1;
 		}
+		spin_unlock(&l_mg->free_lock);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	if (is_next)
 		pblk_line_erase(pblk, l_mg->data_next);
-- 
2.17.1
