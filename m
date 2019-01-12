Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBB4C43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2A720872
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YU+0DL/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfALVac (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38168 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfALVab (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so8565379pfi.5
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w5uR07zetzxo27QPcX+8gbKKzHAS9hE9QvWCuwzf6nE=;
        b=YU+0DL/6mX1sJP+4YIy+KvA0AxUV/tj8DPdL9gKSyiBjbukDVykbLVyi3MQBPJ+qGA
         7xATeZ30R21zmEnW6Fv0jyjxNIY9LEsfLJnEWRYvlOyTxtHz8ays/qEfcVvmgQvO8ObJ
         dy0COMHRsgcOTCX9L2K32E8XZjg47hizxdFsRl/wkpIiu/X9AVgWhirX0IDoQ41LvRYH
         kKeVxlL/ejdxrzv1bq4jUUaHz5vgrydJy7GI3avAfty40WYHxWJRt+zev3XtruN12x5q
         BnyKW4I5rt0RH9kBQh7EYPB4uTl0Y01F5F/ovHnqgpJNiK+7bOz2eJ4XAvkH1goD681q
         wk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w5uR07zetzxo27QPcX+8gbKKzHAS9hE9QvWCuwzf6nE=;
        b=XaJUYf4rffeJp+Lf1gXzjBR2JVYpiwWdveDNFOf1fKL4czvCjpoVczQsblLMAQpGLo
         sO8TXHbL/q8mh23p5eAytBqnZ15qAYhH8PESealCHCYAiq+Qg9FEv8TfGaLYDaRRgWQc
         oxLBL10puM90+6Rr15t4qsc6/xPYwjkVyOzAG7OpXTt+KhtiMzvpxuO2veqxQ0zVZWBC
         nt+XBoxAcpX8i0MagzsvfWxIeNuTvgrK4wdjEFox31GDi4jBihBdBNcrygrp5eBLZ4x2
         ABz/Mkzk1i8K5zcJhxJ7gMiM3MrjwYwnyyaXggM8bsJ+P0g5X/KexpaOocuC9jfl4zlb
         fvoA==
X-Gm-Message-State: AJcUukeuCJJkGw5k31drsZyneAE0TTbaxmdbonEiMJvS1A6nNUuOa5nB
        iXQCeLCi6YS6zitYvwU3ODkDYA==
X-Google-Smtp-Source: ALg8bN5ltFW7RAcMKhNgpHu10PFFLBjDEALl13mOHMxkwn8xDlhCrsveqCXLg8y//DVQvseAKgZRQQ==
X-Received: by 2002:a63:5207:: with SMTP id g7mr18161211pgb.253.1547328631145;
        Sat, 12 Jan 2019 13:30:31 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/16] io_uring: add fsync support
Date:   Sat, 12 Jan 2019 14:30:01 -0700
Message-Id: <20190112213011.1439-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Add a new fsync opcode, which either syncs a range if one is passed,
or the whole file if the offset and length fields are both cleared
to zero.  A flag is provided to use fdatasync semantics, that is only
force out metadata which is required to retrieve the file data, but
not others like metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  8 +++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index df8fe19cdb74..c51d429faef1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -419,6 +419,36 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return ret;
 }
 
+static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		    bool force_nonblock)
+{
+	struct io_ring_ctx *ctx = req->ki_ctx;
+	loff_t end = sqe->off + sqe->len;
+	struct file *file;
+	int ret;
+
+	/* fsync always requires a blocking context */
+	if (force_nonblock)
+		return -EAGAIN;
+
+	if (unlikely(sqe->addr))
+		return -EINVAL;
+	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
+		return -EINVAL;
+
+	file = fget(sqe->fd);
+	if (unlikely(!file))
+		return -EBADF;
+
+	ret = vfs_fsync_range(file, sqe->off, end > 0 ? end : LLONG_MAX,
+			sqe->fsync_flags & IORING_FSYNC_DATASYNC);
+
+	fput(file);
+	io_cqring_fill_event(ctx, sqe->user_data, ret, 0);
+	io_free_req(req);
+	return 0;
+}
+
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   struct sqe_submit *s, bool force_nonblock)
 {
@@ -441,6 +471,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_WRITEV:
 		ret = io_write(req, sqe, force_nonblock);
 		break;
+	case IORING_OP_FSYNC:
+		ret = io_fsync(req, sqe, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index dbbfc02bc0a8..72e8f5f13f3b 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -27,7 +27,7 @@ struct io_uring_sqe {
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
 		__kernel_rwf_t	rw_flags;
-		__u32		__resv;
+		__u32		fsync_flags;
 	};
 	__u64	__pad2;
 	__u64	user_data;	/* data to be passed back at completion time */
@@ -35,6 +35,12 @@ struct io_uring_sqe {
 
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
+#define IORING_OP_FSYNC		3
+
+/*
+ * sqe->fsync_flags
+ */
+#define IORING_FSYNC_DATASYNC	(1 << 0)
 
 /*
  * IO completion data structure (Completion Queue Entry)
-- 
2.17.1

