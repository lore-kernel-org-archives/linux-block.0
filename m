Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] nbd: allow device creation at a specific index
Date: Mon, 14 Aug 2017 18:25:33 +0000
Message-Id: <1502735133-15841-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

If users really want to use a particular index for their nbd device and it
doesn't already exist there's no reason we can't just create it for them.  Do
this instead of erroring out.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5bdf923..d816ae7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1584,6 +1584,15 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		}
 	} else {
 		nbd = idr_find(&nbd_index_idr, index);
+		if (!nbd) {
+			ret = nbd_dev_add(index);
+			if (ret < 0) {
+				mutex_unlock(&nbd_index_mutex);
+				printk(KERN_ERR "nbd: failed to add new device\n");
+				return ret;
+			}
+			nbd = idr_find(&nbd_index_idr, index);
+		}
 	}
 	if (!nbd) {
 		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
-- 
2.9.5
