Return-Path: <SRS0=CX+6=YG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E92C4360C
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 15:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F62B20663
	for <linux-block@archiver.kernel.org>; Sun, 13 Oct 2019 15:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh9ZiMSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfJMPlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Oct 2019 11:41:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39579 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfJMPlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 11:41:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id a15so12659711edt.6
        for <linux-block@vger.kernel.org>; Sun, 13 Oct 2019 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laP9mrLho4k9KOdj1jiqx46OWlMyo8ZUGR/PePjn5bY=;
        b=Yh9ZiMSyFNQlUWW+ci0YnCM1w1bMHvG1sKX4wOxq034ZtvhRI5m7OmkyFLlzLes4cu
         iyNhyM4EZoHbRsQAK5RRFkLl4pnWu9w9qNno8iUiFtERaC7tbwxQxPbbWKYTVNFZrL7y
         0njPmjWKBrsVvlEl0lFhGKWsvKeFCRJTtUnglvpv3w8p+YITTXysSp1Qrr4xLITw4XjZ
         YwjihDss3c5RuZP8pVcRJWLaCi8JKmaB2Th/w6GNVQhFvg2n91RDAn29L+sbcD7D05pB
         SKW1qsR6IsuG3CxwI2fEWL94ut7uKXtv6mXhpImnhjQLMo0nSvYxTJyMIyA61rOINNso
         lY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laP9mrLho4k9KOdj1jiqx46OWlMyo8ZUGR/PePjn5bY=;
        b=pEmHZUC8HMpWLJWrSD88sKC5L9sgr5Pv5mIUg6GTzuwpil1AwQpjB7H5ppcXgSoMuq
         A/2lLHsTqi1CGHCEYzw3XgtLX/FrLK+QuuJn6G6eIDFYo4Avh9Edla47skH5AcCJB6WS
         LZBMOake4fZYP5U9gBBLTz0gLoie58atKjgEoFbwZBgVjqJkYgoiiVprlfhU1sFDI5lB
         s9G/uH2kA6r1Dh12BlgRJ+m/VwqnZH9NjPCqDw5qu2zPN64vt+M5XE/z8bTa3hXQxSHZ
         5nN3DKZRQ6TQbmFNg6axOdJMSFnOSxDbn04ry8UmK6B8CWSRi10fzRVz/aaJxO89PKpX
         0jVw==
X-Gm-Message-State: APjAAAXQm5QqpeiMKz5SPph4A9qG1/IJb+pBfcjOrrCSTShn70i6MwnK
        BSvNwEj0O3yQOWA+KUUqOak=
X-Google-Smtp-Source: APXvYqwQTLod8NJeYYx2SgzA7u5NLp4Puci5Jz9mV+4kje3tDGCB0nt/j0BMYi6Lmo9rM8CVmPUORg==
X-Received: by 2002:a17:906:5292:: with SMTP id c18mr24250955ejm.129.1570981276005;
        Sun, 13 Oct 2019 08:41:16 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-103-189-084.188.103.pools.vodafone-ip.de. [188.103.189.84])
        by smtp.gmail.com with ESMTPSA id h58sm2669864edb.43.2019.10.13.08.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 08:41:15 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC v2] io_uring: add set of tracing events
Date:   Sun, 13 Oct 2019 17:42:45 +0200
Message-Id: <20191013154245.23538-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To trace io_uring activity one can get an information from workqueue and
io trace events, but looks like some parts could be hard to identify via
this approach. Making what happens inside io_uring more transparent is
important to be able to reason about many aspects of it, hence introduce
the set of tracing events.

All such events could be roughly divided into two categories:

* those, that are helping to understand correctness (from both kernel
  and an application point of view). E.g. a ring creation, file
  registration, or waiting for available CQE. Proposed approach is to
  get a pointer to an original structure of interest (ring context, or
  request), and then find relevant events. io_uring_queue_async_work
  also exposes a pointer to work_struct, to be able to track down
  corresponding workqueue events.

* those, that provide performance related information. Mostly it's about
  events that change the flow of requests, e.g. whether an async work
  was queued, or delayed due to some dependencies. Another important
  case is how io_uring optimizations (e.g. registered files) are
  utilized.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
v1: add io_uring_link trace event
v2: Extend io_uring events, to include not only io_uring_link, but other
    events to cover important parts of the functionality

 fs/io_uring.c                   |  19 ++
 include/Kbuild                  |   1 +
 include/trace/events/io_uring.h | 372 ++++++++++++++++++++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 include/trace/events/io_uring.h

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bfbb7ab3c4e..730f7182b2a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -71,6 +71,9 @@
 #include <linux/sizes.h>
 #include <linux/hugetlb.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/io_uring.h>
+
 #include <uapi/linux/io_uring.h>
 
 #include "internal.h"
@@ -483,6 +486,7 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 		}
 	}
 
+	trace_io_uring_queue_async_work(ctx, rw, req, &req->work, req->flags);
 	queue_work(ctx->sqo_wq[rw], &req->work);
 }
 
@@ -707,6 +711,7 @@ static void io_fail_links(struct io_kiocb *req)
 {
 	struct io_kiocb *link;
 
+	trace_io_uring_fail_links(req);
 	while (!list_empty(&req->link_list)) {
 		link = list_first_entry(&req->link_list, struct io_kiocb, list);
 		list_del(&link->list);
@@ -1292,6 +1297,7 @@ static ssize_t io_import_iovec(struct io_ring_ctx *ctx, int rw,
 						iovec, iter);
 #endif
 
+	trace_io_uring_import_iovec(ctx, buf);
 	return import_iovec(rw, buf, sqe_len, UIO_FASTIOV, iovec, iter);
 }
 
@@ -2021,6 +2027,7 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	req->submit.sqe = sqe_copy;
 
 	INIT_WORK(&req->work, io_sq_wq_submit_work);
+	trace_io_uring_defer(ctx, req, false);
 	list_add_tail(&req->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);
 	return -EIOCBQUEUED;
@@ -2327,6 +2334,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	} else {
 		if (s->needs_fixed_file)
 			return -EBADF;
+		trace_io_uring_file_get(ctx, fd);
 		req->file = io_file_get(state, fd);
 		if (unlikely(!req->file))
 			return -EBADF;
@@ -2357,6 +2365,8 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 				INIT_WORK(&req->work, io_sq_wq_submit_work);
 				io_queue_async_work(ctx, req);
 			}
+			else
+				trace_io_uring_add_to_prev(ctx, req);
 
 			/*
 			 * Queued up for async execution, worker will release
@@ -2430,6 +2440,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 	/* Insert shadow req to defer_list, blocking next IOs */
 	spin_lock_irq(&ctx->completion_lock);
+	trace_io_uring_defer(ctx, shadow, true);
 	list_add_tail(&shadow->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);
 
@@ -2488,6 +2499,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 
 		s->sqe = sqe_copy;
 		memcpy(&req->submit, s, sizeof(*s));
+		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (s->sqe->flags & IOSQE_IO_LINK) {
 		req->flags |= REQ_F_LINK;
@@ -2626,6 +2638,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			sqes[i].has_user = has_user;
 			sqes[i].needs_lock = true;
 			sqes[i].needs_fixed_file = true;
+			trace_io_uring_submit_sqe(ctx, true, true);
 			io_submit_sqe(ctx, &sqes[i], statep, &link, true);
 			submitted++;
 		}
@@ -2824,6 +2837,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 		if (block_for_last && submit == to_submit)
 			force_nonblock = false;
 
+		trace_io_uring_submit_sqe(ctx, force_nonblock, false);
 		io_submit_sqe(ctx, &s, statep, &link, force_nonblock);
 	}
 	io_commit_sqring(ctx);
@@ -2906,6 +2920,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 
 	ret = 0;
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
+	trace_io_uring_cqring_wait(ctx, min_events);
 	do {
 		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
 						TASK_INTERRUPTIBLE);
@@ -4057,6 +4072,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	p->cq_off.cqes = offsetof(struct io_rings, cqes);
 
 	p->features = IORING_FEAT_SINGLE_MMAP;
+	trace_io_uring_create(ret, ctx, p->sq_entries, p->cq_entries, p->flags);
 	return ret;
 err:
 	io_ring_ctx_wait_and_kill(ctx);
@@ -4194,6 +4210,9 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 	mutex_lock(&ctx->uring_lock);
 	ret = __io_uring_register(ctx, opcode, arg, nr_args);
 	mutex_unlock(&ctx->uring_lock);
+	if (ret >= 0)
+		trace_io_uring_register(ctx, opcode, ctx->nr_user_files,
+								ctx->nr_user_bufs, ctx->cq_ev_fd != NULL);
 out_fput:
 	fdput(f);
 	return ret;
diff --git a/include/Kbuild b/include/Kbuild
index ffba79483cc..61b66725d25 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -1028,6 +1028,7 @@ header-test-			+= trace/events/fsi_master_gpio.h
 header-test-			+= trace/events/huge_memory.h
 header-test-			+= trace/events/ib_mad.h
 header-test-			+= trace/events/ib_umad.h
+header-test-			+= trace/events/io_uring.h
 header-test-			+= trace/events/iscsi.h
 header-test-			+= trace/events/jbd2.h
 header-test-			+= trace/events/kvm.h
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
new file mode 100644
index 00000000000..1e49c050616
--- /dev/null
+++ b/include/trace/events/io_uring.h
@@ -0,0 +1,372 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM io_uring
+
+#if !defined(_TRACE_IO_URING_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IO_URING_H
+
+#include <linux/tracepoint.h>
+
+/**
+ * io_uring_create - called after a new io_uring context was prepared
+ *
+ * @fd:			corresponding file descriptor
+ * @ctx:		pointer to a ring context structure
+ * @sq_entries:	actual SQ size
+ * @cq_entries:	actual CQ size
+ * @flags:		SQ ring flags, provided to io_uring_setup(2)
+ *
+ * Allows to trace io_uring creation and provide pointer to a context, that can
+ * be used later to find correlated events.
+ */
+TRACE_EVENT(io_uring_create,
+
+	TP_PROTO(int fd, void *ctx, u32 sq_entries, u32 cq_entries, u32 flags),
+
+	TP_ARGS(fd, ctx, sq_entries, cq_entries, flags),
+
+	TP_STRUCT__entry (
+		__field(  int,		fd			)
+		__field(  void *,	ctx			)
+		__field(  u32,		sq_entries	)
+		__field(  u32,		cq_entries	)
+		__field(  u32,		flags		)
+	),
+
+	TP_fast_assign(
+		__entry->fd			= fd;
+		__entry->ctx		= ctx;
+		__entry->sq_entries	= sq_entries;
+		__entry->cq_entries	= cq_entries;
+		__entry->flags		= flags;
+	),
+
+	TP_printk("ring %p, fd %d sq size %d, cq size %d, flags %d",
+			  __entry->ctx, __entry->fd, __entry->sq_entries,
+			  __entry->cq_entries, __entry->flags)
+);
+
+/**
+ * io_uring_register - called after a buffer/file/eventfd was succesfully
+ * 					   registered for a ring
+ *
+ * @ctx:			pointer to a ring context structure
+ * @opcode:			describes which operation to perform
+ * @nr_user_files:	number of registered files
+ * @nr_user_bufs:	number of registered buffers
+ * @cq_ev_fd:		whether eventfs registered or not
+ *
+ * Allows to trace fixed files/buffers/eventfds, that could be registered to
+ * avoid an overhead of getting references to them for every operation. This
+ * event, together with io_uring_file_get and io_uring_import_iovec, can
+ * provide a full picture of how much overhead one can reduce via fixing.
+ */
+TRACE_EVENT(io_uring_register,
+
+	TP_PROTO(void *ctx, unsigned opcode, unsigned nr_files,
+			 unsigned nr_bufs, bool eventfd),
+
+	TP_ARGS(ctx, opcode, nr_files, nr_bufs, eventfd),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx			)
+		__field(  unsigned,	opcode		)
+		__field(  unsigned,	nr_files	)
+		__field(  unsigned,	nr_bufs		)
+		__field(  bool,		eventfd		)
+	),
+
+	TP_fast_assign(
+		__entry->ctx		= ctx;
+		__entry->opcode		= opcode;
+		__entry->nr_files	= nr_files;
+		__entry->nr_bufs	= nr_bufs;
+		__entry->eventfd	= eventfd;
+	),
+
+	TP_printk("ring %p, opcode %d, nr_user_files %d, nr_user_bufs %d, "
+			  "eventfd %d",
+			  __entry->ctx, __entry->opcode, __entry->nr_files,
+			  __entry->nr_bufs, __entry->eventfd)
+);
+
+/**
+ * io_uring_file_get - called before getting references to an SQE file
+ *
+ * @ctx:	pointer to a ring context structure
+ * @fd:		SQE file descriptor
+ *
+ * Allows to trace out how often an SQE file reference is obtained, which can
+ * help figuring out if it makes sense to use fixed files, or check that fixed
+ * files are used correctly.
+ */
+TRACE_EVENT(io_uring_file_get,
+
+	TP_PROTO(void *ctx, int fd),
+
+	TP_ARGS(ctx, fd),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx	)
+		__field(  int,		fd	)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	= ctx;
+		__entry->fd		= fd;
+	),
+
+	TP_printk("ring %p, fd %d", __entry->ctx, __entry->fd)
+);
+
+/**
+ * io_uring_import_iovec - called before importing iovec from userspace
+ *
+ * @ctx:	pointer to a ring context structure
+ * @buf:	pointer to a user buffer to be imported
+ *
+ * Allows to trace out how often user buffer are imported, which can help
+ * figuring out if it makes sense to use fixed buffers, or check that fixed
+ * buffers are used correctly.
+ */
+TRACE_EVENT(io_uring_import_iovec,
+
+	TP_PROTO(void *ctx, void __user *buf),
+
+	TP_ARGS(ctx, buf),
+
+	TP_STRUCT__entry (
+		__field(  void *,			ctx	)
+		__field(  void __user *,	buf	)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	= ctx;
+		__entry->buf	= buf;
+	),
+
+	TP_printk("ring %p, buf %p", __entry->ctx, __entry->buf)
+);
+
+/**
+ * io_uring_queue_async_work - called before submitting a new async work
+ *
+ * @ctx:	pointer to a ring context structure
+ * @rw:		type of workqueue, normal or buffered writes
+ * @req:	pointer to a submitted request
+ * @work:	pointer to a submitted work_struct
+ *
+ * Allows to trace asynchronous work submission.
+ */
+TRACE_EVENT(io_uring_queue_async_work,
+
+	TP_PROTO(void *ctx, int rw, void * req, struct work_struct *work,
+			 unsigned int flags),
+
+	TP_ARGS(ctx, rw, req, work, flags),
+
+	TP_STRUCT__entry (
+		__field(  void *,				ctx		)
+		__field(  int,					rw		)
+		__field(  void *,				req		)
+		__field(  struct work_struct *,	work	)
+		__field(  unsigned int,			flags	)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	= ctx;
+		__entry->rw		= rw;
+		__entry->req	= req;
+		__entry->work	= work;
+		__entry->flags	= flags;
+	),
+
+	TP_printk("ring %p, request %p, flags %d, %s queue, work %p",
+			  __entry->ctx, __entry->req, __entry->flags,
+			  __entry->rw ? "buffered" : "normal", __entry->work)
+);
+
+/**
+ * io_uring_defer_list - called before the io_uring work added into defer_list
+ *
+ * @ctx:	pointer to a ring context structure
+ * @req:	pointer to a deferred request
+ * @shadow: whether request is shadow or not
+ *
+ * Allows to track deferred requests, to get an insight about what requests are
+ * not started immediately.
+ */
+TRACE_EVENT(io_uring_defer,
+
+	TP_PROTO(void *ctx, void *req, bool shadow),
+
+	TP_ARGS(ctx, req, shadow),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx		)
+		__field(  void *,	req		)
+		__field(  bool,		shadow	)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	= ctx;
+		__entry->req	= req;
+		__entry->shadow	= shadow;
+	),
+
+	TP_printk("ring %p, request %p%s", __entry->ctx, __entry->req,
+			  __entry->shadow ? ", shadow": "")
+);
+
+/**
+ * io_uring_link - called before the io_uring request added into link_list of
+ * 				   another request
+ *
+ * @ctx:			pointer to a ring context structure
+ * @req:			pointer to a linked request
+ * @target_req:		pointer to a previous request, that would contain @req
+ *
+ * Allows to track linked requests, to understand dependencies between requests
+ * and how does it influence their execution flow.
+ */
+TRACE_EVENT(io_uring_link,
+
+	TP_PROTO(void *ctx, void *req, void *target_req),
+
+	TP_ARGS(ctx, req, target_req),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx			)
+		__field(  void *,	req			)
+		__field(  void *,	target_req	)
+	),
+
+	TP_fast_assign(
+		__entry->ctx		= ctx;
+		__entry->req		= req;
+		__entry->target_req	= target_req;
+	),
+
+	TP_printk("ring %p, request %p linked after %p",
+			  __entry->ctx, __entry->req, __entry->target_req)
+);
+
+/**
+ * io_uring_add_to_prev - called after a request was added into a previously
+ * 						  submitted work
+ *
+ * @ctx:	pointer to a ring context structure
+ * @req:	pointer to a request, added to a previous
+ *
+ * Allows to track merged work, to figure out how oftern requests are piggy
+ * backed into other ones, changing the execution flow.
+ */
+TRACE_EVENT(io_uring_add_to_prev,
+
+	TP_PROTO(void *ctx, void *req),
+
+	TP_ARGS(ctx, req),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx		)
+		__field(  void *,	req	)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	= ctx;
+		__entry->req	= req;
+	),
+
+	TP_printk("ring %p, request %p", __entry->ctx, __entry->req)
+);
+
+/**
+ * io_uring_cqring_wait - called before start waiting for an available CQE
+ *
+ * @ctx:		pointer to a ring context structure
+ * @min_events:	minimal number of events to wait for
+ *
+ * Allows to track waiting for CQE, so that we can e.g. troubleshoot
+ * situations, when an application wants to wait for an event, that never
+ * comes.
+ */
+TRACE_EVENT(io_uring_cqring_wait,
+
+	TP_PROTO(void *ctx, int min_events),
+
+	TP_ARGS(ctx, min_events),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx			)
+		__field(  int,		min_events	)
+	),
+
+	TP_fast_assign(
+		__entry->ctx	= ctx;
+		__entry->min_events	= min_events;
+	),
+
+	TP_printk("ring %p, min_events %d", __entry->ctx, __entry->min_events)
+);
+
+/**
+ * io_uring_fail_links - called before failing linked requests
+ *
+ * @req:	requestion, which links will be cancelled
+ *
+ * Allows to track linked requests cancellation, to see not only that some work
+ * was cancelled, but also which request was the reason.
+ */
+TRACE_EVENT(io_uring_fail_links,
+
+	TP_PROTO(void *req),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry (
+		__field(  void *,	req	)
+	),
+
+	TP_fast_assign(
+		__entry->req	= req;
+	),
+
+	TP_printk("request %p", __entry->req)
+);
+
+/**
+ * io_uring_submit_sqe - called before submitting one SQE
+ *
+ * @ctx:			pointer to a ring context structure
+ * @force_nonblock:	whether a context blocking or not
+ * @sq_thread:		true if sq_thread has submitted this SQE
+ *
+ * Allows to track SQE submitting, to understand what was the source of it, SQ
+ * thread or io_uring_enter call.
+ */
+TRACE_EVENT(io_uring_submit_sqe,
+
+	TP_PROTO(void *ctx, bool force_nonblock, bool sq_thread),
+
+	TP_ARGS(ctx, force_nonblock, sq_thread),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx				)
+		__field(  bool,		force_nonblock	)
+		__field(  bool,		sq_thread		)
+	),
+
+	TP_fast_assign(
+		__entry->ctx			= ctx;
+		__entry->force_nonblock	= force_nonblock;
+		__entry->sq_thread		= sq_thread;
+	),
+
+	TP_printk("ring %p, non block %d, sq_thread %d",
+			  __entry->ctx, __entry->force_nonblock, __entry->sq_thread)
+);
+
+#endif /* _TRACE_IO_URING_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.21.0

