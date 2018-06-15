Return-Path: <prvs=970446e0dd=doronrk@fb.com>
From: Doron Roberts-Kedes <doronrk@fb.com>
To: <linux-block@vger.kernel.org>
CC: <josef@toxicpanda.com>, <axboe@kernel.dk>,
        Doron Roberts-Kedes
	<doronrk@fb.com>
Subject: [PATCH] nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.
Date: Fri, 15 Jun 2018 14:05:32 -0700
Message-ID: <20180615210532.499516-1-doronrk@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If NBD_DISCONNECT_ON_CLOSE is set on a device, then the driver will
issue a disconnect from nbd_release if the device has no remaining
bdev->bd_openers.

Fix ret val so reconfigure with only setting the flag succeeds.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
---
 drivers/block/nbd.c      | 42 ++++++++++++++++++++++++++++++++++--------
 include/uapi/linux/nbd.h |  3 +++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3ed1ef8..ee27a25 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -76,6 +76,7 @@ struct link_dead_args {
 #define NBD_HAS_CONFIG_REF		4
 #define NBD_BOUND			5
 #define NBD_DESTROY_ON_DISCONNECT	6
+#define NBD_DISCONNECT_ON_CLOSE 	7
 
 struct nbd_config {
 	u32 flags;
@@ -138,6 +139,7 @@ static void nbd_config_put(struct nbd_device *nbd);
 static void nbd_connect_reply(struct genl_info *info, int index);
 static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info);
 static void nbd_dead_link_work(struct work_struct *work);
+static void nbd_disconnect_and_put(struct nbd_device *nbd);
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -1303,6 +1305,12 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 static void nbd_release(struct gendisk *disk, fmode_t mode)
 {
 	struct nbd_device *nbd = disk->private_data;
+	struct block_device *bdev = bdget_disk(disk, 0);
+
+	if (test_bit(NBD_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
+			bdev->bd_openers == 0)
+		nbd_disconnect_and_put(nbd);
+
 	nbd_config_put(nbd);
 	nbd_put(nbd);
 }
@@ -1702,6 +1710,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 				&config->runtime_flags);
 			put_dev = true;
 		}
+		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
+			set_bit(NBD_DISCONNECT_ON_CLOSE,
+				&config->runtime_flags);
+		}
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
@@ -1746,6 +1758,17 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static void nbd_disconnect_and_put(struct nbd_device *nbd)
+{
+	mutex_lock(&nbd->config_lock);
+	nbd_disconnect(nbd);
+	nbd_clear_sock(nbd);
+	mutex_unlock(&nbd->config_lock);
+	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
+			       &nbd->config->runtime_flags))
+		nbd_config_put(nbd);
+}
+
 static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nbd_device *nbd;
@@ -1778,13 +1801,7 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 		nbd_put(nbd);
 		return 0;
 	}
-	mutex_lock(&nbd->config_lock);
-	nbd_disconnect(nbd);
-	nbd_clear_sock(nbd);
-	mutex_unlock(&nbd->config_lock);
-	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
-			       &nbd->config->runtime_flags))
-		nbd_config_put(nbd);
+	nbd_disconnect_and_put(nbd);
 	nbd_config_put(nbd);
 	nbd_put(nbd);
 	return 0;
@@ -1795,7 +1812,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	struct nbd_device *nbd = NULL;
 	struct nbd_config *config;
 	int index;
-	int ret = -EINVAL;
+	int ret = 0;
 	bool put_dev = false;
 
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
@@ -1835,6 +1852,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	    !nbd->task_recv) {
 		dev_err(nbd_to_dev(nbd),
 			"not configured, cannot reconfigure\n");
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -1859,6 +1877,14 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 					       &config->runtime_flags))
 				refcount_inc(&nbd->refs);
 		}
+
+		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
+			set_bit(NBD_DISCONNECT_ON_CLOSE,
+					&config->runtime_flags);
+		} else {
+			clear_bit(NBD_DISCONNECT_ON_CLOSE,
+					&config->runtime_flags);
+		}
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 85a3fb6..20d6cc9 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -53,6 +53,9 @@ enum {
 /* These are client behavior specific flags. */
 #define NBD_CFLAG_DESTROY_ON_DISCONNECT	(1 << 0) /* delete the nbd device on
 						    disconnect. */
+#define NBD_CFLAG_DISCONNECT_ON_CLOSE (1 << 1) /* disconnect the nbd device on
+						*  close by last opener.
+						*/
 
 /* userspace doesn't need the nbd_device structure */
 
-- 
2.9.5
