Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E547FC43444
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B452420850
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b55XYKNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfARQMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:12:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37454 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbfARQMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:12:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so6266817pgb.4
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B+ngOqxtkell8tMitE8QAbzC+xS03+bz1EA2WKjHVWQ=;
        b=b55XYKNn1eBDlEJOscP4/EvADszggrtPnUgZLmEZVccomiGNkrYvP8v3Ba5HM0FZlI
         /N3LVqYXNylPVY2U0K6cqLCDAc2NwIb+RQftc3RirQFAahsljwaiXVuBI1+E2MD4I6T3
         MmtCFX7h8I6zNHll7WmNrjse5xdd+uB1u+JasLHrajgD+S7Wh1BhfsANHgP+/ddN9XDd
         uU31U8iMF+37CT01RmEF40ZjSfoIZ2W2nbRukzicdYUQlUSB8zhQ7PIs36ZSBuw8rfzl
         ie519csaqhPcmBG/E1OTyB4Cd4GN5mGQAwjJOmMa9RuAEU5ql77jf82DQgGei7beQTvE
         b6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B+ngOqxtkell8tMitE8QAbzC+xS03+bz1EA2WKjHVWQ=;
        b=JruVEFmBGTsircrOlppumiZvOdprpcNNls4PhYsHgpIf4c8mY57MQUfbtcLSrW8dKb
         EZmx+uDwXQZX0TKIosTCfBrZ5kSW1SBwpO6Am6Y0s4Sopj/zNXjGr/TIvsri4du+0Q8a
         ikfu9H1inqTwRoHORVrIWcDGbYz6wnm3y7nVNuRkbbbw859daemecvGa++9DNSYGI1mE
         szs/Xx5n7XnTxZ08D7JR8+sWwErWSA6Qq81GOAAVZXi7ef8PcUHyh17zDqFHrMfvJ9rp
         i93BkJivTL6g2NYM9LeGcTm+Gq5pq1KxSyt4t0qcTimeWVa0gmqIFSoVO80uy5yaFEIB
         /WvQ==
X-Gm-Message-State: AJcUukfC2mDR11stOOMn/dOIi6l82JlPOeeEL2ODeoU+RU5OX9NnSIBD
        XTeXlkiUl+/kAvC7RWE6jef5Ww==
X-Google-Smtp-Source: ALg8bN6j16HsXbr7xqXEPoSo0EbI6cwDlwrCk0TxFaKdNOLoKqGGbxqrXC3d7IH6nGRymNdD+e6+jQ==
X-Received: by 2002:a63:981:: with SMTP id 123mr18405305pgj.444.1547827966871;
        Fri, 18 Jan 2019 08:12:46 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:12:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/17] io_uring: add fsync support
Date:   Fri, 18 Jan 2019 09:12:14 -0700
Message-Id: <20190118161225.4545-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118161225.4545-1-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
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
index 2952d0a82dd3..f464f6ca2b7d 100644
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
@@ -465,6 +466,36 @@ static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
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
@@ -486,6 +517,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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

