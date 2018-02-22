Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52822 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBVVD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 16:03:57 -0500
Date: Thu, 22 Feb 2018 15:01:50 -0600
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
To: mb@lightnvm.io, jg@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: fix memory leak in pblk_luns_init
Message-ID: <20180222210147.GA29523@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Huaicheng Li <huaicheng@cs.uchicago.edu>
---
 drivers/lightnvm/pblk-init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 93d671ca518e..330665d91d8d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -510,6 +510,7 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 		if (ret) {
 			while (--i >= 0)
 				kfree(pblk->luns[i].bb_list);
+			kfree(pblk->luns);
 			return ret;
 		}
 	}
-- 
2.13.6
