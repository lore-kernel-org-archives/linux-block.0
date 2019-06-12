Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD356C31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864A2215EA
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="cM2YdyHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407917AbfFLQb4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:31:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43569 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404956AbfFLQbz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 12:31:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so12652415lfk.10
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2019 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uyGy4WWNd2ICdtMeMw4Zv+i9/3GDsNbkiJ11wIkXVHk=;
        b=cM2YdyHPEuHJeH6B4zlWv7cFDZ58r/VLbHAjpEq7LRr4gfQuJgyJVY8V7eqma8hgte
         4zGM0EC3wvKYWvhAAB+wiA89/DLZ7cZ+w+jCKeHn3apaCzmlnKJxVqZTHJiHufE0+9Mz
         QpJ6bZNRmZzIzi5TUNQGP6Cec/IxleJOQAiWNRceu0qYiIiSSpt8Yi03c/qcS3/S/QE2
         HYAXO9oAqV46cS9rpAQUr6ZlNHHpKeA2cQrpJUCCod2ERVIppHZSaIAS6XlgwlBpIZno
         4lZ46FPrXVeSpOx3J1ujNz1AunbzDoe3C9O52LCg25K+JRdropo2buWQjcQl/FesB8Jo
         aONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uyGy4WWNd2ICdtMeMw4Zv+i9/3GDsNbkiJ11wIkXVHk=;
        b=A887ToVa9GE5KKPkqHRP0vi6jajG5s/L3gXOC9jByPxVl7ukUj/P8PxKMuJWXQRPfj
         gLB3O9Q5Oqe8ncCgZ57YBKt+XmII6+hFfUFkTr/YxF4qoZlf5iKIJaLQl+06YfpNRWTr
         lvUj+6Xh7N2RzKMV+rP6B8ORKsVWC5lcVPdBuu1s5AAcWKN0IjzM3BCsC//XscZ6TEwe
         gy0u79fhNZ0eDsItDxhaouaL/sX+ask9MCvG8eL4RZehk2JIFxLGW5XwuVKRZ2EHfFw7
         hyYl1P1ylGU29goz0vxJYODiJGTbJI6D2cEiblyHRuUxkuYGfay04HvbJ8RJaXJVjVzN
         5OLA==
X-Gm-Message-State: APjAAAV11Q7efSk/x0hMEGBb/fdTcEGej4v2Di3V0/rPukvoO5l7PMtx
        uR8pk5tNwh+i/SeTuas9RdqFQQ==
X-Google-Smtp-Source: APXvYqxXheLkvoces0WjHrstT2gH4vDKkOotaV8dXkmVihwqMr/COQ6Whd22gTXlZGmoX2kwSjz5tQ==
X-Received: by 2002:a19:ae01:: with SMTP id f1mr40901890lfc.29.1560357113198;
        Wed, 12 Jun 2019 09:31:53 -0700 (PDT)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id e26sm54358ljl.33.2019.06.12.09.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:31:52 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        nbd@other.debian.org, A.Bulyshchenko@globallogic.com,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH 1/2] nbd: make sock_xmit() and nbd_add_socket() more generic
Date:   Wed, 12 Jun 2019 19:31:43 +0300
Message-Id: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Prepare base for the nbd-root patch:
 - allow to reuse sock_xmit without struct nbd_device as an argument.
 - allow to reuse nbd_add_socket with struct socket as an argument.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
Reviewed-by: Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>
---
 drivers/block/nbd.c | 62 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3a9bca3aa093..63fcfb38e640 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -404,22 +404,13 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 /*
  *  Send or receive packet.
  */
-static int sock_xmit(struct nbd_device *nbd, int index, int send,
+static int sock_xmit(struct socket *sock, int send,
 		     struct iov_iter *iter, int msg_flags, int *sent)
 {
-	struct nbd_config *config = nbd->config;
-	struct socket *sock = config->socks[index]->sock;
 	int result;
 	struct msghdr msg;
 	unsigned int noreclaim_flag;
 
-	if (unlikely(!sock)) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-			"Attempted %s on closed socket in sock_xmit\n",
-			(send ? "send" : "recv"));
-		return -EINVAL;
-	}
-
 	msg.msg_iter = *iter;
 
 	noreclaim_flag = memalloc_noreclaim_save();
@@ -450,6 +441,22 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 	return result;
 }
 
+static int nbd_xmit(struct nbd_device *nbd, int index, int send,
+		     struct iov_iter *iter, int msg_flags, int *sent)
+{
+	struct nbd_config *config = nbd->config;
+	struct socket *sock = config->socks[index]->sock;
+
+	if (unlikely(!sock)) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+			"Attempted %s on closed socket in %s\n",
+			(send ? "send" : "recv"), __func__);
+		return -EINVAL;
+	}
+
+	return sock_xmit(sock, send, iter, msg_flags, sent);
+}
+
 /*
  * Different settings for sk->sk_sndtimeo can result in different return values
  * if there is a signal pending when we enter sendmsg, because reasons?
@@ -537,7 +544,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	dev_dbg(nbd_to_dev(nbd), "request %p: sending control (%s@%llu,%uB)\n",
 		req, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
-	result = sock_xmit(nbd, index, 1, &from,
+	result = nbd_xmit(nbd, index, 1, &from,
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
 	trace_nbd_header_sent(req, handle);
 	if (result <= 0) {
@@ -583,7 +590,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				iov_iter_advance(&from, skip);
 				skip = 0;
 			}
-			result = sock_xmit(nbd, index, 1, &from, flags, &sent);
+			result = nbd_xmit(nbd, index, 1, &from, flags, &sent);
 			if (result <= 0) {
 				if (was_interrupted(result)) {
 					/* We've already sent the header, we
@@ -635,7 +642,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 
 	reply.magic = 0;
 	iov_iter_kvec(&to, READ, &iov, 1, sizeof(reply));
-	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
+	result = nbd_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result <= 0) {
 		if (!nbd_disconnected(config))
 			dev_err(disk_to_dev(nbd->disk),
@@ -690,7 +697,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 
 		rq_for_each_segment(bvec, req, iter) {
 			iov_iter_bvec(&to, READ, &bvec, 1, bvec.bv_len);
-			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
+			result = nbd_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
@@ -931,18 +938,12 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
+static int nbd_add_socket(struct nbd_device *nbd, struct socket *sock,
 			  bool netlink)
 {
 	struct nbd_config *config = nbd->config;
-	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
-	int err;
-
-	sock = sockfd_lookup(arg, &err);
-	if (!sock)
-		return err;
 
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_BOUND, &config->runtime_flags))
@@ -984,6 +985,19 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	return 0;
 }
 
+static int nbd_add_socket_fd(struct nbd_device *nbd, unsigned long arg,
+			  bool netlink)
+{
+	struct socket *sock;
+	int err;
+
+	sock = sockfd_lookup(arg, &err);
+	if (!sock)
+		return err;
+
+	return nbd_add_socket(nbd, sock, netlink);
+}
+
 static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 {
 	struct nbd_config *config = nbd->config;
@@ -1087,7 +1101,7 @@ static void send_disconnects(struct nbd_device *nbd)
 
 		iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
-		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
+		ret = nbd_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret <= 0)
 			dev_err(disk_to_dev(nbd->disk),
 				"Send disconnect failed %d\n", ret);
@@ -1249,7 +1263,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd_clear_sock_ioctl(nbd, bdev);
 		return 0;
 	case NBD_SET_SOCK:
-		return nbd_add_socket(nbd, arg, false);
+		return nbd_add_socket_fd(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
 		if (!arg || !is_power_of_2(arg) || arg < 512 ||
 		    arg > PAGE_SIZE)
@@ -1821,7 +1835,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			if (!socks[NBD_SOCK_FD])
 				continue;
 			fd = (int)nla_get_u32(socks[NBD_SOCK_FD]);
-			ret = nbd_add_socket(nbd, fd, true);
+			ret = nbd_add_socket_fd(nbd, fd, true);
 			if (ret)
 				goto out;
 		}
-- 
2.17.1

