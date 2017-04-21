Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35978 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426670AbdDUXdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 19:33:04 -0400
Received: by mail-wm0-f41.google.com with SMTP id o81so25767224wmb.1
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 16:33:03 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/5] lightnvm: pblk: fix memory leak on error path
Date: Sat, 22 Apr 2017 01:32:47 +0200
Message-Id: <1492817569-13532-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When write recovery fails, Free memory for the recovery structure.

Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 74f7413..a896190 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -142,6 +142,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 		/* Logic error */
 		if (bit > c_ctx->nr_valid) {
 			WARN_ONCE(1, "pblk: corrupted write request\n");
+			mempool_free(recovery, pblk->rec_pool);
 			goto out;
 		}
 
@@ -149,6 +150,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 		entry = pblk_rb_sync_scan_entry(&pblk->rwb, &ppa);
 		if (!entry) {
 			pr_err("pblk: could not scan entry on write failure\n");
+			mempool_free(recovery, pblk->rec_pool);
 			goto out;
 		}
 
@@ -162,6 +164,7 @@ static void pblk_end_w_fail(struct pblk *pblk, struct nvm_rq *rqd)
 	ret = pblk_recov_setup_rq(pblk, c_ctx, recovery, comp_bits, c_entries);
 	if (ret) {
 		pr_err("pblk: could not recover from write failure\n");
+		mempool_free(recovery, pblk->rec_pool);
 		goto out;
 	}
 
-- 
2.7.4
