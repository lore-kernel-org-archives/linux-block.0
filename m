Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E0FA372A
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 21:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028A721A49
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 21:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hPSBkvGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503669AbfJQV3O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:29:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46515 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503659AbfJQV3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 17:29:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so2426340pfg.13
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2019 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=doYdHShm7Cj6c5yy0xMLHFKPEk8aJtR5YML+JUnmtX8=;
        b=hPSBkvGihBWMfS/THlqQxutH+w1AuaWzHDziJJpI2bdMNmcS9hr71S7mmR59eGs6tO
         m+lypp2NuuiH6ZEKSdXFuXQmhwpCT4hHn2SnqGc/h00eWTlsYA9+hXmUNTV2byEWJOdw
         erCSC+bcyauQNJHW1EnbnfqdleE2R7/boxRATJz8tnhrn/8jYRhx0QFoaJ4iVg9YNxxo
         gyNEC9Nr+vGrAGYjna0SYqIptcQ6CeZ+mrTsIuNlZSHsmAJd/tkpgaTYq+Xoa3hftBkB
         PgVrtlzpfPdDuBZTRJYhkH24W3SEeJyJmQwKvhJZerHEMVfhwBhm9c5V93wEAKC6hoUI
         yPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=doYdHShm7Cj6c5yy0xMLHFKPEk8aJtR5YML+JUnmtX8=;
        b=WEhXdkylZeIwkWecjaw+Ph2ZP9CK5/52CUSt2EewzbtI3j7ulE1J1dcMIkSXaBO2ii
         x6NuWkHQe4NlSc6JzMTSql6PyoohJ28sZBuoBUIpuXMATdLkOsop10uw7NFLlEzZs8uq
         HYsSdE2Ev3zaIVFwlyJT0jXehUN6+pcUe4c+xsreMx2jJHTCUDMGrx40Z4KEkSa5MSVw
         /xJo5j3a2lJC6iZIOM3OzxgSLq6NVPxOmqikHsN/pY0MCyNYPnCeIOEZF4lMncMGB0K/
         IDY4zQOaaabJTDqtnDcXOwlEiRWvZsM3hdNPgNLYqA4pAkR9A1wsTITv24ehftA16U7J
         O2kQ==
X-Gm-Message-State: APjAAAWeJiIKin2ag24XDAUUpk8MidBVwUjFvBS/n4smoq0dUa3u28Kd
        qjLodtXWDG12glxcLnjXr2wNIPnk+vJo4g==
X-Google-Smtp-Source: APXvYqyEn7Tz/OO0FGVOq3vwqrkRJjAra9c1NDd8sbbDTq7xFSlmrOLUotkwy3IcJD1TD48GEh9BrQ==
X-Received: by 2002:a17:90a:17e1:: with SMTP id q88mr6872814pja.134.1571347751462;
        Thu, 17 Oct 2019 14:29:11 -0700 (PDT)
Received: from x1.thefacebook.com ([2620:10d:c090:180::e2ce])
        by smtp.gmail.com with ESMTPSA id w6sm4296446pfw.84.2019.10.17.14.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 14:29:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: add support for IORING_OP_ACCEPT
Date:   Thu, 17 Oct 2019 15:28:58 -0600
Message-Id: <20191017212858.13230-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017212858.13230-1-axboe@kernel.dk>
References: <20191017212858.13230-1-axboe@kernel.dk>
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
index ad462237275e..8d183a6b08d4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1694,6 +1694,38 @@ static int io_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
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
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+
+	addr = (struct sockaddr __user *) READ_ONCE(sqe->addr);
+	addr_len = (int __user *) READ_ONCE(sqe->addr2);
+	flags = READ_ONCE(sqe->accept_flags);
+	file_flags = force_nonblock ? O_NONBLOCK : 0;
+
+	ret = __sys_accept4_file(req->file, file_flags, addr, addr_len, flags);
+	if (ret == -EAGAIN && force_nonblock) {
+		req->flags |= REQ_F_NEED_FILES;
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
@@ -2144,6 +2176,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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

