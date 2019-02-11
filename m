Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2E6C4151A
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB0F2229E
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="koMEoRJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbfBKTBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50616 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733264AbfBKTBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:07 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so938944iti.0
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxYi0FhWuXRKsMffM0NC7yJF4pwiUC98N3zVoSyVJvw=;
        b=koMEoRJ64skLgy28IDgk9fDtL+YI1Uqu5V+3syXQZDF+R1+lwSt7rWizFwBzSZNxNd
         94gB6ctdIUv8ijte5NE3EJZNsVs7YTA9UxKl0Lg0M/VSDw+Bt62gUtbw8cmhTC/gXWkm
         cdvNke0l/arkRhxLDuGSWwxZ0iqspYNpofEpiKtQ69Q6B9XDH3f9StwRKK/HBPEgk6ns
         yvbafFfqdLvS0NWD6ygQ3PJg+X4YJVgOZY/h+wEVPq3wnJiX7xRCkRl+mx45S+1BIdlg
         d8h9+M4S4l0nDer4b3a2idxOjIUNxA2TD7E0yG3h7Yp4zxN3oYCOdE37Bd7OFduSpm9Q
         vjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bxYi0FhWuXRKsMffM0NC7yJF4pwiUC98N3zVoSyVJvw=;
        b=mj+30mSK7lqcazTtJOHYoAWqexJkY8X3KNMQUwPmEzGKwTBVfrop6150RCtHHMmA16
         7Bzn0gdgUwXByBBPY06sH11pxMHzhq5UR9+QYbtCqpAlpQNmVxB885T0TZ+MDWN70gIX
         tpqYadua6JuDST5XKZr+OZf8XIt5T+i8QhWSCi9R8dFQLlEFuq6lQkt2/5t3EczJ1RcA
         tCUzeCpV3n5ycdckrSSLMb8QjizCoQfJKFCaJf/ZfzGiADHp2V1fPOdOMxnQyS/0Kh8l
         K5RoWrZ+PeD+8kqlcc107Vsl9XVefcqFtmA4XOL1pPX5QbBiaunaR1yPgMj/Q9TCiNU8
         Zh4Q==
X-Gm-Message-State: AHQUAuZVp0dVn+HYyBsXsw3jUjMiGtg752vUdPqDqBVBAThT1Wvy/rNX
        9OWFF1fCIi5CDCPH3ZXb89WHrw==
X-Google-Smtp-Source: AHgI3IZ7oJ0kY0Lq5zVOFtMxEOOKAhOYiM4EEGLoMkEzA36h5Kb/Nd7bDZ/oZiCQWunX21Os9ya2jw==
X-Received: by 2002:a5d:8d18:: with SMTP id p24mr9166675ioj.223.1549911666098;
        Mon, 11 Feb 2019 11:01:06 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:01:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/19] io_uring: add fsync support
Date:   Mon, 11 Feb 2019 12:00:36 -0700
Message-Id: <20190211190049.7888-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
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

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 54 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  8 +++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1b28d38a9b76..dc9155b7294e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -24,6 +24,7 @@
  * data that the application could potentially modify, it remains stable.
  *
  * Copyright (C) 2018-2019 Jens Axboe
+ * Copyright (c) 2018-2019 Christoph Hellwig
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -557,6 +558,56 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 	return 0;
 }
 
+static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	int fd;
+
+	/* Prep already done */
+	if (req->rw.ki_filp)
+		return 0;
+
+	if (unlikely(sqe->addr || sqe->ioprio))
+		return -EINVAL;
+
+	fd = READ_ONCE(sqe->fd);
+	req->rw.ki_filp = fget(fd);
+	if (unlikely(!req->rw.ki_filp))
+		return -EBADF;
+
+	return 0;
+}
+
+static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		    bool force_nonblock)
+{
+	loff_t sqe_off = READ_ONCE(sqe->off);
+	loff_t sqe_len = READ_ONCE(sqe->len);
+	loff_t end = sqe_off + sqe_len;
+	unsigned fsync_flags;
+	int ret;
+
+	fsync_flags = READ_ONCE(sqe->fsync_flags);
+	if (unlikely(fsync_flags & ~IORING_FSYNC_DATASYNC))
+		return -EINVAL;
+
+	ret = io_prep_fsync(req, sqe);
+	if (ret)
+		return ret;
+
+	/* fsync always requires a blocking context */
+	if (force_nonblock)
+		return -EAGAIN;
+
+	ret = vfs_fsync_range(req->rw.ki_filp, sqe_off,
+				end > 0 ? end : LLONG_MAX,
+				fsync_flags & IORING_FSYNC_DATASYNC);
+
+	fput(req->rw.ki_filp);
+	io_cqring_add_event(req->ctx, sqe->user_data, ret, 0);
+	io_free_req(req);
+	return 0;
+}
+
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   const struct sqe_submit *s, bool force_nonblock)
 {
@@ -578,6 +629,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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

