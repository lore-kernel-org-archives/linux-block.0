Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35906 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755535AbcK1Vjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:42 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so21231273wma.3
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:41 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 04/23] lightnvm: do not protect block 0
Date: Mon, 28 Nov 2016 22:38:55 +0100
Message-Id: <20161128213914.12516-5-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
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
2.9.3

