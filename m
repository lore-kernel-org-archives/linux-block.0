Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B876C43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E262086C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h2ylMZpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfALVar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43831 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfALVap (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so8353808plb.10
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XEP6KqqE0cXLJ/gjC0UMvyFFqquWaHcgFrOVWDcHLU8=;
        b=h2ylMZpiMrky5MBzdUxKQKBmOUmmrwAcyqv4DEgDRI2AJustFw5bz30Eq3w4FP4hs1
         4hiOKrnhdahdqQ2w+oEBkGcorExj2KD1JBt1wV4Ew7hQ2izD0/rLD8/pwopn6zphKFk7
         BnpjmVZ+2qzTzBLWBc7l11+J6T7tDAg358QfRNExdzI05ralIQxOc2fLPjj6AuIEJUpD
         br9HU6zwlaorObLtKqp+EzZcX3LOrzTfCctEDd9ZAqOkKQlUrssBOqvlK/JMRrDrewAc
         sNCt2ZCiO+dDPi5kuuqTqKM71j4U2UERMPt4FEdDsv78ILVKLMgyLtiF6FAnExfn78AY
         ZBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XEP6KqqE0cXLJ/gjC0UMvyFFqquWaHcgFrOVWDcHLU8=;
        b=JjlljF1kL337i17v8Rl1gVMlP2hewQu6Ku/cBd9Fhy7NhQrealNvmEQR7qz50bZ3Dx
         gS8WhELHMkdthmtTMcGPdWQzIcaNu5tO5EipfKmlEtI2UzX1ZutYz0UwdQpJDXbzF8J1
         QuNyzA1nY++KhgDKFAv0arvHoiyrxpRPE+F4YIDfS4DD0Zt2l5om0KBSx+yJZw0J20jh
         ctXsNK3BT/2XtIGR8DZK5X/K+5mZmIWmkrfTU3Dy0jSNVqldBMsg315bITItcanrmb7P
         qZ/e1KNddkaDEXVWhXn6SaSvovD92bcEhVTxUhidE19kftQ4ne7YYF6n8L0EoCQ1TWBS
         UqrQ==
X-Gm-Message-State: AJcUukehAq6P4gNYnJEZJP9L4a7iypiKs7DVPe9AgmkGE2oHc051EX1g
        qa9if7VMcyUElaKkzifte0mgaFpV0n3uZg==
X-Google-Smtp-Source: ALg8bN4a75FSMMBTLGRkLQ4/WpZpz/yAPHDyRtYPIEq2RjLZpOqC3rHaMPlXj+4mSzmcOtMRkTXuSw==
X-Received: by 2002:a17:902:7005:: with SMTP id y5mr20009535plk.7.1547328644028;
        Sat, 12 Jan 2019 13:30:44 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/16] io_uring: add support for pre-mapped user IO buffers
Date:   Sat, 12 Jan 2019 14:30:08 -0700
Message-Id: <20190112213011.1439-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have fixed user buffers, we can map them into the kernel when we
setup the io_context. That avoids the need to do get_user_pages() for
each and every IO.

To utilize this feature, the application must call io_uring_register()
after having setup an io_uring context, passing in
IORING_REGISTER_BUFFERS as the opcode, and the following struct as the
argument:

struct io_uring_register_buffers {
	struct iovec *iovecs;
	__u32 nr_iovecs;
};

If successful, these buffers are now mapped into the kernel, eligible
for IO. To use these fixed buffers, the application must use the
IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
must point to somewhere inside the indexed buffer.

The application may register buffers throughout the lifetime of the
io_uring context. It can call io_uring_register() with
IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
buffers, and then register a new set. The application need not
unregister buffers explicitly before shutting down the io_uring context.

It's perfectly valid to setup a larger buffer, and then sometimes only
use parts of it for an IO. As long as the range is within the originally
mapped region, it will work just fine.

RLIMIT_MEMLOCK is used to check how much memory we can pin. A somewhat
arbitrary 1G per buffer size is also imposed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/io_uring.c                          | 318 +++++++++++++++++++++++--
 include/linux/syscalls.h               |   2 +
 include/uapi/linux/io_uring.h          |  17 +-
 kernel/sys_ni.c                        |   1 +
 5 files changed, 323 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 453ff7a79002..8e05d4f05d88 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,7 @@
 334	common	rseq			__x64_sys_rseq
 335	common	io_uring_setup		__x64_sys_io_uring_setup
 336	common	io_uring_enter		__x64_sys_io_uring_enter
+337	common	io_uring_register	__x64_sys_io_uring_register
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3867a93d485f..64e590175641 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -23,8 +23,11 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/blkdev.h>
+#include <linux/bvec.h>
 #include <linux/anon_inodes.h>
 #include <linux/sched/mm.h>
+#include <linux/sizes.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
@@ -60,6 +63,13 @@ struct list_multi {
 	unsigned multi;
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
 
@@ -82,6 +92,10 @@ struct io_ring_ctx {
 	struct mm_struct	*sqo_mm;
 	struct files_struct	*sqo_files;
 
+	/* if used, fixed mapped user buffers */
+	struct io_mapped_ubuf	*user_bufs;
+	unsigned		nr_user_bufs;
+
 	struct completion	ctx_done;
 
 	/* iopoll submission state */
@@ -726,11 +740,42 @@ static inline void io_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
+static int io_import_fixed(int rw, struct io_kiocb *req,
+			   const struct io_uring_sqe *sqe,
+			   struct iov_iter *iter)
+{
+	struct io_ring_ctx *ctx = req->ki_ctx;
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
+	index = array_index_nospec(sqe->buf_index, ctx->sq_entries);
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
 static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		       bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
-	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
 	struct kiocb *kiocb = &req->rw;
 	struct iov_iter iter;
 	struct file *file;
@@ -748,7 +793,15 @@ static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (unlikely(!file->f_op->read_iter))
 		goto out_fput;
 
-	ret = import_iovec(READ, buf, sqe->len, UIO_FASTIOV, &iovec, &iter);
+	if (sqe->opcode == IORING_OP_READ_FIXED) {
+		ret = io_import_fixed(READ, req, sqe, &iter);
+		iovec = NULL;
+	} else {
+		void __user *buf = (void __user *) (uintptr_t) sqe->addr;
+
+		ret = import_iovec(READ, buf, sqe->len, UIO_FASTIOV, &iovec,
+					&iter);
+	}
 	if (ret)
 		goto out_fput;
 
@@ -774,7 +827,6 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			bool force_nonblock, struct io_submit_state *state)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
-	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
 	struct kiocb *kiocb = &req->rw;
 	struct iov_iter iter;
 	struct file *file;
@@ -796,7 +848,15 @@ static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	if (unlikely(!file->f_op->write_iter))
 		goto out_fput;
 
-	ret = import_iovec(WRITE, buf, sqe->len, UIO_FASTIOV, &iovec, &iter);
+	if (sqe->opcode == IORING_OP_WRITE_FIXED) {
+		ret = io_import_fixed(WRITE, req, sqe, &iter);
+		iovec = NULL;
+	} else {
+		void __user *buf = (void __user *) (uintptr_t) sqe->addr;
+
+		ret = import_iovec(WRITE, buf, sqe->len, UIO_FASTIOV, &iovec,
+					&iter);
+	}
 	if (ret)
 		goto out_fput;
 
@@ -865,7 +925,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
-	if (unlikely(sqe->flags || sqe->__pad2))
+	if (unlikely(sqe->flags || sqe->__pad2 || sqe->__pad3))
 		return -EINVAL;
 
 	if (unlikely(s->index >= ctx->sq_entries))
@@ -875,9 +935,27 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = -EINVAL;
 	switch (sqe->opcode) {
 	case IORING_OP_READV:
+		if (unlikely(sqe->buf_index))
+			return -EINVAL;
 		ret = io_read(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_WRITEV:
+		if (unlikely(sqe->buf_index))
+			return -EINVAL;
+		ret = io_write(req, sqe, force_nonblock, state);
+		break;
+	case IORING_OP_READ_FIXED:
+		if (unlikely(!ctx->user_bufs))
+			return -EFAULT;
+		if (unlikely(sqe->buf_index >= ctx->nr_user_bufs))
+			return -EFAULT;
+		ret = io_read(req, sqe, force_nonblock, state);
+		break;
+	case IORING_OP_WRITE_FIXED:
+		if (unlikely(!ctx->user_bufs))
+			return -EFAULT;
+		if (unlikely(sqe->buf_index >= ctx->nr_user_bufs))
+			return -EFAULT;
 		ret = io_write(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_FSYNC:
@@ -903,9 +981,11 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 static void io_sq_wq_submit_work(struct work_struct *work)
 {
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work.work);
+	struct sqe_submit *s = &req->work.submit;
 	struct io_ring_ctx *ctx = req->ki_ctx;
-	mm_segment_t old_fs = get_fs();
 	struct files_struct *old_files;
+	mm_segment_t old_fs;
+	bool needs_user;
 	int ret;
 
 	/*
@@ -918,19 +998,32 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	old_files = current->files;
 	current->files = ctx->sqo_files;
 
-	if (!mmget_not_zero(ctx->sqo_mm)) {
-		ret = -EFAULT;
-		goto err;
+	/*
+	 * If we're doing IO to fixed buffers, we don't need to get/set
+	 * user context
+	 */
+	needs_user = true;
+	if (s->sqe->opcode == IORING_OP_READ_FIXED ||
+	    s->sqe->opcode == IORING_OP_WRITE_FIXED)
+		needs_user = false;
+
+	if (needs_user) {
+		if (!mmget_not_zero(ctx->sqo_mm)) {
+			ret = -EFAULT;
+			goto err;
+		}
+		use_mm(ctx->sqo_mm);
+		old_fs = get_fs();
+		set_fs(USER_DS);
 	}
 
-	use_mm(ctx->sqo_mm);
-	set_fs(USER_DS);
-
 	ret = __io_submit_sqe(ctx, req, &req->work.submit, false, NULL);
 
-	set_fs(old_fs);
-	unuse_mm(ctx->sqo_mm);
-	mmput(ctx->sqo_mm);
+	if (needs_user) {
+		set_fs(old_fs);
+		unuse_mm(ctx->sqo_mm);
+		mmput(ctx->sqo_mm);
+	}
 err:
 	if (ret) {
 		io_fill_cq_error(ctx, &req->work.submit, ret);
@@ -1173,6 +1266,132 @@ static void io_sq_offload_stop(struct io_ring_ctx *ctx)
 	}
 }
 
+static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
+{
+	int i, j;
+
+	if (!ctx->user_bufs)
+		return -EINVAL;
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
+	return 0;
+}
+
+static int io_sqe_buffer_register(struct io_ring_ctx *ctx,
+				  struct io_uring_register_buffers *reg)
+{
+	unsigned long total_pages, page_limit;
+	struct page **pages = NULL;
+	int i, j, got_pages = 0;
+	int ret = -EINVAL;
+
+	if (reg->nr_iovecs > USHRT_MAX)
+		return -EINVAL;
+
+	ctx->user_bufs = kcalloc(reg->nr_iovecs, sizeof(struct io_mapped_ubuf),
+					GFP_KERNEL);
+	if (!ctx->user_bufs)
+		return -ENOMEM;
+
+	/* Don't allow more pages than we can safely lock */
+	total_pages = 0;
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	for (i = 0; i < reg->nr_iovecs; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+		unsigned long off, start, end, ubuf;
+		int pret, nr_pages;
+		struct iovec iov;
+		size_t size;
+
+		ret = -EFAULT;
+		if (copy_from_user(&iov, &reg->iovecs[i], sizeof(iov)))
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
+		if (iov.iov_len > SZ_1G)
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
+	ctx->nr_user_bufs = reg->nr_iovecs;
+	return 0;
+err:
+	kfree(pages);
+	io_sqe_buffer_unregister(ctx);
+	return ret;
+}
+
 static void io_free_scq_urings(struct io_ring_ctx *ctx)
 {
 	if (ctx->sq_ring) {
@@ -1194,6 +1413,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sq_offload_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_sqe_buffer_unregister(ctx);
 	percpu_ref_exit(&ctx->refs);
 	kfree(ctx);
 }
@@ -1422,6 +1642,74 @@ SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 	return ret;
 }
 
+static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
+			       void __user *arg)
+{
+	int ret;
+
+	/* Drop our initial ref and wait for the ctx to be fully idle */
+	percpu_ref_put(&ctx->refs);
+	percpu_ref_kill(&ctx->refs);
+	wait_for_completion(&ctx->ctx_done);
+
+	switch (opcode) {
+	case IORING_REGISTER_BUFFERS: {
+		struct io_uring_register_buffers reg;
+
+		ret = -EFAULT;
+		if (copy_from_user(&reg, arg, sizeof(reg)))
+			break;
+		ret = io_sqe_buffer_register(ctx, &reg);
+		break;
+		}
+	case IORING_UNREGISTER_BUFFERS:
+		ret = -EINVAL;
+		if (arg)
+			break;
+		ret = io_sqe_buffer_unregister(ctx);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	/* bring the ctx back to life */
+	percpu_ref_resurrect(&ctx->refs);
+	percpu_ref_get(&ctx->refs);
+	return ret;
+}
+
+SYSCALL_DEFINE3(io_uring_register, unsigned int, fd, unsigned int, opcode,
+		void __user *, arg)
+{
+	struct io_ring_ctx *ctx;
+	long ret = -EBADF;
+	struct fd f;
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+
+	ret = -EOPNOTSUPP;
+	if (f.file->f_op != &io_scqring_fops)
+		goto out_fput;
+
+	ret = -EINVAL;
+	ctx = f.file->private_data;
+	if (!percpu_ref_tryget(&ctx->refs))
+		goto out_fput;
+
+	ret = -EBUSY;
+	if (mutex_trylock(&ctx->uring_lock)) {
+		ret = __io_uring_register(ctx, opcode, arg);
+		mutex_unlock(&ctx->uring_lock);
+	}
+	io_ring_drop_ctx_refs(ctx, 1);
+out_fput:
+	fdput(f);
+	return ret;
+}
+
 static int __init io_uring_setup(void)
 {
 	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 542757a4c898..e36c264d74e8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
 				struct io_uring_params __user *p);
 asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
 				u32 min_complete, u32 flags);
+asmlinkage long sys_io_uring_register(unsigned int fd, unsigned op,
+				void __user *arg);
 
 /* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 506498cc913e..e1eeb3fc7443 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -29,7 +29,9 @@ struct io_uring_sqe {
 		__kernel_rwf_t	rw_flags;
 		__u32		fsync_flags;
 	};
-	__u64	__pad2;
+	__u16	buf_index;	/* index into fixed buffers, if used */
+	__u16	__pad2;
+	__u32	__pad3;
 	__u64	user_data;	/* data to be passed back at completion time */
 };
 
@@ -41,6 +43,8 @@ struct io_uring_sqe {
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
 #define IORING_OP_FSYNC		3
+#define IORING_OP_READ_FIXED	4
+#define IORING_OP_WRITE_FIXED	5
 
 /*
  * sqe->fsync_flags
@@ -104,4 +108,15 @@ struct io_uring_params {
 	struct io_cqring_offsets cq_off;
 };
 
+/*
+ * io_uring_register(2) opcodes and arguments
+ */
+#define IORING_REGISTER_BUFFERS		0
+#define IORING_UNREGISTER_BUFFERS	1
+
+struct io_uring_register_buffers {
+	struct iovec *iovecs;
+	__u32 nr_iovecs;
+};
+
 #endif
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index ee5e523564bb..1bb6604dc19f 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -48,6 +48,7 @@ COND_SYSCALL_COMPAT(io_getevents);
 COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
+COND_SYSCALL(io_uring_register);
 
 /* fs/xattr.c */
 
-- 
2.17.1

