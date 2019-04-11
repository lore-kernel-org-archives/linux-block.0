Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B91C10F14
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD43A2173C
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wL45qkaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKPHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:07:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41478 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKPHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:07:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so3548533plj.8
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2019 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0xL4w0F1B+J5454K56TlE8W3VFRPmyEybwUFOoOzosA=;
        b=wL45qkajdZPYKKWee5ynwT7z0iUlS6k407bET2jimqOde1yhGTGxxuijsZsgZFRKSg
         FYYS3mRLZuohdqBuvgmh1iEJ3m28X2FtNyhwU0al8ms+g43UmGE85zNNPMzKmqRkVuVb
         vldIDmW/+p73UJpGFzJONEn3VC5/WN+N3aEzaAg+CkBbQbhT7I7oP+BLexI4T16H0vgj
         C4vjD7sE3tH+wfhKfXBQ97ffV52CJdYA7RDocqjgvcrUuuHsVrFejR0HU+jS2Nz7bpSF
         7az/FHZeIAEE3l6p/4cFLSj2ezsiVnz4EMFaivurGuTXnGt/WV+5AhqxiVrlkGev7Bp3
         7bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0xL4w0F1B+J5454K56TlE8W3VFRPmyEybwUFOoOzosA=;
        b=l9IRrJ/IYdz6oD0T9L3P6cwntYki5bGSuMX86wkNtarlrrqO/gxf1C6O0cwuXgmaiP
         O4krkDVi57N33Ubo1PsKwItW0Y0vsj7tnL7AOLnDHudE/qpS7LbhKpzWGZaDBtetKx6g
         /3GRZaMtrj5d4Nx2zOrQGE5Hf4ZixAdM32w+7cMdJtJy4vUFxK4FQxNnWTxoany+VLYm
         eMetzVBjGTmdvcMn90lnIyGwfJ70RR4Bcfa+/uslOMszixgK8HLtPHjXGYgbuexl94YQ
         /L3ijJtKWRYhKVBA83KXkBujnIQbiK2cAliEAfckSBuGwG4B8wNiC0UjgU1B9/PeNR2a
         GFuQ==
X-Gm-Message-State: APjAAAUYxf8936+DrTbo6p5Fv/GDRD77JDq1WIfNTHIpX2RWv+nNhFPX
        WYz0d/8tMpTbpZKD8U8VJtraew==
X-Google-Smtp-Source: APXvYqxjcDlwwHvUaa+b0FRAdtAfFujQlEEd2sQF59zQxdZP+VD2BS38DDKv2hbyI78rmUeqgS5/qA==
X-Received: by 2002:a17:902:ea0d:: with SMTP id cu13mr50217664plb.92.1554995224967;
        Thu, 11 Apr 2019 08:07:04 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s12sm62905062pgc.28.2019.04.11.08.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:07:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] io_uring: add support for marking commands as draining
Date:   Thu, 11 Apr 2019 09:06:55 -0600
Message-Id: <20190411150657.18480-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411150657.18480-1-axboe@kernel.dk>
References: <20190411150657.18480-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are no ordering constraints between the submission and completion
side of io_uring. But sometimes that would be useful to have. One common
example is doing an fsync, for instance, and have it ordered with
previous writes. Without support for that, the application must do this
tracking itself.

This adds a general SQE flag, IOSQE_IO_DRAIN. If a command is marked
with this flag, then it will not be issued before previous commands have
completed, and subsequent commands submitted after the drain will not be
issued before the drain is started.. If there are no pending commands,
setting this flag will not change the behavior of the issue of the
command.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 91 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |  1 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 07d6ef195d05..a10fd5900a17 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -121,6 +121,8 @@ struct io_ring_ctx {
 		unsigned		sq_mask;
 		unsigned		sq_thread_idle;
 		struct io_uring_sqe	*sq_sqes;
+
+		struct list_head	defer_list;
 	} ____cacheline_aligned_in_smp;
 
 	/* IO offload */
@@ -226,8 +228,11 @@ struct io_kiocb {
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
 #define REQ_F_SEQ_PREV		8	/* sequential with previous */
 #define REQ_F_PREPPED		16	/* prep already done */
+#define REQ_F_IO_DRAIN		32	/* drain existing IO first */
+#define REQ_F_IO_DRAINED	64	/* drain done */
 	u64			user_data;
-	u64			error;
+	u32			error;
+	u32			sequence;
 
 	struct work_struct	work;
 };
@@ -255,6 +260,8 @@ struct io_submit_state {
 	unsigned int		ios_left;
 };
 
+static void io_sq_wq_submit_work(struct work_struct *work);
+
 static struct kmem_cache *req_cachep;
 
 static const struct file_operations io_uring_fops;
@@ -306,10 +313,36 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	spin_lock_init(&ctx->completion_lock);
 	INIT_LIST_HEAD(&ctx->poll_list);
 	INIT_LIST_HEAD(&ctx->cancel_list);
+	INIT_LIST_HEAD(&ctx->defer_list);
 	return ctx;
 }
 
-static void io_commit_cqring(struct io_ring_ctx *ctx)
+static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
+				     struct io_kiocb *req)
+{
+	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
+		return false;
+
+	return req->sequence > ctx->cached_cq_tail + ctx->sq_ring->dropped;
+}
+
+static struct io_kiocb *io_get_deferred_req(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	if (list_empty(&ctx->defer_list))
+		return NULL;
+
+	req = list_first_entry(&ctx->defer_list, struct io_kiocb, list);
+	if (!io_sequence_defer(ctx, req)) {
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
 
@@ -330,6 +363,18 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 	}
 }
 
+static void io_commit_cqring(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	__io_commit_cqring(ctx);
+
+	while ((req = io_get_deferred_req(ctx)) != NULL) {
+		req->flags |= REQ_F_IO_DRAINED;
+		queue_work(ctx->sqo_wq, &req->work);
+	}
+}
+
 static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 {
 	struct io_cq_ring *ring = ctx->cq_ring;
@@ -1337,6 +1382,34 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return ipt.error;
 }
 
+static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			const struct io_uring_sqe *sqe)
+{
+	struct io_uring_sqe *sqe_copy;
+
+	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list))
+		return 0;
+
+	sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
+	if (!sqe_copy)
+		return -EAGAIN;
+
+	spin_lock_irq(&ctx->completion_lock);
+	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list)) {
+		spin_unlock_irq(&ctx->completion_lock);
+		kfree(sqe_copy);
+		return 0;
+	}
+
+	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
+	req->submit.sqe = sqe_copy;
+
+	INIT_WORK(&req->work, io_sq_wq_submit_work);
+	list_add_tail(&req->list, &ctx->defer_list);
+	spin_unlock_irq(&ctx->completion_lock);
+	return -EIOCBQUEUED;
+}
+
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   const struct sqe_submit *s, bool force_nonblock,
 			   struct io_submit_state *state)
@@ -1585,6 +1658,11 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	flags = READ_ONCE(s->sqe->flags);
 	fd = READ_ONCE(s->sqe->fd);
 
+	if (flags & IOSQE_IO_DRAIN) {
+		req->flags |= REQ_F_IO_DRAIN;
+		req->sequence = ctx->cached_sq_head - 1;
+	}
+
 	if (!io_op_needs_file(s->sqe)) {
 		req->file = NULL;
 		return 0;
@@ -1614,7 +1692,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	int ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(s->sqe->flags & ~IOSQE_FIXED_FILE))
+	if (unlikely(s->sqe->flags & ~(IOSQE_FIXED_FILE | IOSQE_IO_DRAIN)))
 		return -EINVAL;
 
 	req = io_get_req(ctx, state);
@@ -1625,6 +1703,13 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(ret))
 		goto out;
 
+	ret = io_req_defer(ctx, req, s->sqe);
+	if (ret) {
+		if (ret == -EIOCBQUEUED)
+			ret = 0;
+		return ret;
+	}
+
 	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		struct io_uring_sqe *sqe_copy;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index e23408692118..a7a6384d0c70 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -38,6 +38,7 @@ struct io_uring_sqe {
  * sqe->flags
  */
 #define IOSQE_FIXED_FILE	(1U << 0)	/* use fixed fileset */
+#define IOSQE_IO_DRAIN		(1U << 1)	/* issue after inflight IO */
 
 /*
  * io_uring_setup() flags
-- 
2.17.1

