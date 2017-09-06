Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38507 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbdIFKwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 06:52:41 -0400
Received: by mail-wm0-f51.google.com with SMTP id 187so29402962wmn.1
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 03:52:40 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 04/18] lightnvm: pblk: check for failed mempool alloc.
Date: Wed,  6 Sep 2017 12:50:57 +0200
Message-Id: <1504695071-25928-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Check for failed mempool allocations and act accordingly.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e3997abdf740..11a684162a5d 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -165,6 +165,8 @@ struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int rw)
 	}
 
 	rqd = mempool_alloc(pool, GFP_KERNEL);
+	if (!rqd)
+		return NULL;
 	memset(rqd, 0, rq_size);
 
 	return rqd;
@@ -1478,6 +1480,8 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	int err;
 
 	rqd = mempool_alloc(pblk->g_rq_pool, GFP_KERNEL);
+	if (!rqd)
+		return -ENOMEM;
 	memset(rqd, 0, pblk_g_rq_size);
 
 	pblk_setup_e_rq(pblk, rqd, ppa);
-- 
2.7.4
