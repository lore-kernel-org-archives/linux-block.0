Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC789C282CF
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA042177E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1mQE0ktQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfA1Vf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:35:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56300 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfA1Vf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:35:57 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so906376ith.5
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8r3NrG14radg1cc9nOpeVXnMvLMDl7fB5/7Hgnpl5vg=;
        b=1mQE0ktQ3PbzQDOJ6YpvHF2lmmbnyRSK43TzAOCUafsWoXcv8ZmPd+/5twtXl2oVMf
         cvESjnUujE4I5A8PUNlVCN5KA0YHze3IpmlHe+dCnMt6yDytFpJJS6OA6RaU8RkYExPv
         NOq2HyAmXBdMEEGzRrsAuG+ivR+F5blILoioKPWHPDMF+rwO7wQaXOX9VZXLDOhZIQr8
         B6S9D8r3tbNXhugx/wXHR/MnP0I9lMYs2vR4NF71m4D8hp0j/TDikXDlZc53W/0jazw9
         Hf5lQ4XNqYSGhUk+JHUX0KOGVnJrF2cI3/335fe9N9+OfAiGO5OpD6nyZFU4AZ1aJmFk
         Rw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8r3NrG14radg1cc9nOpeVXnMvLMDl7fB5/7Hgnpl5vg=;
        b=s1auZCawO6hqeqenAABZR/joI8l9UjJmUG1COJ7QJv7nDvrDAjl8fIa2Q5Q4S3hUgy
         0qFdSc0jgmf3my+0kZqnNGc5Q1hCwbsiFcCHn+dJ4q3tK39iSCa+3Nqu9NYI+eoNiws/
         UqKY1mWnZ2ciXFVlW+wQ8Oy68D/QBgKENfvAxX7k8TWYaer30y+pKArZwnl7UaGeQN1/
         VEWqNNvKm+9C9Dsy11dso960Cgsto62nfFRqG0+Z5wkvpFtmQhpQUfJ0BWlwwUDTGQ2N
         8PQ6kVALVZXfKcclWqM9M0HEZCpH/0KXhcyyAQ4ATLYtT7FiIPOU7HpuQlR6a/0bPX5w
         js5A==
X-Gm-Message-State: AJcUukcG7W8T2AAleP1gNdp15sJ0XMJo23zT54IGNzo4PXNoFagcINLn
        PxxMDCLQ62MYtCSgWO+UZ/scAA==
X-Google-Smtp-Source: ALg8bN4ZkBDQcCL1zWSQhZmMjVR3qc9S7EALWopNJCWcc7nPJEm/jHxSLWJFxx29QHcMtEDoE70/Hw==
X-Received: by 2002:a02:1bc5:: with SMTP id 66mr15261028jas.105.1548711355930;
        Mon, 28 Jan 2019 13:35:55 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:35:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/18] io_uring: add fsync support
Date:   Mon, 28 Jan 2019 14:35:26 -0700
Message-Id: <20190128213538.13486-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 34 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  8 +++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 309eed3629d2..7d2e6db08b05 100644
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
@@ -466,6 +467,36 @@ static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
+static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		    bool force_nonblock)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	loff_t end = sqe->off + sqe->len;
+	struct file *file;
+	int ret;
+
+	/* fsync always requires a blocking context */
+	if (force_nonblock)
+		return -EAGAIN;
+
+	if (unlikely(sqe->addr || sqe->ioprio))
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
+	io_cqring_add_event(ctx, sqe->user_data, ret, 0);
+	io_free_req(req);
+	return 0;
+}
+
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   struct sqe_submit *s, bool force_nonblock)
 {
@@ -487,6 +518,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
index ce65db9269a8..ca503ded73e3 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -26,7 +26,7 @@ struct io_uring_sqe {
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
 		__kernel_rwf_t	rw_flags;
-		__u32		__resv;
+		__u32		fsync_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	__u64	__pad2[3];
@@ -35,6 +35,12 @@ struct io_uring_sqe {
 #define IORING_OP_NOP		0
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

