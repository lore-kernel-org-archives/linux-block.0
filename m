Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA9C49ED9
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1952089F
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sK0bXOt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436872AbfIJQmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:42:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33241 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfIJQmy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 12:42:54 -0400
Received: by mail-io1-f67.google.com with SMTP id m11so39073105ioo.0
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2019 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z88mpf7Z9vvUH+AtdP8BL5MishRujD/mcVODCGscRmc=;
        b=sK0bXOt7FrOH8DhBrEvJllLGQNDssn+az7tQX88BGV3PUMmEGjU6erVyu7jZ0Y8fH6
         TKbjpYLacA7lqoB+Mf1FdbXkglGZnGiM3hH/61rT0wKRmRCj1ynNrFWs2ELqRmtV2Y84
         fdJclmkG1x/qfj0eB3QTJwg7LSC6neCUQiHp45IVcakM7LiPeMiN4mntQyF165XCk2W7
         9LsPS/hIiKfbIHNPDrvxAIQk0NKMWbNDvujyD8dR7nVnOSmHNhbXuYKQoi+dKV4G34+W
         VdSchub09d/xT6WrT0kuXbTCm2aBJxmNv+Kfyl59bZoiVZFas16Eq/lYbyqNVhCi4Hp3
         kf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z88mpf7Z9vvUH+AtdP8BL5MishRujD/mcVODCGscRmc=;
        b=A5bkstCe9PAFzh4PSGCkEHzZcth1eSM6qaWNHPgSLD9ROdIRId5xlbsWeMJ2dMgC/Q
         Y2StBE9Si5p9KUPaeOiXLCSXiBnvlrEltfekdn9sNppali0pHYVZ1yUPQbSoTLcGS2Yj
         SXEaP8/MWewW6+OYlTEeAKAWGeBcVJ03LW2yCFKvvjzOp50uN6RsqBP9cPhMacGR19xx
         kO4JIu2j/09dCeW8vfA1VJaqP4YNv7in4BF52xhTJ+hRc+mN39nRur7grnZryFnJgNS0
         f5UfPK7d7B0JTJkh4gcDyv4/7wk7Ds+t06Wnh9UhLDshvFmilIx+pXGth92gJ5jjNlTv
         GRoQ==
X-Gm-Message-State: APjAAAUH0IIAAvW9D6KfsqbVHf7rlkvuJ12M6Yh7JuFKgq5FAyH3Ir0w
        iwQ/letcdGakfv0g+Xt+8B+7vhg0a/472g==
X-Google-Smtp-Source: APXvYqwBqLe1xBZ+VndRlfIjvlFiIBU2phb4O+SprgqHIV9bo5RjgNdRjJ0S7FNx5clrZTWqKdin4A==
X-Received: by 2002:a5d:8942:: with SMTP id b2mr578664iot.183.1568133771948;
        Tue, 10 Sep 2019 09:42:51 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm16849797iod.78.2019.09.10.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 09:42:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: limit parallelism of buffered writes
Date:   Tue, 10 Sep 2019 10:42:45 -0600
Message-Id: <20190910164245.14625-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910164245.14625-1-axboe@kernel.dk>
References: <20190910164245.14625-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All the popular filesystems need to grab the inode lock for buffered
writes. With io_uring punting buffered writes to async context, we
observe a lot of contention with all workers hamming this mutex.

For buffered writes, we generally don't need a lot of parallelism on
the submission side, as the flushing will take care of that for us.
Hence we don't need a deep queue on the write side, as long as we
can safely punt from the original submission context.

Add a workqueue with a limit of 2 that we can use for buffered writes.
This greatly improves the performance and efficiency of higher queue
depth buffered async writes with io_uring.

Reported-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 41840bf26d3b..03fcd974fd1d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -203,7 +203,7 @@ struct io_ring_ctx {
 	} ____cacheline_aligned_in_smp;
 
 	/* IO offload */
-	struct workqueue_struct	*sqo_wq;
+	struct workqueue_struct	*sqo_wq[2];
 	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	wait_queue_head_t	sqo_wait;
@@ -446,7 +446,19 @@ static void __io_commit_cqring(struct io_ring_ctx *ctx)
 static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 				       struct io_kiocb *req)
 {
-	queue_work(ctx->sqo_wq, &req->work);
+	int rw;
+
+	switch (req->submit.sqe->opcode) {
+	case IORING_OP_WRITEV:
+	case IORING_OP_WRITE_FIXED:
+		rw = !(req->rw.ki_flags & IOCB_DIRECT);
+		break;
+	default:
+		rw = 0;
+		break;
+	}
+
+	queue_work(ctx->sqo_wq[rw], &req->work);
 }
 
 static void io_commit_cqring(struct io_ring_ctx *ctx)
@@ -2634,11 +2646,15 @@ static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 
 static void io_finish_async(struct io_ring_ctx *ctx)
 {
+	int i;
+
 	io_sq_thread_stop(ctx);
 
-	if (ctx->sqo_wq) {
-		destroy_workqueue(ctx->sqo_wq);
-		ctx->sqo_wq = NULL;
+	for (i = 0; i < ARRAY_SIZE(ctx->sqo_wq); i++) {
+		if (ctx->sqo_wq[i]) {
+			destroy_workqueue(ctx->sqo_wq[i]);
+			ctx->sqo_wq[i] = NULL;
+		}
 	}
 }
 
@@ -2846,16 +2862,31 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 	}
 
 	/* Do QD, or 2 * CPUS, whatever is smallest */
-	ctx->sqo_wq = alloc_workqueue("io_ring-wq", WQ_UNBOUND | WQ_FREEZABLE,
+	ctx->sqo_wq[0] = alloc_workqueue("io_ring-wq",
+			WQ_UNBOUND | WQ_FREEZABLE,
 			min(ctx->sq_entries - 1, 2 * num_online_cpus()));
-	if (!ctx->sqo_wq) {
+	if (!ctx->sqo_wq[0]) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * This is for buffered writes, where we want to limit the parallelism
+	 * due to file locking in file systems. As "normal" buffered writes
+	 * should parellelize on writeout quite nicely, limit us to having 2
+	 * pending. This avoids massive contention on the inode when doing
+	 * buffered async writes.
+	 */
+	ctx->sqo_wq[1] = alloc_workqueue("io_ring-write-wq",
+						WQ_UNBOUND | WQ_FREEZABLE, 2);
+	if (!ctx->sqo_wq[1]) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
 	return 0;
 err:
-	io_sq_thread_stop(ctx);
+	io_finish_async(ctx);
 	mmdrop(ctx->sqo_mm);
 	ctx->sqo_mm = NULL;
 	return ret;
-- 
2.17.1

