Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AF2C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707C320854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H1kw3pk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfCNUos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37494 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfCNUos (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:48 -0400
Received: by mail-it1-f194.google.com with SMTP id z124so7345845itc.2
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbv2OInshtL5ZMEKoOBoCLd+hlK/j7knHFf5h1+VkbI=;
        b=H1kw3pk6HuArwug5x8mkTneH7xhNIINJ6qTdKdVbIo69ztbBGIPTTfeV+21dkfUWO/
         XDS7yCoe/4IcL3cXhn9O/zKnNKdOhI5kMFSDtzjZpzCsYIJkX9UpKOrgmbZFyCYgiOl6
         RhgQdiOgIU6KWWkEKgKsSTH+SH7gFYPv3x+NSa4vZq/XgNzOpTE0m7OMK2ppdb2B42hK
         2IrFYh/Ll6Asg3FdtIOpW44MPpYsJ+SU0PXxHDlc2MyMKFOeA9WI0zy7X7uOT5AJGK8v
         JWf2Wp0mSeaBSxhwnZsgUbG+kQMzkDh4ksg/1j8WuZP/54jIaDNu5ryflr3TgB4jILC4
         I9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lbv2OInshtL5ZMEKoOBoCLd+hlK/j7knHFf5h1+VkbI=;
        b=V13nY9R2RvOk7hJDR7e/d2FUg6nBRUIRy3PvJ7DDWPphWplOiDsvRT20qFeIngP3Ac
         6MkXu+rjN9yShmvUs7rZNQGE+YcZ/ZTNlN2iEiQX38sC96khyoCOfGu3e3IGDpOuk6a6
         05LrkSuhGC8OiCS/eOFQpPCqyI44qzJFDo21YPaWvq3W47iut7B+smJ0Lc5aTgd7wX79
         dPrJfAEDdq5UsnNttgEE/HbtFHg+kpluAFitSEd0xpDBz87+7+CopYgJrp7oEQpxzOFg
         HnzbkVVY26X3w6aqXAT9u3SQh2360bxGXDc61+zvKlPj+TJxMf+Q2bALHLPNgq8r/bJw
         mCMA==
X-Gm-Message-State: APjAAAVZi8BgZbllQxv6BnO4f6b7ThZBNVxYu+IaknnXOsbWy9DrAu6m
        Vq0II7Xcnd2yMzNVDTb19ODRMg==
X-Google-Smtp-Source: APXvYqw5ViYDx/mur4Gh2oV/egL4S9xIj6m0Tgo59XfasWwKo6vevm0orzY34YIHyLNFWqQ7yP+mBw==
X-Received: by 2002:a02:ec4:: with SMTP id 187mr138501jae.11.1552596287076;
        Thu, 14 Mar 2019 13:44:47 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] io_uring: fix fget/fput handling
Date:   Thu, 14 Mar 2019 14:44:31 -0600
Message-Id: <20190314204435.7692-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This isn't a straight port of commit 84c4e1f89fef for aio.c, since
io_uring doesn't use files in exactly the same way. But it's pretty
close. See the commit message for that commit.

This essentially fixes a use-after-free with the poll command
handling, but it takes cue from Linus's approach to just simplifying
the file handling. We move the setup of the file into a higher level
location, so the individual commands don't have to deal with it. And
then we release the reference when we free the associated io_kiocb.

Fixes: 221c5eb23382 ("io_uring: add support for IORING_OP_POLL")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 201 +++++++++++++++++---------------------------------
 1 file changed, 67 insertions(+), 134 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d8468594a483..f4fe9dce38ee 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -189,6 +189,10 @@ struct sqe_submit {
 	bool				needs_fixed_file;
 };
 
+/*
+ * First field must be the file pointer in all the
+ * iocb unions! See also 'struct kiocb' in <linux/fs.h>
+ */
 struct io_poll_iocb {
 	struct file			*file;
 	struct wait_queue_head		*head;
@@ -198,8 +202,15 @@ struct io_poll_iocb {
 	struct wait_queue_entry		wait;
 };
 
+/*
+ * NOTE! Each of the iocb union members has the file pointer
+ * as the first entry in their struct definition. So you can
+ * access the file pointer through any of the sub-structs,
+ * or directly as just 'ki_filp' in this struct.
+ */
 struct io_kiocb {
 	union {
+		struct file		*file;
 		struct kiocb		rw;
 		struct io_poll_iocb	poll;
 	};
@@ -429,8 +440,16 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 	}
 }
 
+static void io_fput(struct io_kiocb *req)
+{
+	if (!(req->flags & REQ_F_FIXED_FILE))
+		fput(req->file);
+}
+
 static void io_free_req(struct io_kiocb *req)
 {
+	if (req->file)
+		io_fput(req);
 	io_ring_drop_ctx_refs(req->ctx, 1);
 	kmem_cache_free(req_cachep, req);
 }
@@ -448,45 +467,34 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			       struct list_head *done)
 {
 	void *reqs[IO_IOPOLL_BATCH];
-	int file_count, to_free;
-	struct file *file = NULL;
 	struct io_kiocb *req;
+	int to_free;
 
-	file_count = to_free = 0;
+	to_free = 0;
 	while (!list_empty(done)) {
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
 
 		io_cqring_fill_event(ctx, req->user_data, req->error, 0);
-
-		if (refcount_dec_and_test(&req->refs))
-			reqs[to_free++] = req;
 		(*nr_events)++;
 
-		/*
-		 * Batched puts of the same file, to avoid dirtying the
-		 * file usage count multiple times, if avoidable.
-		 */
-		if (!(req->flags & REQ_F_FIXED_FILE)) {
-			if (!file) {
-				file = req->rw.ki_filp;
-				file_count = 1;
-			} else if (file == req->rw.ki_filp) {
-				file_count++;
+		if (refcount_dec_and_test(&req->refs)) {
+			/* If we're not using fixed files, we have to pair the
+			 * completion part with the file put. Use regular
+			 * completions for those, only batch free for fixed
+			 * file.
+			 */
+			if (req->flags & REQ_F_FIXED_FILE) {
+				reqs[to_free++] = req;
+				if (to_free == ARRAY_SIZE(reqs))
+					io_free_req_many(ctx, reqs, &to_free);
 			} else {
-				fput_many(file, file_count);
-				file = req->rw.ki_filp;
-				file_count = 1;
+				io_free_req(req);
 			}
 		}
-
-		if (to_free == ARRAY_SIZE(reqs))
-			io_free_req_many(ctx, reqs, &to_free);
 	}
-	io_commit_cqring(ctx);
 
-	if (file)
-		fput_many(file, file_count);
+	io_commit_cqring(ctx);
 	io_free_req_many(ctx, reqs, &to_free);
 }
 
@@ -609,19 +617,12 @@ static void kiocb_end_write(struct kiocb *kiocb)
 	}
 }
 
-static void io_fput(struct io_kiocb *req)
-{
-	if (!(req->flags & REQ_F_FIXED_FILE))
-		fput(req->rw.ki_filp);
-}
-
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
 	kiocb_end_write(kiocb);
 
-	io_fput(req);
 	io_cqring_add_event(req->ctx, req->user_data, res, 0);
 	io_put_req(req);
 }
@@ -738,31 +739,16 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	const struct io_uring_sqe *sqe = s->sqe;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
-	unsigned ioprio, flags;
-	int fd, ret;
+	unsigned ioprio;
+	int ret;
 
 	/* For -EAGAIN retry, everything is already prepped */
 	if (req->flags & REQ_F_PREPPED)
 		return 0;
 
-	flags = READ_ONCE(sqe->flags);
-	fd = READ_ONCE(sqe->fd);
+	if (force_nonblock && !io_file_supports_async(req->file))
+		force_nonblock = false;
 
-	if (flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files ||
-		    (unsigned) fd >= ctx->nr_user_files))
-			return -EBADF;
-		kiocb->ki_filp = ctx->user_files[fd];
-		req->flags |= REQ_F_FIXED_FILE;
-	} else {
-		if (s->needs_fixed_file)
-			return -EBADF;
-		kiocb->ki_filp = io_file_get(state, fd);
-		if (unlikely(!kiocb->ki_filp))
-			return -EBADF;
-		if (force_nonblock && !io_file_supports_async(kiocb->ki_filp))
-			force_nonblock = false;
-	}
 	kiocb->ki_pos = READ_ONCE(sqe->off);
 	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
 	kiocb->ki_hint = ki_hint_validate(file_write_hint(kiocb->ki_filp));
@@ -771,7 +757,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ioprio) {
 		ret = ioprio_check_cap(ioprio);
 		if (ret)
-			goto out_fput;
+			return ret;
 
 		kiocb->ki_ioprio = ioprio;
 	} else
@@ -779,39 +765,26 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 
 	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
 	if (unlikely(ret))
-		goto out_fput;
+		return ret;
 	if (force_nonblock) {
 		kiocb->ki_flags |= IOCB_NOWAIT;
 		req->flags |= REQ_F_FORCE_NONBLOCK;
 	}
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		ret = -EOPNOTSUPP;
 		if (!(kiocb->ki_flags & IOCB_DIRECT) ||
 		    !kiocb->ki_filp->f_op->iopoll)
-			goto out_fput;
+			return -EOPNOTSUPP;
 
 		req->error = 0;
 		kiocb->ki_flags |= IOCB_HIPRI;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 	} else {
-		if (kiocb->ki_flags & IOCB_HIPRI) {
-			ret = -EINVAL;
-			goto out_fput;
-		}
+		if (kiocb->ki_flags & IOCB_HIPRI)
+			return -EINVAL;
 		kiocb->ki_complete = io_complete_rw;
 	}
 	req->flags |= REQ_F_PREPPED;
 	return 0;
-out_fput:
-	if (!(flags & IOSQE_FIXED_FILE)) {
-		/*
-		 * in case of error, we didn't use this file reference. drop it.
-		 */
-		if (state)
-			state->used_refs--;
-		io_file_put(state, kiocb->ki_filp);
-	}
-	return ret;
 }
 
 static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
@@ -968,16 +941,14 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		return ret;
 	file = kiocb->ki_filp;
 
-	ret = -EBADF;
 	if (unlikely(!(file->f_mode & FMODE_READ)))
-		goto out_fput;
-	ret = -EINVAL;
+		return -EBADF;
 	if (unlikely(!file->f_op->read_iter))
-		goto out_fput;
+		return -EINVAL;
 
 	ret = io_import_iovec(req->ctx, READ, s, &iovec, &iter);
 	if (ret)
-		goto out_fput;
+		return ret;
 
 	iov_count = iov_iter_count(&iter);
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
@@ -999,10 +970,6 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		}
 	}
 	kfree(iovec);
-out_fput:
-	/* Hold on to the file for -EAGAIN */
-	if (unlikely(ret && ret != -EAGAIN))
-		io_fput(req);
 	return ret;
 }
 
@@ -1020,17 +987,15 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	if (ret)
 		return ret;
 
-	ret = -EBADF;
 	file = kiocb->ki_filp;
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
-		goto out_fput;
-	ret = -EINVAL;
+		return -EBADF;
 	if (unlikely(!file->f_op->write_iter))
-		goto out_fput;
+		return -EINVAL;
 
 	ret = io_import_iovec(req->ctx, WRITE, s, &iovec, &iter);
 	if (ret)
-		goto out_fput;
+		return ret;
 
 	iov_count = iov_iter_count(&iter);
 
@@ -1062,10 +1027,6 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	}
 out_free:
 	kfree(iovec);
-out_fput:
-	/* Hold on to the file for -EAGAIN */
-	if (unlikely(ret && ret != -EAGAIN))
-		io_fput(req);
 	return ret;
 }
 
@@ -1080,16 +1041,6 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 
-	/*
-	 * Twilight zone - it's possible that someone issued an opcode that
-	 * has a file attached, then got -EAGAIN on submission, and changed
-	 * the sqe before we retried it from async context. Avoid dropping
-	 * a file reference for this malicious case, and flag the error.
-	 */
-	if (req->rw.ki_filp) {
-		err = -EBADF;
-		io_fput(req);
-	}
 	io_cqring_add_event(ctx, user_data, err, 0);
 	io_put_req(req);
 	return 0;
@@ -1098,8 +1049,6 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	unsigned flags;
-	int fd;
 
 	/* Prep already done (EAGAIN retry) */
 	if (req->flags & REQ_F_PREPPED)
@@ -1110,20 +1059,6 @@ static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
 		return -EINVAL;
 
-	fd = READ_ONCE(sqe->fd);
-	flags = READ_ONCE(sqe->flags);
-
-	if (flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files || fd >= ctx->nr_user_files))
-			return -EBADF;
-		req->rw.ki_filp = ctx->user_files[fd];
-		req->flags |= REQ_F_FIXED_FILE;
-	} else {
-		req->rw.ki_filp = fget(fd);
-		if (unlikely(!req->rw.ki_filp))
-			return -EBADF;
-	}
-
 	req->flags |= REQ_F_PREPPED;
 	return 0;
 }
@@ -1153,7 +1088,6 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 				end > 0 ? end : LLONG_MAX,
 				fsync_flags & IORING_FSYNC_DATASYNC);
 
-	io_fput(req);
 	io_cqring_add_event(req->ctx, sqe->user_data, ret, 0);
 	io_put_req(req);
 	return 0;
@@ -1220,7 +1154,6 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 static void io_poll_complete(struct io_kiocb *req, __poll_t mask)
 {
 	io_cqring_add_event(req->ctx, req->user_data, mangle_poll(mask), 0);
-	io_fput(req);
 	io_put_req(req);
 }
 
@@ -1314,10 +1247,8 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_poll_iocb *poll = &req->poll;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_poll_table ipt;
-	unsigned flags;
 	__poll_t mask;
 	u16 events;
-	int fd;
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -1328,20 +1259,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	events = READ_ONCE(sqe->poll_events);
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
 
-	flags = READ_ONCE(sqe->flags);
-	fd = READ_ONCE(sqe->fd);
-
-	if (flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files || fd >= ctx->nr_user_files))
-			return -EBADF;
-		poll->file = ctx->user_files[fd];
-		req->flags |= REQ_F_FIXED_FILE;
-	} else {
-		poll->file = fget(fd);
-	}
-	if (unlikely(!poll->file))
-		return -EBADF;
-
 	poll->head = NULL;
 	poll->woken = false;
 	poll->canceled = false;
@@ -1380,8 +1297,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 out:
 	if (unlikely(ipt.error)) {
-		if (!(flags & IOSQE_FIXED_FILE))
-			fput(poll->file);
 		/*
 		 * Drop one of our refs to this req, __io_submit_sqe() will
 		 * drop the other one since we're returning an error.
@@ -1626,7 +1541,8 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 {
 	bool did_submit = true;
 	struct io_kiocb *req;
-	int ret;
+	unsigned flags;
+	int ret, fd;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(s->sqe->flags & ~IOSQE_FIXED_FILE))
@@ -1636,6 +1552,23 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(!req))
 		return -EAGAIN;
 
+	flags = READ_ONCE(s->sqe->flags);
+	fd = READ_ONCE(s->sqe->fd);
+
+	if (flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files ||
+		    (unsigned) fd >= ctx->nr_user_files))
+			return -EBADF;
+		req->file = ctx->user_files[fd];
+		req->flags |= REQ_F_FIXED_FILE;
+	} else {
+		if (s->needs_fixed_file)
+			return -EBADF;
+		req->file = io_file_get(state, fd);
+		if (unlikely(!req->file))
+			return -EBADF;
+	}
+
 	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
 		struct io_uring_sqe *sqe_copy;
-- 
2.17.1

