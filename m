Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35864 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbcKROn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:43:59 -0500
Received: by mail-wm0-f51.google.com with SMTP id g23so42645615wme.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:43:59 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 02/20] lightnvm: do not protect block 0
Date: Fri, 18 Nov 2016 15:43:24 +0100
Message-Id: <1479480222-18790-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Device blocks should be marked by the device and considered as bad
blocks by the media manager. Thus, do not make assumptions on which
blocks are going to be used by the device. In doing so we might lose
valid blocks from the free list.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 730d736..a7e17fa 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -371,12 +371,6 @@ static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
 			block->lun = &lun->vlun;
 			block->id = cur_block_id++;
 
-			/* First block is reserved for device */
-			if (unlikely(lun_iter == 0 && blk_iter == 0)) {
-				lun->vlun.nr_free_blocks--;
-				continue;
-			}
-
 			list_add_tail(&block->list, &lun->free_list);
 		}
 
-- 
2.7.4

