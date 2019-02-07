Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A6FC282CC
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E972A2173B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hluCxhbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfBGT4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36954 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfBGT4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:11 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so2958058iti.2
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rf7RqaMZdixzZlTvGWlyJgJvm8vyz+uMGRavhxLh86s=;
        b=hluCxhbfuIbcDlTYI6NttBBq1dndLtKRNvOHuannGv9UVgA9+wDRtMhF8vIRYfY+z+
         YWM6LhyJoZxGB8CnPBHdnDmQ1GORdT2zWnUaps0mc88y0Ll5kB4wuEhfr2eOezmo7Fq0
         2m0eQOfmkYm9qbDRVyO23orNf5bHboLFB3dKS47KuimCj3IEk/rgfwoVPVGSAIQeEp2v
         1w2FIkGkmmtfDJCkYYgJ3WAvWC+Asv/hynO9RcENRoe92j25kgz1voXopr5ZoFDOrwKs
         cFC14NtTInFYNybxgPTAl76szv5lyRQJfEv7dGCZbMoNa8gkvKNCYaX4KdtGt1/9tMz+
         Sb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rf7RqaMZdixzZlTvGWlyJgJvm8vyz+uMGRavhxLh86s=;
        b=dtkXRNQ2MMED/IQn0nMp2hXiMwCKydHZCucuMWBVl8A9PqAKDFN2UyvL+wOIEFNQzQ
         WnaYrrlFQHN+aApAGNhNaM6WGjBXD4w1JwAi3V5OqnvBWw0ujWqAUmfIw46Gn51GBNwj
         Q6cOixxJKvGjuMKibp0IzN8IeBGU/HVouBzlgUuLbt9x01zuXoX0Ghrwr7H5mldABi7z
         yp+vd97VwmAH1gmX0zctWpsR6HlpaNG6SViUetYGSsQ8pvZPLqJeOrK0xZRQjiFq+hZL
         3UhYtrd797Y0kSPSK8zn18h07bR7qI1kitnE4HtaIDiNIe/mnKdUC9uj9a+/C0DiPYAx
         Tqpw==
X-Gm-Message-State: AHQUAuaIjJSpgwU34k7tAgtjEbIkPvNZZVS/+oj6vv48m0nB3j/cAoKN
        jPtZsYDPdZeFjT4hoWbUEFkw2A==
X-Google-Smtp-Source: AHgI3IZojjfQZUntG4iYZBx1RXLeFrUk9cIy5C0QJDTZgIx+g12xhY+v7X07d7C1gFQfKGNS+wcJog==
X-Received: by 2002:a02:601d:: with SMTP id i29mr8988816jac.11.1549569370533;
        Thu, 07 Feb 2019 11:56:10 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/18] io_uring: add fsync support
Date:   Thu,  7 Feb 2019 12:55:40 -0700
Message-Id: <20190207195552.22770-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
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
index 39a6cd14f0ec..e92ae7abffce 100644
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
@@ -517,6 +518,42 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
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
@@ -538,6 +575,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
index ac692823d6f4..4589d56d0b68 100644
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

