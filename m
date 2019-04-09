Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A14C282DA
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A192133D
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NgPGvA2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDIQ1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:27:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37799 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDIQ1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 12:27:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so10020939pfr.4
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NjH3l1S65wvOriqqUQr6RgCY2OAzbap8AC4F6zPrTso=;
        b=NgPGvA2KadR7Ct0II6MDftS8rZJFXcrTFrXzaiQXr2pTRzKKTv+1C2VrYeITXd7Dc4
         ca7GjiWsHe8B6ApD3k54/KbQs9xVurfdPxWEs3n7mmJJiUMV3VBA8VV3Jiaa7Q5Mfjz5
         5X+Rp7qaGtQIw1eIuF/2c0HST1L1bqG+dyVQlCAr95zCH2a8arg+uLzeo2D3piCU1gTL
         yb7jS2/7gdu/py14vG7rHOCZjc2UTtKSn4wdczMw4jhTx5fmOr3Q3PxjjaBBBBg1hZyk
         8KC0dOWVUTJm0NnD4IURhjdY7NzC+TR/RXoOBB7v/aMdlbtc6w87CwdsYb4ee43o7eXf
         hwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NjH3l1S65wvOriqqUQr6RgCY2OAzbap8AC4F6zPrTso=;
        b=s2Z135ENieI3j7VJZZi4NIn5fOD2TtoXZ1XvqCVrAn+wpyA44f3mce2vrAo8zVA020
         g0UoDvuFotRBSY9UVjJBzrBog8Y3jsE6aoOIZZYd2QNZejXWU+FEuKv25DhcOdMIUPc8
         4oU1NHqu4LLwi3KuHsJhLcG/CX3WDbNCgRNExgEb2pcSmsvzHWbfqDfE6pQ+oR62kzD/
         6Bh+ZNUlo2+HQ1KFw2CxIhHkFVq0o2wXGtDPNrupY5g7zCoxmi3s6zeiO0NMUDLt+vQR
         M12ZLE+MooB17xkh/Gle2GEsJe90uiuvEZXh928jF+oQV7eBImJOZa/y0QQkSs80YCB8
         4SkA==
X-Gm-Message-State: APjAAAX+ub1aoP+h2vbh3JXViaEuHWT8V6E+OwcKE0ugt5hgMJGyerdS
        yywmSECqHxyxs40UefHUy3mn2QqGKvR3FA==
X-Google-Smtp-Source: APXvYqxosd71lhowLTDP2VHCpcruuo+WTbBydmPHCMK3WFh8pXecPwLMkgJ7ciH9X2CRuHLTdsBhfA==
X-Received: by 2002:a63:7444:: with SMTP id e4mr36061971pgn.261.1554827266098;
        Tue, 09 Apr 2019 09:27:46 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r87sm63181265pfa.71.2019.04.09.09.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:27:44 -0700 (PDT)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: add support for barrier fsync
Message-ID: <7c7276e4-8ffa-495a-6abf-926a58ee899e@kernel.dk>
Date:   Tue, 9 Apr 2019 10:27:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's a quite common use case to issue a bunch of writes, then an fsync
or fdatasync when they complete. Since io_uring doesn't guarantee any
type of ordering, the application must track issued writes and wait
with the fsync issue until they have completed.

Add an IORING_FSYNC_BARRIER flag that helps with this so the application
doesn't have to do this manually. If this flag is set for the fsync
request, we won't issue it until pending IO has already completed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 07d6ef195d05..08f1e5766554 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -172,6 +172,7 @@ struct io_ring_ctx {
 		 */
 		struct list_head	poll_list;
 		struct list_head	cancel_list;
+		struct list_head	fsync_list;
 	} ____cacheline_aligned_in_smp;
 
 	struct async_list	pending_async[2];
@@ -202,6 +203,11 @@ struct io_poll_iocb {
 	struct wait_queue_entry		wait;
 };
 
+struct io_fsync_iocb {
+	struct file			*file;
+	unsigned			sequence;
+};
+
 /*
  * NOTE! Each of the iocb union members has the file pointer
  * as the first entry in their struct definition. So you can
@@ -213,6 +219,7 @@ struct io_kiocb {
 		struct file		*file;
 		struct kiocb		rw;
 		struct io_poll_iocb	poll;
+		struct io_fsync_iocb	fsync;
 	};
 
 	struct sqe_submit	submit;
@@ -255,6 +262,8 @@ struct io_submit_state {
 	unsigned int		ios_left;
 };
 
+static void io_sq_wq_submit_work(struct work_struct *work);
+
 static struct kmem_cache *req_cachep;
 
 static const struct file_operations io_uring_fops;
@@ -306,10 +315,32 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	spin_lock_init(&ctx->completion_lock);
 	INIT_LIST_HEAD(&ctx->poll_list);
 	INIT_LIST_HEAD(&ctx->cancel_list);
+	INIT_LIST_HEAD(&ctx->fsync_list);
 	return ctx;
 }
 
-static void io_commit_cqring(struct io_ring_ctx *ctx)
+static inline bool io_sequence_defer(struct io_ring_ctx *ctx, unsigned seq)
+{
+	return seq > ctx->cached_cq_tail + ctx->sq_ring->dropped;
+}
+
+static struct io_kiocb *io_get_ready_fsync(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	if (list_empty(&ctx->fsync_list))
+		return NULL;
+
+	req = list_first_entry(&ctx->fsync_list, struct io_kiocb, list);
+	if (!io_sequence_defer(ctx, req->fsync.sequence)) {
+		list_del_init(&req->list);
+		return req;
+	}
+
+	return NULL;
+}
+
+static void __io_commit_cqring(struct io_ring_ctx *ctx)
 {
 	struct io_cq_ring *ring = ctx->cq_ring;
 
@@ -330,6 +361,16 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 	}
 }
 
+static void io_commit_cqring(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	__io_commit_cqring(ctx);
+
+	while ((req = io_get_ready_fsync(ctx)) != NULL)
+		queue_work(ctx->sqo_wq, &req->work);
+}
+
 static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 {
 	struct io_cq_ring *ring = ctx->cq_ring;
@@ -1073,9 +1114,39 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 	return 0;
 }
 
-static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+static int io_fsync_defer(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_uring_sqe *sqe_copy;
+
+	if (!io_sequence_defer(ctx, req->fsync.sequence))
+		return 0;
+
+	sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
+	if (!sqe_copy)
+		return -EAGAIN;
+
+	spin_lock_irq(&ctx->completion_lock);
+	if (!io_sequence_defer(ctx, req->fsync.sequence)) {
+		spin_unlock_irq(&ctx->completion_lock);
+		kfree(sqe_copy);
+		return 0;
+	}
+
+	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
+	req->submit.sqe = sqe_copy;
+
+	INIT_WORK(&req->work, io_sq_wq_submit_work);
+	list_add_tail(&req->list, &ctx->fsync_list);
+	spin_unlock_irq(&ctx->completion_lock);
+	return -EIOCBQUEUED;
+}
+
+static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+			 unsigned fsync_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
+	int ret = 0;
 
 	if (!req->file)
 		return -EBADF;
@@ -1088,8 +1159,13 @@ static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
 		return -EINVAL;
 
+	if (fsync_flags & IORING_FSYNC_BARRIER) {
+		req->fsync.sequence = ctx->cached_sq_head - 1;
+		ret = io_fsync_defer(req, sqe);
+	}
+
 	req->flags |= REQ_F_PREPPED;
-	return 0;
+	return ret;
 }
 
 static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
@@ -1102,12 +1178,15 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	int ret;
 
 	fsync_flags = READ_ONCE(sqe->fsync_flags);
-	if (unlikely(fsync_flags & ~IORING_FSYNC_DATASYNC))
+	if (unlikely(fsync_flags & ~(IORING_FSYNC_DATASYNC|IORING_FSYNC_BARRIER)))
 		return -EINVAL;
 
-	ret = io_prep_fsync(req, sqe);
-	if (ret)
+	ret = io_prep_fsync(req, sqe, fsync_flags);
+	if (ret) {
+		if (ret == -EIOCBQUEUED)
+			return 0;
 		return ret;
+	}
 
 	/* fsync always requires a blocking context */
 	if (force_nonblock)
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e23408692118..57b8f4d57af6 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -59,6 +59,7 @@ struct io_uring_sqe {
  * sqe->fsync_flags
  */
 #define IORING_FSYNC_DATASYNC	(1U << 0)
+#define IORING_FSYNC_BARRIER	(1U << 1)
 
 /*
  * IO completion data structure (Completion Queue Entry)

-- 
Jens Axboe

