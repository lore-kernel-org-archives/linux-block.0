Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 12/12] nbd: add a flag to destroy an nbd device on disconnect
Date: Thu,  6 Apr 2017 17:02:07 -0400
Message-Id: <1491512527-4286-13-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

For ease of management it would be nice for users to specify that the
device node for a nbd device is destroyed once it is disconnected and
there are no more users.  Add a client flag and enable this operation to
happen.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c      | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/nbd.h |  6 +++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b33014a..d220045 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -74,6 +74,7 @@ struct link_dead_args {
 #define NBD_HAS_PID_FILE		3
 #define NBD_HAS_CONFIG_REF		4
 #define NBD_BOUND			5
+#define NBD_DESTROY_ON_DISCONNECT	6
 
 struct nbd_config {
 	u32 flags;
@@ -174,6 +175,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 		del_gendisk(disk);
 		blk_cleanup_queue(disk->queue);
 		blk_mq_free_tag_set(&nbd->tag_set);
+		disk->private_data = NULL;
 		put_disk(disk);
 	}
 	kfree(nbd);
@@ -1028,6 +1030,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 			kfree(config->socks);
 		}
 		nbd_reset(nbd);
+
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
 		module_put(THIS_MODULE);
@@ -1540,6 +1543,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	struct nbd_config *config;
 	int index = -1;
 	int ret;
+	bool put_dev = false;
 
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1634,6 +1638,15 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_SERVER_FLAGS])
 		config->flags =
 			nla_get_u64(info->attrs[NBD_ATTR_SERVER_FLAGS]);
+	if (info->attrs[NBD_ATTR_CLIENT_FLAGS]) {
+		u64 flags = nla_get_u64(info->attrs[NBD_ATTR_CLIENT_FLAGS]);
+		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
+			set_bit(NBD_DESTROY_ON_DISCONNECT,
+				&config->runtime_flags);
+			put_dev = true;
+		}
+	}
+
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
 		struct nlattr *attr;
 		int rem, fd;
@@ -1671,6 +1684,8 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		nbd_connect_reply(info, nbd->index);
 	}
 	nbd_config_put(nbd);
+	if (put_dev)
+		nbd_put(nbd);
 	return ret;
 }
 
@@ -1723,6 +1738,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	struct nbd_config *config;
 	int index;
 	int ret = -EINVAL;
+	bool put_dev = false;
 
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1774,6 +1790,18 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			nla_get_u64(info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]);
 		config->dead_conn_timeout *= HZ;
 	}
+	if (info->attrs[NBD_ATTR_CLIENT_FLAGS]) {
+		u64 flags = nla_get_u64(info->attrs[NBD_ATTR_CLIENT_FLAGS]);
+		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
+			if (!test_and_set_bit(NBD_DESTROY_ON_DISCONNECT,
+					      &config->runtime_flags))
+				put_dev = true;
+		} else {
+			if (test_and_clear_bit(NBD_DESTROY_ON_DISCONNECT,
+					       &config->runtime_flags))
+				refcount_inc(&nbd->refs);
+		}
+	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
 		struct nlattr *attr;
@@ -1811,6 +1839,8 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&nbd->config_lock);
 	nbd_config_put(nbd);
 	nbd_put(nbd);
+	if (put_dev)
+		nbd_put(nbd);
 	return ret;
 }
 
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index c91c642..155e33f 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -37,7 +37,7 @@ enum {
 	NBD_CMD_TRIM = 4
 };
 
-/* values for flags field */
+/* values for flags field, these are server interaction specific. */
 #define NBD_FLAG_HAS_FLAGS	(1 << 0) /* nbd-server supports flags */
 #define NBD_FLAG_READ_ONLY	(1 << 1) /* device is read-only */
 #define NBD_FLAG_SEND_FLUSH	(1 << 2) /* can flush writeback cache */
@@ -45,6 +45,10 @@ enum {
 #define NBD_FLAG_SEND_TRIM	(1 << 5) /* send trim/discard */
 #define NBD_FLAG_CAN_MULTI_CONN	(1 << 8)	/* Server supports multiple connections per export. */
 
+/* These are client behavior specific flags. */
+#define NBD_CFLAG_DESTROY_ON_DISCONNECT	(1 << 0) /* delete the nbd device on
+						    disconnect. */
+
 /* userspace doesn't need the nbd_device structure */
 
 /* These are sent over the network in the request/reply magic fields */
-- 
2.7.4
