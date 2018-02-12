Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.5]:48465 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753227AbeBLRfG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Feb 2018 12:35:06 -0500
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 8E603ED4F
        for <linux-block@vger.kernel.org>; Mon, 12 Feb 2018 11:15:05 -0600 (CST)
Date: Mon, 12 Feb 2018 11:14:55 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] nbd: fix return value in error handling path
Message-ID: <20180212171450.GA31668@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It seems that the proper value to return in this particular case is the
one contained into variable new_index instead of ret.

Addresses-Coverity-ID: 1465148 ("Copy-paste error")
Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5f2a424..86258b0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1591,7 +1591,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			if (new_index < 0) {
 				mutex_unlock(&nbd_index_mutex);
 				printk(KERN_ERR "nbd: failed to add new device\n");
-				return ret;
+				return new_index;
 			}
 			nbd = idr_find(&nbd_index_idr, new_index);
 		}
-- 
2.7.4
