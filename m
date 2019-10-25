Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735ACA9EBE
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C0821D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w0UwFk56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505893AbfJYRbl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:31:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33704 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505883AbfJYRaw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 13:30:52 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so3346651ior.0
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wTR5iTu8qxd9g7eLd8K6LBymJYwzVyhOH22aSZJ49ZA=;
        b=w0UwFk56i+jEFwBRCWVBN0+u6HkQbPjq8+/3iG7PpgLFvkZQi/Fa4UJyEJu9VWS24n
         zVzrFkZeyta6ea3T6LEyLJxunNZOf9Aag88JtZ/b7+zFXkr5tPaNOqKDWgPqLx2RClY4
         mOKsw/HcVC8OtUbNpVicpEMK0sTocy0+dy0k+MxIOI0/4Ftinwp32w1961wHy5b0HYhj
         8R82VclIdCCYr5O9X2rZ/dboEKQDobt+3RJp8ZQufT/jttNLOEYHdB2oaXpSw5Lts08O
         Eczb8OpZ8StQsFDBKlohuoOO2JDJfAhF39RnwoCBRTHL9XlfOZ4ZZPx/BCxEucnDFNoj
         S3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wTR5iTu8qxd9g7eLd8K6LBymJYwzVyhOH22aSZJ49ZA=;
        b=tkgubDarvGFlB4b5Gl9iXb5STB+Drmz/JbB2wDHUzoN15D5dUKGofE+NBYQpFy3hvH
         9H1OFh5zPrqKjzeB4csRIWRV+L2Pv5bS5XsiFtTNHjAlY84YUxyJuSO5IYyd9RNh8Z75
         Qk3ib8utXZQw7QTEzjbpSaMbU0UDRi3mmBECk1B3boQaFRB+iKBGFhBVEj9GuzSiKvOO
         KvK7qvpgHX94rqzYnCq3mW4E9+JotlaQYX/UHWSDIdvpWemm69e6ZXguj9tf2+vxTsm8
         cWkE1lXrOwCPObIJvR49JO82r05tX3Xhxf7UPA8n8iJQjJBhez67+e4LmHxiHqYE43RA
         Wefg==
X-Gm-Message-State: APjAAAV1/GWdknlybSUFn0MucLSzTu9iGbnOoYG5z62mbNaWAxsDb3vc
        KhRzD/n820bzOvk52+l3lx+1lsz0mC4zNQ==
X-Google-Smtp-Source: APXvYqzddTq9xHH/LP/GQgmjueIfFEpwDhlGEjJskjOvwEijfI2Kc5EQbd0qfNFJDzzUpXG59IJOSQ==
X-Received: by 2002:a6b:fa19:: with SMTP id p25mr4747107ioh.125.1572024649744;
        Fri, 25 Oct 2019 10:30:49 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g23sm323674ioe.73.2019.10.25.10.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:30:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] io_uring: add support for IORING_OP_ACCEPT
Date:   Fri, 25 Oct 2019 11:30:37 -0600
Message-Id: <20191025173037.13486-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025173037.13486-1-axboe@kernel.dk>
References: <20191025173037.13486-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows an application to call accept4() in an async fashion. Like
other opcodes, we first try a non-blocking accept, then punt to async
context if we have to.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 35 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  7 ++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5a6f8e1dc718..4402485f0879 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1687,6 +1687,38 @@ static int io_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 #endif
 }
 
+static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		     struct io_kiocb **nxt, bool force_nonblock)
+{
+#if defined(CONFIG_NET)
+	struct sockaddr __user *addr;
+	int __user *addr_len;
+	unsigned file_flags;
+	int flags, ret;
+
+	if (unlikely(req->ctx->flags & (IORING_SETUP_IOPOLL|IORING_SETUP_SQPOLL)))
+		return -EINVAL;
+
+	addr = (struct sockaddr __user *) (unsigned long) READ_ONCE(sqe->addr);
+	addr_len = (int __user *) (unsigned long) READ_ONCE(sqe->addr2);
+	flags = READ_ONCE(sqe->accept_flags);
+	file_flags = force_nonblock ? O_NONBLOCK : 0;
+
+	ret = __sys_accept4_file(req->file, file_flags, addr, addr_len, flags);
+	if (ret == -EAGAIN && force_nonblock) {
+		req->work.flags |= IO_WQ_WORK_NEEDS_FILES;
+		return -EAGAIN;
+	}
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
+	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_put_req(req, nxt);
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 static void io_poll_remove_one(struct io_kiocb *req)
 {
 	struct io_poll_iocb *poll = &req->poll;
@@ -2174,6 +2206,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_TIMEOUT_REMOVE:
 		ret = io_timeout_remove(req, s->sqe);
 		break;
+	case IORING_OP_ACCEPT:
+		ret = io_accept(req, s->sqe, nxt, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 6dc5ced1c37a..f82d90e617a6 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -19,7 +19,10 @@ struct io_uring_sqe {
 	__u8	flags;		/* IOSQE_ flags */
 	__u16	ioprio;		/* ioprio for the request */
 	__s32	fd;		/* file descriptor to do IO on */
-	__u64	off;		/* offset into file */
+	union {
+		__u64	off;	/* offset into file */
+		__u64	addr2;
+	};
 	__u64	addr;		/* pointer to buffer or iovecs */
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
@@ -29,6 +32,7 @@ struct io_uring_sqe {
 		__u32		sync_range_flags;
 		__u32		msg_flags;
 		__u32		timeout_flags;
+		__u32		accept_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	union {
@@ -65,6 +69,7 @@ struct io_uring_sqe {
 #define IORING_OP_RECVMSG	10
 #define IORING_OP_TIMEOUT	11
 #define IORING_OP_TIMEOUT_REMOVE	12
+#define IORING_OP_ACCEPT	13
 
 /*
  * sqe->fsync_flags
-- 
2.17.1

