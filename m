Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 06/12] nbd: add a reconfigure netlink command
Date: Thu,  6 Apr 2017 17:02:01 -0400
Message-Id: <1491512527-4286-7-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

We want to be able to reconnect dead connections to existing block
devices, so add a reconfigure netlink command.  We will also allow users
to change their timeout on the fly, but everything else will require a
disconnect and reconnect.  You won't be able to add more connections
either, simply replace dead connections with new more lively
connections.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c              | 141 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nbd-netlink.h |   1 +
 2 files changed, 142 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b8764e1..27958c3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -785,6 +785,59 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	return 0;
 }
 
+static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
+{
+	struct nbd_config *config = nbd->config;
+	struct socket *sock, *old;
+	struct recv_thread_args *args;
+	int i;
+	int err;
+
+	sock = sockfd_lookup(arg, &err);
+	if (!sock)
+		return err;
+
+	args = kzalloc(sizeof(*args), GFP_KERNEL);
+	if (!args) {
+		sockfd_put(sock);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < config->num_connections; i++) {
+		struct nbd_sock *nsock = config->socks[i];
+
+		if (!nsock->dead)
+			continue;
+
+		mutex_lock(&nsock->tx_lock);
+		if (!nsock->dead) {
+			mutex_unlock(&nsock->tx_lock);
+			continue;
+		}
+		sk_set_memalloc(sock->sk);
+		atomic_inc(&config->recv_threads);
+		refcount_inc(&nbd->config_refs);
+		old = nsock->sock;
+		nsock->fallback_index = -1;
+		nsock->sock = sock;
+		nsock->dead = false;
+		INIT_WORK(&args->work, recv_work);
+		args->index = i;
+		args->nbd = nbd;
+		mutex_unlock(&nsock->tx_lock);
+		sockfd_put(old);
+
+		/* We take the tx_mutex in an error path in the recv_work, so we
+		 * need to queue_work outside of the tx_mutex.
+		 */
+		queue_work(recv_workqueue, &args->work);
+		return 0;
+	}
+	sockfd_put(sock);
+	kfree(args);
+	return -ENOSPC;
+}
+
 /* Reset all properties of an NBD device */
 static void nbd_reset(struct nbd_device *nbd)
 {
@@ -1529,6 +1582,89 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nbd_device *nbd = NULL;
+	struct nbd_config *config;
+	int index;
+	int ret = -EINVAL;
+
+	if (!netlink_capable(skb, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!info->attrs[NBD_ATTR_INDEX]) {
+		printk(KERN_ERR "nbd: must specify a device to reconfigure\n");
+		return -EINVAL;
+	}
+	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
+	mutex_lock(&nbd_index_mutex);
+	nbd = idr_find(&nbd_index_idr, index);
+	mutex_unlock(&nbd_index_mutex);
+	if (!nbd) {
+		printk(KERN_ERR "nbd: couldn't find a device at index %d\n",
+		       index);
+		return -EINVAL;
+	}
+
+	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+		dev_err(nbd_to_dev(nbd),
+			"not configured, cannot reconfigure\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&nbd->config_lock);
+	config = nbd->config;
+	if (!test_bit(NBD_BOUND, &config->runtime_flags) ||
+	    !nbd->task_recv) {
+		dev_err(nbd_to_dev(nbd),
+			"not configured, cannot reconfigure\n");
+		goto out;
+	}
+
+	if (info->attrs[NBD_ATTR_TIMEOUT]) {
+		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
+		nbd->tag_set.timeout = timeout * HZ;
+		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
+	}
+
+	if (info->attrs[NBD_ATTR_SOCKETS]) {
+		struct nlattr *attr;
+		int rem, fd;
+
+		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
+				    rem) {
+			struct nlattr *socks[NBD_SOCK_MAX+1];
+
+			if (nla_type(attr) != NBD_SOCK_ITEM) {
+				printk(KERN_ERR "nbd: socks must be embedded in a SOCK_ITEM attr\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			ret = nla_parse_nested(socks, NBD_SOCK_MAX, attr,
+					       nbd_sock_policy);
+			if (ret != 0) {
+				printk(KERN_ERR "nbd: error processing sock list\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			if (!socks[NBD_SOCK_FD])
+				continue;
+			fd = (int)nla_get_u32(socks[NBD_SOCK_FD]);
+			ret = nbd_reconnect_socket(nbd, fd);
+			if (ret) {
+				if (ret == -ENOSPC)
+					ret = 0;
+				goto out;
+			}
+			dev_info(nbd_to_dev(nbd), "reconnected socket\n");
+		}
+	}
+out:
+	mutex_unlock(&nbd->config_lock);
+	nbd_config_put(nbd);
+	return ret;
+}
+
 static const struct genl_ops nbd_connect_genl_ops[] = {
 	{
 		.cmd	= NBD_CMD_CONNECT,
@@ -1540,6 +1676,11 @@ static const struct genl_ops nbd_connect_genl_ops[] = {
 		.policy	= nbd_attr_policy,
 		.doit	= nbd_genl_disconnect,
 	},
+	{
+		.cmd	= NBD_CMD_RECONFIGURE,
+		.policy	= nbd_attr_policy,
+		.doit	= nbd_genl_reconfigure,
+	},
 };
 
 static struct genl_family nbd_genl_family __ro_after_init = {
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netlink.h
index fd0f4e4..f932f96 100644
--- a/include/uapi/linux/nbd-netlink.h
+++ b/include/uapi/linux/nbd-netlink.h
@@ -62,6 +62,7 @@ enum {
 	NBD_CMD_UNSPEC,
 	NBD_CMD_CONNECT,
 	NBD_CMD_DISCONNECT,
+	NBD_CMD_RECONFIGURE,
 	__NBD_CMD_MAX,
 };
 #define NBD_CMD_MAX	(__NBD_CMD_MAX - 1)
-- 
2.7.4
