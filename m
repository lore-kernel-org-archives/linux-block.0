Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 09/12] nbd: handle dead connections
Date: Thu,  6 Apr 2017 17:02:04 -0400
Message-Id: <1491512527-4286-10-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

Sometimes we like to upgrade our server without making all of our
clients freak out and reconnect.  This patch provides a way to specify a
dead connection timeout to allow us to pause all requests and wait for
new connections to be opened.  With this in place I can take down the
nbd server for less than the dead connection timeout time and bring it
back up and everything resumes gracefully.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c              | 63 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/nbd-netlink.h |  1 +
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 70c5e75..fd3d535 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -77,9 +77,12 @@ struct link_dead_args {
 struct nbd_config {
 	u32 flags;
 	unsigned long runtime_flags;
+	u64 dead_conn_timeout;
 
 	struct nbd_sock **socks;
 	int num_connections;
+	atomic_t live_connections;
+	wait_queue_head_t conn_wait;
 
 	atomic_t recv_threads;
 	wait_queue_head_t recv_wq;
@@ -178,8 +181,10 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 			queue_work(system_wq, &args->work);
 		}
 	}
-	if (!nsock->dead)
+	if (!nsock->dead) {
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+		atomic_dec(&nbd->config->live_connections);
+	}
 	nsock->dead = true;
 	nsock->pending = NULL;
 	nsock->sent = 0;
@@ -257,6 +262,14 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		return BLK_EH_HANDLED;
 	}
 
+	/* If we are waiting on our dead timer then we could get timeout
+	 * callbacks for our request.  For this we just want to reset the timer
+	 * and let the queue side take care of everything.
+	 */
+	if (!completion_done(&cmd->send_complete)) {
+		nbd_config_put(nbd);
+		return BLK_EH_RESET_TIMER;
+	}
 	config = nbd->config;
 
 	if (config->num_connections > 1) {
@@ -665,6 +678,19 @@ static int find_fallback(struct nbd_device *nbd, int index)
 	return new_index;
 }
 
+static int wait_for_reconnect(struct nbd_device *nbd)
+{
+	struct nbd_config *config = nbd->config;
+	if (!config->dead_conn_timeout)
+		return 0;
+	if (test_bit(NBD_DISCONNECTED, &config->runtime_flags))
+		return 0;
+	wait_event_interruptible_timeout(config->conn_wait,
+					 atomic_read(&config->live_connections),
+					 config->dead_conn_timeout);
+	return atomic_read(&config->live_connections);
+}
+
 static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
@@ -691,12 +717,24 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	nsock = config->socks[index];
 	mutex_lock(&nsock->tx_lock);
 	if (nsock->dead) {
+		int old_index = index;
 		index = find_fallback(nbd, index);
+		mutex_unlock(&nsock->tx_lock);
 		if (index < 0) {
-			ret = -EIO;
-			goto out;
+			if (wait_for_reconnect(nbd)) {
+				index = old_index;
+				goto again;
+			}
+			/* All the sockets should already be down at this point,
+			 * we just want to make sure that DISCONNECTED is set so
+			 * any requests that come in that were queue'ed waiting
+			 * for the reconnect timer don't trigger the timer again
+			 * and instead just error out.
+			 */
+			sock_shutdown(nbd);
+			nbd_config_put(nbd);
+			return -EIO;
 		}
-		mutex_unlock(&nsock->tx_lock);
 		goto again;
 	}
 
@@ -809,6 +847,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	nsock->sent = 0;
 	nsock->cookie = 0;
 	socks[config->num_connections++] = nsock;
+	atomic_inc(&config->live_connections);
 
 	return 0;
 }
@@ -860,6 +899,9 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		 * need to queue_work outside of the tx_mutex.
 		 */
 		queue_work(recv_workqueue, &args->work);
+
+		atomic_inc(&config->live_connections);
+		wake_up(&config->conn_wait);
 		return 0;
 	}
 	sockfd_put(sock);
@@ -1137,7 +1179,9 @@ static struct nbd_config *nbd_alloc_config(void)
 		return NULL;
 	atomic_set(&config->recv_threads, 0);
 	init_waitqueue_head(&config->recv_wq);
+	init_waitqueue_head(&config->conn_wait);
 	config->blksize = 1024;
+	atomic_set(&config->live_connections, 0);
 	try_module_get(THIS_MODULE);
 	return config;
 }
@@ -1449,6 +1493,7 @@ static struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_SERVER_FLAGS]		=	{ .type = NLA_U64 },
 	[NBD_ATTR_CLIENT_FLAGS]		=	{ .type = NLA_U64 },
 	[NBD_ATTR_SOCKETS]		=	{ .type = NLA_NESTED},
+	[NBD_ATTR_DEAD_CONN_TIMEOUT]	=	{ .type = NLA_U64 },
 };
 
 static struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
@@ -1535,6 +1580,11 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		nbd->tag_set.timeout = timeout * HZ;
 		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
 	}
+	if (info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]) {
+		config->dead_conn_timeout =
+			nla_get_u64(info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]);
+		config->dead_conn_timeout *= HZ;
+	}
 	if (info->attrs[NBD_ATTR_SERVER_FLAGS])
 		config->flags =
 			nla_get_u64(info->attrs[NBD_ATTR_SERVER_FLAGS]);
@@ -1655,6 +1705,11 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		nbd->tag_set.timeout = timeout * HZ;
 		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
 	}
+	if (info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]) {
+		config->dead_conn_timeout =
+			nla_get_u64(info->attrs[NBD_ATTR_DEAD_CONN_TIMEOUT]);
+		config->dead_conn_timeout *= HZ;
+	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
 		struct nlattr *attr;
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netlink.h
index b69105cc..c2209c75 100644
--- a/include/uapi/linux/nbd-netlink.h
+++ b/include/uapi/linux/nbd-netlink.h
@@ -32,6 +32,7 @@ enum {
 	NBD_ATTR_SERVER_FLAGS,
 	NBD_ATTR_CLIENT_FLAGS,
 	NBD_ATTR_SOCKETS,
+	NBD_ATTR_DEAD_CONN_TIMEOUT,
 	__NBD_ATTR_MAX,
 };
 #define NBD_ATTR_MAX (__NBD_ATTR_MAX - 1)
-- 
2.7.4
