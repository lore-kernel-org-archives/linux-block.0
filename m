Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48116C4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B3620854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Oq7jVHzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCNUou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:50 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40084 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfCNUot (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:49 -0400
Received: by mail-it1-f196.google.com with SMTP id l139so7323718ita.5
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRH2veoxBrMHbgwT8WykbY7Ezh04BGLnBv6N+nQQnco=;
        b=Oq7jVHzESlhUA2GzDYpQPEa36K1Y5HCmnJkmPKTXb5/P5LIRVn64oyPY3Jkwa22Bn2
         oWLrWI1Zc8TgnOT043f7QkP74rsQeOgSNxHIkNHTUfGkHcla1BiOD6yFl/v4GVEXvQOx
         CqeRlls0r2M0Iu5+3hBSLB1NQhNCOqbTHQay8q7r6/a21N/7Gya1Js0Vk0EKINlGFb+/
         UwPpYJgYvbLLwnG0insFnSKd7XOm1x430yNSHDefZHZKpsK/dUKeO4dYCnthPCqEwFt7
         StEF2EENbCcMTcp+UR3luVWvu0rYUNVz/pdpaf9/qnyqYMNj9+MCZxG2iOmulHPgkiD8
         hoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TRH2veoxBrMHbgwT8WykbY7Ezh04BGLnBv6N+nQQnco=;
        b=QbXnftbioLC4oeZskA2zxh8r2dDoHfuefLlOVO8USKipni4j9o3JtTfTSPBZ1k8mN/
         NGEO1qfHLUOdo0kMb+CfFU17qL0TBRG3sAfwqId3rb5bSnoLV1Fy/BvZ/kMIELXqNEPo
         hOE1BJ+onWd2oGFnaWOnMIsXVuuLLtGC6Ui9UseSvwbQ4lfMpIhTJRsS6RUVRJ59vesg
         ti5od0HKa/+Yy4iYFdJefDEwM6qGfBf131Wx7MSboeXhnsmW5j7W01CmJ9V5b9WsroWC
         0CWxmyB0Tc+QVlypDO0oveAaAvZIC6avdLmVZUxVdKLV3exKnzY154sUZe+Mkn90Yv0n
         Bd9A==
X-Gm-Message-State: APjAAAXNG4Ul34KmJ4X1VQmnw4WhyaSwkrz/IiRp2T7sb1JzwdDLi+ZH
        nIFuAjn/UULeWDTVGxSkSLZwNR/YdLLYCg==
X-Google-Smtp-Source: APXvYqxt+2AgpprtT5KGTHGE4S6x2GCJ73/aj7N8qXdi8C4gBNqnMMWL2pzDiaKWssD5ZqSN4VS5pA==
X-Received: by 2002:a24:bdcc:: with SMTP id x195mr287373ite.149.1552596288447;
        Thu, 14 Mar 2019 13:44:48 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] io_uring: fix poll races
Date:   Thu, 14 Mar 2019 14:44:32 -0600
Message-Id: <20190314204435.7692-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a straight port of Al's fix for the aio poll implementation,
since the io_uring version is heavily based on that. The below
description is almost straight from that patch, just modified to
fit the io_uring situation.

io_poll() has to cope with several unpleasant problems:
	* requests that might stay around indefinitely need to
be made visible for io_cancel(2); that must not be done to
a request already completed, though.
	* in cases when ->poll() has placed us on a waitqueue,
wakeup might have happened (and request completed) before ->poll()
returns.
	* worse, in some early wakeup cases request might end
up re-added into the queue later - we can't treat "woken up and
currently not in the queue" as "it's not going to stick around
indefinitely"
	* ... moreover, ->poll() might have decided not to
put it on any queues to start with, and that needs to be distinguished
from the previous case
	* ->poll() might have tried to put us on more than one queue.
Only the first will succeed for io poll, so we might end up missing
wakeups.  OTOH, we might very well notice that only after the
wakeup hits and request gets completed (all before ->poll() gets
around to the second poll_wait()).  In that case it's too late to
decide that we have an error.

req->woken was an attempt to deal with that.  Unfortunately, it was
broken.  What we need to keep track of is not that wakeup has happened -
the thing might come back after that.  It's that async reference is
already gone and won't come back, so we can't (and needn't) put the
request on the list of cancellables.

The easiest case is "request hadn't been put on any waitqueues"; we
can tell by seeing NULL apt.head, and in that case there won't be
anything async.  We should either complete the request ourselves
(if vfs_poll() reports anything of interest) or return an error.

In all other cases we get exclusion with wakeups by grabbing the
queue lock.

If request is currently on queue and we have something interesting
from vfs_poll(), we can steal it and complete the request ourselves.

If it's on queue and vfs_poll() has not reported anything interesting,
we either put it on the cancellable list, or, if we know that it
hadn't been put on all queues ->poll() wanted it on, we steal it and
return an error.

If it's _not_ on queue, it's either been already dealt with (in which
case we do nothing), or there's io_poll_complete_work() about to be
executed.  In that case we either put it on the cancellable list,
or, if we know it hadn't been put on all queues ->poll() wanted it on,
simulate what cancel would've done.

Fixes: 221c5eb23382 ("io_uring: add support for IORING_OP_POLL")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 110 +++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 56 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f4fe9dce38ee..46cf38b8d863 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -197,7 +197,7 @@ struct io_poll_iocb {
 	struct file			*file;
 	struct wait_queue_head		*head;
 	__poll_t			events;
-	bool				woken;
+	bool				done;
 	bool				canceled;
 	struct wait_queue_entry		wait;
 };
@@ -367,20 +367,25 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 	}
 }
 
-static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+{
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->sqo_wait))
+		wake_up(&ctx->sqo_wait);
+}
+
+static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data,
 				long res, unsigned ev_flags)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	io_cqring_fill_event(ctx, ki_user_data, res, ev_flags);
+	io_cqring_fill_event(ctx, user_data, res, ev_flags);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
-	if (waitqueue_active(&ctx->sqo_wait))
-		wake_up(&ctx->sqo_wait);
+	io_cqring_ev_posted(ctx);
 }
 
 static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
@@ -1151,10 +1156,13 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return 0;
 }
 
-static void io_poll_complete(struct io_kiocb *req, __poll_t mask)
+static void io_poll_complete(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			     __poll_t mask)
 {
-	io_cqring_add_event(req->ctx, req->user_data, mangle_poll(mask), 0);
-	io_put_req(req);
+	req->poll.done = true;
+	io_cqring_fill_event(ctx, req->user_data, mangle_poll(mask), 0);
+	io_commit_cqring(ctx);
+	io_cqring_ev_posted(ctx);
 }
 
 static void io_poll_complete_work(struct work_struct *work)
@@ -1182,9 +1190,10 @@ static void io_poll_complete_work(struct work_struct *work)
 		return;
 	}
 	list_del_init(&req->list);
+	io_poll_complete(ctx, req, mask);
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_poll_complete(req, mask);
+	io_put_req(req);
 }
 
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
@@ -1195,29 +1204,23 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	struct io_kiocb *req = container_of(poll, struct io_kiocb, poll);
 	struct io_ring_ctx *ctx = req->ctx;
 	__poll_t mask = key_to_poll(key);
-
-	poll->woken = true;
+	unsigned long flags;
 
 	/* for instances that support it check for an event match first: */
-	if (mask) {
-		unsigned long flags;
-
-		if (!(mask & poll->events))
-			return 0;
+	if (mask && !(mask & poll->events))
+		return 0;
 
-		/* try to complete the iocb inline if we can: */
-		if (spin_trylock_irqsave(&ctx->completion_lock, flags)) {
-			list_del(&req->list);
-			spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	list_del_init(&poll->wait.entry);
 
-			list_del_init(&poll->wait.entry);
-			io_poll_complete(req, mask);
-			return 1;
-		}
+	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
+		list_del(&req->list);
+		io_poll_complete(ctx, req, mask);
+		spin_unlock_irqrestore(&ctx->completion_lock, flags);
+		io_put_req(req);
+	} else {
+		queue_work(ctx->sqo_wq, &req->work);
 	}
 
-	list_del_init(&poll->wait.entry);
-	queue_work(ctx->sqo_wq, &req->work);
 	return 1;
 }
 
@@ -1247,6 +1250,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_poll_iocb *poll = &req->poll;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_poll_table ipt;
+	bool cancel = false;
 	__poll_t mask;
 	u16 events;
 
@@ -1260,7 +1264,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
 
 	poll->head = NULL;
-	poll->woken = false;
+	poll->done = false;
 	poll->canceled = false;
 
 	ipt.pt._qproc = io_poll_queue_proc;
@@ -1273,41 +1277,35 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
 
 	mask = vfs_poll(poll->file, &ipt.pt) & poll->events;
-	if (unlikely(!poll->head)) {
-		/* we did not manage to set up a waitqueue, done */
-		goto out;
-	}
 
 	spin_lock_irq(&ctx->completion_lock);
-	spin_lock(&poll->head->lock);
-	if (poll->woken) {
-		/* wake_up context handles the rest */
-		mask = 0;
+	if (likely(poll->head)) {
+		spin_lock(&poll->head->lock);
+		if (unlikely(list_empty(&poll->wait.entry))) {
+			if (ipt.error)
+				cancel = true;
+			ipt.error = 0;
+			mask = 0;
+		}
+		if (mask || ipt.error)
+			list_del_init(&poll->wait.entry);
+		else if (cancel)
+			WRITE_ONCE(poll->canceled, true);
+		else if (!poll->done) /* actually waiting for an event */
+			list_add_tail(&req->list, &ctx->cancel_list);
+		spin_unlock(&poll->head->lock);
+	}
+	if (mask) { /* no async, we'd stolen it */
+		req->error = mangle_poll(mask);
 		ipt.error = 0;
-	} else if (mask || ipt.error) {
-		/* if we get an error or a mask we are done */
-		WARN_ON_ONCE(list_empty(&poll->wait.entry));
-		list_del_init(&poll->wait.entry);
-	} else {
-		/* actually waiting for an event */
-		list_add_tail(&req->list, &ctx->cancel_list);
 	}
-	spin_unlock(&poll->head->lock);
 	spin_unlock_irq(&ctx->completion_lock);
 
-out:
-	if (unlikely(ipt.error)) {
-		/*
-		 * Drop one of our refs to this req, __io_submit_sqe() will
-		 * drop the other one since we're returning an error.
-		 */
+	if (mask) {
+		io_poll_complete(ctx, req, mask);
 		io_put_req(req);
-		return ipt.error;
 	}
-
-	if (mask)
-		io_poll_complete(req, mask);
-	return 0;
+	return ipt.error;
 }
 
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
-- 
2.17.1

