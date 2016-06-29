Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35394 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbcF2OmX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 10:42:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so14847123wme.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2016 07:42:17 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 09/11] lightnvm: fix lun offset calculation for mark blk
Date: Wed, 29 Jun 2016 16:41:54 +0200
Message-Id: <1467211316-22373-10-git-send-email-m@bjorling.me>
In-Reply-To: <1467211316-22373-1-git-send-email-m@bjorling.me>
References: <1467211316-22373-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The gen_mark_blk_bad function marks the wrong block when a block is on
a different channel. Fix the index calculation, so that it updates the
correct block.

Reported-by: Javier Gonzalez <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index c65fb67..b74174c 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -542,7 +542,7 @@ static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 		return;
 	}
 
-	lun = &gn->luns[ppa.g.lun * ppa.g.ch];
+	lun = &gn->luns[(dev->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
 	blk = &lun->vlun.blocks[ppa.g.blk];
 
 	/* will be moved to bb list on put_blk from target */
-- 
2.1.4

