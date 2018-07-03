Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway36.websitewelcome.com ([192.185.192.36]:30412 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752839AbeGCVlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Jul 2018 17:41:31 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E91D2400C6F09
        for <linux-block@vger.kernel.org>; Tue,  3 Jul 2018 15:22:12 -0500 (CDT)
Date: Tue, 3 Jul 2018 16:21:25 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lightnvm: pblk: mark expected switch fall-through
Message-ID: <20180703212125.GA29262@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/lightnvm/pblk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ed9cc97..9c93334 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -264,6 +264,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 	switch (type) {
 	case PBLK_WRITE:
 		kfree(((struct pblk_c_ctx *)nvm_rq_to_pdu(rqd))->lun_bitmap);
+		/* fall through */
 	case PBLK_WRITE_INT:
 		pool = &pblk->w_rq_pool;
 		break;
-- 
2.7.4
