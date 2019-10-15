Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945EDECE588
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8982084B
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 17:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTL+jAEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfJORAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:00:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54649 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfJORAe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 13:00:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so21688277wmp.4
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2UhsSFSl/wny1qemQ2xcUXcd516L9yrcZeBO8TRXhg=;
        b=vTL+jAEQq7jAcPi7cjnxGbmiT04d4YKgw2Pi+SsuW0U8bn5L6gkqkUk6eZfRP+QXUQ
         BsKqijx9AmyANjTG7oON4aTGoyH3bYYRC8+YrvHI6HFODoXPIbYX+qlJQRKNDSvHr866
         1Y5/8okDircMp9TajK86vNi9wNGmT/glphb9E4tHY8c8lWJG90+PGQmaRUciDHKp7Yoh
         UGascvKqE/qa8xsfosNhI4kJo4YCaTdHoppiaVtadDkJZtOj+5lpMy5yq40n13QjtHzx
         gBG3jOKPffAhJAzZ5YdeCzQlS9v33oQEuE60utOdIE7Nhub4Q4EYg1PW29Br20FMhnyn
         MEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2UhsSFSl/wny1qemQ2xcUXcd516L9yrcZeBO8TRXhg=;
        b=AtC6gnmdOcmxY2azPk5Y01LpccoukiaBsGGcMDwgLvfk8CJB6L/GVSItn7/ORNUhM2
         m2NEskGvXX6ghqrv5d5VwUHxBwqapZ1Y/Koynac2d9piVXbUjPyXDUUkRMYmVLtb2ufR
         ijuB6J0Tia+EFQeGABCr//UQoU3xFyc/1DgJlU8WIKTkRqOi/rGYDK4hl4DiNonh/7uy
         vFhN76SZVrrYheF76mk4J27baV423BfuAt7A6bea+TwfYS9CBNTqdoPjN7VfH7q+VbsZ
         eHaDlYN+MKANXdveKfrWSDi9GToqSManocWB7+InDS+5ytjOChWIaMlY7sz4+bJbTrAE
         p1dg==
X-Gm-Message-State: APjAAAWvUAFa3wL5cekrjrds3Tyi7wMJKmZsadw9FY3Uc4estATdRhon
        J766Xq+HDaORkPwgmGgGwFk=
X-Google-Smtp-Source: APXvYqxhSPeE6+OqI+aIcnWBGm3hDlj8dzHDwqbGfhwfpihJc96oWA4CnLpXLtMFPHY3d5vgjg1m6Q==
X-Received: by 2002:a05:600c:2489:: with SMTP id 9mr20177976wms.131.1571158830004;
        Tue, 15 Oct 2019 10:00:30 -0700 (PDT)
Received: from localhost.localdomain (tmo-110-247.customers.d1-online.com. [80.187.110.247])
        by smtp.gmail.com with ESMTPSA id m62sm20218430wmm.35.2019.10.15.10.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 10:00:29 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC v3] io_uring: add set of tracing events
Date:   Tue, 15 Oct 2019 19:02:01 +0200
Message-Id: <20191015170201.27131-1-9erthalion6@gmail.com>
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
    events to cover important parts of the functionality.
v3: Remove io_uring_import_iovec event.
    Expose not only a failed request, but also all the failed links in the
    failing link event.
    Move io_uring_add_to_prev into io_add_to_prev_work() and fix a comment
    typo.
    Remove condition and add ret to io_uring_register.

 fs/io_uring.c                   |  17 ++
 include/Kbuild                  |   1 +
 include/trace/events/io_uring.h | 349 ++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
 create mode 100644 include/trace/events/io_uring.h

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bfbb7ab3c4e..de8fefbfca4 100644
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
 
@@ -711,6 +715,7 @@ static void io_fail_links(struct io_kiocb *req)
 		link = list_first_entry(&req->link_list, struct io_kiocb, list);
 		list_del(&link->list);
 
+		trace_io_uring_fail_link(req, link);
 		io_cqring_add_event(req->ctx, link->user_data, -ECANCELED);
 		__io_free_req(link);
 	}
@@ -2021,6 +2026,7 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	req->submit.sqe = sqe_copy;
 
 	INIT_WORK(&req->work, io_sq_wq_submit_work);
+	trace_io_uring_defer(ctx, req, false);
 	list_add_tail(&req->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);
 	return -EIOCBQUEUED;
@@ -2279,6 +2285,8 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 		ret = false;
 	}
 	spin_unlock(&list->lock);
+
+	trace_io_uring_add_to_prev(req, ret);
 	return ret;
 }
 
@@ -2327,6 +2335,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	} else {
 		if (s->needs_fixed_file)
 			return -EBADF;
+		trace_io_uring_file_get(ctx, fd);
 		req->file = io_file_get(state, fd);
 		if (unlikely(!req->file))
 			return -EBADF;
@@ -2430,6 +2439,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 	/* Insert shadow req to defer_list, blocking next IOs */
 	spin_lock_irq(&ctx->completion_lock);
+	trace_io_uring_defer(ctx, shadow, true);
 	list_add_tail(&shadow->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);
 
@@ -2488,6 +2498,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 
 		s->sqe = sqe_copy;
 		memcpy(&req->submit, s, sizeof(*s));
+		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (s->sqe->flags & IOSQE_IO_LINK) {
 		req->flags |= REQ_F_LINK;
@@ -2626,6 +2637,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			sqes[i].has_user = has_user;
 			sqes[i].needs_lock = true;
 			sqes[i].needs_fixed_file = true;
+			trace_io_uring_submit_sqe(ctx, true, true);
 			io_submit_sqe(ctx, &sqes[i], statep, &link, true);
 			submitted++;
 		}
@@ -2824,6 +2836,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 		if (block_for_last && submit == to_submit)
 			force_nonblock = false;
 
+		trace_io_uring_submit_sqe(ctx, force_nonblock, false);
 		io_submit_sqe(ctx, &s, statep, &link, force_nonblock);
 	}
 	io_commit_sqring(ctx);
@@ -2906,6 +2919,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 
 	ret = 0;
 	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
+	trace_io_uring_cqring_wait(ctx, min_events);
 	do {
 		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
 						TASK_INTERRUPTIBLE);
@@ -4057,6 +4071,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	p->cq_off.cqes = offsetof(struct io_rings, cqes);
 
 	p->features = IORING_FEAT_SINGLE_MMAP;
+	trace_io_uring_create(ret, ctx, p->sq_entries, p->cq_entries, p->flags);
 	return ret;
 err:
 	io_ring_ctx_wait_and_kill(ctx);
@@ -4194,6 +4209,8 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 	mutex_lock(&ctx->uring_lock);
 	ret = __io_uring_register(ctx, opcode, arg, nr_args);
 	mutex_unlock(&ctx->uring_lock);
+	trace_io_uring_register(ctx, opcode, ctx->nr_user_files, ctx->nr_user_bufs,
+							ctx->cq_ev_fd != NULL, ret);
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
index 00000000000..c5a905fbf1d
--- /dev/null
+++ b/include/trace/events/io_uring.h
@@ -0,0 +1,349 @@
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
+ * @ret:			return code
+ *
+ * Allows to trace fixed files/buffers/eventfds, that could be registered to
+ * avoid an overhead of getting references to them for every operation. This
+ * event, together with io_uring_file_get, can provide a full picture of how
+ * much overhead one can reduce via fixing.
+ */
+TRACE_EVENT(io_uring_register,
+
+	TP_PROTO(void *ctx, unsigned opcode, unsigned nr_files,
+			 unsigned nr_bufs, bool eventfd, long ret),
+
+	TP_ARGS(ctx, opcode, nr_files, nr_bufs, eventfd, ret),
+
+	TP_STRUCT__entry (
+		__field(  void *,	ctx			)
+		__field(  unsigned,	opcode		)
+		__field(  unsigned,	nr_files	)
+		__field(  unsigned,	nr_bufs		)
+		__field(  bool,		eventfd		)
+		__field(  long,		ret			)
+	),
+
+	TP_fast_assign(
+		__entry->ctx		= ctx;
+		__entry->opcode		= opcode;
+		__entry->nr_files	= nr_files;
+		__entry->nr_bufs	= nr_bufs;
+		__entry->eventfd	= eventfd;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("ring %p, opcode %d, nr_user_files %d, nr_user_bufs %d, "
+			  "eventfd %d, ret %ld",
+			  __entry->ctx, __entry->opcode, __entry->nr_files,
+			  __entry->nr_bufs, __entry->eventfd, __entry->ret)
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
+ * @req:	pointer to a request, added to a previous
+ * @ret:	whether or not it was completed successfully
+ *
+ * Allows to track merged work, to figure out how often requests are piggy
+ * backed into other ones, changing the execution flow.
+ */
+TRACE_EVENT(io_uring_add_to_prev,
+
+	TP_PROTO(void *req, bool ret),
+
+	TP_ARGS(req, ret),
+
+	TP_STRUCT__entry (
+		__field(  void *,	req	)
+		__field(  bool,		ret	)
+	),
+
+	TP_fast_assign(
+		__entry->req	= req;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("request %p, ret %d", __entry->req, __entry->ret)
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
+ * io_uring_fail_link - called before failing a linked request
+ *
+ * @req:	request, which links were cancelled
+ * @link:	cancelled link
+ *
+ * Allows to track linked requests cancellation, to see not only that some work
+ * was cancelled, but also which request was the reason.
+ */
+TRACE_EVENT(io_uring_fail_link,
+
+	TP_PROTO(void *req, void *link),
+
+	TP_ARGS(req, link),
+
+	TP_STRUCT__entry (
+		__field(  void *,	req		)
+		__field(  void *,	link	)
+	),
+
+	TP_fast_assign(
+		__entry->req	= req;
+		__entry->link	= link;
+	),
+
+	TP_printk("request %p, link %p", __entry->req, __entry->link)
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

