Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2813DB644;
	Fri, 27 Mar 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603457; cv=none; b=Rhndp8UsTwyc8DudPrpvJDVMGeRgeMwXMrOGu1kZODIvyN3kKvyU3pfBKgEFUNn7lT0GYPQrRpGyad9BqmAma/M3Aw+JI99eObAvC38mWuwn/T47iLxtli2e655Jfq4oCHOVAjSN/eHUoTCvNafA3JSPtqG1dcHZllZRGO4VKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603457; c=relaxed/simple;
	bh=KwqU1rHPW/gX0zWbLuhE/kSr4jPGfoFo+HbuwOvJCvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+jSBnvE36dYGv19ARQMa/sDsA8W/kU3U8w72LXBIdYb+/Uqx9syp5M+SfiOKahkQd8GkHY4DvPgAz4vgAKsBd2/IepHHDDZ/79P7gIUIVrTiQBomy00tYiecNCMPCK32ByXrjOy7wAPYSy4uyroPLM0HbnmbPH/NRKje/gG0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhwDg4tcWzKHMkG;
	Fri, 27 Mar 2026 17:23:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4994E40539;
	Fri, 27 Mar 2026 17:24:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgAHC9uyTMZpTlaWCQ--.27625S6;
	Fri, 27 Mar 2026 17:24:13 +0800 (CST)
From: leo.lilong@huaweicloud.com
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: leo.lilong@huawei.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lonuxli.64@gmail.com
Subject: [PATCH 2/4] nbd: replace socks pointer array with xarray
Date: Fri, 27 Mar 2026 17:12:21 +0800
Message-Id: <20260327091223.4147956-3-leo.lilong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
References: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHC9uyTMZpTlaWCQ--.27625S6
X-Coremail-Antispam: 1UD129KBjvAXoW3KF4DWr4ftF4kZr1rGr1ftFb_yoW8Jr1DZo
	WxXF9agw48Jr17XFWFg3WfKFW8Xa1qkwsxAr4UCrnxu3Wjga15Ka43Kw43CasxJr15tFyI
	y34fWw47Z3W3Jr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYE7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r
	1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gBMtUUUUU=
	=
X-CM-SenderInfo: hohrhzxlor0w46kxt4xhlfz01xgou0bp/

From: Long Li <leo.lilong@huawei.com>

Replace the krealloc-based struct nbd_sock **socks array with struct
xarray socks. Each nbd sock is fully initialized before being stored
into the xarray via xa_store(), ensuring concurrent readers calling
xa_load() never observe a partially initialized socket.

Convert all array index accesses to xa_load() and open-coded for-loops
to xa_for_each().

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 drivers/block/nbd.c | 155 +++++++++++++++++++++++++++-----------------
 1 file changed, 96 insertions(+), 59 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f26ad2f1f3ff..728db2e832f8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -38,6 +38,7 @@
 #include <linux/types.h>
 #include <linux/debugfs.h>
 #include <linux/blk-mq.h>
+#include <linux/xarray.h>
 
 #include <linux/uaccess.h>
 #include <asm/types.h>
@@ -94,7 +95,7 @@ struct nbd_config {
 	unsigned long runtime_flags;
 	u64 dead_conn_timeout;
 
-	struct nbd_sock **socks;
+	struct xarray socks;
 	int num_connections;
 	atomic_t live_connections;
 	wait_queue_head_t conn_wait;
@@ -398,15 +399,15 @@ static void nbd_complete_rq(struct request *req)
 static void sock_shutdown(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
-	int i;
+	struct nbd_sock *nsock;
+	unsigned long i;
 
 	if (config->num_connections == 0)
 		return;
 	if (test_and_set_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
 		return;
 
-	for (i = 0; i < config->num_connections; i++) {
-		struct nbd_sock *nsock = config->socks[i];
+	xa_for_each(&config->socks, i, nsock) {
 		mutex_lock(&nsock->tx_lock);
 		nbd_mark_nsock_dead(nbd, nsock, 0);
 		mutex_unlock(&nsock->tx_lock);
@@ -453,6 +454,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 	struct nbd_device *nbd = cmd->nbd;
 	struct nbd_config *config;
+	struct nbd_sock *nsock;
 
 	if (!mutex_trylock(&cmd->lock))
 		return BLK_EH_RESET_TIMER;
@@ -488,10 +490,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 		 * connection is configured, the submit path will wait util
 		 * a new connection is reconfigured or util dead timeout.
 		 */
-		if (config->socks) {
-			if (cmd->index < config->num_connections) {
-				struct nbd_sock *nsock =
-					config->socks[cmd->index];
+		if (!xa_empty(&config->socks)) {
+			nsock = xa_load(&config->socks, cmd->index);
+			if (nsock) {
 				mutex_lock(&nsock->tx_lock);
 				/* We can have multiple outstanding requests, so
 				 * we don't want to mark the nsock dead if we've
@@ -515,22 +516,24 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 		 * Userspace sets timeout=0 to disable socket disconnection,
 		 * so just warn and reset the timer.
 		 */
-		struct nbd_sock *nsock = config->socks[cmd->index];
 		cmd->retries++;
 		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds\n",
 			req, nbdcmd_to_ascii(req_to_nbd_cmd_type(req)),
 			(unsigned long long)blk_rq_pos(req) << 9,
 			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries);
 
-		mutex_lock(&nsock->tx_lock);
-		if (cmd->cookie != nsock->cookie) {
-			nbd_requeue_cmd(cmd);
+		nsock = xa_load(&config->socks, cmd->index);
+		if (nsock) {
+			mutex_lock(&nsock->tx_lock);
+			if (cmd->cookie != nsock->cookie) {
+				nbd_requeue_cmd(cmd);
+				mutex_unlock(&nsock->tx_lock);
+				mutex_unlock(&cmd->lock);
+				nbd_config_put(nbd);
+				return BLK_EH_DONE;
+			}
 			mutex_unlock(&nsock->tx_lock);
-			mutex_unlock(&cmd->lock);
-			nbd_config_put(nbd);
-			return BLK_EH_DONE;
 		}
-		mutex_unlock(&nsock->tx_lock);
 		mutex_unlock(&cmd->lock);
 		nbd_config_put(nbd);
 		return BLK_EH_RESET_TIMER;
@@ -600,8 +603,16 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 		     struct iov_iter *iter, int msg_flags, int *sent)
 {
 	struct nbd_config *config = nbd->config;
-	struct socket *sock = config->socks[index]->sock;
+	struct nbd_sock *nsock;
+	struct socket *sock;
 
+	nsock = xa_load(&config->socks, index);
+	if (unlikely(!nsock)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted xmit on invalid socket\n");
+		return -EINVAL;
+	}
+	sock = nsock->sock;
 	return __sock_xmit(nbd, sock, send, iter, msg_flags, sent);
 }
 
@@ -647,7 +658,7 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	struct nbd_config *config = nbd->config;
-	struct nbd_sock *nsock = config->socks[index];
+	struct nbd_sock *nsock;
 	int result;
 	struct nbd_request request = {.magic = htonl(NBD_REQUEST_MAGIC)};
 	struct kvec iov = {.iov_base = &request, .iov_len = sizeof(request)};
@@ -656,7 +667,14 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 	u64 handle;
 	u32 type;
 	u32 nbd_cmd_flags = 0;
-	int sent = nsock->sent, skip = 0;
+	int sent, skip = 0;
+
+	nsock = xa_load(&config->socks, index);
+	if (unlikely(!nsock)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted send on invalid socket\n");
+		return BLK_STS_IOERR;
+	}
 
 	lockdep_assert_held(&cmd->lock);
 	lockdep_assert_held(&nsock->tx_lock);
@@ -683,6 +701,7 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
 	 * request struct, so just go and send the rest of the pages in the
 	 * request.
 	 */
+	sent = nsock->sent;
 	if (sent) {
 		if (sent >= sizeof(request)) {
 			skip = sent - sizeof(request);
@@ -1059,9 +1078,10 @@ static int find_fallback(struct nbd_device *nbd, int index)
 {
 	struct nbd_config *config = nbd->config;
 	int new_index = -1;
-	struct nbd_sock *nsock = config->socks[index];
-	int fallback = nsock->fallback_index;
-	int i;
+	struct nbd_sock *nsock;
+	struct nbd_sock *fallback_nsock;
+	unsigned long i;
+	int fallback;
 
 	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
 		return new_index;
@@ -1069,12 +1089,19 @@ static int find_fallback(struct nbd_device *nbd, int index)
 	if (config->num_connections <= 1)
 		goto no_fallback;
 
-	if (fallback >= 0 && fallback < config->num_connections &&
-	    !config->socks[fallback]->dead)
-		return fallback;
+	nsock = xa_load(&config->socks, index);
+	if (unlikely(!nsock))
+		goto no_fallback;
 
-	for (i = 0; i < config->num_connections; i++) {
-		if (i != index && !config->socks[i]->dead) {
+	fallback = nsock->fallback_index;
+	if (fallback >= 0 && fallback < config->num_connections) {
+		fallback_nsock = xa_load(&config->socks, fallback);
+		if (fallback_nsock && !fallback_nsock->dead)
+			return fallback;
+	}
+
+	xa_for_each(&config->socks, i, fallback_nsock) {
+		if (i != index && !fallback_nsock->dead) {
 			new_index = i;
 			break;
 		}
@@ -1130,7 +1157,14 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	}
 	cmd->status = BLK_STS_OK;
 again:
-	nsock = config->socks[index];
+	nsock = xa_load(&config->socks, index);
+	if (unlikely(!nsock)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted send on invalid socket\n");
+		nbd_config_put(nbd);
+		return BLK_STS_IOERR;
+	}
+
 	mutex_lock(&nsock->tx_lock);
 	if (nsock->dead) {
 		int old_index = index;
@@ -1234,9 +1268,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 {
 	struct nbd_config *config = nbd->config;
 	struct socket *sock;
-	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
 	unsigned int memflags;
+	unsigned int index;
 	int err;
 
 	/* Arg will be cast to int, check it to avoid overflow */
@@ -1271,16 +1305,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		goto put_socket;
 	}
 
-	socks = krealloc(config->socks, (config->num_connections + 1) *
-			 sizeof(struct nbd_sock *), GFP_KERNEL);
-	if (!socks) {
-		kfree(nsock);
-		err = -ENOMEM;
-		goto put_socket;
-	}
-
-	config->socks = socks;
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
@@ -1289,7 +1313,14 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	nsock->sent = 0;
 	nsock->cookie = 0;
 	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
-	socks[config->num_connections++] = nsock;
+
+	err = xa_alloc(&config->socks, &index, nsock, xa_limit_32b, GFP_KERNEL);
+	if (err < 0) {
+		kfree(nsock);
+		goto put_socket;
+	}
+
+	config->num_connections++;
 	atomic_inc(&config->live_connections);
 	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 
@@ -1306,7 +1337,8 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	struct nbd_config *config = nbd->config;
 	struct socket *sock, *old;
 	struct recv_thread_args *args;
-	int i;
+	struct nbd_sock *nsock;
+	unsigned long i;
 	int err;
 
 	sock = nbd_get_socket(nbd, arg, &err);
@@ -1319,9 +1351,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < config->num_connections; i++) {
-		struct nbd_sock *nsock = config->socks[i];
-
+	xa_for_each(&config->socks, i, nsock) {
 		if (!nsock->dead)
 			continue;
 
@@ -1387,10 +1417,11 @@ static void send_disconnects(struct nbd_device *nbd)
 	};
 	struct kvec iov = {.iov_base = &request, .iov_len = sizeof(request)};
 	struct iov_iter from;
-	int i, ret;
+	struct nbd_sock *nsock;
+	unsigned long i;
+	int ret;
 
-	for (i = 0; i < config->num_connections; i++) {
-		struct nbd_sock *nsock = config->socks[i];
+	xa_for_each(&config->socks, i, nsock) {
 
 		iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
@@ -1425,6 +1456,9 @@ static void nbd_config_put(struct nbd_device *nbd)
 	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
 					&nbd->config_lock)) {
 		struct nbd_config *config = nbd->config;
+		struct nbd_sock *nsock;
+		unsigned long i;
+
 		nbd_dev_dbg_close(nbd);
 		invalidate_disk(nbd->disk);
 		if (nbd->config->bytesize)
@@ -1440,14 +1474,15 @@ static void nbd_config_put(struct nbd_device *nbd)
 			nbd->backend = NULL;
 		}
 		nbd_clear_sock(nbd);
+
 		if (config->num_connections) {
-			int i;
-			for (i = 0; i < config->num_connections; i++) {
-				sockfd_put(config->socks[i]->sock);
-				kfree(config->socks[i]);
+			xa_for_each(&config->socks, i, nsock) {
+				sockfd_put(nsock->sock);
+				kfree(nsock);
 			}
-			kfree(config->socks);
 		}
+		xa_destroy(&config->socks);
+
 		kfree(nbd->config);
 		nbd->config = NULL;
 
@@ -1463,11 +1498,13 @@ static int nbd_start_device(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
 	int num_connections = config->num_connections;
-	int error = 0, i;
+	int error = 0;
+	unsigned long i;
+	struct nbd_sock *nsock;
 
 	if (nbd->pid)
 		return -EBUSY;
-	if (!config->socks)
+	if (xa_empty(&config->socks))
 		return -EINVAL;
 	if (num_connections > 1 &&
 	    !(config->flags & NBD_FLAG_CAN_MULTI_CONN)) {
@@ -1498,7 +1535,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 	set_bit(NBD_RT_HAS_PID_FILE, &config->runtime_flags);
 
 	nbd_dev_dbg_init(nbd);
-	for (i = 0; i < num_connections; i++) {
+	xa_for_each(&config->socks, i, nsock) {
 		struct recv_thread_args *args;
 
 		args = kzalloc_obj(*args);
@@ -1516,15 +1553,14 @@ static int nbd_start_device(struct nbd_device *nbd)
 				flush_workqueue(nbd->recv_workq);
 			return -ENOMEM;
 		}
-		sk_set_memalloc(config->socks[i]->sock->sk);
+		sk_set_memalloc(nsock->sock->sk);
 		if (nbd->tag_set.timeout)
-			config->socks[i]->sock->sk->sk_sndtimeo =
-				nbd->tag_set.timeout;
+			nsock->sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
 		INIT_WORK(&args->work, recv_work);
 		args->nbd = nbd;
-		args->nsock = config->socks[i];
+		args->nsock = nsock;
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
@@ -1674,6 +1710,7 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
 		return -ENOMEM;
 	}
 
+	xa_init_flags(&config->socks, XA_FLAGS_ALLOC);
 	atomic_set(&config->recv_threads, 0);
 	init_waitqueue_head(&config->recv_wq);
 	init_waitqueue_head(&config->conn_wait);
-- 
2.39.2

