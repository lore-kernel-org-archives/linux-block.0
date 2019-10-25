Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377FCA9EC0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C651D222C4
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CGdT1qUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502816AbfJYRbl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:31:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37626 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505880AbfJYRas (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 13:30:48 -0400
Received: by mail-io1-f68.google.com with SMTP id 1so3322872iou.4
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t/7vAwNRes/OgSWHDpsbdJG9hBx8gt3i+4E5Djauy08=;
        b=CGdT1qUuvKsWPxl4sLXLPgFyVbTaw4sKniCbWUtOdSjtQxNOy7E59UEa1eUO3jdk6N
         9dllHULVf9uLP2ouMpR54/XwyGmQ/n8wQR/2gnPQitAqZsD2p5lvS0mar/wvAdHUZ0fr
         SwKc9yWB/CZOOiaIImo3tScDuG6yXKtvBHjzG0jDNAEXIYrXeRMChySP6DbtQrAw0EIi
         WjB66sJgBjVwwV2GCU6VVkUqtgxdKH7AsDyM8fnv50DFXXWF6E9gwijB/lr4+IXlarI2
         WttdiDYQ5VN63AwOlWyylp59aHxnvqVxZ+aNxWuHPlB68lVEL0JJ16xpVyzRk3T49ea8
         QUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t/7vAwNRes/OgSWHDpsbdJG9hBx8gt3i+4E5Djauy08=;
        b=GBN3fRhNG29xtst2WryE0Isim33ARBLXUrczRPKT2xbs010XNbtGVmiboAIsiAWYLo
         Pfhpbt4yBtvU8bu6K0MnaibLAoKldg+qKlJkdQNt8BbTgMdqv+k6/9ba7f/VHO2RAUnL
         0iY2Mg74PUkf67HDiBCNKdkno/UapcVPWrb1P6RsMbD2oTE7LF2o1KHrayI/j9HkhfNC
         SkuQJSLSQcQILn7m2A1NSonWEFVeAcQOmV1Nws92Zm18MP8xjy9/4ZKHqTf8nt2fH4ye
         ZTKRI0ZRzBMAAUxFV1mlP0Nux151qn16JBXm9jG7kHKbLp4/tqn8Yv4aMQnC79Gt3Ne8
         JZRg==
X-Gm-Message-State: APjAAAXx5VCFh1ko8WjZNUUMBSv/AuH31BIP5pKmqgTDePJhkCkn8O9V
        at9H2gAwIIKs/9KI8g5+0DxjuUD1qgYvLw==
X-Google-Smtp-Source: APXvYqwUDgf7JyPX6HPTQqUx/qAcpASBBCIBV3bC66/ycxJrFBqB+pbO6njJJA0HY1iYHru7aPh3wA==
X-Received: by 2002:a5d:83c1:: with SMTP id u1mr1446664ior.78.1572024646595;
        Fri, 25 Oct 2019 10:30:46 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g23sm323674ioe.73.2019.10.25.10.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:30:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] net: add __sys_accept4_file() helper
Date:   Fri, 25 Oct 2019 11:30:36 -0600
Message-Id: <20191025173037.13486-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025173037.13486-1-axboe@kernel.dk>
References: <20191025173037.13486-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is identical to __sys_accept4(), except it takes a struct file
instead of an fd, and it also allows passing in extra file->f_flags
flags. The latter is done to support masking in O_NONBLOCK without
manipulating the original file flags.

No functional changes in this patch.

Cc: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/socket.h |  3 ++
 net/socket.c           | 65 ++++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index fc0bed59fc84..dd061f741bc1 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -392,6 +392,9 @@ extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
 extern int __sys_sendto(int fd, void __user *buff, size_t len,
 			unsigned int flags, struct sockaddr __user *addr,
 			int addr_len);
+extern int __sys_accept4_file(struct file *file, unsigned file_flags,
+			struct sockaddr __user *upeer_sockaddr,
+			 int __user *upeer_addrlen, int flags);
 extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 			 int __user *upeer_addrlen, int flags);
 extern int __sys_socket(int family, int type, int protocol);
diff --git a/net/socket.c b/net/socket.c
index 6a9ab7a8b1d2..40ab39f6c5d8 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1690,24 +1690,13 @@ SYSCALL_DEFINE2(listen, int, fd, int, backlog)
 	return __sys_listen(fd, backlog);
 }
 
-/*
- *	For accept, we attempt to create a new socket, set up the link
- *	with the client, wake up the client, then return the new
- *	connected fd. We collect the address of the connector in kernel
- *	space and move it to user at the very end. This is unclean because
- *	we open the socket then return an error.
- *
- *	1003.1g adds the ability to recvmsg() to query connection pending
- *	status to recvmsg. We need to add that support in a way thats
- *	clean when we restructure accept also.
- */
-
-int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
-		  int __user *upeer_addrlen, int flags)
+int __sys_accept4_file(struct file *file, unsigned file_flags,
+		       struct sockaddr __user *upeer_sockaddr,
+		       int __user *upeer_addrlen, int flags)
 {
 	struct socket *sock, *newsock;
 	struct file *newfile;
-	int err, len, newfd, fput_needed;
+	int err, len, newfd;
 	struct sockaddr_storage address;
 
 	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
@@ -1716,14 +1705,14 @@ int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
 		flags = (flags & ~SOCK_NONBLOCK) | O_NONBLOCK;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
+	sock = sock_from_file(file, &err);
 	if (!sock)
 		goto out;
 
 	err = -ENFILE;
 	newsock = sock_alloc();
 	if (!newsock)
-		goto out_put;
+		goto out;
 
 	newsock->type = sock->type;
 	newsock->ops = sock->ops;
@@ -1738,20 +1727,21 @@ int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 	if (unlikely(newfd < 0)) {
 		err = newfd;
 		sock_release(newsock);
-		goto out_put;
+		goto out;
 	}
 	newfile = sock_alloc_file(newsock, flags, sock->sk->sk_prot_creator->name);
 	if (IS_ERR(newfile)) {
 		err = PTR_ERR(newfile);
 		put_unused_fd(newfd);
-		goto out_put;
+		goto out;
 	}
 
 	err = security_socket_accept(sock, newsock);
 	if (err)
 		goto out_fd;
 
-	err = sock->ops->accept(sock, newsock, sock->file->f_flags, false);
+	err = sock->ops->accept(sock, newsock, sock->file->f_flags | file_flags,
+					false);
 	if (err < 0)
 		goto out_fd;
 
@@ -1772,15 +1762,42 @@ int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 
 	fd_install(newfd, newfile);
 	err = newfd;
-
-out_put:
-	fput_light(sock->file, fput_needed);
 out:
 	return err;
 out_fd:
 	fput(newfile);
 	put_unused_fd(newfd);
-	goto out_put;
+	goto out;
+
+}
+
+/*
+ *	For accept, we attempt to create a new socket, set up the link
+ *	with the client, wake up the client, then return the new
+ *	connected fd. We collect the address of the connector in kernel
+ *	space and move it to user at the very end. This is unclean because
+ *	we open the socket then return an error.
+ *
+ *	1003.1g adds the ability to recvmsg() to query connection pending
+ *	status to recvmsg. We need to add that support in a way thats
+ *	clean when we restructure accept also.
+ */
+
+int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
+		  int __user *upeer_addrlen, int flags)
+{
+	int ret = -EBADF;
+	struct fd f;
+
+	f = fdget(fd);
+	if (f.file) {
+		ret = __sys_accept4_file(f.file, 0, upeer_sockaddr,
+						upeer_addrlen, flags);
+		if (f.flags)
+			fput(f.file);
+	}
+
+	return ret;
 }
 
 SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
-- 
2.17.1

