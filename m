Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33989 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756402AbcJ0OuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 10:50:04 -0400
Received: by mail-wm0-f52.google.com with SMTP id 140so5599041wmv.1
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 07:50:03 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/7] lightnvm: do not decide on device blocks
Date: Thu, 27 Oct 2016 16:49:38 +0200
Message-Id: <1477579783-5289-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
References: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
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

