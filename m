Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AAEC282CC
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8151621934
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="orkfrOHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBIVOE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:14:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39446 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfBIVOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:14:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so3322700pfa.6
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eQtBxayuV3Xz6yL7f1QRwAethRRukad+OWrWf/KC/jo=;
        b=orkfrOHUr8X0OKq9a5B0AXctYjNHe/XUwUCspHdLPNvMMvGS3UoKXaIJvxKCkYSqg6
         Osu0F0qIEOSOZw47VeCEF6PJLLVEaM9ZHO7htvEmlih+TnwmLPm84xjG8gH5L7KOvKaK
         p+g/PPUhJGY3Ahi8jbC/+lVo2+0lONr9b/of6wvPjLUWALx4Q1ZcVlLfp9S+mK5yNCJU
         mYiMLmv+ooCVEESzkRbxno1c+Ls7R6XbQsbgp/W7vdlyePOk49Wslh3ALpLucFCjIz1v
         1KdCkzG14sF4J2qUB8kNbj2DXBsznd06qlX/WG//LQatBx2jX9ET8FyHyjsNzUnw63mz
         amHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eQtBxayuV3Xz6yL7f1QRwAethRRukad+OWrWf/KC/jo=;
        b=EK7o7EAi0rmzI0/hg4E1cR/2qTmk01gzbPjsUOCRE5koXlAuu2J2zEdKRQLnfdAhCZ
         CZPjk05HygT74FP3T8l7wc0djwJIv0TKA4wMlO/sfEp0E/6ulQthqntPWcaT+ouVdsit
         f5+JCNjljPWgz2BalFO2m7ykbvTT9asBGhFPZbLVijnxYSXlKBaWcwmhHEarExwvPRN/
         5huMe0K+3CYs7m/oQcj81ILvkfWBqBQSZweNZj2ibUMILLTwaOSbHRF7OS1tvAhxYKaT
         A9ROje9v0ekHpC14Vf/vFNcBWah8x1xQ2akcj7KP0CPxDkjpvo4ruMGHZmatojksDxE5
         GIyw==
X-Gm-Message-State: AHQUAuaxAwpHzDJyPfna4mAmxJ/EXZLjPb/oAIzYLYpaeksL4vYtZgH2
        q1jPbwc8gARGJ/1/RaoDqmziyQ==
X-Google-Smtp-Source: AHgI3IYHJz+JqD+UEVHvgXm+HMQpVqkzmT42Io+avnnsoYGgpU++CnF6WIa3/z1LgVygKKpYPqSj2Q==
X-Received: by 2002:a62:28c9:: with SMTP id o192mr29733616pfo.57.1549746843709;
        Sat, 09 Feb 2019 13:14:03 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:14:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/19] io_uring: add fsync support
Date:   Sat,  9 Feb 2019 14:13:33 -0700
Message-Id: <20190209211346.26060-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
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
index bc6f819fdf8c..8af7093f0608 100644
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
@@ -533,6 +534,56 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
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
@@ -554,6 +605,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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

