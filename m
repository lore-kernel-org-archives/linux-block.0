Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 07/12] nbd: multicast dead link notifications
Date: Thu,  6 Apr 2017 17:02:02 -0400
Message-Id: <1491512527-4286-8-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

Provide a mechanism to notify userspace that there's been a link problem
on a NBD device.  This will allow userspace to re-establish a connection
and provide the new socket to the device without disrupting the device.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c              | 89 ++++++++++++++++++++++++++++++++++------
 include/uapi/linux/nbd-netlink.h |  6 ++-
 2 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 27958c3..911e36c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -53,6 +53,7 @@ struct nbd_sock {
 	int sent;
 	bool dead;
 	int fallback_index;
+	int cookie;
 };
 
 struct recv_thread_args {
@@ -61,6 +62,11 @@ struct recv_thread_args {
 	int index;
 };
 
+struct link_dead_args {
+	struct work_struct work;
+	int index;
+};
+
 #define NBD_TIMEDOUT			0
 #define NBD_DISCONNECT_REQUESTED	1
 #define NBD_DISCONNECTED		2
@@ -100,6 +106,7 @@ struct nbd_device {
 struct nbd_cmd {
 	struct nbd_device *nbd;
 	int index;
+	int cookie;
 	struct completion send_complete;
 };
 
@@ -120,6 +127,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
 static void nbd_config_put(struct nbd_device *nbd);
 static void nbd_connect_reply(struct genl_info *info, int index);
+static void nbd_dead_link_work(struct work_struct *work);
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -152,8 +160,24 @@ static struct device_attribute pid_attr = {
 	.show = pid_show,
 };
 
-static void nbd_mark_nsock_dead(struct nbd_sock *nsock)
+static int nbd_disconnected(struct nbd_config *config)
+{
+	return test_bit(NBD_DISCONNECTED, &config->runtime_flags) ||
+		test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
+}
+
+static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
+				int notify)
 {
+	if (!nsock->dead && notify && !nbd_disconnected(nbd->config)) {
+		struct link_dead_args *args;
+		args = kmalloc(sizeof(struct link_dead_args), GFP_NOIO);
+		if (args) {
+			INIT_WORK(&args->work, nbd_dead_link_work);
+			args->index = nbd->index;
+			queue_work(system_wq, &args->work);
+		}
+	}
 	if (!nsock->dead)
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
 	nsock->dead = true;
@@ -215,8 +239,7 @@ static void sock_shutdown(struct nbd_device *nbd)
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 		mutex_lock(&nsock->tx_lock);
-		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
-		nbd_mark_nsock_dead(nsock);
+		nbd_mark_nsock_dead(nbd, nsock, 0);
 		mutex_unlock(&nsock->tx_lock);
 	}
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
@@ -248,7 +271,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 				struct nbd_sock *nsock =
 					config->socks[cmd->index];
 				mutex_lock(&nsock->tx_lock);
-				nbd_mark_nsock_dead(nsock);
+				/* We can have multiple outstanding requests, so
+				 * we don't want to mark the nsock dead if we've
+				 * already reconnected with a new socket, so
+				 * only mark it dead if its the same socket we
+				 * were sent out on.
+				 */
+				if (cmd->cookie == nsock->cookie)
+					nbd_mark_nsock_dead(nbd, nsock, 1);
 				mutex_unlock(&nsock->tx_lock);
 			}
 			blk_mq_requeue_request(req, true);
@@ -370,6 +400,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		iov_iter_advance(&from, sent);
 	}
 	cmd->index = index;
+	cmd->cookie = nsock->cookie;
 	request.type = htonl(type);
 	if (type != NBD_CMD_FLUSH) {
 		request.from = cpu_to_be64((u64)blk_rq_pos(req) << 9);
@@ -458,12 +489,6 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	return 0;
 }
 
-static int nbd_disconnected(struct nbd_config *config)
-{
-	return test_bit(NBD_DISCONNECTED, &config->runtime_flags) ||
-		test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
-}
-
 /* NULL returned = something went wrong, inform userspace */
 static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 {
@@ -564,7 +589,7 @@ static void recv_work(struct work_struct *work)
 			struct nbd_sock *nsock = config->socks[args->index];
 
 			mutex_lock(&nsock->tx_lock);
-			nbd_mark_nsock_dead(nsock);
+			nbd_mark_nsock_dead(nbd, nsock, 1);
 			mutex_unlock(&nsock->tx_lock);
 			ret = PTR_ERR(cmd);
 			break;
@@ -691,7 +716,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (ret == -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Request send failed trying another connection\n");
-		nbd_mark_nsock_dead(nsock);
+		nbd_mark_nsock_dead(nbd, nsock, 1);
 		mutex_unlock(&nsock->tx_lock);
 		goto again;
 	}
@@ -780,6 +805,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	nsock->sock = sock;
 	nsock->pending = NULL;
 	nsock->sent = 0;
+	nsock->cookie = 0;
 	socks[config->num_connections++] = nsock;
 
 	return 0;
@@ -824,6 +850,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		INIT_WORK(&args->work, recv_work);
 		args->index = i;
 		args->nbd = nbd;
+		nsock->cookie++;
 		mutex_unlock(&nsock->tx_lock);
 		sockfd_put(old);
 
@@ -1683,6 +1710,10 @@ static const struct genl_ops nbd_connect_genl_ops[] = {
 	},
 };
 
+static const struct genl_multicast_group nbd_mcast_grps[] = {
+	{ .name = NBD_GENL_MCAST_GROUP_NAME, },
+};
+
 static struct genl_family nbd_genl_family __ro_after_init = {
 	.hdrsize	= 0,
 	.name		= NBD_GENL_FAMILY_NAME,
@@ -1691,6 +1722,8 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.ops		= nbd_connect_genl_ops,
 	.n_ops		= ARRAY_SIZE(nbd_connect_genl_ops),
 	.maxattr	= NBD_ATTR_MAX,
+	.mcgrps		= nbd_mcast_grps,
+	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
 };
 
 static void nbd_connect_reply(struct genl_info *info, int index)
@@ -1717,6 +1750,38 @@ static void nbd_connect_reply(struct genl_info *info, int index)
 	genlmsg_reply(skb, info);
 }
 
+static void nbd_mcast_index(int index)
+{
+	struct sk_buff *skb;
+	void *msg_head;
+	int ret;
+
+	skb = genlmsg_new(nla_total_size(sizeof(u32)), GFP_KERNEL);
+	if (!skb)
+		return;
+	msg_head = genlmsg_put(skb, 0, 0, &nbd_genl_family, 0,
+				     NBD_CMD_LINK_DEAD);
+	if (!msg_head) {
+		nlmsg_free(skb);
+		return;
+	}
+	ret = nla_put_u32(skb, NBD_ATTR_INDEX, index);
+	if (ret) {
+		nlmsg_free(skb);
+		return;
+	}
+	genlmsg_end(skb, msg_head);
+	genlmsg_multicast(&nbd_genl_family, skb, 0, 0, GFP_KERNEL);
+}
+
+static void nbd_dead_link_work(struct work_struct *work)
+{
+	struct link_dead_args *args = container_of(work, struct link_dead_args,
+						   work);
+	nbd_mcast_index(args->index);
+	kfree(args);
+}
+
 static int __init nbd_init(void)
 {
 	int i;
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netlink.h
index f932f96..b69105cc 100644
--- a/include/uapi/linux/nbd-netlink.h
+++ b/include/uapi/linux/nbd-netlink.h
@@ -18,8 +18,9 @@
 #ifndef _UAPILINUX_NBD_NETLINK_H
 #define _UAPILINUX_NBD_NETLINK_H
 
-#define NBD_GENL_FAMILY_NAME	"nbd"
-#define NBD_GENL_VERSION	0x1
+#define NBD_GENL_FAMILY_NAME		"nbd"
+#define NBD_GENL_VERSION		0x1
+#define NBD_GENL_MCAST_GROUP_NAME	"nbd_mc_group"
 
 /* Configuration policy attributes, used for CONNECT */
 enum {
@@ -63,6 +64,7 @@ enum {
 	NBD_CMD_CONNECT,
 	NBD_CMD_DISCONNECT,
 	NBD_CMD_RECONFIGURE,
+	NBD_CMD_LINK_DEAD,
 	__NBD_CMD_MAX,
 };
 #define NBD_CMD_MAX	(__NBD_CMD_MAX - 1)
-- 
2.7.4
