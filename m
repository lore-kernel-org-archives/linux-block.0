Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:33610 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbeKEVBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Nov 2018 16:01:33 -0500
Received: by mail-it1-f196.google.com with SMTP id p11-v6so7500018itf.0
        for <linux-block@vger.kernel.org>; Mon, 05 Nov 2018 03:42:14 -0800 (PST)
From: Hans Holmberg <hans@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 7/7] lightnvm: pblk: remove dead code in pblk_recov_l2p
Date: Mon,  5 Nov 2018 12:41:13 +0100
Message-Id: <20181105114113.30932-8-hans.ml.holmberg@cnexlabs.com>
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

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
