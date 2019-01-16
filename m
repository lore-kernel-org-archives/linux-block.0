Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB26EC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8C2082F
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V35gud4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfAPRuX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:50:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55962 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfAPRuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 12:50:23 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so4367644ith.5
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OupOW3VwHB6tWHT8SUdnb9w+rLEOXhO4z2r3B9lMfmc=;
        b=V35gud4RSLl8GBWK/qK4AZ3/fTcG8HgmILJ7vBRmj9gt4hsHT6MIiJcXh68R6Air61
         i3NSXKnx3vB1sMyq1RWE5TV0Io2y4w93glHXw2ktDf58iC4XE9CmK75xFg+E165giC3s
         Bogv9stSJv6xDzMFtbhUMyxUXEWercXCfvbSwcN/pisktctzAuppiZTYVh2OTwJ9ecNu
         3kKIq8Rp9KmX8r7gon0NNCCekBLrQHkdo60QgiETFSVD9bW6OZz+BuK+3LmbBhdgA6Jp
         5ktkvNNhTSBRM3KWEGI0QE+9z9C2odh31cXBZGEL0Z/64i9h1InjpPAOfh5y8swlIChB
         t1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OupOW3VwHB6tWHT8SUdnb9w+rLEOXhO4z2r3B9lMfmc=;
        b=L3l/zd3ralElPmmEumlC7zMyz2vdVCVCzjAC+3lPGpcQjpinunsoVqYou3m2AgCly3
         LuSMSPIZajHbmHviZRqYIW+isfxvEpPbMLBbUzGUl+r01xfCKTYtB8HRctHdklLpVobG
         EAFPOMnGnZFdEdG3kNnyYwPqqsha3CABh7OgEPZSqqSGi5gKzFdvz6fjavqJeEJ0kQ/U
         O4X7yO9P6JK7NRFRpGQbeHrANHYZL+cHRvjK/zWph9zWH/Rjma6kvMuhf8mRXxJ5lDz8
         Fe1JE8RHU4X4+l3J7kcmlPQL9MGiPKFpeWQnf6JQkrH+UbpIb0AARS8iSzr7fe5qptvf
         k4aw==
X-Gm-Message-State: AJcUukd4GNIlSuXEnNx96rLDQ6zyjRa/SRz5zNYaWQoYgHdZP2xixnoW
        1OTHDOjg1OAktto87WSHMYn+vg==
X-Google-Smtp-Source: ALg8bN7qhbgAAeG18WwVcHx8zYCyZRCu5hghjF5mZkB6Z4/hFZBRCEiAFwQhz913LVZLJGY+orWdiA==
X-Received: by 2002:a24:a64f:: with SMTP id r15mr6217194iti.101.1547661022505;
        Wed, 16 Jan 2019 09:50:22 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm3705690itb.8.2019.01.16.09.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:50:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/15] io_uring: add fsync support
Date:   Wed, 16 Jan 2019 10:49:54 -0700
Message-Id: <20190116175003.17880-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
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
index 54dac6213a4f..47959f28d5e0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -457,6 +457,36 @@ static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
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
@@ -482,6 +512,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
index 0b1dfc2a278a..3f5f9a8642cb 100644
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
+#define IORING_FSYNC_DATASYNC	(1 << 0)
 
 /*
  * IO completion data structure (Completion Queue Entry)
-- 
2.17.1

