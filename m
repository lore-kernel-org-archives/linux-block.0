Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561AAC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C25E21738
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jKci7gK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfAJCon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46506 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfAJCon (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so4156954pgp.13
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+uVN/Gf1zNysNQvdyWHCD5E6ExnZZsJtsButMXmMw8=;
        b=jKci7gK8zdD/lOjcNroUZ+pROMiGPmlR6xmyFb4cuM0dpbBoPgQCGwu2E94pLVmwZy
         fntP9LicNkCEkQFloia/yPhz3qWXq3Ksa+zh4mclTPTBNY/VUkt9KLxJPok8AXcSCRbF
         hHBLNX7Mh93jt/hQl8q9NE8OX1+Y96hgucTVez+ELokdLzaMOBrJhcTj62lhkYDHybm5
         Jg6KtAyRGxMt4zPaodarDQDMfXfRKi2W92O5ZEGx2Wh7vXEegYhy00YHXaiv3Kp4NV/9
         wYpQywAASizPlGVAaJfKK1rBHNfr4+yMudpJvQlrtEf34YOaXiHWkL+1lREYUUp3ODFG
         DPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+uVN/Gf1zNysNQvdyWHCD5E6ExnZZsJtsButMXmMw8=;
        b=SO33w7i9nP8LkZEWsqCPc+nF44dYXoWzFbyFrcF5sVqdKSPIm/NgxNa4Qx1HxMGZBE
         k6pMP+p63tLUcIf7hC8eCED5aHJmdR4wjXAzKSwJZiVZleTSkVQyL9o0a+0RIvtjoiJz
         s6/xsdk2NuEOlYlZ3z9GAAk3isVG+lYWlvSBcnc5qixsSeijOgCsjsvb4wVP0HTF7wX5
         VUpVW5aleyqQvKBqIf+lnjenBqIo+hYX9oK05qKuhWTLAeMaBBLQMk8KAtzehxs0MfXH
         XWd7idpc/EaS3kQrwgvTgYNUs43G9R3o7cq6cIIqrwYEFQKYx5GOdbw/zo/LvVNOMjAa
         IjeA==
X-Gm-Message-State: AJcUukfX3rMFOdxTj1lqoo37y5r/gyeCXWxmc/nFIMZ5CPf25QXa/egI
        Mvg5zuxF+V/ICCol9KajNnTGJA==
X-Google-Smtp-Source: ALg8bN4q8MYPMW1tq64u+D0Vu8eWqBjC8lrhOWgUHSxOOlLSmtG2x3k2+/K8eNVJV3Sr//ZoWNJA5A==
X-Received: by 2002:a62:6204:: with SMTP id w4mr8554083pfb.5.1547088281210;
        Wed, 09 Jan 2019 18:44:41 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/15] io_uring: add support for pre-mapped user IO buffers
Date:   Wed,  9 Jan 2019 19:44:01 -0700
Message-Id: <20190110024404.25372-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have fixed user buffers, we can map them into the kernel when we
setup the io_context. That avoids the need to do get_user_pages() for
each and every IO.

To utilize this feature, the application must pass in an array of iovecs
that contain the desired buffer addresses and lengths. These buffers can
then be mapped into the kernel for the life time of the io_uring, as
opposed to just the duration of the each single IO. The application can
then use the IORING_OP_{READ,WRITE}_FIXED to perform IO to these fixed
locations.

It's perfectly valid to setup a larger buffer, and then sometimes only
use parts of it for an IO. As long as the range is within the originally
mapped region, it will work just fine.

A limit of 4M is imposed as the largest buffer we currently support.
There's nothing preventing us from going larger, but we need some cap,
and 4M seemed like it would definitely be big enough. RLIMIT_MEMLOCK
is used to cap the total amount of memory pinned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 202 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   2 +
 2 files changed, 196 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b5233786b5a8..7ab20258e39b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -23,6 +23,8 @@
 #include <linux/workqueue.h>
 #include <linux/blkdev.h>
 #include <linux/anon_inodes.h>
+#include <linux/sizes.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
@@ -53,6 +55,13 @@ struct io_cq_ring {
 	struct io_uring_cqe	cqes[];
 };
 
+struct io_mapped_ubuf {
+	u64		ubuf;
+	size_t		len;
+	struct		bio_vec *bvec;
+	unsigned int	nr_bvecs;
+};
+
 struct io_ring_ctx {
 	struct percpu_ref	refs;
 
@@ -69,6 +78,9 @@ struct io_ring_ctx {
 	unsigned		cq_entries;
 	unsigned		cq_mask;
 
+	/* if used, fixed mapped user buffers */
+	struct io_mapped_ubuf	*user_bufs;
+
 	struct completion	ctx_done;
 
 	/* iopoll submission state */
@@ -656,11 +668,42 @@ static void io_iopoll_kiocb_issued(struct io_submit_state *state,
 		io_iopoll_iocb_add_state(state, kiocb);
 }
 
+static int io_import_fixed(int rw, struct io_kiocb *kiocb,
+			   const struct io_uring_sqe *sqe,
+			   struct iov_iter *iter)
+{
+	struct io_ring_ctx *ctx = kiocb->ki_ctx;
+	struct io_mapped_ubuf *imu;
+	size_t len = sqe->len;
+	size_t offset;
+	int index;
+
+	/* attempt to use fixed buffers without having provided iovecs */
+	if (!ctx->user_bufs)
+		return -EFAULT;
+
+	/* io_submit_sqe() already validated the index */
+	index = array_index_nospec(kiocb->ki_index, ctx->sq_entries);
+	imu = &ctx->user_bufs[index];
+	if ((unsigned long) sqe->addr < imu->ubuf ||
+	    (unsigned long) sqe->addr + len > imu->ubuf + imu->len)
+		return -EFAULT;
+
+	/*
+	 * May not be a start of buffer, set size appropriately
+	 * and advance us to the beginning.
+	 */
+	offset = (unsigned long) sqe->addr - imu->ubuf;
+	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
+	if (offset)
+		iov_iter_advance(iter, offset);
+	return 0;
+}
+
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 		       struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
-	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
 	struct kiocb *req = &kiocb->rw;
 	struct iov_iter iter;
 	struct file *file;
@@ -678,7 +721,15 @@ static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 	if (unlikely(!file->f_op->read_iter))
 		goto out_fput;
 
-	ret = import_iovec(READ, buf, sqe->len, UIO_FASTIOV, &iovec, &iter);
+	if (sqe->opcode == IORING_OP_READV) {
+		void __user *buf = (void __user *) (uintptr_t) sqe->addr;
+
+		ret = import_iovec(READ, buf, sqe->len, UIO_FASTIOV, &iovec,
+					&iter);
+	} else {
+		ret = io_import_fixed(READ, kiocb, sqe, &iter);
+		iovec = NULL;
+	}
 	if (ret)
 		goto out_fput;
 
@@ -696,7 +747,6 @@ static ssize_t io_write(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 			struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
-	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
 	struct kiocb *req = &kiocb->rw;
 	struct iov_iter iter;
 	struct file *file;
@@ -714,7 +764,14 @@ static ssize_t io_write(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 	if (unlikely(!file->f_op->write_iter))
 		goto out_fput;
 
-	ret = import_iovec(WRITE, buf, sqe->len, UIO_FASTIOV, &iovec, &iter);
+	if (sqe->opcode == IORING_OP_WRITEV) {
+		void __user *buf = (void __user *) (uintptr_t) sqe->addr;
+
+		ret = import_iovec(WRITE, buf, sqe->len, UIO_FASTIOV, &iovec, &iter);
+	} else {
+		ret = io_import_fixed(WRITE, kiocb, sqe, &iter);
+		iovec = NULL;
+	}
 	if (ret)
 		goto out_fput;
 
@@ -802,9 +859,11 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	ret = -EINVAL;
 	switch (sqe->opcode) {
 	case IORING_OP_READV:
+	case IORING_OP_READ_FIXED:
 		ret = io_read(req, sqe, state);
 		break;
 	case IORING_OP_WRITEV:
+	case IORING_OP_WRITE_FIXED:
 		ret = io_write(req, sqe, state);
 		break;
 	case IORING_OP_FSYNC:
@@ -1007,6 +1066,127 @@ static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
 	return ret;
 }
 
+static void io_sqe_buffer_unmap(struct io_ring_ctx *ctx)
+{
+	int i, j;
+
+	if (!ctx->user_bufs)
+		return;
+
+	for (i = 0; i < ctx->sq_entries; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+
+		for (j = 0; j < imu->nr_bvecs; j++)
+			put_page(imu->bvec[j].bv_page);
+
+		kfree(imu->bvec);
+		imu->nr_bvecs = 0;
+	}
+
+	kfree(ctx->user_bufs);
+	ctx->user_bufs = NULL;
+}
+
+static int io_sqe_buffer_map(struct io_ring_ctx *ctx,
+			     struct iovec __user *iovecs)
+{
+	unsigned long total_pages, page_limit;
+	struct page **pages = NULL;
+	int i, j, got_pages = 0;
+	int ret = -EINVAL;
+
+	ctx->user_bufs = kcalloc(ctx->sq_entries, sizeof(struct io_mapped_ubuf),
+					GFP_KERNEL);
+	if (!ctx->user_bufs)
+		return -ENOMEM;
+
+	/* Don't allow more pages than we can safely lock */
+	total_pages = 0;
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	for (i = 0; i < ctx->sq_entries; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+		unsigned long off, start, end, ubuf;
+		int pret, nr_pages;
+		struct iovec iov;
+		size_t size;
+
+		ret = -EFAULT;
+		if (copy_from_user(&iov, &iovecs[i], sizeof(iov)))
+			goto err;
+
+		/*
+		 * Don't impose further limits on the size and buffer
+		 * constraints here, we'll -EINVAL later when IO is
+		 * submitted if they are wrong.
+		 */
+		ret = -EFAULT;
+		if (!iov.iov_base)
+			goto err;
+
+		/* arbitrary limit, but we need something */
+		if (iov.iov_len > SZ_4M)
+			goto err;
+
+		ubuf = (unsigned long) iov.iov_base;
+		end = (ubuf + iov.iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		start = ubuf >> PAGE_SHIFT;
+		nr_pages = end - start;
+
+		ret = -ENOMEM;
+		if (total_pages + nr_pages > page_limit)
+			goto err;
+
+		if (!pages || nr_pages > got_pages) {
+			kfree(pages);
+			pages = kmalloc(nr_pages * sizeof(struct page *),
+					GFP_KERNEL);
+			if (!pages)
+				goto err;
+			got_pages = nr_pages;
+		}
+
+		imu->bvec = kmalloc(nr_pages * sizeof(struct bio_vec),
+					GFP_KERNEL);
+		if (!imu->bvec)
+			goto err;
+
+		down_write(&current->mm->mmap_sem);
+		pret = get_user_pages_longterm(ubuf, nr_pages, 1, pages, NULL);
+		up_write(&current->mm->mmap_sem);
+
+		if (pret < nr_pages) {
+			if (pret < 0)
+				ret = pret;
+			goto err;
+		}
+
+		off = ubuf & ~PAGE_MASK;
+		size = iov.iov_len;
+		for (j = 0; j < nr_pages; j++) {
+			size_t vec_len;
+
+			vec_len = min_t(size_t, size, PAGE_SIZE - off);
+			imu->bvec[j].bv_page = pages[j];
+			imu->bvec[j].bv_len = vec_len;
+			imu->bvec[j].bv_offset = off;
+			off = 0;
+			size -= vec_len;
+		}
+		/* store original address for later verification */
+		imu->ubuf = ubuf;
+		imu->len = iov.iov_len;
+		imu->nr_bvecs = nr_pages;
+		total_pages += nr_pages;
+	}
+	kfree(pages);
+	return 0;
+err:
+	kfree(pages);
+	io_sqe_buffer_unmap(ctx);
+	return ret;
+}
+
 static void io_free_scq_urings(struct io_ring_ctx *ctx)
 {
 	if (ctx->sq_ring) {
@@ -1027,6 +1207,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 {
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_sqe_buffer_unmap(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
 }
@@ -1185,7 +1366,8 @@ static void io_fill_offsets(struct io_uring_params *p)
 	p->cq_off.cqes = offsetof(struct io_cq_ring, cqes);
 }
 
-static int io_uring_create(unsigned entries, struct io_uring_params *p)
+static int io_uring_create(unsigned entries, struct io_uring_params *p,
+			   struct iovec __user *iovecs)
 {
 	struct io_ring_ctx *ctx;
 	int ret;
@@ -1207,6 +1389,12 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	if (ret)
 		goto err;
 
+	if (iovecs) {
+		ret = io_sqe_buffer_map(ctx, iovecs);
+		if (ret)
+			goto err;
+	}
+
 	ret = anon_inode_getfd("[io_uring]", &io_scqring_fops, ctx,
 				O_RDWR | O_CLOEXEC);
 	if (ret < 0)
@@ -1240,10 +1428,8 @@ SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
 
 	if (p.flags & ~IORING_SETUP_IOPOLL)
 		return -EINVAL;
-	if (iovecs)
-		return -EINVAL;
 
-	ret = io_uring_create(entries, &p);
+	ret = io_uring_create(entries, &p, iovecs);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ba9e5b851f73..80d1a8224b9c 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -40,6 +40,8 @@ struct io_uring_sqe {
 #define IORING_OP_WRITEV	2
 #define IORING_OP_FSYNC		3
 #define IORING_OP_FDSYNC	4
+#define IORING_OP_READ_FIXED	5
+#define IORING_OP_WRITE_FIXED	6
 
 /*
  * IO completion data structure (Completion Queue Entry)
-- 
2.17.1

