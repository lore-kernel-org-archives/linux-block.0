Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98AAC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A4421872
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nnsEtgms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfBAPYb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:31 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52349 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbfBAPYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:31 -0500
Received: by mail-it1-f194.google.com with SMTP id d11so9632015itf.2
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BNlz25pr5ZEU/bAxQFsl0VFz4PQkGhr4Ho2bXNY6uwA=;
        b=nnsEtgmsBFKlbt+6+FVgmj5EqRqPKews6qAgAdLbJwlGAKSym68Tjc1ZZGo1qXQ89I
         4lRp1ViQMIhxC77zp0KeKtTxAWUquw1E7aseNzA+He4/yrrhlih2kldNWhyJcayMxWKV
         Msh04YRHWDvMXfhHZAHH7bhkQ4we1uC9Xfy3rlmwR3IZ0WQA9WrgSSOKQ6y0MQOTh3Ye
         L3cnWsiOa/Qxo8Imj7G/8puxBE50xBQVs5foBVzb68FX3G1oHAt086215l0PoscedHmI
         fckSDl9dyaBWT9nY56c6FlvMEbwCU/DLyaHMO2xqgzeVFvxMPz3BC8I1twip7JeOr69M
         AeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BNlz25pr5ZEU/bAxQFsl0VFz4PQkGhr4Ho2bXNY6uwA=;
        b=MV4HGSByd6llfcR518myhv+WLKbFwr5n5Q6xaRGZ7dRrCTLy5f10NSOfiAQgK4C64C
         8fzIbFGXO3O3kSrVDLetfZQ39xhSy3C9LcdMJGAqfN6+1eOzmSyB5RcNVCos+ks2UeW+
         jbvTKAsfzBDDQMBZ6OMgQRjwGptKg5kg8kGjTwT2JR4BIiAXI7DoADazWlN/PpnLGLvM
         pCOSNwbj+gr53zRpHsJhbw+gZWZz2NEgxzJFlNqPd2tBVzbFynz7i8cR1u9vfuNONMca
         Tmg1Ws3QgoDelfPbGnDdwNHsRRtUdIxX9yZPosOZEAxiITPkK+8LAkTuuvn/ozFdGuJL
         D97g==
X-Gm-Message-State: AHQUAuZ64K7IzqzLwaxn0e8bTlDcTrdBkhgWdt8t+B2kyZxNNn+wdm0I
        hxEilbj+vIbHDe4a1aLETf6pnw==
X-Google-Smtp-Source: AHgI3IYK1vRov4gAEue2AVq2Om/ajPflqfQ/r4kmf36uI0ohAIm+YB9+t0+IxJTTlqKDYBiP8g/R1w==
X-Received: by 2002:a24:fa4b:: with SMTP id v72mr1657310ith.20.1549034670230;
        Fri, 01 Feb 2019 07:24:30 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/18] io_uring: add fsync support
Date:   Fri,  1 Feb 2019 08:24:02 -0700
Message-Id: <20190201152414.23296-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
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
index ab05fd377049..a1b7b87a98d7 100644
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

