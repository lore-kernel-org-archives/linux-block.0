Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.182]:42080 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757598AbdEWWh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 18:37:58 -0400
Received: from cm2.websitewelcome.com (cm2.websitewelcome.com [192.185.178.13])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id C421186F361
        for <linux-block@vger.kernel.org>; Tue, 23 May 2017 17:13:49 -0500 (CDT)
Date: Tue, 23 May 2017 17:13:47 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, nbd-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] block: fix potential null pointer dereference
Message-ID: <20170523221347.GA11184@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add null check before dereferencing pointer dev_list inside
function nla_nest_end() at line 1968: nla_nest_end(reply, dev_list);

Addresses-Coverity-ID: 1408827
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 9a7bb2c..6006de5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1948,6 +1948,9 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list)
+		goto out;
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.5.0
