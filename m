Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A79C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDFA2184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VhWFaqUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfAWPf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:35:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32992 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAWPf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:35:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so1245835pgu.0
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aZSmKaenOGyifuCo3xnDrHVOL/A9zE3YjNYfaq4Ku50=;
        b=VhWFaqUZ+4/LPAo7Ktum2RmbXk0+e7gjZRy9v604nywIpFZsPft/uAMc7FULfycihk
         +u4Z2b5RxUDks7PVvrNLs1YjjmtbLMFjClYzHxJzBDIJYkKIE5T1DvrWzWyT4kDVooH9
         ApMXvGD2c8VD62ljgA4fkBwW8SVNtMW6Ub/uXts7Xi5iqr6N/EA2Bs1wYmaehnWh6fXO
         OhXxSRVm4EA3A3guy1qoEaLjREQbMbGjzet7f8xTfZ1EnV5xM+yohmfFIMPCJLV01UXt
         aGwjebtZ0AumAQ5NXL9yA/vpWuLEb9McPJWwOflz6KgMT2bp0kdu3fje334ps2wrHvwD
         jUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aZSmKaenOGyifuCo3xnDrHVOL/A9zE3YjNYfaq4Ku50=;
        b=pR4mhsyFMkWuhTWWQDupTB+QCtuX8W9us/48PCwQUhF84YcL66rpeR/qknVOLNEg7F
         w4KXG/GTBbkYYL34yt4QXdjZyAWcTPe1NIQ3Qt1ZHoUKNzEZ0Oki0NyyYegZcMaO7ahx
         8s6OCLWqT4KgYwXJ3mJQgImP0WDlCEfOSmgY7Kwi6UPaE9hITX4JpxwOPclPKsofNJqU
         bfdxEZNsMC7/6BxCjn7ReX5cnMgYkoFaDEFNeaMJYUcAV3WtVkm57YM5QXHPbS9SeQV9
         qp7z0in9oOy1IqTAIlkM7+5IzX+IdeGHmIY16B+egGn7AYBmp+5R0E3z+leboTlfzU1r
         aOdQ==
X-Gm-Message-State: AJcUukf9UCzWo9O4WEv1pjcv3sLNZAmqqUxRIiWPp38NfS0d59TooBqu
        U4U9/g5Ky8i2C6k74J3wXMGdoA==
X-Google-Smtp-Source: ALg8bN4ehJ1AUCJbP2yYLdd/0ztCDyIGTle6TmNuH4h9njXGCV43Uk3d7sbssx+YhBHE6PZevK7d/A==
X-Received: by 2002:a63:a30a:: with SMTP id s10mr2214755pge.234.1548257755448;
        Wed, 23 Jan 2019 07:35:55 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:35:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/13] io_uring: add support for pre-mapped user IO buffers
Date:   Wed, 23 Jan 2019 08:35:18 -0700
Message-Id: <20190123153536.7081-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have fixed user buffers, we can map them into the kernel when we
setup the io_context. That avoids the need to do get_user_pages() for
each and every IO.

To utilize this feature, the application must call io_uring_register()
after having setup an io_uring context, passing in
IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
to an iovec array, and the nr_args should contain how many iovecs the
application wishes to map.

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

For now, buffers must not be file backed. If file backed buffers are
passed in, the registration will fail with -1/EOPNOTSUPP. This
restriction may be relaxed in the future.

RLIMIT_MEMLOCK is used to check how much memory we can pin. A somewhat
arbitrary 1G per buffer size is also imposed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/io_uring.c                          | 357 ++++++++++++++++++++++++-
 include/linux/sched/user.h             |   2 +-
 include/linux/syscalls.h               |   2 +
 include/uapi/linux/io_uring.h          |  13 +-
 kernel/sys_ni.c                        |   1 +
 7 files changed, 364 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 194e79c0032e..7e89016f8118 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -400,3 +400,4 @@
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_compat_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
+427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 453ff7a79002..8e05d4f05d88 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,7 @@
 334	common	rseq			__x64_sys_rseq
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
+427	common	io_uring_register	__x64_sys_io_uring_register
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 497bea0f29c5..63ad09e7cdc7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -25,8 +25,11 @@
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
@@ -57,6 +60,13 @@ struct io_cq_ring {
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
 	struct {
 		struct percpu_ref	refs;
@@ -90,6 +100,10 @@ struct io_ring_ctx {
 		struct fasync_struct	*cq_fasync;
 	} ____cacheline_aligned_in_smp;
 
+	/* if used, fixed mapped user buffers */
+	unsigned		nr_user_bufs;
+	struct io_mapped_ubuf	*user_bufs;
+
 	struct user_struct	*user;
 
 	struct completion	ctx_done;
@@ -664,12 +678,51 @@ static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 	}
 }
 
+static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
+			   const struct io_uring_sqe *sqe,
+			   struct iov_iter *iter)
+{
+	struct io_mapped_ubuf *imu;
+	size_t len = sqe->len;
+	size_t offset;
+	int index;
+
+	/* attempt to use fixed buffers without having provided iovecs */
+	if (unlikely(!ctx->user_bufs))
+		return -EFAULT;
+	if (unlikely(sqe->buf_index >= ctx->nr_user_bufs))
+		return -EFAULT;
+
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
 static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
 			   const struct io_uring_sqe *sqe,
 			   struct iovec **iovec, struct iov_iter *iter)
 {
 	void __user *buf = u64_to_user_ptr(sqe->addr);
 
+	if (sqe->opcode == IORING_OP_READ_FIXED ||
+	    sqe->opcode == IORING_OP_WRITE_FIXED) {
+		ssize_t ret = io_import_fixed(ctx, rw, sqe, iter);
+		*iovec = NULL;
+		return ret;
+	}
+
 #ifdef CONFIG_COMPAT
 	if (ctx->compat)
 		return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
@@ -805,7 +858,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
-	if (unlikely(sqe->addr || sqe->ioprio))
+	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
 		return -EINVAL;
 	if (unlikely(sqe->fsync_flags & ~IORING_FSYNC_DATASYNC))
 		return -EINVAL;
@@ -840,9 +893,19 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		ret = io_nop(req, sqe);
 		break;
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
+		ret = io_read(req, sqe, force_nonblock, state);
+		break;
+	case IORING_OP_WRITE_FIXED:
 		ret = io_write(req, sqe, force_nonblock, state);
 		break;
 	case IORING_OP_FSYNC:
@@ -865,14 +928,21 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return 0;
 }
 
+static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
+{
+	return !(sqe->opcode == IORING_OP_READ_FIXED ||
+		 sqe->opcode == IORING_OP_WRITE_FIXED);
+}
+
 static void io_sq_wq_submit_work(struct work_struct *work)
 {
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct sqe_submit *s = &req->submit;
 	u64 user_data = s->sqe->user_data;
 	struct io_ring_ctx *ctx = req->ctx;
-	mm_segment_t old_fs = get_fs();
 	struct files_struct *old_files;
+	mm_segment_t old_fs;
+	bool needs_user;
 	int ret;
 
 	 /* Ensure we clear previously set forced non-block flag */
@@ -881,19 +951,28 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 	old_files = current->files;
 	current->files = ctx->sqo_files;
 
-	if (!mmget_not_zero(ctx->sqo_mm)) {
-		ret = -EFAULT;
-		goto err;
+	/*
+	 * If we're doing IO to fixed buffers, we don't need to get/set
+	 * user context
+	 */
+	needs_user = io_sqe_needs_user(s->sqe);
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
 	ret = __io_submit_sqe(ctx, req, s, false, NULL);
 
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
 		io_cqring_add_event(ctx, user_data, ret, 0);
@@ -1163,6 +1242,14 @@ static int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 	return 0;
 }
 
+static int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
+{
+	if (ctx->user)
+		return __io_account_mem(ctx->user, nr_pages);
+
+	return 0;
+}
+
 static unsigned long ring_pages(unsigned sq_entries, unsigned cq_entries)
 {
 	struct io_sq_ring *sq_ring;
@@ -1176,6 +1263,190 @@ static unsigned long ring_pages(unsigned sq_entries, unsigned cq_entries)
 	return (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
 }
 
+static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
+{
+	int i, j;
+
+	if (!ctx->user_bufs)
+		return -ENXIO;
+
+	for (i = 0; i < ctx->sq_entries; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+
+		for (j = 0; j < imu->nr_bvecs; j++)
+			put_page(imu->bvec[j].bv_page);
+
+		io_unaccount_mem(ctx, imu->nr_bvecs);
+		kfree(imu->bvec);
+		imu->nr_bvecs = 0;
+	}
+
+	kfree(ctx->user_bufs);
+	ctx->user_bufs = NULL;
+	free_uid(ctx->user);
+	ctx->user = NULL;
+	return 0;
+}
+
+static int io_copy_iov(struct io_ring_ctx *ctx, struct iovec *dst,
+		       void __user *arg, unsigned index)
+{
+	struct iovec __user *src;
+
+#ifdef CONFIG_COMPAT
+	if (ctx->compat) {
+		struct compat_iovec __user *ciovs;
+		struct compat_iovec ciov;
+
+		ciovs = (struct compat_iovec __user *) arg;
+		if (copy_from_user(&ciov, &ciovs[index], sizeof(ciov)))
+			return -EFAULT;
+
+		dst->iov_base = (void __user *) (unsigned long) ciov.iov_base;
+		dst->iov_len = ciov.iov_len;
+		return 0;
+	}
+#endif
+	src = (struct iovec __user *) arg;
+	if (copy_from_user(dst, &src[index], sizeof(*dst)))
+		return -EFAULT;
+	return 0;
+}
+
+static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
+				  unsigned nr_args)
+{
+	struct vm_area_struct **vmas = NULL;
+	struct page **pages = NULL;
+	int i, j, got_pages = 0;
+	int ret = -EINVAL;
+
+	if (ctx->user_bufs)
+		return -EBUSY;
+	if (!nr_args || nr_args > UIO_MAXIOV)
+		return -EINVAL;
+
+	ctx->user_bufs = kcalloc(nr_args, sizeof(struct io_mapped_ubuf),
+					GFP_KERNEL);
+	if (!ctx->user_bufs)
+		return -ENOMEM;
+
+	if (!capable(CAP_IPC_LOCK))
+		ctx->user = get_uid(current_user());
+
+	for (i = 0; i < nr_args; i++) {
+		struct io_mapped_ubuf *imu = &ctx->user_bufs[i];
+		unsigned long off, start, end, ubuf;
+		int pret, nr_pages;
+		struct iovec iov;
+		size_t size;
+
+		ret = io_copy_iov(ctx, &iov, arg, i);
+		if (ret)
+			break;
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
+		ret = io_account_mem(ctx, nr_pages);
+		if (ret)
+			goto err;
+
+		if (!pages || nr_pages > got_pages) {
+			kfree(vmas);
+			kfree(pages);
+			pages = kmalloc_array(nr_pages, sizeof(struct page *),
+						GFP_KERNEL);
+			vmas = kmalloc_array(nr_pages,
+					sizeof(struct vma_area_struct *),
+					GFP_KERNEL);
+			if (!pages || !vmas) {
+				io_unaccount_mem(ctx, nr_pages);
+				goto err;
+			}
+			got_pages = nr_pages;
+		}
+
+		imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
+						GFP_KERNEL);
+		if (!imu->bvec) {
+			io_unaccount_mem(ctx, nr_pages);
+			goto err;
+		}
+
+		down_write(&current->mm->mmap_sem);
+		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
+						pages, vmas);
+		if (pret == nr_pages) {
+			/* don't support file backed memory */
+			for (j = 0; j < nr_pages; j++) {
+				struct vm_area_struct *vma = vmas[j];
+
+				if (vma->vm_file) {
+					ret = -EOPNOTSUPP;
+					break;
+				}
+			}
+		} else {
+			ret = pret < 0 ? pret : -EFAULT;
+		}
+		up_write(&current->mm->mmap_sem);
+		if (ret) {
+			/*
+			 * if we did partial map, or found file backed vmas,
+			 * release any pages we did get
+			 */
+			if (pret > 0) {
+				for (j = 0; j < pret; j++)
+					put_page(pages[j]);
+			}
+			io_unaccount_mem(ctx, nr_pages);
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
+	}
+	kfree(pages);
+	kfree(vmas);
+	ctx->nr_user_bufs = nr_args;
+	return 0;
+err:
+	kfree(pages);
+	kfree(vmas);
+	io_sqe_buffer_unregister(ctx);
+	return ret;
+}
+
 static void io_free_scq_urings(struct io_ring_ctx *ctx)
 {
 	if (ctx->sq_ring) {
@@ -1197,6 +1468,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sq_offload_stop(ctx);
 	io_iopoll_reap_events(ctx);
 	io_free_scq_urings(ctx);
+	io_sqe_buffer_unregister(ctx);
 	percpu_ref_exit(&ctx->refs);
 	io_unaccount_mem(ctx, ring_pages(ctx->sq_entries, ctx->cq_entries));
 	kfree(ctx);
@@ -1488,6 +1760,69 @@ COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
 }
 #endif
 
+static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
+			       void __user *arg, unsigned nr_args)
+{
+	int ret;
+
+	/* Drop our initial ref and wait for the ctx to be fully idle */
+	percpu_ref_put(&ctx->refs);
+	percpu_ref_kill(&ctx->refs);
+	wait_for_completion(&ctx->ctx_done);
+
+	switch (opcode) {
+	case IORING_REGISTER_BUFFERS:
+		ret = io_sqe_buffer_register(ctx, arg, nr_args);
+		break;
+	case IORING_UNREGISTER_BUFFERS:
+		ret = -EINVAL;
+		if (arg || nr_args)
+			break;
+		ret = io_sqe_buffer_unregister(ctx);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	/* bring the ctx back to life */
+	reinit_completion(&ctx->ctx_done);
+	percpu_ref_resurrect(&ctx->refs);
+	percpu_ref_get(&ctx->refs);
+	return ret;
+}
+
+SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
+		void __user *, arg, unsigned int, nr_args)
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
+	if (f.file->f_op != &io_uring_fops)
+		goto out_fput;
+
+	ret = -ENXIO;
+	ctx = f.file->private_data;
+	if (!percpu_ref_tryget(&ctx->refs))
+		goto out_fput;
+
+	ret = -EBUSY;
+	if (mutex_trylock(&ctx->uring_lock)) {
+		ret = __io_uring_register(ctx, opcode, arg, nr_args);
+		mutex_unlock(&ctx->uring_lock);
+	}
+	io_ring_drop_ctx_refs(ctx, 1);
+out_fput:
+	fdput(f);
+	return ret;
+}
+
 static int __init io_uring_init(void)
 {
 	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 39ad98c09c58..c7b5f86b91a1 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -40,7 +40,7 @@ struct user_struct {
 	kuid_t uid;
 
 #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
-    defined(CONFIG_NET)
+    defined(CONFIG_NET) || defined(CONFIG_IO_URING)
 	atomic_long_t locked_vm;
 #endif
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 542757a4c898..101f7024d154 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -314,6 +314,8 @@ asmlinkage long sys_io_uring_setup(u32 entries,
 				struct io_uring_params __user *p);
 asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
 				u32 min_complete, u32 flags);
+asmlinkage long sys_io_uring_register(unsigned int fd, unsigned int op,
+				void __user *arg, unsigned int nr_args);
 
 /* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 4fc5fbd07688..03ce7133c3b2 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -29,7 +29,10 @@ struct io_uring_sqe {
 		__u32		fsync_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
-	__u64	__pad2[3];
+	union {
+		__u16	buf_index;	/* index into fixed buffers, if used */
+		__u64	__pad2[3];
+	};
 };
 
 /*
@@ -41,6 +44,8 @@ struct io_uring_sqe {
 #define IORING_OP_READV		1
 #define IORING_OP_WRITEV	2
 #define IORING_OP_FSYNC		3
+#define IORING_OP_READ_FIXED	4
+#define IORING_OP_WRITE_FIXED	5
 
 /*
  * sqe->fsync_flags
@@ -104,4 +109,10 @@ struct io_uring_params {
 	struct io_cqring_offsets cq_off;
 };
 
+/*
+ * io_uring_register(2) opcodes and arguments
+ */
+#define IORING_REGISTER_BUFFERS		0
+#define IORING_UNREGISTER_BUFFERS	1
+
 #endif
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d754811ec780..38567718c397 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -49,6 +49,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL_COMPAT(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
+COND_SYSCALL(io_uring_register);
 
 /* fs/xattr.c */
 
-- 
2.17.1

