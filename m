Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEC2C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B2820856
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oEHLxuLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfA2T1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40366 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfA2T1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:18 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so6384982ita.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VbFi69sXwOAavl43yZfQiJrSxunS27vyKBk600vh360=;
        b=oEHLxuLgrGZTouhWgT/Ax3fRaneCNNe7cmOctoMi4CT/aU3Ow6qD5Y3rxnEWVXJFhd
         Vavoh6VDIjqVlEvhrLdsJS3mlpvX3yIjRM8sEGbGesMFWyrTRwk2MbWNkr1RgeyfZMiG
         ilJFuFyOEFAz/JSxdK3rclyjfxYug9qLRp6Asng31z43y288c/WjMRq+jM4Ie9zO5Wm4
         CgJ5mIpWUsVt7KVsOv2P82A5qiFKkT2Z3RacdQYl9QNNMNulXH2KDBMwOCGZHrDgTCWo
         1cHlNzFWy8LHy3jXcjCIKWPCCbke5DnlxT5qHZ9ONX68Xm8ax6zT0fjpXH9aYIvmLHRL
         U0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VbFi69sXwOAavl43yZfQiJrSxunS27vyKBk600vh360=;
        b=n6tOE2Po+bhb/FeM0IiLNAmImpsMdTeuSUKLwsg7gi76duFl1u5vJ2IPwGH4zkYNwu
         7S30/hdR4ZRRLPnf6WzuX/sJGJTlcBNpu7ndX6dEipxulOg90S7m84xLNw6LNBoXw+0f
         fCODpPuL9K6eiVhfHj1swHsJOrEE8a6LwKyM9OedmiEBKvcdXgl9aSO2VAxpB7VEdzlk
         oysiHym7XlrZIea0KEVLVrU7Gvd+98/rw2VY2Gzhxd0hLG1IeMy1xSWyDV7hc7DzJFsg
         4PxHI2tHbvM55t/gfguQSkLllrHlk62Jr3bMaunvfE3AY276aDo2F220A50ZNxhPLJuf
         axVw==
X-Gm-Message-State: AJcUukfcp+GPJig016iJlwQmsED7LCtJyuoN0sL2QZy41wQ72c4AuXJ/
        j5UVnR2jO0rXg4Q+dOdG/NrXKA==
X-Google-Smtp-Source: ALg8bN7C7skvlkKtqiI/YX896Oriwjr1iX/Mto4hsqJI50jH41GpLZEchbTN6K4zE6BiT9WpKbQVlA==
X-Received: by 2002:a02:12c5:: with SMTP id 66mr17610936jap.54.1548790036963;
        Tue, 29 Jan 2019 11:27:16 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/18] io_uring: add fsync support
Date:   Tue, 29 Jan 2019 12:26:50 -0700
Message-Id: <20190129192702.3605-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
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
index b41fed1c056b..c75a3e197ed5 100644
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
@@ -473,6 +474,42 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
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
@@ -495,6 +532,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_WRITEV:
 		ret = io_write(req, s->sqe, force_nonblock);
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

