Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35862 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935747AbcJ0SBw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 14:01:52 -0400
Received: by mail-lf0-f49.google.com with SMTP id b75so38485502lfg.3
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 11:01:51 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/7] lightnvm: do not decide on device blocks
Date: Thu, 27 Oct 2016 20:01:34 +0200
Message-Id: <1477591299-26504-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
References: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Device blocks should be marked by the device and considered as bad
blocks by the media manager. Thus, do not make assumptions on which
blocks are going to be used by the device. In doing so we might lose
valid blocks from the free list.

Signed-off-by: Javier González <javier@cnexlabs.com>
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

