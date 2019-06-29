Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADFEC4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B102086D
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="euNs9sZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfF2QMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 12:12:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43656 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfF2QMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 12:12:12 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so19084337ios.10
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dA47feNTKckUGsiN4gp0DeUJlHGcHXqYOeJ1uWs0xig=;
        b=euNs9sZu3OAl8yvDmNMV9PAGGTWK3ClsvxNJMYOJLk9njZM41PT8XuFzHQ4oBGMa0u
         aCS/gHZWaaghoylMeA/tzdhe9451BeKXQ6Xuc9Alla88zVeaE9dIvbadts5+3D+7xHBG
         FlAxmeDGHsVhhSwGytOiHlBgCNMseqz+WGMk49gIckwgIC/zfUgGDtHG8y4nZ5Fhx5Bw
         4XGtwvSNR/xb3FgSrrbJzNTt/+yuYZRR2edEJ13SuSORnCgXaXStB37sMfCQhFR7iTe/
         tCAQPt9mePkp8KoXAA823dA884S5uRs/oDmQPSZ6QEDUTe12UL3U2v18V9BuKlgUxD6Q
         3XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dA47feNTKckUGsiN4gp0DeUJlHGcHXqYOeJ1uWs0xig=;
        b=rdnSXVQSU3tEzDw8MSkXNU7xVo4sITJuQQs1a0fjXHOz6uMMNClWQdzuSq2DGOS0M/
         MbmHy5lfbVyrQ+sqYR0sSf++uug3n9Tjw3VhvoifQ0SRAz9jwT2JTGEj1GLiJwzTlAGR
         Go8xGrDa58IZ4strHTOT9OjTKB8cNGYO0oxhRvCSJCl0I8GgdME/r81pxkOGRwViRqyY
         ItL+urtjgxShNdtKxnxZafmvmy8mE/PEp7YfKcyNpCTB+1wkLKJ2LEGCdelZGQR7yNHL
         HvMU+Mg93xK9g/VkoIoar9n95OBorsTXeQ6+5YE0AiDoe7/mfUyisoQyVeXj/5ChR9Yo
         f9GA==
X-Gm-Message-State: APjAAAVndbpa17OLR6lQ+Skq+pR/1vWL30OQbckaAK/EHcGjjiP8a3zg
        5FBYjNTltxjewYnfl8aq7mgoMg==
X-Google-Smtp-Source: APXvYqx4N3N8a4rRiNiUK8cJ1bnTnfLQcYoOAnRPJXkefaoKYE68Jpc+LDSNMzkaSDWXtaOeC/GmIg==
X-Received: by 2002:a02:1948:: with SMTP id b69mr18405731jab.55.1561824730913;
        Sat, 29 Jun 2019 09:12:10 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o5sm4743484iob.7.2019.06.29.09.12.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 09:12:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     davem@davemloft.net, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: add support for recvmsg()
Date:   Sat, 29 Jun 2019 10:12:04 -0600
Message-Id: <20190629161204.27226-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629161204.27226-1-axboe@kernel.dk>
References: <20190629161204.27226-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is done through IORING_OP_RECVMSG. This opcode uses the same
sqe->msg_flags that IORING_OP_SENDMSG added, and we pass in the
msghdr struct in the sqe->addr field as well.

We use MSG_DONTWAIT to force an inline fast path if recvmsg() doesn't
block, and punt to async execution if it would have.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 31 +++++++++++++++++++++++++++----
 include/linux/socket.h        |  3 +++
 include/uapi/linux/io_uring.h |  1 +
 net/socket.c                  |  8 ++++++++
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5d4cd8c4132d..8d86e31b0762 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1390,10 +1390,12 @@ static int io_sync_file_range(struct io_kiocb *req,
 	return 0;
 }
 
-static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
-		      bool force_nonblock)
-{
 #if defined(CONFIG_NET)
+static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+			   bool force_nonblock,
+		   long (*fn)(struct socket *, struct user_msghdr __user *,
+				unsigned int))
+{
 	struct socket *sock;
 	int ret;
 
@@ -1414,7 +1416,7 @@ static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		msg = (struct user_msghdr __user *) (unsigned long)
 			READ_ONCE(sqe->addr);
 
-		ret = __sys_sendmsg_sock(sock, msg, flags);
+		ret = fn(sock, msg, flags);
 		if (force_nonblock && ret == -EAGAIN)
 			return ret;
 	}
@@ -1422,6 +1424,24 @@ static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);
 	io_put_req(req);
 	return 0;
+}
+#endif
+
+static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		      bool force_nonblock)
+{
+#if defined(CONFIG_NET)
+	return io_send_recvmsg(req, sqe, force_nonblock, __sys_sendmsg_sock);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static int io_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		      bool force_nonblock)
+{
+#if defined(CONFIG_NET)
+	return io_send_recvmsg(req, sqe, force_nonblock, __sys_recvmsg_sock);
 #else
 	return -EOPNOTSUPP;
 #endif
@@ -1715,6 +1735,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_SENDMSG:
 		ret = io_sendmsg(req, s->sqe, force_nonblock);
 		break;
+	case IORING_OP_RECVMSG:
+		ret = io_recvmsg(req, s->sqe, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 9d770ef3ced5..97523818cb14 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -378,6 +378,9 @@ extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 extern long __sys_sendmsg_sock(struct socket *sock,
 			       struct user_msghdr __user *msg,
 			       unsigned int flags);
+extern long __sys_recvmsg_sock(struct socket *sock,
+			       struct user_msghdr __user *msg,
+			       unsigned int flags);
 
 /* helpers which do the actual work for syscalls */
 extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index d74742d6269f..1e1652f25cc1 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -60,6 +60,7 @@ struct io_uring_sqe {
 #define IORING_OP_POLL_REMOVE	7
 #define IORING_OP_SYNC_FILE_RANGE	8
 #define IORING_OP_SENDMSG	9
+#define IORING_OP_RECVMSG	10
 
 /*
  * sqe->fsync_flags
diff --git a/net/socket.c b/net/socket.c
index b9536940255e..98354cc18840 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2494,6 +2494,14 @@ static int ___sys_recvmsg(struct socket *sock, struct user_msghdr __user *msg,
  *	BSD recvmsg interface
  */
 
+long __sys_recvmsg_sock(struct socket *sock, struct user_msghdr __user *msg,
+			unsigned int flags)
+{
+	struct msghdr msg_sys;
+
+	return ___sys_recvmsg(sock, msg, &msg_sys, flags, 0);
+}
+
 long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
 		   bool forbid_cmsg_compat)
 {
-- 
2.17.1

