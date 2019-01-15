Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C3C43612
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65602206B7
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QYWwzZPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfAOCzv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:55:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43490 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfAOCzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:55:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so547639pgk.10
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dvVSpCTDLkzAa0HlGl7Glbq/TudFLjKvX778OEvoz/k=;
        b=QYWwzZPa9eu0R3r96mVaH+sD7TkW0lmozYcIT7raUw1151ReLpzsg/dSy4O+t1mXJc
         dnQUDSH2oKih4WcbCn9qARB6GsyeJDg7tR53jDyqbdhBi6a+JFv1rEhBD3s1dOO6LUFC
         bcE40wTQMEOviP2O1Y/LDHI6gANBZoiMr6ud6DPUaJAK2wzpYOHFA40N6PrLwdVWSWxi
         AjIoxlJXDuR9+9VHG6P2ZU/ZyjGkI+R49kOLkKh5NYZZ4bv1xr4/VSMxg80zkfFK2rhJ
         rQNOHzKpf1yAVVX9SNX5QCsrDGIdWo6G+I4Umvw6y97JW1+uF64kfJGblLkpqpsaJgQ5
         X/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dvVSpCTDLkzAa0HlGl7Glbq/TudFLjKvX778OEvoz/k=;
        b=EBPJeaJlRs2EaPYW+VDNeEmfVt8aAwgVlL2FsquitRRVYh06tjDy1EKsqw0FwMygKx
         RhEBi1xOal2Bw+rztKYlx8kxQpCkd0s1VEUvysnOxVS0JWua9WjkwB7sUrl4HcOtLNbj
         wO/y76AccFgERUfrm6ek1KiKxFLiq0mQAe+Mw73rBu+bnXu6Z+oL8IYdHkQj1gTRtwmU
         V/nPG6O7xe+UYBbIS2vqIz32Jlj1i72zDuiDziX5rpd89inPk2qVOZ9LtFQdc6AhZUz+
         D51QEShCC4J7QHxllSnM5pMXMvO1XbflC7CaNxs4wMYEuW/cUIExBWJkrU2mcA6SE2II
         QKEA==
X-Gm-Message-State: AJcUukeNnw3ck+NGOke1KydIO9UBFlSvPLCEOREVdhlyOA7qLSnUdRYU
        pfm4m7Os4I+xp4ZqOTiGZMNMIA==
X-Google-Smtp-Source: ALg8bN5FJEH8/MHHlCPHqrJdTbHX/L4WLJqsjNLtsSutxYIHLuTsXVShwmCCRTIbN0sr9jBcqm+d9A==
X-Received: by 2002:a63:f444:: with SMTP id p4mr1692242pgk.124.1547520949830;
        Mon, 14 Jan 2019 18:55:49 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/16] io_uring: add fsync support
Date:   Mon, 14 Jan 2019 19:55:21 -0700
Message-Id: <20190115025531.13985-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
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
index 148eb3af7dc4..7d74463217a6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -449,6 +449,36 @@ static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
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
@@ -474,6 +504,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
index a1ebaa09e1b8..ac49bd179ed9 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -27,7 +27,7 @@ struct io_uring_sqe {
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
 		__kernel_rwf_t	rw_flags;
-		__u32		__resv;
+		__u32		fsync_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	__u64	__pad2[3];
@@ -36,6 +36,12 @@ struct io_uring_sqe {
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

