Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70FC282C5
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B30421855
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CZBBKbA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfAWPfy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:35:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45315 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfAWPfy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:35:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so1334080pfd.12
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vD3mHfkWqh/2L12ai375xhH63L1EiQD3U0Thmed7EGM=;
        b=CZBBKbA7TRrwaKMXvrIdJ+aZ0Nr3tGR1L+cxcPxyz+Rgexx9NzBR6/h53zzF3tldRV
         VFG40wbsamggRq79uS4N52V8u8OS0rlPkpr7OKS+g+v5RgYG7gnvpkCf/JcMnlfpOFpy
         0Q9rvOUziFaDvIXlmZSaumoQiV1pKOn+f4xiXaX34ZEZZUnVPzWADqf4U6oqfHtsLu2X
         28Zx3Ypcf/un6PCs78iNoqYQIEvYkJH2qC1EM87R0gmMMTkyhE/k17Q+ardG7hCghpgp
         tsmBmtTPn7LBH139LfusYJ4JBs+k4jRoOYFYDKYbh8rfJNh5lCnbAEl9DT+PULc6/Diz
         tYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vD3mHfkWqh/2L12ai375xhH63L1EiQD3U0Thmed7EGM=;
        b=iW1LegLZOTsamqC237WMs+u+Fhemz6LtefZVA7y2ld1b2UGpvbO4hyd+Jv+wwbu3QQ
         hebRAcY3QOTgp2eaHBO899WaRoQnBMzWLugKEL6KhO73dFOV1ZDrCQAZPf0upxTz9sSD
         9cH4EW4xFsAwQ2vVuZnMkoGe40NaHEHEpx6lyGVuFPfh/VXLoRdeoZabjuK9xuO7kEZb
         dOIkPSEsXJ95bYAcEFrPx3e4DkmUKbFM942Qpemx+z17H8UNThX4NilMOP71IiSTe1OC
         4jy8Au+nsdjvTkrYovfGe9gMDj2+Nj8piLpXnPt4btZnaE6yypyJSUDOuYFNxxI5hxnK
         OqQw==
X-Gm-Message-State: AJcUuke1a0BIQzARB8l3tAQ8pxHGKcXhLTKpkcFcBg1MGecoU2QBGppn
        tzfAUQ508R5DzziZk4v+tWMWtQ==
X-Google-Smtp-Source: ALg8bN4cwOsxueTVfzo2C4UmBU7PLE5iGkaW5yxyy9O4dFz5JGqRGOnLXcgMZvBYk1OWBLLpgmzZOw==
X-Received: by 2002:a62:3141:: with SMTP id x62mr2388596pfx.12.1548257753514;
        Wed, 23 Jan 2019 07:35:53 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:35:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/18] io_uring: add fsync support
Date:   Wed, 23 Jan 2019 08:35:17 -0700
Message-Id: <20190123153536.7081-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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
index 37ab16007aa6..35d25b49ad94 100644
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

