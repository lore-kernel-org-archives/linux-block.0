Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8793DC4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 19:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B020665
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 19:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z2snWn0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfIQTiJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:38:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38384 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfIQTiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 15:38:09 -0400
Received: by mail-io1-f66.google.com with SMTP id k5so10500114iol.5
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1XZHt/H1b8l6RwrrDS4uUKWiF3tv/RURgPy8VMEQBT8=;
        b=Z2snWn0Ff2blSLYT2W5yPnv3Qgwjk49DeHDypMHpMglAqaiA00QFpOTzLHCOJv+OdV
         Xf2zUlGKSF/0k+7i7fQj3jHzyRnqCUmVqI7IKKBPUdwMuhRzhkD8/FXO1zIRQNMG71n7
         EF7f9ICbPRe2NYcbVOrYPgNyDOVMxxt94m5Fyhybz8OnzVXwOgv5/9QW3bnMTebYf31p
         53fMzJyWTNmFRIvG27iFGBmDptbNgLGxKOhYY1BwKUCxWJu/eEjDlaiEWwJBemIBEFUU
         MU6eIuQbSxwuEXKvUVW4alIfGVdqbPe5JtzDwayTMBrIodrKBg8d/yb4q81rZTF9so5K
         6i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1XZHt/H1b8l6RwrrDS4uUKWiF3tv/RURgPy8VMEQBT8=;
        b=S3SFtlvHQiz9WOnbxiA+scJzsgIgv7xURoYG3AQddEu16Yaz4tCODMgvqmM9EyaB83
         HavOOdAzOmr/dsUO5m+npP7EhqQdWlXkpyYmNEgCfOi4xFpLQMLBZYbkrR5XcQVgieDF
         URQc9aFznzcT66NJOdjEcyf0TAnBTcuCQlxgKh2pgizLFWxj5EgoqHQFrEdArnG2ZLqi
         9Dgi2BvtD8ANy4PEhtdl1o9gVMmh20HBZr/jjsrYQDOwxbR2pmq9fnocQbx8qx/0GVEZ
         YRytBPYaJLpXP/W1MA3g9W0K3NeOTeh8+v2Z97h5SMToeknPh+Eht8EA+8UqpUMLy15F
         93jg==
X-Gm-Message-State: APjAAAUzgxY9Q2dodWa5Uj0fv8NGthlIrvtQIn1oPipLXOqPU6Xnb0s6
        u8/3mGOtMjYQ3PXOuhqtn/iGvNviVQIZNA==
X-Google-Smtp-Source: APXvYqwSId0P0P5X53xcgeTgr1GEnV75QS+cfURd3d263wDNrtAk8uucpHXowJCbl9mVdyoW/doB4w==
X-Received: by 2002:a6b:6117:: with SMTP id v23mr491737iob.95.1568749087664;
        Tue, 17 Sep 2019 12:38:07 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w7sm3263629iob.17.2019.09.17.12.38.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 12:38:06 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] io_uring: IORING_OP_TIMEOUT support
Message-ID: <afda2462-d192-7f95-6a26-b2e604d57463@kernel.dk>
Date:   Tue, 17 Sep 2019 13:38:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's been a few requests for functionality similar to io_getevents()
and epoll_wait(), where the user can specify a timeout for waiting on
events. I deliberately did not add support for this through the system
call initially to avoid overloading the args, but I can see that the use
cases for this are valid.

This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
when waiting for events, simply submit one of these timeout commands
with your wait call (or before). This ensures that the application
sleeping on the CQ ring waiting for events will get woken. The timeout
command is passed in as a pointer to a struct timespec. Timeouts are
relative.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

V2

- Ensure any timeout will result in a return to userspace from
  io_cqring_wait().
- Improve commit message
- Add ->file to struct io_timeout
- Kill separate 'kt' value, use timespec_to_kt() directly

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0dadbdbead0f..02db09b89e83 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -216,6 +216,7 @@ struct io_ring_ctx {
 		struct wait_queue_head	cq_wait;
 		struct fasync_struct	*cq_fasync;
 		struct eventfd_ctx	*cq_ev_fd;
+		atomic_t		cq_timeouts;
 	} ____cacheline_aligned_in_smp;
 
 	struct io_rings	*rings;
@@ -283,6 +284,11 @@ struct io_poll_iocb {
 	struct wait_queue_entry		wait;
 };
 
+struct io_timeout {
+	struct file			*file;
+	struct hrtimer			timer;
+};
+
 /*
  * NOTE! Each of the iocb union members has the file pointer
  * as the first entry in their struct definition. So you can
@@ -294,6 +300,7 @@ struct io_kiocb {
 		struct file		*file;
 		struct kiocb		rw;
 		struct io_poll_iocb	poll;
+		struct io_timeout	timeout;
 	};
 
 	struct sqe_submit	submit;
@@ -1765,6 +1772,35 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return ipt.error;
 }
 
+static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
+{
+	struct io_kiocb *req;
+
+	req = container_of(timer, struct io_kiocb, timeout.timer);
+	atomic_inc(&req->ctx->cq_timeouts);
+	io_cqring_add_event(req->ctx, req->user_data, 0);
+	io_put_req(req);
+	return HRTIMER_NORESTART;
+}
+
+static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct timespec ts;
+
+	if (sqe->flags || sqe->ioprio || sqe->off || sqe->buf_index)
+		return -EINVAL;
+	if (sqe->len != 1)
+		return -EINVAL;
+	if (copy_from_user(&ts, (void __user *) sqe->addr, sizeof(ts)))
+		return -EFAULT;
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
@@ -1842,6 +1878,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_RECVMSG:
 		ret = io_recvmsg(req, s->sqe, force_nonblock);
 		break;
+	case IORING_OP_TIMEOUT:
+		ret = io_timeout(req, s->sqe);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2593,6 +2632,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
 	struct io_rings *rings = ctx->rings;
+	unsigned nr_timeouts;
 	int ret;
 
 	if (io_cqring_events(rings) >= min_events)
@@ -2611,7 +2651,15 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	ret = wait_event_interruptible(ctx->wait, io_cqring_events(rings) >= min_events);
+	/*
+	 * Return if we have enough events, or if a timeout occured since
+	 * we started waiting. For timeouts, we always want to return to
+	 * userspace.
+	 */
+	nr_timeouts = atomic_read(&ctx->cq_timeouts);
+	ret = wait_event_interruptible(ctx->wait,
+				io_cqring_events(rings) >= min_events ||
+				atomic_read(&ctx->cq_timeouts) != nr_timeouts);
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
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

