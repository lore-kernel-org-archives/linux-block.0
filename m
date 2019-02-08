Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F3FC282CB
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA536217D8
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xcj+bFqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfBHRes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:34:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35736 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfBHRer (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:34:47 -0500
Received: by mail-it1-f195.google.com with SMTP id r6so10902217itk.0
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GApnfsa7c+mg+tc0yKqlcv3g9TPKkz7bCJNbZx5pt0A=;
        b=xcj+bFqjW0s1JR1Zs/398yokoDoLbdW5Lyx4owiDTrBmaRhw2U1VQyFZ5AUpKTo7UU
         SWA/3M0CnwWNfY3zsenP+glLgRpeoZ0otgra8ayOhgKxhqs5TQ723vm1wGw/TF8J2lQ7
         VdRTz2s2WZhF28H84xyLqJta9loGvY7Ejj5sELXt/1g9IXTNVfPQQ4kzpgLehixnI84Z
         FH2u49+1BDIR8HikzIELG6Ps6wZvNHbZrPIZSv4VCJeeBmu5DPv8smNDhVLofsWPnfXJ
         K52QHOsGk99xkNbxjLbAO4cb9I3NqxqmLpFbomROJRzpSn6qV+YGnEyLH5dt/Y09Uczk
         xkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GApnfsa7c+mg+tc0yKqlcv3g9TPKkz7bCJNbZx5pt0A=;
        b=id0Sqsed/ZH+BtS4DvnlEypq9r3FNz7wDvGCDwPlkz8FICvSnYPIO4iQeNf0aRnBXU
         1lns3nJbNHHew1AJOwPNsrwKc8qNwXls6M/kZuk2I/XX7nU0817PmeS/u2Lr0G1Qp1/5
         6TWUVB2BMsp3MF5jttutq3hOSlOeE1ll/pLZTj6kiWTpcWkqzk7HMG4mTRfnVo/At82z
         s4ur8VqxrUUVrBnnnf8MmEQNTvun9RBFHRRUNzyB03zcb4y00E5n6uNI9bC3gTLBdMEG
         WwrlUBAAtWPwXOe/RT1Yg6qnSQUIhI4g6xfjENj5Z6KY7W8ayeLzaJWmpun+iVFLVfwW
         FYGQ==
X-Gm-Message-State: AHQUAuaKZWzRxIGRvdye64PmVc+VX6mWq6SRwUGtwNdkhhfcZVz6w628
        LUBn2Up1ByWAQ/v0sM6O4zH4f+G3VYHn+w==
X-Google-Smtp-Source: AHgI3IYctximbItKyUBcCPUdJRnb/1kxjfhS/hN0mQe/lVZduXlZNgKjNJx6aHBRKGzBEHAzMUBNMA==
X-Received: by 2002:a6b:8f48:: with SMTP id r69mr11936602iod.128.1549647286762;
        Fri, 08 Feb 2019 09:34:46 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:34:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/19] io_uring: add fsync support
Date:   Fri,  8 Feb 2019 10:34:10 -0700
Message-Id: <20190208173423.27014-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
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
index 927d61ebecf3..6cdf11373304 100644
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
@@ -518,6 +519,42 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
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
@@ -539,6 +576,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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

