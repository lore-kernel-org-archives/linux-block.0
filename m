Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:52681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932159AbdJUSz0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Oct 2017 14:55:26 -0400
To: linux-block@vger.kernel.org, nbd@other.debian.org,
        Josef Bacik <jbacik@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] nbd: Use common error handling code in nbd_genl_connect()
Message-ID: <110a7553-d57c-6a77-a9f7-fdee43a60195@users.sourceforge.net>
Date: Sat, 21 Oct 2017 20:55:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Oct 2017 20:50:37 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/nbd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 883dfebd3014..05bd1fc70ee3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1585,22 +1585,18 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		if (ret == 0) {
 			int new_index;
 			new_index = nbd_dev_add(-1);
-			if (new_index < 0) {
-				mutex_unlock(&nbd_index_mutex);
-				printk(KERN_ERR "nbd: failed to add new device\n");
-				return ret;
-			}
+			if (new_index < 0)
+				goto report_failure;
+
 			nbd = idr_find(&nbd_index_idr, new_index);
 		}
 	} else {
 		nbd = idr_find(&nbd_index_idr, index);
 		if (!nbd) {
 			ret = nbd_dev_add(index);
-			if (ret < 0) {
-				mutex_unlock(&nbd_index_mutex);
-				printk(KERN_ERR "nbd: failed to add new device\n");
-				return ret;
-			}
+			if (ret < 0)
+				goto report_failure;
+
 			nbd = idr_find(&nbd_index_idr, index);
 		}
 	}
@@ -1716,6 +1712,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (put_dev)
 		nbd_put(nbd);
 	return ret;
+
+report_failure:
+	mutex_unlock(&nbd_index_mutex);
+	pr_err("nbd: failed to add new device\n");
+	return ret;
 }
 
 static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
-- 
2.14.2
