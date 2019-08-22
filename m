Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A153FC3A59D
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5E42339F
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfHVH7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbfHVH7l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 03:59:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A282C3082E57;
        Thu, 22 Aug 2019 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 031385D6A7;
        Thu, 22 Aug 2019 07:59:37 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 1/2 v3] nbd: rename the runtime flags as NBD_RT_ prefixed
Date:   Thu, 22 Aug 2019 13:29:22 +0530
Message-Id: <20190822075923.11996-2-xiubli@redhat.com>
In-Reply-To: <20190822075923.11996-1-xiubli@redhat.com>
References: <20190822075923.11996-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 22 Aug 2019 07:59:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Preparing for the destory when disconnecting crash fixing.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 74 ++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e21d2ded732b..8c2f17b99224 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -71,14 +71,14 @@ struct link_dead_args {
 	int index;
 };
 
-#define NBD_TIMEDOUT			0
-#define NBD_DISCONNECT_REQUESTED	1
-#define NBD_DISCONNECTED		2
-#define NBD_HAS_PID_FILE		3
-#define NBD_HAS_CONFIG_REF		4
-#define NBD_BOUND			5
-#define NBD_DESTROY_ON_DISCONNECT	6
-#define NBD_DISCONNECT_ON_CLOSE 	7
+#define NBD_RT_TIMEDOUT			0
+#define NBD_RT_DISCONNECT_REQUESTED	1
+#define NBD_RT_DISCONNECTED		2
+#define NBD_RT_HAS_PID_FILE		3
+#define NBD_RT_HAS_CONFIG_REF		4
+#define NBD_RT_BOUND			5
+#define NBD_RT_DESTROY_ON_DISCONNECT	6
+#define NBD_RT_DISCONNECT_ON_CLOSE	7
 
 struct nbd_config {
 	u32 flags;
@@ -237,8 +237,8 @@ static void nbd_put(struct nbd_device *nbd)
 
 static int nbd_disconnected(struct nbd_config *config)
 {
-	return test_bit(NBD_DISCONNECTED, &config->runtime_flags) ||
-		test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
+	return test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags) ||
+		test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
 }
 
 static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
@@ -256,9 +256,9 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	if (!nsock->dead) {
 		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
 		if (atomic_dec_return(&nbd->config->live_connections) == 0) {
-			if (test_and_clear_bit(NBD_DISCONNECT_REQUESTED,
+			if (test_and_clear_bit(NBD_RT_DISCONNECT_REQUESTED,
 					       &nbd->config->runtime_flags)) {
-				set_bit(NBD_DISCONNECTED,
+				set_bit(NBD_RT_DISCONNECTED,
 					&nbd->config->runtime_flags);
 				dev_info(nbd_to_dev(nbd),
 					"Disconnected due to user request.\n");
@@ -332,7 +332,7 @@ static void sock_shutdown(struct nbd_device *nbd)
 
 	if (config->num_connections == 0)
 		return;
-	if (test_and_set_bit(NBD_DISCONNECTED, &config->runtime_flags))
+	if (test_and_set_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
 		return;
 
 	for (i = 0; i < config->num_connections; i++) {
@@ -393,7 +393,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out\n");
 	}
-	set_bit(NBD_TIMEDOUT, &config->runtime_flags);
+	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
 	cmd->status = BLK_STS_IOERR;
 	mutex_unlock(&cmd->lock);
 	sock_shutdown(nbd);
@@ -773,7 +773,7 @@ static int find_fallback(struct nbd_device *nbd, int index)
 	struct nbd_sock *nsock = config->socks[index];
 	int fallback = nsock->fallback_index;
 
-	if (test_bit(NBD_DISCONNECTED, &config->runtime_flags))
+	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
 		return new_index;
 
 	if (config->num_connections <= 1) {
@@ -814,7 +814,7 @@ static int wait_for_reconnect(struct nbd_device *nbd)
 	struct nbd_config *config = nbd->config;
 	if (!config->dead_conn_timeout)
 		return 0;
-	if (test_bit(NBD_DISCONNECTED, &config->runtime_flags))
+	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
 		return 0;
 	return wait_event_timeout(config->conn_wait,
 				  atomic_read(&config->live_connections) > 0,
@@ -947,12 +947,12 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		return err;
 
 	if (!netlink && !nbd->task_setup &&
-	    !test_bit(NBD_BOUND, &config->runtime_flags))
+	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
 		nbd->task_setup = current;
 
 	if (!netlink &&
 	    (nbd->task_setup != current ||
-	     test_bit(NBD_BOUND, &config->runtime_flags))) {
+	     test_bit(NBD_RT_BOUND, &config->runtime_flags))) {
 		dev_err(disk_to_dev(nbd->disk),
 			"Device being setup by another task");
 		sockfd_put(sock);
@@ -1031,7 +1031,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		mutex_unlock(&nsock->tx_lock);
 		sockfd_put(old);
 
-		clear_bit(NBD_DISCONNECTED, &config->runtime_flags);
+		clear_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
 
 		/* We take the tx_mutex in an error path in the recv_work, so we
 		 * need to queue_work outside of the tx_mutex.
@@ -1102,7 +1102,7 @@ static int nbd_disconnect(struct nbd_device *nbd)
 	struct nbd_config *config = nbd->config;
 
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
-	set_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
+	set_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
 	send_disconnects(nbd);
 	return 0;
 }
@@ -1121,7 +1121,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 		struct nbd_config *config = nbd->config;
 		nbd_dev_dbg_close(nbd);
 		nbd_size_clear(nbd);
-		if (test_and_clear_bit(NBD_HAS_PID_FILE,
+		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
 				       &config->runtime_flags))
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
 		nbd->task_recv = NULL;
@@ -1175,7 +1175,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
 		return error;
 	}
-	set_bit(NBD_HAS_PID_FILE, &config->runtime_flags);
+	set_bit(NBD_RT_HAS_PID_FILE, &config->runtime_flags);
 
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
@@ -1220,9 +1220,9 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(bdev);
 	/* user requested, ignore socket errors */
-	if (test_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags))
+	if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))
 		ret = 0;
-	if (test_bit(NBD_TIMEDOUT, &config->runtime_flags))
+	if (test_bit(NBD_RT_TIMEDOUT, &config->runtime_flags))
 		ret = -ETIMEDOUT;
 	return ret;
 }
@@ -1233,7 +1233,7 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 	sock_shutdown(nbd);
 	__invalidate_device(bdev, true);
 	nbd_bdev_reset(bdev);
-	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
+	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
 }
@@ -1324,7 +1324,7 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 	/* Don't allow ioctl operations on a nbd device that was created with
 	 * netlink, unless it's DISCONNECT or CLEAR_SOCK, which are fine.
 	 */
-	if (!test_bit(NBD_BOUND, &config->runtime_flags) ||
+	if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) ||
 	    (cmd == NBD_DISCONNECT || cmd == NBD_CLEAR_SOCK))
 		error = __nbd_ioctl(bdev, nbd, cmd, arg);
 	else
@@ -1395,7 +1395,7 @@ static void nbd_release(struct gendisk *disk, fmode_t mode)
 	struct nbd_device *nbd = disk->private_data;
 	struct block_device *bdev = bdget_disk(disk, 0);
 
-	if (test_bit(NBD_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
+	if (test_bit(NBD_RT_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
 			bdev->bd_openers == 0)
 		nbd_disconnect_and_put(nbd);
 
@@ -1793,7 +1793,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	}
 	refcount_set(&nbd->config_refs, 1);
-	set_bit(NBD_BOUND, &config->runtime_flags);
+	set_bit(NBD_RT_BOUND, &config->runtime_flags);
 
 	ret = nbd_genl_size_set(info, nbd);
 	if (ret)
@@ -1815,12 +1815,12 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_CLIENT_FLAGS]) {
 		u64 flags = nla_get_u64(info->attrs[NBD_ATTR_CLIENT_FLAGS]);
 		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
-			set_bit(NBD_DESTROY_ON_DISCONNECT,
+			set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 				&config->runtime_flags);
 			put_dev = true;
 		}
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
-			set_bit(NBD_DISCONNECT_ON_CLOSE,
+			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
 				&config->runtime_flags);
 		}
 	}
@@ -1859,7 +1859,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 out:
 	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
-		set_bit(NBD_HAS_CONFIG_REF, &config->runtime_flags);
+		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
 		refcount_inc(&nbd->config_refs);
 		nbd_connect_reply(info, nbd->index);
 	}
@@ -1875,7 +1875,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	nbd_disconnect(nbd);
 	nbd_clear_sock(nbd);
 	mutex_unlock(&nbd->config_lock);
-	if (test_and_clear_bit(NBD_HAS_CONFIG_REF,
+	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
 }
@@ -1959,7 +1959,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&nbd->config_lock);
 	config = nbd->config;
-	if (!test_bit(NBD_BOUND, &config->runtime_flags) ||
+	if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) ||
 	    !nbd->task_recv) {
 		dev_err(nbd_to_dev(nbd),
 			"not configured, cannot reconfigure\n");
@@ -1984,20 +1984,20 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NBD_ATTR_CLIENT_FLAGS]) {
 		u64 flags = nla_get_u64(info->attrs[NBD_ATTR_CLIENT_FLAGS]);
 		if (flags & NBD_CFLAG_DESTROY_ON_DISCONNECT) {
-			if (!test_and_set_bit(NBD_DESTROY_ON_DISCONNECT,
+			if (!test_and_set_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 					      &config->runtime_flags))
 				put_dev = true;
 		} else {
-			if (test_and_clear_bit(NBD_DESTROY_ON_DISCONNECT,
+			if (test_and_clear_bit(NBD_RT_DESTROY_ON_DISCONNECT,
 					       &config->runtime_flags))
 				refcount_inc(&nbd->refs);
 		}
 
 		if (flags & NBD_CFLAG_DISCONNECT_ON_CLOSE) {
-			set_bit(NBD_DISCONNECT_ON_CLOSE,
+			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
 					&config->runtime_flags);
 		} else {
-			clear_bit(NBD_DISCONNECT_ON_CLOSE,
+			clear_bit(NBD_RT_DISCONNECT_ON_CLOSE,
 					&config->runtime_flags);
 		}
 	}
-- 
2.21.0

