Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B19C282CB
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE937217D8
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qRQSBW3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfBHRfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56216 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfBHRfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:35:09 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so10632819ith.5
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOds5RvdTm88p5p2eQ7fJu8YQ9XwamqLjpknn6qyPBc=;
        b=qRQSBW3r9PG5U++N7QE6HdC4QEeFy1GoJlj/uiGCmT4KNpV2J53w2rE87THiiEko1E
         ikKuOa8yXqmedqBAykg/+o8JB8PQuKzWM8NoTAebn7/q26r5dSavQUGUOrVcsozeXc1G
         jgmoAXaBQkC6Ny2AmUWxO6T4gIFpAXlqeiDgZ5NVJkWSBPFOzgxKbIr92pVGXvImfDfO
         9SWo1bFsXgyGoJpW1TBvcNhHuEi8vShMd5ZZhJIcSvLkXtirmWtyldg32MDd6XX80NSd
         vAxfmUL1Kcf/jQT3AeE8blBEjomZ1BhE8yfUMvzI573oKaiCt8G+2vI4SHqKuvTjZkCz
         Q3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOds5RvdTm88p5p2eQ7fJu8YQ9XwamqLjpknn6qyPBc=;
        b=C+pwTA57Rgyot7VRjN/Sh6iM8oFWUvrdMxkdGaH+sBIbPv8GoCo+aeC9Tud/Alo6fB
         +iY/2h5pwTqM98oYxg2z0f6/ouY92PKYOGmgjfSlE324awrnWYIIgyJA7wDB8BtY4Tzx
         bUxONk5FTg0tHekEG5A1UuzWI94fScnYO62J2SXeHe0jsLAr/rXHbzv1eGjCyGWdtNXQ
         JM8vY4+L4l7YpX+aPTwZZDASaQBbW7lBbtIalrpgAuw0p0s97Wf5lAZWN4j4E1tF4mGw
         gc3Tt8kk5NHVzIXx0TJIuemMO79wBnGpjMAgTOC0NuxyHO2/j9IG1HllqkhQf4AUGYtX
         zhMQ==
X-Gm-Message-State: AHQUAuZdd33kVZ+NdiIP9hg9ETlcbnWlFk1PBIavHcbzlELp21a+hWrs
        vYl/H4UIlT5Lp7WuxGbMy+f86g==
X-Google-Smtp-Source: AHgI3IY6IgR5fcwjnUIFvwVMn1Ybv5RZWn1zG5tnfO03FTdeK1KM3IrRJYaF9pVXyNkFTgmxACjZIA==
X-Received: by 2002:a6b:b644:: with SMTP id g65mr3722527iof.198.1549647308353;
        Fri, 08 Feb 2019 09:35:08 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/19] io_uring: add support for IORING_OP_POLL
Date:   Fri,  8 Feb 2019 10:34:21 -0700
Message-Id: <20190208173423.27014-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is basically a direct port of bfe4037e722e, which implements a
one-shot poll command through aio. Description below is based on that
commit as well. However, instead of adding a POLL command and relying
on io_cancel(2) to remove it, we mimic the epoll(2) interface of
having a command to add a poll notification, IORING_OP_POLL_ADD,
and one to remove it again, IORING_OP_POLL_REMOVE.

To poll for a file descriptor the application should submit an sqe of
type IORING_OP_POLL. It will poll the fd for the events specified in the
poll_events field.

Unlike poll or epoll without EPOLLONESHOT this interface always works in
one shot mode, that is once the sqe is completed, it will have to be
resubmitted.

Based-on-code-from: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 261 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/io_uring.h |   3 +
 2 files changed, 263 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9b28f2cd29db..c014dbc29c77 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -140,6 +140,7 @@ struct io_ring_ctx {
 		 * manipulate the list, hence no extra locking is needed there.
 		 */
 		struct list_head	poll_list;
+		struct list_head	cancel_list;
 	} ____cacheline_aligned_in_smp;
 
 #if defined(CONFIG_UNIX)
@@ -155,8 +156,20 @@ struct sqe_submit {
 	bool				needs_fixed_file;
 };
 
+struct io_poll_iocb {
+	struct file *file;
+	struct wait_queue_head *head;
+	__poll_t events;
+	bool woken;
+	bool canceled;
+	struct wait_queue_entry wait;
+};
+
 struct io_kiocb {
-	struct kiocb		rw;
+	union {
+		struct kiocb		rw;
+		struct io_poll_iocb	poll;
+	};
 
 	struct sqe_submit	submit;
 
@@ -240,6 +253,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
 	INIT_LIST_HEAD(&ctx->poll_list);
+	INIT_LIST_HEAD(&ctx->cancel_list);
 	return ctx;
 }
 
@@ -993,6 +1007,244 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
+static void io_poll_remove_one(struct io_kiocb *req)
+{
+	struct io_poll_iocb *poll = &req->poll;
+
+	spin_lock(&poll->head->lock);
+	WRITE_ONCE(poll->canceled, true);
+	if (!list_empty(&poll->wait.entry)) {
+		list_del_init(&poll->wait.entry);
+		queue_work(req->ctx->sqo_wq, &req->work);
+	}
+	spin_unlock(&poll->head->lock);
+
+	list_del_init(&req->list);
+}
+
+static void io_poll_remove_all(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	spin_lock_irq(&ctx->completion_lock);
+	while (!list_empty(&ctx->cancel_list)) {
+		req = list_first_entry(&ctx->cancel_list, struct io_kiocb,list);
+		io_poll_remove_one(req);
+	}
+	spin_unlock_irq(&ctx->completion_lock);
+}
+
+/*
+ * Find a running poll command that matches one specified in sqe->addr,
+ * and remove it if found.
+ */
+static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *poll_req, *next;
+	int ret = -ENOENT;
+
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (sqe->ioprio || sqe->off || sqe->len || sqe->buf_index ||
+	    sqe->poll_events)
+		return -EINVAL;
+
+	spin_lock_irq(&ctx->completion_lock);
+	list_for_each_entry_safe(poll_req, next, &ctx->cancel_list, list) {
+		if (READ_ONCE(sqe->addr) == poll_req->user_data) {
+			io_poll_remove_one(poll_req);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock_irq(&ctx->completion_lock);
+
+	io_cqring_add_event(req->ctx, sqe->user_data, ret, 0);
+	io_free_req(req);
+	return 0;
+}
+
+static void io_poll_complete(struct io_kiocb *req, __poll_t mask)
+{
+	io_cqring_add_event(req->ctx, req->user_data, mangle_poll(mask), 0);
+	io_fput(req);
+	io_free_req(req);
+}
+
+static void io_poll_complete_work(struct work_struct *work)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+	struct io_poll_iocb *poll = &req->poll;
+	struct poll_table_struct pt = { ._key = poll->events };
+	struct io_ring_ctx *ctx = req->ctx;
+	__poll_t mask = 0;
+
+	if (!READ_ONCE(poll->canceled))
+		mask = vfs_poll(poll->file, &pt) & poll->events;
+
+	/*
+	 * Note that ->ki_cancel callers also delete iocb from active_reqs after
+	 * calling ->ki_cancel.  We need the ctx_lock roundtrip here to
+	 * synchronize with them.  In the cancellation case the list_del_init
+	 * itself is not actually needed, but harmless so we keep it in to
+	 * avoid further branches in the fast path.
+	 */
+	spin_lock_irq(&ctx->completion_lock);
+	if (!mask && !READ_ONCE(poll->canceled)) {
+		add_wait_queue(poll->head, &poll->wait);
+		spin_unlock_irq(&ctx->completion_lock);
+		return;
+	}
+	list_del_init(&req->list);
+	spin_unlock_irq(&ctx->completion_lock);
+
+	io_poll_complete(req, mask);
+}
+
+static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+			void *key)
+{
+	struct io_poll_iocb *poll = container_of(wait, struct io_poll_iocb,
+							wait);
+	struct io_kiocb *req = container_of(poll, struct io_kiocb, poll);
+	struct io_ring_ctx *ctx = req->ctx;
+	__poll_t mask = key_to_poll(key);
+
+	poll->woken = true;
+
+	/* for instances that support it check for an event match first: */
+	if (mask) {
+		if (!(mask & poll->events))
+			return 0;
+
+		/* try to complete the iocb inline if we can: */
+		if (spin_trylock(&ctx->completion_lock)) {
+			list_del(&req->list);
+			spin_unlock(&ctx->completion_lock);
+
+			list_del_init(&poll->wait.entry);
+			io_poll_complete(req, mask);
+			return 1;
+		}
+	}
+
+	list_del_init(&poll->wait.entry);
+	queue_work(ctx->sqo_wq, &req->work);
+	return 1;
+}
+
+struct io_poll_table {
+	struct poll_table_struct pt;
+	struct io_kiocb *req;
+	int error;
+};
+
+static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
+			       struct poll_table_struct *p)
+{
+	struct io_poll_table *pt = container_of(p, struct io_poll_table, pt);
+
+	if (unlikely(pt->req->poll.head)) {
+		pt->error = -EINVAL;
+		return;
+	}
+
+	pt->error = 0;
+	pt->req->poll.head = head;
+	add_wait_queue(head, &pt->req->poll.wait);
+}
+
+static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_poll_iocb *poll = &req->poll;
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_poll_table ipt;
+	unsigned flags;
+	__poll_t mask;
+	u16 events;
+	int fd;
+
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (sqe->addr || sqe->ioprio || sqe->off || sqe->len || sqe->buf_index)
+		return -EINVAL;
+
+	INIT_WORK(&req->work, io_poll_complete_work);
+	events = READ_ONCE(sqe->poll_events);
+	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
+
+	flags = READ_ONCE(sqe->flags);
+	fd = READ_ONCE(sqe->fd);
+
+	if (flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || fd >= ctx->nr_user_files))
+			return -EBADF;
+		poll->file = ctx->user_files[fd];
+		req->flags |= REQ_F_FIXED_FILE;
+	} else {
+		poll->file = fget(fd);
+	}
+	if (unlikely(!poll->file))
+		return -EBADF;
+
+	poll->head = NULL;
+	poll->woken = false;
+	poll->canceled = false;
+
+	ipt.pt._qproc = io_poll_queue_proc;
+	ipt.pt._key = poll->events;
+	ipt.req = req;
+	ipt.error = -EINVAL; /* same as no support for IOCB_CMD_POLL */
+
+	/* initialized the list so that we can do list_empty checks */
+	INIT_LIST_HEAD(&poll->wait.entry);
+	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
+
+	/* one for removal from waitqueue, one for this function */
+	refcount_set(&req->refs, 2);
+
+	mask = vfs_poll(poll->file, &ipt.pt) & poll->events;
+	if (unlikely(!poll->head)) {
+		/* we did not manage to set up a waitqueue, done */
+		goto out;
+	}
+
+	spin_lock_irq(&ctx->completion_lock);
+	spin_lock(&poll->head->lock);
+	if (poll->woken) {
+		/* wake_up context handles the rest */
+		mask = 0;
+		ipt.error = 0;
+	} else if (mask || ipt.error) {
+		/* if we get an error or a mask we are done */
+		WARN_ON_ONCE(list_empty(&poll->wait.entry));
+		list_del_init(&poll->wait.entry);
+	} else {
+		/* actually waiting for an event */
+		list_add_tail(&req->list, &ctx->cancel_list);
+	}
+	spin_unlock(&poll->head->lock);
+	spin_unlock_irq(&ctx->completion_lock);
+
+out:
+	if (unlikely(ipt.error)) {
+		if (!(flags & IOSQE_FIXED_FILE))
+			fput(poll->file);
+		/*
+		 * Drop one of our refs to this req, __io_submit_sqe() will
+		 * drop the other one since we're returning an error.
+		 */
+		io_free_req(req);
+		return ipt.error;
+	}
+
+	if (mask)
+		io_poll_complete(req, mask);
+	io_free_req(req);
+	return 0;
+}
+
 static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   const struct sqe_submit *s, bool force_nonblock,
 			   struct io_submit_state *state)
@@ -1028,6 +1280,12 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_FSYNC:
 		ret = io_fsync(req, s->sqe, force_nonblock);
 		break;
+	case IORING_OP_POLL_ADD:
+		ret = io_poll_add(req, s->sqe);
+		break;
+	case IORING_OP_POLL_REMOVE:
+		ret = io_poll_remove(req, s->sqe);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1983,6 +2241,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
+	io_poll_remove_all(ctx);
 	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 0ec74bab8dbe..e23408692118 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -25,6 +25,7 @@ struct io_uring_sqe {
 	union {
 		__kernel_rwf_t	rw_flags;
 		__u32		fsync_flags;
+		__u16		poll_events;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	union {
@@ -51,6 +52,8 @@ struct io_uring_sqe {
 #define IORING_OP_FSYNC		3
 #define IORING_OP_READ_FIXED	4
 #define IORING_OP_WRITE_FIXED	5
+#define IORING_OP_POLL_ADD	6
+#define IORING_OP_POLL_REMOVE	7
 
 /*
  * sqe->fsync_flags
-- 
2.17.1

