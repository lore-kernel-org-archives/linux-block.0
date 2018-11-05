Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44808 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeKEVqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Nov 2018 16:46:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id n19-v6so7282338edq.11
        for <linux-block@vger.kernel.org>; Mon, 05 Nov 2018 04:26:51 -0800 (PST)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 7/7] lightnvm: pblk: remove dead code in pblk_recov_l2p
Date: Mon,  5 Nov 2018 13:26:10 +0100
Message-Id: <20181105122610.1555-8-hans.ml.holmberg@owltronix.com>
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Remove the call to pblk_line_replace_data as it returns
directly as we have not set l_mg->data_next yet.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0fbd30e0a587..416d9840544b 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -805,7 +805,6 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
 							&l_mg->meta_bitmap));
 		spin_unlock(&l_mg->free_lock);
-		pblk_line_replace_data(pblk);
 	} else {
 		spin_lock(&l_mg->free_lock);
 		/* Allocate next line for preparation */
-- 
2.17.1
