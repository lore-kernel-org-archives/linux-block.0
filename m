Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32969 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755581AbcK1Vjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:48 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so15789241wjc.0
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:48 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 12/23] lightnvm: use constant name instead of value
Date: Mon, 28 Nov 2016 22:39:03 +0100
Message-Id: <20161128213914.12516-13-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

There is a constant to refer to free blocks. Use it when marking bad
blocks instead of using a constant value

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index e969e3a..aee5b72 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -279,7 +279,7 @@ static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 	lun = &gn->luns[(dev->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
 
 	for (i = 0; i < nr_blks; i++) {
-		if (blks[i] == 0)
+		if (blks[i] == NVM_BLK_T_FREE)
 			continue;
 
 		blk = &lun->vlun.blocks[i];
-- 
2.9.3

