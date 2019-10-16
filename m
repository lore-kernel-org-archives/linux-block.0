Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C3FA3728
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7BD2067D
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 15:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a5ZJSPoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfJPPQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:16:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44360 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfJPPQX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 11:16:23 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so54224131iol.11
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2019 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bu8W6EBBQ7Z2tnsKnB9IgioY5X883y+5LOiqkgaKAYg=;
        b=a5ZJSPoS0HBxefeFEURXfb0cZEHwckU58yoY2TrUuAH6TJckGTx7TmK6THiYzS/Pqn
         APBKY/POjEcFmbXWCMPONgFv+ga+AXsMDFnh+QF8hEeBOQAYkC9wX0Nj5ekED8Mbdfgk
         Ch3m/GkBA42VxOQeD79i1qEtZOlm3Cd9ZtXtcdHFim8NknqYKZle+u37aaCdPFIOoP1E
         VvVVLjd9+B+f1TEJ/DeZ8pCx743UXfbeHe8qSyUNWfG4l5Sr9Tvj/49D09Lm/7wgWLsu
         gjrK9L3Z2K6H79MdhtiujRTDZ7ZyXJH2ZUBNBI66emugG1MiOAaCJAyzZMeYZRVrqxEc
         BZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bu8W6EBBQ7Z2tnsKnB9IgioY5X883y+5LOiqkgaKAYg=;
        b=pewRYsFwfNMrMDhViWXkljzMN3Ukau6xWPzk/KzRZwe7xjwWtEqYE8BLtP/n/ertLR
         jAlT5fsWa5QFA1Xwu63rzTaCltcZ4iQJdMQGkSTm6vVH7CW7bed2vPvExdgmqWlDfvYj
         NyCYmAAld6qLgygk21gpgc5JIiQ1oJ6WeS8qB8MiTwYYLdxIeNtnYkhh2+njS77kvHxj
         YN6wGQeBtEyewdTEW92BM5QfhR1A1JVVEI/hmd8VbFSp8an7+FX0YH5Z5H2lL3B/WCvQ
         lzIo3yejJNCliH8T3ffJPQggqdt6Rwd/diD37Gg9qflyfKIW+YiQiR7JKDk2KrteRyxM
         rTAw==
X-Gm-Message-State: APjAAAUT5DM5EJIsQqOxOCrp4TL/5+FmjyZ0lfGzdgJ8cD7JFuXxZv/L
        sxq9QMk1gGHeRFtKWr+EF0xA/vZWOpFMxQ==
X-Google-Smtp-Source: APXvYqyI1zyKEmVkc0Y1DSJZEUC+p85rw4ukOL7Uhb4u+YpK58RfHKA+NQrOU5RJK6t4tU8GozkJvQ==
X-Received: by 2002:a5d:8452:: with SMTP id w18mr2131076ior.145.1571238980419;
        Wed, 16 Oct 2019 08:16:20 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p7sm4468582ilh.10.2019.10.16.08.16.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:16:18 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: add support for canceling timeout requests
Message-ID: <0f03efc4-fa7d-cb96-bca5-64f692ae52d8@kernel.dk>
Date:   Wed, 16 Oct 2019 09:16:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We might have cases where the need for a specific timeout is gone, add
support for canceling an existing timeout operation. This works like the
POLL_REMOVE command, where the application passes in the user_data of
the timeout it wishes to cancel in the sqe->addr field.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 92 ++++++++++++++++++++++++++++++-----
 include/uapi/linux/io_uring.h |  1 +
 2 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e48e0854bc1e..635856023fdf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1914,22 +1914,88 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	struct io_ring_ctx *ctx;
 	struct io_kiocb *req;
 	unsigned long flags;
+	bool comp;
 
 	req = container_of(timer, struct io_kiocb, timeout.timer);
 	ctx = req->ctx;
 	atomic_inc(&ctx->cq_timeouts);
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	list_del(&req->list);
-
-	io_cqring_fill_event(ctx, req->user_data, -ETIME);
-	io_commit_cqring(ctx);
+	/*
+	 * We could be racing with timeout deletion. If the list is empty,
+	 * then timeout lookup already found it and will be handling it.
+	 */
+	comp = !list_empty(&req->list);
+	if (comp) {
+		list_del_init(&req->list);
+		io_cqring_fill_event(ctx, req->user_data, -ETIME);
+		io_commit_cqring(ctx);
+	}
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
+	if (comp) {
+		io_cqring_ev_posted(ctx);
+		io_put_req(req, NULL);
+	}
+	return HRTIMER_NORESTART;
+}
+
+/*
+ * Remove or update an existing timeout command
+ */
+static int io_timeout_remove(struct io_kiocb *req,
+			     const struct io_uring_sqe *sqe)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *treq;
+	int ret = -ENOENT;
+	__u64 user_data;
+	unsigned flags;
+
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->len)
+		return -EINVAL;
+	flags = READ_ONCE(sqe->timeout_flags);
+	if (flags)
+		return -EINVAL;
+
+	user_data = READ_ONCE(sqe->addr);
+	spin_lock_irq(&ctx->completion_lock);
+	list_for_each_entry(treq, &ctx->timeout_list, list) {
+		if (user_data == treq->user_data) {
+			list_del_init(&treq->list);
+			ret = 0;
+			break;
+		}
+	}
+
+	/* didn't find timeout */
+	if (ret) {
+fill_ev:
+		io_cqring_fill_event(ctx, req->user_data, ret);
+		io_commit_cqring(ctx);
+		spin_unlock_irq(&ctx->completion_lock);
+		io_cqring_ev_posted(ctx);
+		io_put_req(req, NULL);
+		return 0;
+	}
+
+	ret = hrtimer_try_to_cancel(&treq->timeout.timer);
+	if (ret == -1) {
+		ret = -EBUSY;
+		goto fill_ev;
+	}
+
+	io_cqring_fill_event(ctx, req->user_data, 0);
+	io_cqring_fill_event(ctx, treq->user_data, -ECANCELED);
+	io_commit_cqring(ctx);
+	spin_unlock_irq(&ctx->completion_lock);
 	io_cqring_ev_posted(ctx);
 
+	io_put_req(treq, NULL);
 	io_put_req(req, NULL);
-	return HRTIMER_NORESTART;
+	return 0;
 }
 
 static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
@@ -1952,6 +2018,13 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr)))
 		return -EFAULT;
 
+	if (flags & IORING_TIMEOUT_ABS)
+		mode = HRTIMER_MODE_ABS;
+	else
+		mode = HRTIMER_MODE_REL;
+
+	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, mode);
+
 	/*
 	 * sqe->off holds how many events that need to occur for this
 	 * timeout event to be satisfied.
@@ -1980,12 +2053,6 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 	list_add(&req->list, entry);
 	spin_unlock_irq(&ctx->completion_lock);
-
-	if (flags & IORING_TIMEOUT_ABS)
-		mode = HRTIMER_MODE_ABS;
-	else
-		mode = HRTIMER_MODE_REL;
-	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, mode);
 	req->timeout.timer.function = io_timeout_fn;
 	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(ts), mode);
 	return 0;
@@ -2072,6 +2139,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_TIMEOUT:
 		ret = io_timeout(req, s->sqe);
 		break;
+	case IORING_OP_TIMEOUT_REMOVE:
+		ret = io_timeout_remove(req, s->sqe);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b402dfee5e15..6dc5ced1c37a 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -64,6 +64,7 @@ struct io_uring_sqe {
 #define IORING_OP_SENDMSG	9
 #define IORING_OP_RECVMSG	10
 #define IORING_OP_TIMEOUT	11
+#define IORING_OP_TIMEOUT_REMOVE	12
 
 /*
  * sqe->fsync_flags
-- 
2.17.1

-- 
Jens Axboe

