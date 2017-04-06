Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 10/12] nbd: add a status netlink command
Date: Thu,  6 Apr 2017 17:02:05 -0400
Message-Id: <1491512527-4286-11-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

Allow users to query the status of existing nbd devices.  Right now this
only returns whether or not the device is connected, but could be
extended in the future to include more information.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c              | 108 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nbd-netlink.h |  25 +++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fd3d535..e1289d0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -45,6 +45,7 @@
 
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
+static int nbd_total_devices = 0;
 
 struct nbd_sock {
 	struct socket *sock;
@@ -130,6 +131,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
 static void nbd_config_put(struct nbd_device *nbd);
 static void nbd_connect_reply(struct genl_info *info, int index);
+static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info);
 static void nbd_dead_link_work(struct work_struct *work);
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
@@ -1458,6 +1460,7 @@ static int nbd_dev_add(int index)
 	sprintf(disk->disk_name, "nbd%d", index);
 	nbd_reset(nbd);
 	add_disk(disk);
+	nbd_total_devices++;
 	return index;
 
 out_free_tags:
@@ -1494,12 +1497,22 @@ static struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_CLIENT_FLAGS]		=	{ .type = NLA_U64 },
 	[NBD_ATTR_SOCKETS]		=	{ .type = NLA_NESTED},
 	[NBD_ATTR_DEAD_CONN_TIMEOUT]	=	{ .type = NLA_U64 },
+	[NBD_ATTR_DEVICE_LIST]		=	{ .type = NLA_NESTED},
 };
 
 static struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
 	[NBD_SOCK_FD]			=	{ .type = NLA_U32 },
 };
 
+/* We don't use this right now since we don't parse the incoming list, but we
+ * still want it here so userspace knows what to expect.
+ */
+static struct nla_policy __attribute__((unused))
+nbd_device_policy[NBD_DEVICE_ATTR_MAX + 1] = {
+	[NBD_DEVICE_INDEX]		=	{ .type = NLA_U32 },
+	[NBD_DEVICE_CONNECTED]		=	{ .type = NLA_U8 },
+};
+
 static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nbd_device *nbd = NULL;
@@ -1765,6 +1778,11 @@ static const struct genl_ops nbd_connect_genl_ops[] = {
 		.policy	= nbd_attr_policy,
 		.doit	= nbd_genl_reconfigure,
 	},
+	{
+		.cmd	= NBD_CMD_STATUS,
+		.policy	= nbd_attr_policy,
+		.doit	= nbd_genl_status,
+	},
 };
 
 static const struct genl_multicast_group nbd_mcast_grps[] = {
@@ -1783,6 +1801,96 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
 };
 
+static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
+{
+	struct nlattr *dev_opt;
+	u8 connected = 0;
+	int ret;
+
+	/* This is a little racey, but for status it's ok.  The
+	 * reason we don't take a ref here is because we can't
+	 * take a ref in the index == -1 case as we would need
+	 * to put under the nbd_index_mutex, which could
+	 * deadlock if we are configured to remove ourselves
+	 * once we're disconnected.
+	 */
+	if (refcount_read(&nbd->config_refs))
+		connected = 1;
+	dev_opt = nla_nest_start(reply, NBD_DEVICE_ITEM);
+	if (!dev_opt)
+		return -EMSGSIZE;
+	ret = nla_put_u32(reply, NBD_DEVICE_INDEX, nbd->index);
+	if (ret)
+		return -EMSGSIZE;
+	ret = nla_put_u8(reply, NBD_DEVICE_CONNECTED,
+			 connected);
+	if (ret)
+		return -EMSGSIZE;
+	nla_nest_end(reply, dev_opt);
+	return 0;
+}
+
+static int status_cb(int id, void *ptr, void *data)
+{
+	struct nbd_device *nbd = ptr;
+	return populate_nbd_status(nbd, (struct sk_buff *)data);
+}
+
+static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *dev_list;
+	struct sk_buff *reply;
+	void *reply_head;
+	size_t msg_size;
+	int index = -1;
+	int ret = -ENOMEM;
+
+	if (info->attrs[NBD_ATTR_INDEX])
+		index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
+
+	mutex_lock(&nbd_index_mutex);
+
+	msg_size = nla_total_size(nla_attr_size(sizeof(u32)) +
+				  nla_attr_size(sizeof(u8)));
+	msg_size *= (index == -1) ? nbd_total_devices : 1;
+
+	reply = genlmsg_new(msg_size, GFP_KERNEL);
+	if (!reply)
+		goto out;
+	reply_head = genlmsg_put_reply(reply, info, &nbd_genl_family, 0,
+				       NBD_CMD_STATUS);
+	if (!reply_head) {
+		nlmsg_free(reply);
+		goto out;
+	}
+
+	dev_list = nla_nest_start(reply, NBD_ATTR_DEVICE_LIST);
+	if (index == -1) {
+		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
+		if (ret) {
+			nlmsg_free(reply);
+			goto out;
+		}
+	} else {
+		struct nbd_device *nbd;
+		nbd = idr_find(&nbd_index_idr, index);
+		if (nbd) {
+			ret = populate_nbd_status(nbd, reply);
+			if (ret) {
+				nlmsg_free(reply);
+				goto out;
+			}
+		}
+	}
+	nla_nest_end(reply, dev_list);
+	genlmsg_end(reply, reply_head);
+	genlmsg_reply(reply, info);
+	ret = 0;
+out:
+	mutex_unlock(&nbd_index_mutex);
+	return ret;
+}
+
 static void nbd_connect_reply(struct genl_info *info, int index)
 {
 	struct sk_buff *skb;
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netlink.h
index c2209c75..6f7ca3d 100644
--- a/include/uapi/linux/nbd-netlink.h
+++ b/include/uapi/linux/nbd-netlink.h
@@ -33,11 +33,35 @@ enum {
 	NBD_ATTR_CLIENT_FLAGS,
 	NBD_ATTR_SOCKETS,
 	NBD_ATTR_DEAD_CONN_TIMEOUT,
+	NBD_ATTR_DEVICE_LIST,
 	__NBD_ATTR_MAX,
 };
 #define NBD_ATTR_MAX (__NBD_ATTR_MAX - 1)
 
 /*
+ * This is the format for multiple devices with NBD_ATTR_DEVICE_LIST
+ *
+ * [NBD_ATTR_DEVICE_LIST]
+ *   [NBD_DEVICE_ITEM]
+ *     [NBD_DEVICE_INDEX]
+ *     [NBD_DEVICE_CONNECTED]
+ */
+enum {
+	NBD_DEVICE_ITEM_UNSPEC,
+	NBD_DEVICE_ITEM,
+	__NBD_DEVICE_ITEM_MAX,
+};
+#define NBD_DEVICE_ITEM_MAX (__NBD_DEVICE_ITEM_MAX - 1)
+
+enum {
+	NBD_DEVICE_UNSPEC,
+	NBD_DEVICE_INDEX,
+	NBD_DEVICE_CONNECTED,
+	__NBD_DEVICE_MAX,
+};
+#define NBD_DEVICE_ATTR_MAX (__NBD_DEVICE_MAX - 1)
+
+/*
  * This is the format for multiple sockets with NBD_ATTR_SOCKETS
  *
  * [NBD_ATTR_SOCKETS]
@@ -66,6 +90,7 @@ enum {
 	NBD_CMD_DISCONNECT,
 	NBD_CMD_RECONFIGURE,
 	NBD_CMD_LINK_DEAD,
+	NBD_CMD_STATUS,
 	__NBD_CMD_MAX,
 };
 #define NBD_CMD_MAX	(__NBD_CMD_MAX - 1)
-- 
2.7.4
