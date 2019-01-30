Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8CCC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC5D20881
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GVuQ7+kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfA3XAW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:00:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33789 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfA3XAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:00:21 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so833847itk.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 15:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebr5pMIFr0p53nuinISo2xXwiprYWR1UKbNXLzMH5KA=;
        b=GVuQ7+kziPdpU7e+nIiGOnguUkKdffFpliPlHMulG6hTl4iDDuWckpp9ePkaebsA2y
         nbYUVkoW0axtRNs3ot4lS0B8jR2/JdNSQQkOOOzUM8JrYfg6bSwT4BvIuhMKxM+fF3cW
         g7mazhzwcLPJg0540/cbqrDlm4q9qygzvDrQufHYo9W9VDs0TXZKdDMV6BAmO2/Ib38+
         4vpWJuQnTdMg5zX0peBIB1Tp29GEoDqctzhofmMi41sm0op9+c3DQ7KupuDC2AbSrhaF
         VhKc2pVJC1hHGJYhHN5JadjJbU9D0BnjOWHbwDXGWVrVDzhagk9DvSx+wqbBgvGUsTiR
         dXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ebr5pMIFr0p53nuinISo2xXwiprYWR1UKbNXLzMH5KA=;
        b=lIdBNyfFU1qyIy543bgasuSJBjCBwko/OK0UV/l/AdSG3ZXpIXaeeAKbN+pJJMQXv+
         4Phv3v+b4ORZN3w4zeMfmPwz1DmiphJEkBsZYjZpS4cH7FFvHOEhKr7zh2GgiBeZV9Z1
         MtHw2dw++OCar8K5N8arJ7PieNh2DPszmUY0TnTc+LjPlWS7dWkMx5Ayx1D3K1rMgn6l
         eNpPFwIUR7C2EfWmFZDa84gd/5YWNxRNM8wBnq+C7EyA2QGlssc03B43ldHzby5uExqh
         sY3A2xLhfYL1G+VjlKdG/rqCxirGc2WG/d/hngG4RHgEDQXknV1E4x5ek7mrx42oDc9E
         m9HA==
X-Gm-Message-State: AJcUukcmlHxLVljdUhBrPZcQp7LMztuuZfsTNdnYoZ9VybWIe1jEGG4R
        vtDVPT80AAkauiwz7x5dXIX2bg==
X-Google-Smtp-Source: ALg8bN5otDxADoLrItKGSOV8StRjuU1Ebh5sPHNN/MAybBIFy8bs27uz9NpvCdt9Cy3jnXu5JExHcw==
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr17004821itl.83.1548885354775;
        Wed, 30 Jan 2019 13:55:54 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:55:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/18] io_uring: add fsync support
Date:   Wed, 30 Jan 2019 14:55:28 -0700
Message-Id: <20190130215540.20871-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 40 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  8 ++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 356a697ee21c..bcd3a7c72142 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4,6 +4,7 @@
  * supporting fast/efficient IO.
  *
  * Copyright (C) 2018-2019 Jens Axboe
+ * Copyright (c) 2018-2019 Christoph Hellwig
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -477,6 +478,42 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 	return 0;
 }
 
+static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		    bool force_nonblock)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	loff_t sqe_off = READ_ONCE(sqe->off);
+	loff_t sqe_len = READ_ONCE(sqe->len);
+	loff_t end = sqe_off + sqe_len;
+	unsigned fsync_flags;
+	struct file *file;
+	int ret, fd;
+
+	/* fsync always requires a blocking context */
+	if (force_nonblock)
+		return -EAGAIN;
+
+	if (unlikely(sqe->addr || sqe->ioprio))
+		return -EINVAL;
+
+	fsync_flags = READ_ONCE(sqe->fsync_flags);
+	if (unlikely(fsync_flags & ~IORING_FSYNC_DATASYNC))
+		return -EINVAL;
+
+	fd = READ_ONCE(sqe->fd);
+	file = fget(fd);
+	if (unlikely(!file))
+		return -EBADF;
+
+	ret = vfs_fsync_range(file, sqe_off, end > 0 ? end : LLONG_MAX,
+				fsync_flags & IORING_FSYNC_DATASYNC);
+
+	fput(file);
+	io_cqring_add_event(ctx, sqe->user_data, ret, 0);
+	io_free_req(req);
+	return 0;
+}
+
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   const struct sqe_submit *s, bool force_nonblock)
 {
@@ -498,6 +535,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_WRITEV:
 		ret = io_write(req, s, force_nonblock);
 		break;
+	case IORING_OP_FSYNC:
+		ret = io_fsync(req, s->sqe, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index bd47e86701ea..0fca46f8fc37 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -24,7 +24,7 @@ struct io_uring_sqe {
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
 		__kernel_rwf_t	rw_flags;
-		__u32		__resv;
+		__u32		fsync_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	__u64	__pad2[3];
@@ -33,6 +33,12 @@ struct io_uring_sqe {
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
+#define IORING_OP_FSYNC		3
+
+/*
+ * sqe->fsync_flags
+ */
+#define IORING_FSYNC_DATASYNC	(1U << 0)
 
 /*
  * IO completion data structure (Completion Queue Entry)
-- 
2.17.1

