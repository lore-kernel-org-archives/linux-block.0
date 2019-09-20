Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE2C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 23:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2962A2080F
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 23:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YmDAEANH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407071AbfITXKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:10:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38077 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407054AbfITXKg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 19:10:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id w10so3878787plq.5
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2019 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=teelS75FoQ0Q/2i1ntC2ci03atUEPC5q6ZB7a7OkshU=;
        b=YmDAEANHs448JdqUnpDcINkesxeSvkEClBz/vxq037u0eBdubgy2Kzf0Mh88IHsz1C
         lBOZlooWXwGh1b8MoUZi5RAO6dXecmhdPgGvn9Fr2LHm4O8Svyb/3Lm5GRokVNoUvWWf
         sBOjaReK4JRm2lntljgUUm6lKJUU4YFxrIzQfpRAYDPO6xfwL1JdxZBjTwIjTOnipOX6
         xBWPpxTvzsZStNs4lbt1qTw5pbBA8Yg8/UwqqyTR4L1imVLBL6L8AiTZUKX4fuxWU+v8
         eCiqPEk+yVSfObrwTITSW2d7cKBHVABvxA1nlGoahAMOfSW23NKKYQV4OVtQ/DX/PXeV
         cQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=teelS75FoQ0Q/2i1ntC2ci03atUEPC5q6ZB7a7OkshU=;
        b=JjWGHCbPi7zrLfW8ovjkLk6gJpfVWasdKYxIlFSpgktZBjYUN8yoaYUceQCrR7T7Q4
         YX2jn1rvRDfs7mbDcygunRLTgqjbY1HNeriQwqrXGseoI3t1vQmxe0bcb8AWF+MMknni
         fj4djcyZLwrUFCzSj8cZ3HFq6aPWZZoMfDUlcUP5mtdJXKrVv1o2h5cqTkfY2nfT/lnw
         NhRrBneO+8KOCwBcLmoCVrAPkz5RiSwNx08zzszt7MMdog49neW3bDPBsMeUyt+kOru5
         tpxeaSyg/JuNNTz+zE3HW6t2ji+I+D8OD3VHKxoHynT+lXUujz05eGnFYPX88NqTWRME
         DxKQ==
X-Gm-Message-State: APjAAAW5CT/sF5T+V4DAOfgZMJIBfPvf4l2JejPsF3TQxhg4SunCzykh
        n7E3g2W+SuPqsj3KnMDDpc3GEcG24fqxWg==
X-Google-Smtp-Source: APXvYqwIfhRUh/GxHV4b+qfre8POasXqkhuVAFJqwlzUbVAVkVCykvxH3elHSHYuxfs+v/omEY6bBg==
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr20155341pls.10.1569021034669;
        Fri, 20 Sep 2019 16:10:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z2sm4798672pfq.58.2019.09.20.16.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 16:10:33 -0700 (PDT)
Subject: Re: [PATCH] io_uring: IORING_OP_TIMEOUT support
From:   Jens Axboe <axboe@kernel.dk>
To:     Andres Freund <andres@anarazel.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f0488dd6-c32b-be96-9bdc-67099f1f56f8@kernel.dk>
 <20190920165348.pjmdnm3mozna3ous@alap3.anarazel.de>
 <838a193a-cb83-c6d5-f251-b113e9faf9d5@kernel.dk>
 <20190920205654.2g7z6znt4r337qrt@alap3.anarazel.de>
 <bd6ee297-da1b-d82c-d776-1d75a72b35e8@kernel.dk>
Message-ID: <dc70ab56-49c9-4110-3115-902d743e4e66@kernel.dk>
Date:   Fri, 20 Sep 2019 17:10:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bd6ee297-da1b-d82c-d776-1d75a72b35e8@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/19 3:26 PM, Jens Axboe wrote:
> But sounds like we are in violent agreement. I'll post a new patch for
> this soonish.

How about this? You pass in number of events in sqe->off. If that amount
of events happen before the timer expires, then the timer is deleted and
the completion posted. The timeout cqe->res will be -ETIME if the timer
expired, and 0 if it got removed due to hitting the number of events.

Lightly tested, works for me.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 05a299e80159..88d4584f12cd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -200,6 +200,7 @@ struct io_ring_ctx {
 		struct io_uring_sqe	*sq_sqes;
 
 		struct list_head	defer_list;
+		struct list_head	timeout_list;
 	} ____cacheline_aligned_in_smp;
 
 	/* IO offload */
@@ -216,6 +217,7 @@ struct io_ring_ctx {
 		struct wait_queue_head	cq_wait;
 		struct fasync_struct	*cq_fasync;
 		struct eventfd_ctx	*cq_ev_fd;
+		atomic_t		cq_timeouts;
 	} ____cacheline_aligned_in_smp;
 
 	struct io_rings	*rings;
@@ -283,6 +285,12 @@ struct io_poll_iocb {
 	struct wait_queue_entry		wait;
 };
 
+struct io_timeout {
+	struct file			*file;
+	unsigned			count;
+	struct hrtimer			timer;
+};
+
 /*
  * NOTE! Each of the iocb union members has the file pointer
  * as the first entry in their struct definition. So you can
@@ -294,6 +302,7 @@ struct io_kiocb {
 		struct file		*file;
 		struct kiocb		rw;
 		struct io_poll_iocb	poll;
+		struct io_timeout	timeout;
 	};
 
 	struct sqe_submit	submit;
@@ -344,6 +353,8 @@ struct io_submit_state {
 };
 
 static void io_sq_wq_submit_work(struct work_struct *work);
+static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+				 long res);
 static void __io_free_req(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
@@ -400,6 +411,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	INIT_LIST_HEAD(&ctx->poll_list);
 	INIT_LIST_HEAD(&ctx->cancel_list);
 	INIT_LIST_HEAD(&ctx->defer_list);
+	INIT_LIST_HEAD(&ctx->timeout_list);
 	return ctx;
 }
 
@@ -460,10 +472,40 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 	queue_work(ctx->sqo_wq[rw], &req->work);
 }
 
+static void io_kill_timeout(struct io_kiocb *req)
+{
+	int ret;
+
+	ret = hrtimer_try_to_cancel(&req->timeout.timer);
+	if (ret != -1) {
+		list_del(&req->list);
+		io_cqring_fill_event(req->ctx, req->user_data, 0);
+		__io_free_req(req);
+	}
+}
+
+static void io_kill_timeouts(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req, *tmp;
+
+	spin_lock_irq(&ctx->completion_lock);
+	list_for_each_entry_safe(req, tmp, &ctx->timeout_list, list)
+		io_kill_timeout(req);
+	spin_unlock_irq(&ctx->completion_lock);
+}
+
 static void io_commit_cqring(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
 
+	if (!list_empty(&ctx->timeout_list)) {
+		struct io_kiocb *tmp;
+
+		list_for_each_entry_safe(req, tmp, &ctx->timeout_list, list)
+			if (!--req->timeout.count)
+				io_kill_timeout(req);
+	}
+
 	__io_commit_cqring(ctx);
 
 	while ((req = io_get_deferred_req(ctx)) != NULL) {
@@ -1765,6 +1807,60 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return ipt.error;
 }
 
+static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
+{
+	struct io_ring_ctx *ctx;
+	struct io_kiocb *req;
+	unsigned long flags;
+
+	req = container_of(timer, struct io_kiocb, timeout.timer);
+	ctx = req->ctx;
+	atomic_inc(&ctx->cq_timeouts);
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+	list_del(&req->list);
+
+	io_cqring_fill_event(ctx, req->user_data, -ETIME);
+	io_commit_cqring(ctx);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+
+	io_cqring_ev_posted(ctx);
+
+	io_put_req(req);
+	return HRTIMER_NORESTART;
+}
+
+static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct timespec ts;
+
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->len != 1)
+		return -EINVAL;
+	if (copy_from_user(&ts, (void __user *) sqe->addr, sizeof(ts)))
+		return -EFAULT;
+
+	/*
+	 * sqe->off holds how many events that need to occur for this
+	 * timeout event to be satisfied.
+	 */
+	req->timeout.count = READ_ONCE(sqe->off);
+	if (!req->timeout.count)
+		req->timeout.count = 1;
+
+	spin_lock_irq(&ctx->completion_lock);
+	list_add_tail(&req->list, &ctx->timeout_list);
+	spin_unlock_irq(&ctx->completion_lock);
+
+	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	req->timeout.timer.function = io_timeout_fn;
+	hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
+			HRTIMER_MODE_REL);
+	return 0;
+}
+
 static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			const struct io_uring_sqe *sqe)
 {
@@ -1842,6 +1938,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_RECVMSG:
 		ret = io_recvmsg(req, s->sqe, force_nonblock);
 		break;
+	case IORING_OP_TIMEOUT:
+		ret = io_timeout(req, s->sqe);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2599,6 +2698,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
 	struct io_rings *rings = ctx->rings;
+	unsigned nr_timeouts;
 	int ret;
 
 	if (io_cqring_events(rings) >= min_events)
@@ -2617,7 +2717,15 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	ret = wait_event_interruptible(ctx->wait, io_cqring_events(rings) >= min_events);
+	nr_timeouts = atomic_read(&ctx->cq_timeouts);
+	/*
+	 * Return if we have enough events, or if a timeout occured since
+	 * we started waiting. For timeouts, we always want to return to
+	 * userspace.
+	 */
+	ret = wait_event_interruptible(ctx->wait,
+				io_cqring_events(rings) >= min_events ||
+				atomic_read(&ctx->cq_timeouts) != nr_timeouts);
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
@@ -3288,6 +3396,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
+	io_kill_timeouts(ctx);
 	io_poll_remove_all(ctx);
 	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 96ee9d94b73e..cf3101dc6b1e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -61,6 +61,7 @@ struct io_uring_sqe {
 #define IORING_OP_SYNC_FILE_RANGE	8
 #define IORING_OP_SENDMSG	9
 #define IORING_OP_RECVMSG	10
+#define IORING_OP_TIMEOUT	11
 
 /*
  * sqe->fsync_flags

-- 
Jens Axboe

