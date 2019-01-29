Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F860C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 03:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2092177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 03:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tydY0hmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfA2Dqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:46:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51019 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfA2Dqi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 22:46:38 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so2173275iti.0
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 19:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iFWF2psl3y4QvE1huBYWzlqCAk7uRdPZ5mpJEi7PXkM=;
        b=tydY0hmIy3TCga5qKRNEHZlYuJ/MNB/iVyw6nkJCIugah9HfUkbPIFgwgk3YFCH6NX
         vmFbhvvFctpFKet3LUCLXLEiwQudQCkpzRFMFIDuO/QPQD1yLcdB6TZlihOGBPs6ko5t
         3Ukl3uMO7H73BnCiWK8xqDVLR7aC4/5PcM6uwH2i8tTFKqSzuU2pEN+K3PihA6oReZaq
         AnoEL6FzHhmwynUq64sRlP4xbg5MHyTpy8zN3UqfzzPyQN5UxDSG/7btzqb00SL5WwZ7
         QeMeSSBC7lHi3uOyjWuQYjx7Ryl5N3O6BhSpJNG1c+CFQssJZTZwYmBieim60xuXjrsp
         wU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFWF2psl3y4QvE1huBYWzlqCAk7uRdPZ5mpJEi7PXkM=;
        b=L6tiqt8mtr+SA7Gs6Fqj8E1NjcTdJQi1wtJ7duEuw0vdRsIHXsTOiFKsNu0MIUAfE0
         89nlXRSlBibIPVF9OyKnVLOLXzmeAB3olhLQuGdYDroGFN/exBkjukQtp/sy+dZsbpnr
         K0AZ70nst71fx3GwMspfxiKDEiIa1C6lFEUB0uCSALfIwpwKTBtkTLAknO5C3fcWCn+X
         T/SnQTfvX6+NbY2SLU3rflVw6KtzJahTSGsA1qI46SHb0RW+zawoy4hgAlWmseMkk/eY
         3eWyJgxWxZQW6gyOUF4/5TRTuKTITxBDv2uqx/cxpcGxCbKyARGsWfccZR3FE4rLtqNi
         f7+A==
X-Gm-Message-State: AJcUukfvar46JBZxuPKUuIe2IhTgMBa2M6lJyGpG1ZG5H14jnu4t752y
        3YDn2nKvnYVzLb8NSQpLqRaFSg==
X-Google-Smtp-Source: ALg8bN7xDEg3qwOhOorllWJJy3aOE+QqTxNhZPa6U1Ucd6vlDJ8cSrndLPw4rIDVqXLVXmzs1w43YQ==
X-Received: by 2002:a24:4c8e:: with SMTP id a136mr12448545itb.108.1548733597447;
        Mon, 28 Jan 2019 19:46:37 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c75sm764000itd.1.2019.01.28.19.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 19:46:36 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
 <CAG48ez1Ms+NPTXPj_UiQyv=2aMaMR3akCdp5SdDL3x7x7gd_ig@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5902860-30a9-3dc9-b513-3d892afdc51b@kernel.dk>
Date:   Mon, 28 Jan 2019 20:46:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1Ms+NPTXPj_UiQyv=2aMaMR3akCdp5SdDL3x7x7gd_ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 7:21 PM, Jann Horn wrote:
> Please create a local copy of the request before parsing it to keep
> the data from changing under you. Additionally, it might make sense to
> annotate every pointer to shared memory with a comment, or something
> like that, to ensure that anyone looking at the code can immediately
> see for which pointers special caution is required on access.

I took a look at the viability of NOT having to local copy the data, and
I don't think it's too bad. Local copy has a noticeable impact on the
performance, hence I'd really (REALLY) like to avoid it.

Here's something on top of the current git branch. I think I even went a
bit too far in some areas, but it should hopefully catch the cases where
we might end up double evaluating the parts of the sqe that we depend
on. For most of the sqe reading we don't really care too much. For
instance, the sqe->user_data. If the app changes this field, then it
just gets whatever passed back in cqe->user_data. That's not a kernel
issue.

For cases like addr/len etc validation, it should be sound. I'll double
check this in the morning as well, and obviously would need to be folded
in along the way.

I'd appreciate your opinion on this part, if you see any major issues
with it, or if I missed something.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index e8760ad02e82..64d090300990 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -668,31 +668,35 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	struct kiocb *kiocb = &req->rw;
-	int ret;
+	unsigned flags, ioprio;
+	int fd, ret;
 
-	if (sqe->flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
+	flags = READ_ONCE(sqe->flags);
+	fd = READ_ONCE(sqe->fd);
+	if (flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || fd >= ctx->nr_user_files))
 			return -EBADF;
-		kiocb->ki_filp = ctx->user_files[sqe->fd];
+		kiocb->ki_filp = ctx->user_files[fd];
 		req->flags |= REQ_F_FIXED_FILE;
 	} else {
-		kiocb->ki_filp = io_file_get(state, sqe->fd);
+		kiocb->ki_filp = io_file_get(state, fd);
 	}
 	if (unlikely(!kiocb->ki_filp))
 		return -EBADF;
-	kiocb->ki_pos = sqe->off;
+	kiocb->ki_pos = READ_ONCE(sqe->off);
 	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
 	kiocb->ki_hint = ki_hint_validate(file_write_hint(kiocb->ki_filp));
-	if (sqe->ioprio) {
-		ret = ioprio_check_cap(sqe->ioprio);
+	ioprio = READ_ONCE(sqe->ioprio);
+	if (ioprio) {
+		ret = ioprio_check_cap(ioprio);
 		if (ret)
 			goto out_fput;
 
-		kiocb->ki_ioprio = sqe->ioprio;
+		kiocb->ki_ioprio = ioprio;
 	} else
 		kiocb->ki_ioprio = get_current_ioprio();
 
-	ret = kiocb_set_rw_flags(kiocb, sqe->rw_flags);
+	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
 	if (unlikely(ret))
 		goto out_fput;
 	if (force_nonblock) {
@@ -716,7 +720,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	return 0;
 out_fput:
-	if (!(sqe->flags & IOSQE_FIXED_FILE))
+	if (!(flags & IOSQE_FIXED_FILE))
 		io_file_put(state, kiocb->ki_filp);
 	return ret;
 }
@@ -746,28 +750,31 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 			   const struct io_uring_sqe *sqe,
 			   struct iov_iter *iter)
 {
+	size_t len = READ_ONCE(sqe->len);
 	struct io_mapped_ubuf *imu;
-	size_t len = sqe->len;
+	int buf_index, index;
 	size_t offset;
-	int index;
+	u64 buf_addr;
 
 	/* attempt to use fixed buffers without having provided iovecs */
 	if (unlikely(!ctx->user_bufs))
 		return -EFAULT;
-	if (unlikely(sqe->buf_index >= ctx->nr_user_bufs))
+
+	buf_index = READ_ONCE(sqe->buf_index);
+	if (unlikely(buf_index >= ctx->nr_user_bufs))
 		return -EFAULT;
 
-	index = array_index_nospec(sqe->buf_index, ctx->sq_entries);
+	index = array_index_nospec(buf_index, ctx->sq_entries);
 	imu = &ctx->user_bufs[index];
-	if ((unsigned long) sqe->addr < imu->ubuf ||
-	    (unsigned long) sqe->addr + len > imu->ubuf + imu->len)
+	buf_addr = READ_ONCE(sqe->addr);
+	if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
 		return -EFAULT;
 
 	/*
 	 * May not be a start of buffer, set size appropriately
 	 * and advance us to the beginning.
 	 */
-	offset = (unsigned long) sqe->addr - imu->ubuf;
+	offset = buf_addr - imu->ubuf;
 	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
 	if (offset)
 		iov_iter_advance(iter, offset);
@@ -778,10 +785,12 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 			   const struct io_uring_sqe *sqe,
 			   struct iovec **iovec, struct iov_iter *iter)
 {
-	void __user *buf = u64_to_user_ptr(sqe->addr);
+	void __user *buf = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	int opcode;
 
-	if (sqe->opcode == IORING_OP_READ_FIXED ||
-	    sqe->opcode == IORING_OP_WRITE_FIXED) {
+	opcode = READ_ONCE(sqe->opcode);
+	if (opcode == IORING_OP_READ_FIXED ||
+	    opcode == IORING_OP_WRITE_FIXED) {
 		ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
 		*iovec = NULL;
 		return ret;
@@ -789,11 +798,12 @@ static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 
 #ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
-		return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
-						iovec, iter);
+		return compat_import_iovec(rw, buf, READ_ONCE(sqe->len),
+						UIO_FASTIOV, iovec, iter);
 #endif
 
-	return import_iovec(rw, buf, sqe->len, UIO_FASTIOV, iovec, iter);
+	return import_iovec(rw, buf, READ_ONCE(sqe->len), UIO_FASTIOV, iovec,
+				iter);
 }
 
 static void io_async_list_note(int rw, struct io_kiocb *req, size_t len)
@@ -939,14 +949,14 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 /*
  * IORING_OP_NOP just posts a completion event, nothing else.
  */
-static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+static int io_nop(struct io_kiocb *req, u64 user_data)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 
-	io_cqring_add_event(ctx, sqe->user_data, 0, 0);
+	io_cqring_add_event(ctx, user_data, 0, 0);
 	io_free_req(req);
 	return 0;
 }
@@ -955,9 +965,12 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		    bool force_nonblock)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	loff_t end = sqe->off + sqe->len;
+	loff_t sqe_off = READ_ONCE(sqe->off);
+	loff_t sqe_len = READ_ONCE(sqe->len);
+	loff_t end = sqe_off + sqe_len;
 	struct file *file;
-	int ret;
+	unsigned flags;
+	int ret, fd;
 
 	/* fsync always requires a blocking context */
 	if (force_nonblock)
@@ -970,21 +983,23 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
 		return -EINVAL;
 
-	if (sqe->flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
+	fd = READ_ONCE(sqe->fd);
+	flags = READ_ONCE(sqe->flags);
+	if (flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || fd >= ctx->nr_user_files))
 			return -EBADF;
-		file = ctx->user_files[sqe->fd];
+		file = ctx->user_files[fd];
 	} else {
-		file = fget(sqe->fd);
+		file = fget(fd);
 	}
 
 	if (unlikely(!file))
 		return -EBADF;
 
-	ret = vfs_fsync_range(file, sqe->off, end > 0 ? end : LLONG_MAX,
+	ret = vfs_fsync_range(file, sqe_off, end > 0 ? end : LLONG_MAX,
 			sqe->fsync_flags & IORING_FSYNC_DATASYNC);
 
-	if (!(sqe->flags & IOSQE_FIXED_FILE))
+	if (!(flags & IOSQE_FIXED_FILE))
 		fput(file);
 
 	io_cqring_add_event(ctx, sqe->user_data, ret, 0);
@@ -1037,7 +1052,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	spin_lock_irq(&ctx->completion_lock);
 	list_for_each_entry_safe(poll_req, next, &ctx->cancel_list, list) {
-		if (sqe->addr == poll_req->user_data) {
+		if (READ_ONCE(sqe->addr) == poll_req->user_data) {
 			io_poll_remove_one(poll_req);
 			ret = 0;
 			break;
@@ -1145,7 +1160,10 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_poll_iocb *poll = &req->poll;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_poll_table ipt;
+	unsigned flags;
 	__poll_t mask;
+	u16 events;
+	int fd;
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -1153,15 +1171,18 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	INIT_WORK(&req->work, io_poll_complete_work);
-	poll->events = demangle_poll(sqe->poll_events) | EPOLLERR | EPOLLHUP;
+	events = READ_ONCE(sqe->poll_events);
+	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
 
-	if (sqe->flags & IOSQE_FIXED_FILE) {
-		if (unlikely(!ctx->user_files || sqe->fd >= ctx->nr_user_files))
+	flags = READ_ONCE(sqe->flags);
+	fd = READ_ONCE(sqe->fd);
+	if (flags & IOSQE_FIXED_FILE) {
+		if (unlikely(!ctx->user_files || fd >= ctx->nr_user_files))
 			return -EBADF;
-		poll->file = ctx->user_files[sqe->fd];
+		poll->file = ctx->user_files[fd];
 		req->flags |= REQ_F_FIXED_FILE;
 	} else {
-		poll->file = fget(sqe->fd);
+		poll->file = fget(fd);
 	}
 	if (unlikely(!poll->file))
 		return -EBADF;
@@ -1207,7 +1228,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 out:
 	if (unlikely(ipt.error)) {
-		if (!(sqe->flags & IOSQE_FIXED_FILE))
+		if (!(flags & IOSQE_FIXED_FILE))
 			fput(poll->file);
 		return ipt.error;
 	}
@@ -1224,15 +1245,17 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 {
 	const struct io_uring_sqe *sqe = s->sqe;
 	ssize_t ret;
+	int opcode;
 
 	if (unlikely(s->index >= ctx->sq_entries))
 		return -EINVAL;
-	req->user_data = sqe->user_data;
+	req->user_data = READ_ONCE(sqe->user_data);
 
 	ret = -EINVAL;
-	switch (sqe->opcode) {
+	opcode = READ_ONCE(sqe->opcode);
+	switch (opcode) {
 	case IORING_OP_NOP:
-		ret = io_nop(req, sqe);
+		ret = io_nop(req, req->user_data);
 		break;
 	case IORING_OP_READV:
 		if (unlikely(sqe->buf_index))
@@ -1317,7 +1340,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 restart:
 	do {
 		struct sqe_submit *s = &req->submit;
-		u64 user_data = s->sqe->user_data;
+		u64 user_data = READ_ONCE(s->sqe->user_data);
 
 		/* Ensure we clear previously set forced non-block flag */
 		req->flags &= ~REQ_F_FORCE_NONBLOCK;

-- 
Jens Axboe

