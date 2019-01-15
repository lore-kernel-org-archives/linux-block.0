Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D345C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A420656
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CtTFbXj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfAOCzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:55:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44776 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfAOCzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:55:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so566787pfh.11
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1RMmt5kMMIwEokUf0M4lal2q7/IXOmTJj4+ndVU+AU8=;
        b=CtTFbXj5vN3FjcRZG+7qpO2y09oOpG358+kKrHJW3S7N3sLx9WbDH40kMW6M8A34MG
         sTzWJp7danSVKL9MKaCTMWJ+aXAo2KWe9xqrIeHfuX20icMGofXR+x2+oIdla6q9psEL
         s/GkAxGVIJMHRpKp5pC4C3YtmSo5i1EFolIiUIkHDHIv2os8tZiy4w6iFOA2HJhvSK+p
         +Q/6sNcRMSPrM69364Q8//ZWVx5IhjFjjOq9x9X65hgh09dZ3Kg7SBV0HDpVwxpdn2MR
         Q5AwhRAuxic5pgTcuPNiH5lQkUVyXUKOx1lbQYxXCZsmJS/SdX6GIMnyhnQsr684B89u
         xmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1RMmt5kMMIwEokUf0M4lal2q7/IXOmTJj4+ndVU+AU8=;
        b=gy2pXleZaHTfP3B7Koevwr9IXmjdA4EP5eCvsdupWqvx/Fb/XwAewJ4eMZwk5Shh0V
         R2dNHPcquZDH/3SjS42eeUSvapK5sx9yvKoUEHkuEJwiROnhSXFB0IXT1298Lmz+PDqE
         4TnFEaE+ZDTk759jfhdPcEdOsthC3fd/Qup6PEd9mFKoepWTBTZ0NqOUu9MMYI6k0Pqv
         0v7YvY9IZckxmigz0NskhGcWyQHBEwuJDdRz8wcaKCKComEnPV45hDFSVHsQLaffe517
         9lFcxOpxBzv6QthLMJGWvi7nJryU0IJm2NbIhPmsmpxps5qbcTfj2SlqQRwDAFK+XE0r
         3DDg==
X-Gm-Message-State: AJcUukctaPMC0BOvbLwhm9Q400LMrh8aCiuR1uIn08NDfX63x3rZlWpJ
        eZ8RFXHSa8FoCrRUKCTsICg8ww==
X-Google-Smtp-Source: ALg8bN6NgweHSFxYgJBiV66u/ohmDNjb5QbB6ZEk3FKpmbhgY5VY5AOu9w/3bisS2RwB3+xKVAbW1w==
X-Received: by 2002:a63:451a:: with SMTP id s26mr1740017pga.150.1547520947530;
        Mon, 14 Jan 2019 18:55:47 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/16] Add io_uring IO interface
Date:   Mon, 14 Jan 2019 19:55:20 -0700
Message-Id: <20190115025531.13985-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The submission queue (SQ) and completion queue (CQ) rings are shared
between the application and the kernel. This eliminates the need to
copy data back and forth to submit and complete IO.

IO submissions use the io_uring_sqe data structure, and completions
are generated in the form of io_uring_sqe data structures. The SQ
ring is an index into the io_uring_sqe array, which makes it possible
to submit a batch of IOs without them being contiguous in the ring.
The CQ ring is always contiguous, as completion events are inherently
unordered and can point to any io_uring_iocb.

Two new system calls are added for this:

io_uring_setup(entries, iovecs, params)
	Sets up a context for doing async IO. On success, returns a file
	descriptor that the application can mmap to gain access to the
	SQ ring, CQ ring, and io_uring_iocbs.

io_uring_enter(fd, to_submit, min_complete, flags)
	Initiates IO against the rings mapped to this fd, or waits for
	them to complete, or both The behavior is controlled by the
	parameters passed in. If 'min_complete' is non-zero, then we'll
	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
	kernel will wait for 'min_complete' events, if they aren't
	already available.

With this setup, it's possible to do async IO with a single system
call. Future developments will enable polled IO with this interface,
and polled submission as well. The latter will enable an application
to do IO without doing ANY system calls at all.

For IRQ driven IO, an application only needs to enter the kernel for
completions if it wants to wait for them to occur.

Each io_uring is backed by a workqueue, to support buffered async IO
as well. We will only punt to an async context if the command would
need to wait for IO on the device side. Any data that can be accessed
directly in the page cache is done inline. This avoids the slowness
issue of usual threadpools, since cached data is accessed as quickly
as a sync interface.

Sample application: http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/Makefile                            |   1 +
 fs/io_uring.c                          | 977 +++++++++++++++++++++++++
 include/linux/syscalls.h               |   5 +
 include/uapi/linux/io_uring.h          |  97 +++
 init/Kconfig                           |   9 +
 kernel/sys_ni.c                        |   2 +
 8 files changed, 1095 insertions(+)
 create mode 100644 fs/io_uring.c
 create mode 100644 include/uapi/linux/io_uring.h

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3cf7b533b3d1..194e79c0032e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,3 +398,5 @@
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
+387	i386	io_uring_setup		sys_io_uring_setup		__ia32_compat_sys_io_uring_setup
+388	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..453ff7a79002 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+335	common	io_uring_setup		__x64_sys_io_uring_setup
+336	common	io_uring_enter		__x64_sys_io_uring_enter
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/Makefile b/fs/Makefile
index 293733f61594..8e15d6fc4340 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_TIMERFD)		+= timerfd.o
 obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
 obj-$(CONFIG_AIO)               += aio.o
+obj-$(CONFIG_IO_URING)		+= io_uring.o
 obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
diff --git a/fs/io_uring.c b/fs/io_uring.c
new file mode 100644
index 000000000000..148eb3af7dc4
--- /dev/null
+++ b/fs/io_uring.c
@@ -0,0 +1,977 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Shared application/kernel submission and completion ring pairs, for
+ * supporting fast/efficient IO.
+ *
+ * Copyright (C) 2019 Jens Axboe
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/syscalls.h>
+#include <linux/compat.h>
+#include <linux/refcount.h>
+#include <linux/uio.h>
+
+#include <linux/sched/signal.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/mmu_context.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/blkdev.h>
+#include <linux/anon_inodes.h>
+#include <linux/sched/mm.h>
+
+#include <linux/uaccess.h>
+#include <linux/nospec.h>
+
+#include <uapi/linux/io_uring.h>
+
+#include "internal.h"
+
+struct io_uring {
+	u32 head ____cacheline_aligned_in_smp;
+	u32 tail ____cacheline_aligned_in_smp;
+};
+
+struct io_sq_ring {
+	struct io_uring		r;
+	u32			ring_mask;
+	u32			ring_entries;
+	u32			dropped;
+	u32			flags;
+	u32			array[];
+};
+
+struct io_cq_ring {
+	struct io_uring		r;
+	u32			ring_mask;
+	u32			ring_entries;
+	u32			overflow;
+	struct io_uring_cqe	cqes[];
+};
+
+struct io_ring_ctx {
+	struct percpu_ref	refs;
+
+	unsigned int		flags;
+	bool			compat;
+
+	/* SQ ring */
+	struct io_sq_ring	*sq_ring;
+	unsigned		sq_entries;
+	unsigned		sq_mask;
+	unsigned		sq_thread_cpu;
+	struct io_uring_sqe	*sq_sqes;
+
+	/* CQ ring */
+	struct io_cq_ring	*cq_ring;
+	unsigned		cq_entries;
+	unsigned		cq_mask;
+
+	/* IO offload */
+	struct workqueue_struct	*sqo_wq;
+	struct mm_struct	*sqo_mm;
+	struct files_struct	*sqo_files;
+
+	struct completion	ctx_done;
+
+	struct {
+		struct mutex		uring_lock;
+		wait_queue_head_t	wait;
+	} ____cacheline_aligned_in_smp;
+
+	struct {
+		spinlock_t		completion_lock;
+	} ____cacheline_aligned_in_smp;
+};
+
+struct sqe_submit {
+	const struct io_uring_sqe *sqe;
+	unsigned index;
+};
+
+struct io_work {
+	struct work_struct work;
+	struct sqe_submit submit;
+};
+
+struct io_kiocb {
+	union {
+		struct kiocb		rw;
+		struct io_work		work;
+	};
+
+	struct io_ring_ctx	*ctx;
+	struct list_head	list;
+	unsigned long		flags;
+#define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
+	u64			user_data;
+};
+
+#define IO_PLUG_THRESHOLD		2
+
+static struct kmem_cache *req_cachep;
+
+static const struct file_operations io_uring_fops;
+
+static void io_ring_ctx_ref_free(struct percpu_ref *ref)
+{
+	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
+
+	complete(&ctx->ctx_done);
+}
+
+static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
+{
+	struct io_ring_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free, 0, GFP_KERNEL)) {
+		kfree(ctx);
+		return NULL;
+	}
+
+	ctx->flags = p->flags;
+	init_completion(&ctx->ctx_done);
+	spin_lock_init(&ctx->completion_lock);
+	init_waitqueue_head(&ctx->wait);
+	mutex_init(&ctx->uring_lock);
+	return ctx;
+}
+
+static void io_inc_cqring(struct io_ring_ctx *ctx)
+{
+	struct io_cq_ring *ring = ctx->cq_ring;
+
+	ring->r.tail++;
+	smp_wmb();
+}
+
+static struct io_uring_cqe *io_peek_cqring(struct io_ring_ctx *ctx)
+{
+	struct io_cq_ring *ring = ctx->cq_ring;
+	unsigned tail;
+
+	smp_rmb();
+	tail = READ_ONCE(ring->r.tail);
+	if (tail + 1 == READ_ONCE(ring->r.head))
+		return NULL;
+
+	return &ring->cqes[tail & ctx->cq_mask];
+}
+
+static void __io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+				   long res, unsigned ev_flags)
+{
+	struct io_uring_cqe *cqe;
+
+	/*
+	 * If we can't get a cq entry, userspace overflowed the
+	 * submission (by quite a lot). Increment the overflow count in
+	 * the ring.
+	 */
+	cqe = io_peek_cqring(ctx);
+	if (cqe) {
+		cqe->user_data = ki_user_data;
+		cqe->res = res;
+		cqe->flags = ev_flags;
+		smp_wmb();
+		io_inc_cqring(ctx);
+	} else
+		ctx->cq_ring->overflow++;
+}
+
+static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
+				 long res, unsigned ev_flags)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+	__io_cqring_fill_event(ctx, ki_user_data, res, ev_flags);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+}
+
+static void io_fill_cq_error(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			     long error)
+{
+	io_cqring_fill_event(ctx, s->index, error, 0);
+
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+}
+
+static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	if (!percpu_ref_tryget(&ctx->refs))
+		return NULL;
+
+	req = kmem_cache_alloc(req_cachep, GFP_ATOMIC | __GFP_NOWARN);
+	if (!req)
+		return NULL;
+
+	req->ctx = ctx;
+	INIT_LIST_HEAD(&req->list);
+	req->flags = 0;
+	return req;
+}
+
+static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
+{
+	percpu_ref_put_many(&ctx->refs, refs);
+
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+}
+
+static void io_free_req(struct io_kiocb *req)
+{
+	kmem_cache_free(req_cachep, req);
+	io_ring_drop_ctx_refs(req->ctx, 1);
+}
+
+static void kiocb_end_write(struct kiocb *kiocb)
+{
+	if (kiocb->ki_flags & IOCB_WRITE) {
+		struct inode *inode = file_inode(kiocb->ki_filp);
+
+		/*
+		 * Tell lockdep we inherited freeze protection from submission
+		 * thread.
+		 */
+		if (S_ISREG(inode->i_mode))
+			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+		file_end_write(kiocb->ki_filp);
+	}
+}
+
+static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+
+	kiocb_end_write(kiocb);
+
+	fput(kiocb->ki_filp);
+	io_cqring_fill_event(req->ctx, req->user_data, res, 0);
+	io_free_req(req);
+}
+
+static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		      bool force_nonblock)
+{
+	struct kiocb *kiocb = &req->rw;
+	int ret;
+
+	kiocb->ki_filp = fget(sqe->fd);
+	if (unlikely(!kiocb->ki_filp))
+		return -EBADF;
+	kiocb->ki_pos = sqe->off;
+	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
+	kiocb->ki_hint = ki_hint_validate(file_write_hint(kiocb->ki_filp));
+	if (sqe->ioprio) {
+		ret = ioprio_check_cap(sqe->ioprio);
+		if (ret)
+			goto out_fput;
+
+		kiocb->ki_ioprio = sqe->ioprio;
+	} else
+		kiocb->ki_ioprio = get_current_ioprio();
+
+	ret = kiocb_set_rw_flags(kiocb, sqe->rw_flags);
+	if (unlikely(ret))
+		goto out_fput;
+	if (force_nonblock) {
+		kiocb->ki_flags |= IOCB_NOWAIT;
+		req->flags |= REQ_F_FORCE_NONBLOCK;
+	}
+	if (kiocb->ki_flags & IOCB_HIPRI) {
+		ret = -EINVAL;
+		goto out_fput;
+	}
+
+	kiocb->ki_complete = io_complete_rw;
+	return 0;
+out_fput:
+	fput(kiocb->ki_filp);
+	return ret;
+}
+
+static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
+{
+	switch (ret) {
+	case -EIOCBQUEUED:
+		break;
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/*
+		 * There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		/*FALLTHRU*/
+	default:
+		kiocb->ki_complete(kiocb, ret, 0);
+	}
+}
+
+static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
+			   const struct io_uring_sqe *sqe,
+			   struct iovec **iovec, struct iov_iter *iter)
+{
+	void __user *buf = (void __user *) (uintptr_t) sqe->addr;
+
+#ifdef CONFIG_COMPAT
+	if (ctx->compat)
+		return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
+						iovec, iter);
+#endif
+	return import_iovec(rw, buf, sqe->len, UIO_FASTIOV, iovec, iter);
+}
+
+static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		       bool force_nonblock)
+{
+	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct kiocb *kiocb = &req->rw;
+	struct iov_iter iter;
+	struct file *file;
+	ssize_t ret;
+
+	ret = io_prep_rw(req, sqe, force_nonblock);
+	if (ret)
+		return ret;
+	file = kiocb->ki_filp;
+
+	ret = -EBADF;
+	if (unlikely(!(file->f_mode & FMODE_READ)))
+		goto out_fput;
+	ret = -EINVAL;
+	if (unlikely(!file->f_op->read_iter))
+		goto out_fput;
+
+	ret = io_import_iovec(req->ctx, READ, sqe, &iovec, &iter);
+	if (ret)
+		goto out_fput;
+
+	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_iter_count(&iter));
+	if (!ret) {
+		ssize_t ret2;
+
+		/* Catch -EAGAIN return for forced non-blocking submission */
+		ret2 = call_read_iter(file, kiocb, &iter);
+		if (!force_nonblock || ret2 != -EAGAIN)
+			io_rw_done(kiocb, ret2);
+		else
+			ret = -EAGAIN;
+	}
+	kfree(iovec);
+out_fput:
+	if (unlikely(ret))
+		fput(file);
+	return ret;
+}
+
+static ssize_t io_write(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+			bool force_nonblock)
+{
+	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct kiocb *kiocb = &req->rw;
+	struct iov_iter iter;
+	struct file *file;
+	ssize_t ret;
+
+	ret = io_prep_rw(req, sqe, force_nonblock);
+	if (ret)
+		return ret;
+	file = kiocb->ki_filp;
+
+	ret = -EAGAIN;
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
+		goto out_fput;
+
+	ret = -EBADF;
+	if (unlikely(!(file->f_mode & FMODE_WRITE)))
+		goto out_fput;
+	ret = -EINVAL;
+	if (unlikely(!file->f_op->write_iter))
+		goto out_fput;
+
+	ret = io_import_iovec(req->ctx, WRITE, sqe, &iovec, &iter);
+	if (ret)
+		goto out_fput;
+
+	ret = rw_verify_area(WRITE, file, &kiocb->ki_pos,
+				iov_iter_count(&iter));
+	if (!ret) {
+		/*
+		 * Open-code file_start_write here to grab freeze protection,
+		 * which will be released by another thread in
+		 * io_complete_rw().  Fool lockdep by telling it the lock got
+		 * released so that it doesn't complain about the held lock when
+		 * we return to userspace.
+		 */
+		if (S_ISREG(file_inode(file)->i_mode)) {
+			__sb_start_write(file_inode(file)->i_sb,
+						SB_FREEZE_WRITE, true);
+			__sb_writers_release(file_inode(file)->i_sb,
+						SB_FREEZE_WRITE);
+		}
+		kiocb->ki_flags |= IOCB_WRITE;
+		io_rw_done(kiocb, call_write_iter(file, kiocb, &iter));
+	}
+out_fput:
+	if (unlikely(ret))
+		fput(file);
+	return ret;
+}
+
+/*
+ * IORING_OP_NOP just posts a completion event, nothing else.
+ */
+static int io_nop(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+
+	__io_cqring_fill_event(ctx, sqe->user_data, 0, 0);
+	io_free_req(req);
+	return 0;
+}
+
+static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			   struct sqe_submit *s, bool force_nonblock)
+{
+	const struct io_uring_sqe *sqe = s->sqe;
+	ssize_t ret;
+
+	/* enforce forwards compatibility on users */
+	if (unlikely(sqe->flags))
+		return -EINVAL;
+
+	if (unlikely(s->index >= ctx->sq_entries))
+		return -EINVAL;
+	req->user_data = sqe->user_data;
+
+	ret = -EINVAL;
+	switch (sqe->opcode) {
+	case IORING_OP_NOP:
+		ret = io_nop(req, sqe);
+		break;
+	case IORING_OP_READV:
+		ret = io_read(req, sqe, force_nonblock);
+		break;
+	case IORING_OP_WRITEV:
+		ret = io_write(req, sqe, force_nonblock);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static void io_sq_wq_submit_work(struct work_struct *work)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work.work);
+	struct io_ring_ctx *ctx = req->ctx;
+	mm_segment_t old_fs = get_fs();
+	struct files_struct *old_files;
+	int ret;
+
+	/*
+	 * Ensure we clear previously set flags. even it NOWAIT was originally
+	 * set, it's pointless now that we're in an async context.
+	 */
+	req->rw.ki_flags &= ~IOCB_NOWAIT;
+	req->flags &= ~REQ_F_FORCE_NONBLOCK;
+
+	old_files = current->files;
+	current->files = ctx->sqo_files;
+
+	if (!mmget_not_zero(ctx->sqo_mm)) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	use_mm(ctx->sqo_mm);
+	set_fs(USER_DS);
+
+	ret = __io_submit_sqe(ctx, req, &req->work.submit, false);
+
+	set_fs(old_fs);
+	unuse_mm(ctx->sqo_mm);
+	mmput(ctx->sqo_mm);
+err:
+	if (ret) {
+		io_fill_cq_error(ctx, &req->work.submit, ret);
+		io_free_req(req);
+	}
+	current->files = old_files;
+}
+
+static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
+{
+	struct io_kiocb *req;
+	ssize_t ret;
+
+	req = io_get_req(ctx);
+	if (unlikely(!req))
+		return -EAGAIN;
+
+	ret = __io_submit_sqe(ctx, req, s, true);
+	if (ret == -EAGAIN) {
+		memcpy(&req->work.submit, s, sizeof(*s));
+		INIT_WORK(&req->work.work, io_sq_wq_submit_work);
+		queue_work(ctx->sqo_wq, &req->work.work);
+		ret = 0;
+	}
+	if (ret)
+		io_free_req(req);
+
+	return ret;
+}
+
+static void io_inc_sqring(struct io_ring_ctx *ctx)
+{
+	struct io_sq_ring *ring = ctx->sq_ring;
+
+	ring->r.head++;
+	smp_wmb();
+}
+
+static bool io_peek_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
+{
+	struct io_sq_ring *ring = ctx->sq_ring;
+	unsigned head;
+
+	smp_rmb();
+	head = READ_ONCE(ring->r.head);
+	if (head == READ_ONCE(ring->r.tail))
+		return false;
+
+	head = ring->array[head & ctx->sq_mask];
+	if (head < ctx->sq_entries) {
+		s->index = head;
+		s->sqe = &ctx->sq_sqes[head];
+		return true;
+	}
+
+	/* drop invalid entries */
+	ring->r.head++;
+	ring->dropped++;
+	smp_wmb();
+	return false;
+}
+
+static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
+{
+	int i, ret = 0, submit = 0;
+	struct blk_plug plug;
+
+	if (to_submit > IO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
+
+	for (i = 0; i < to_submit; i++) {
+		struct sqe_submit s;
+
+		if (!io_peek_sqring(ctx, &s))
+			break;
+
+		ret = io_submit_sqe(ctx, &s);
+		if (ret)
+			break;
+
+		submit++;
+		io_inc_sqring(ctx);
+	}
+
+	if (to_submit > IO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
+
+	return submit ? submit : ret;
+}
+
+/*
+ * Wait until events become available, if we don't already have some. The
+ * application must reap them itself, as they reside on the shared cq ring.
+ */
+static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events)
+{
+	struct io_cq_ring *ring = ctx->cq_ring;
+	DEFINE_WAIT(wait);
+	int ret = 0;
+
+	smp_rmb();
+	if (ring->r.head != ring->r.tail)
+		return 0;
+	if (!min_events)
+		return 0;
+
+	do {
+		prepare_to_wait(&ctx->wait, &wait, TASK_INTERRUPTIBLE);
+
+		ret = 0;
+		smp_rmb();
+		if (ring->r.head != ring->r.tail)
+			break;
+
+		schedule();
+
+		ret = -EINTR;
+		if (signal_pending(current))
+			break;
+	} while (1);
+
+	finish_wait(&ctx->wait, &wait);
+	return ring->r.head == ring->r.tail ? ret : 0;
+}
+
+static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
+			    unsigned min_complete, unsigned flags)
+{
+	int ret = 0;
+
+	if (to_submit) {
+		ret = io_ring_submit(ctx, to_submit);
+		if (ret < 0)
+			return ret;
+	}
+	if (flags & IORING_ENTER_GETEVENTS) {
+		int get_ret;
+
+		if (!ret && to_submit)
+			min_complete = 0;
+
+		get_ret = io_cqring_wait(ctx, min_complete);
+		if (get_ret < 0 && !ret)
+			ret = get_ret;
+	}
+
+	return ret;
+}
+
+static int io_sq_offload_start(struct io_ring_ctx *ctx)
+{
+	int ret;
+
+	ctx->sqo_mm = current->mm;
+
+	/*
+	 * This is safe since 'current' has the fd installed, and if that
+	 * gets closed on exit, then fops->release() is invoked which
+	 * waits for the sq thread and sq workqueue to flush and exit
+	 * before exiting.
+	 */
+	ret = -EBADF;
+	ctx->sqo_files = current->files;
+	if (!ctx->sqo_files)
+		goto err;
+
+	/* Do QD, or 2 * CPUS, whatever is smallest */
+	ctx->sqo_wq = alloc_workqueue("io_ring-wq", WQ_UNBOUND | WQ_FREEZABLE,
+			min(ctx->sq_entries - 1, 2 * num_online_cpus()));
+	if (!ctx->sqo_wq) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	return 0;
+err:
+	if (ctx->sqo_files)
+		ctx->sqo_files = NULL;
+	ctx->sqo_mm = NULL;
+	return ret;
+}
+
+static void io_sq_offload_stop(struct io_ring_ctx *ctx)
+{
+	if (ctx->sqo_wq) {
+		destroy_workqueue(ctx->sqo_wq);
+		ctx->sqo_wq = NULL;
+	}
+}
+
+static void io_free_scq_urings(struct io_ring_ctx *ctx)
+{
+	if (ctx->sq_ring) {
+		page_frag_free(ctx->sq_ring);
+		ctx->sq_ring = NULL;
+	}
+	if (ctx->sq_sqes) {
+		page_frag_free(ctx->sq_sqes);
+		ctx->sq_sqes = NULL;
+	}
+	if (ctx->cq_ring) {
+		page_frag_free(ctx->cq_ring);
+		ctx->cq_ring = NULL;
+	}
+}
+
+static void io_ring_ctx_free(struct io_ring_ctx *ctx)
+{
+	io_sq_offload_stop(ctx);
+	io_free_scq_urings(ctx);
+	percpu_ref_exit(&ctx->refs);
+	kfree(ctx);
+}
+
+static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
+{
+	mutex_lock(&ctx->uring_lock);
+	percpu_ref_kill(&ctx->refs);
+	mutex_unlock(&ctx->uring_lock);
+
+	wait_for_completion(&ctx->ctx_done);
+	io_ring_ctx_free(ctx);
+}
+
+static int io_uring_release(struct inode *inode, struct file *file)
+{
+	struct io_ring_ctx *ctx = file->private_data;
+
+	file->private_data = NULL;
+	io_ring_ctx_wait_and_kill(ctx);
+	return 0;
+}
+
+static int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	loff_t offset = (loff_t) vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long sz = vma->vm_end - vma->vm_start;
+	struct io_ring_ctx *ctx = file->private_data;
+	unsigned long pfn;
+	struct page *page;
+	void *ptr;
+
+	switch (offset) {
+	case IORING_OFF_SQ_RING:
+		ptr = ctx->sq_ring;
+		break;
+	case IORING_OFF_SQES:
+		ptr = ctx->sq_sqes;
+		break;
+	case IORING_OFF_CQ_RING:
+		ptr = ctx->cq_ring;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	page = virt_to_head_page(ptr);
+	if (sz > (PAGE_SIZE << compound_order(page)))
+		return -EINVAL;
+
+	pfn = virt_to_phys(ptr) >> PAGE_SHIFT;
+	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
+}
+
+SYSCALL_DEFINE4(io_uring_enter, unsigned int, fd, u32, to_submit,
+		u32, min_complete, u32, flags)
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
+	ret = -EINVAL;
+	ctx = f.file->private_data;
+	if (!percpu_ref_tryget(&ctx->refs))
+		goto out_fput;
+
+	ret = -EBUSY;
+	if (mutex_trylock(&ctx->uring_lock)) {
+		ret = __io_uring_enter(ctx, to_submit, min_complete, flags);
+		mutex_unlock(&ctx->uring_lock);
+	}
+	io_ring_drop_ctx_refs(ctx, 1);
+out_fput:
+	fdput(f);
+	return ret;
+}
+
+static const struct file_operations io_uring_fops = {
+	.release	= io_uring_release,
+	.mmap		= io_uring_mmap,
+};
+
+static void *io_mem_alloc(size_t size)
+{
+	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP |
+				__GFP_NORETRY;
+
+	return (void *) __get_free_pages(gfp_flags, get_order(size));
+}
+
+static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
+				  struct io_uring_params *p)
+{
+	struct io_sq_ring *sq_ring;
+	struct io_cq_ring *cq_ring;
+	size_t size;
+	int ret;
+
+	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
+	if (!sq_ring)
+		return -ENOMEM;
+
+	ctx->sq_ring = sq_ring;
+	sq_ring->ring_mask = p->sq_entries - 1;
+	sq_ring->ring_entries = p->sq_entries;
+	ctx->sq_mask = sq_ring->ring_mask;
+	ctx->sq_entries = sq_ring->ring_entries;
+
+	ret = -EOVERFLOW;
+	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
+	if (size == SIZE_MAX)
+		goto err;
+	ret = -ENOMEM;
+	ctx->sq_sqes = io_mem_alloc(size);
+	if (!ctx->sq_sqes)
+		goto err;
+
+	cq_ring = io_mem_alloc(struct_size(cq_ring, cqes, p->cq_entries));
+	if (!cq_ring)
+		goto err;
+
+	ctx->cq_ring = cq_ring;
+	cq_ring->ring_mask = p->cq_entries - 1;
+	cq_ring->ring_entries = p->cq_entries;
+	ctx->cq_mask = cq_ring->ring_mask;
+	ctx->cq_entries = cq_ring->ring_entries;
+	return 0;
+err:
+	io_free_scq_urings(ctx);
+	return ret;
+}
+
+static void io_fill_offsets(struct io_uring_params *p)
+{
+	memset(&p->sq_off, 0, sizeof(p->sq_off));
+	p->sq_off.head = offsetof(struct io_sq_ring, r.head);
+	p->sq_off.tail = offsetof(struct io_sq_ring, r.tail);
+	p->sq_off.ring_mask = offsetof(struct io_sq_ring, ring_mask);
+	p->sq_off.ring_entries = offsetof(struct io_sq_ring, ring_entries);
+	p->sq_off.flags = offsetof(struct io_sq_ring, flags);
+	p->sq_off.dropped = offsetof(struct io_sq_ring, dropped);
+	p->sq_off.array = offsetof(struct io_sq_ring, array);
+
+	memset(&p->cq_off, 0, sizeof(p->cq_off));
+	p->cq_off.head = offsetof(struct io_cq_ring, r.head);
+	p->cq_off.tail = offsetof(struct io_cq_ring, r.tail);
+	p->cq_off.ring_mask = offsetof(struct io_cq_ring, ring_mask);
+	p->cq_off.ring_entries = offsetof(struct io_cq_ring, ring_entries);
+	p->cq_off.overflow = offsetof(struct io_cq_ring, overflow);
+	p->cq_off.cqes = offsetof(struct io_cq_ring, cqes);
+}
+
+static int io_uring_create(unsigned entries, struct io_uring_params *p,
+			   bool compat)
+{
+	struct io_ring_ctx *ctx;
+	int ret;
+
+	/*
+	 * Use twice as many entries for the CQ ring. It's possible for the
+	 * application to drive a higher depth than the size of the SQ ring,
+	 * since the sqes are only used at submission time. This allows for
+	 * some flexibility in overcommitting a bit.
+	 */
+	p->sq_entries = roundup_pow_of_two(entries);
+	p->cq_entries = 2 * p->sq_entries;
+
+	ctx = io_ring_ctx_alloc(p);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->compat = compat;
+
+	ret = io_allocate_scq_urings(ctx, p);
+	if (ret)
+		goto err;
+
+	ret = io_sq_offload_start(ctx);
+	if (ret)
+		goto err;
+
+	ret = anon_inode_getfd("[io_uring]", &io_uring_fops, ctx,
+				O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto err;
+
+	io_fill_offsets(p);
+	return ret;
+err:
+	io_ring_ctx_wait_and_kill(ctx);
+	return ret;
+}
+
+/*
+ * Sets up an aio uring context, and returns the fd. Applications asks for a
+ * ring size, we return the actual sq/cq ring sizes (among other things) in the
+ * params structure passed in.
+ */
+static long io_uring_setup(u32 entries, struct io_uring_params __user *params,
+			   bool compat)
+{
+	struct io_uring_params p;
+	long ret;
+	int i;
+
+	if (copy_from_user(&p, params, sizeof(p)))
+		return -EFAULT;
+	for (i = 0; i < ARRAY_SIZE(p.resv); i++) {
+		if (p.resv[i])
+			return -EINVAL;
+	}
+
+	if (p.flags)
+		return -EINVAL;
+
+	ret = io_uring_create(entries, &p, compat);
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user(params, &p, sizeof(p)))
+		return -EFAULT;
+
+	return ret;
+}
+
+SYSCALL_DEFINE2(io_uring_setup, u32, entries,
+		struct io_uring_params __user *, params)
+{
+	return io_uring_setup(entries, params, false);
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
+		       struct io_uring_params __user *, params)
+{
+	return io_uring_setup(entries, params, true);
+}
+#endif
+
+static int __init io_uring_init(void)
+{
+	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	return 0;
+};
+__initcall(io_uring_init);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..542757a4c898 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -69,6 +69,7 @@ struct file_handle;
 struct sigaltstack;
 struct rseq;
 union bpf_attr;
+struct io_uring_params;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -309,6 +310,10 @@ asmlinkage long sys_io_pgetevents_time32(aio_context_t ctx_id,
 				struct io_event __user *events,
 				struct old_timespec32 __user *timeout,
 				const struct __aio_sigset *sig);
+asmlinkage long sys_io_uring_setup(u32 entries,
+				struct io_uring_params __user *p);
+asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
+				u32 min_complete, u32 flags);
 
 /* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
new file mode 100644
index 000000000000..a1ebaa09e1b8
--- /dev/null
+++ b/include/uapi/linux/io_uring.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Header file for the io_uring interface.
+ *
+ * Copyright (C) 2019 Jens Axboe
+ * Copyright (C) 2019 Christoph Hellwig
+ */
+#ifndef LINUX_IO_URING_H
+#define LINUX_IO_URING_H
+
+#include <linux/fs.h>
+#include <linux/types.h>
+
+/*
+ * IO submission data structure (Submission Queue Entry)
+ */
+struct io_uring_sqe {
+	__u8	opcode;		/* type of operation for this sqe */
+	__u8	flags;		/* as of now unused */
+	__u16	ioprio;		/* ioprio for the request */
+	__s32	fd;		/* file descriptor to do IO on */
+	__u64	off;		/* offset into file */
+	union {
+		void	*addr;	/* buffer or iovecs */
+		__u64	__pad;
+	};
+	__u32	len;		/* buffer size or number of iovecs */
+	union {
+		__kernel_rwf_t	rw_flags;
+		__u32		__resv;
+	};
+	__u64	user_data;	/* data to be passed back at completion time */
+	__u64	__pad2[3];
+};
+
+#define IORING_OP_NOP		0
+#define IORING_OP_READV		1
+#define IORING_OP_WRITEV	2
+
+/*
+ * IO completion data structure (Completion Queue Entry)
+ */
+struct io_uring_cqe {
+	__u64	user_data;	/* sqe->data submission passed back */
+	__s32	res;		/* result code for this event */
+	__u32	flags;
+};
+
+/*
+ * Magic offsets for the application to mmap the data it needs
+ */
+#define IORING_OFF_SQ_RING		0ULL
+#define IORING_OFF_CQ_RING		0x8000000ULL
+#define IORING_OFF_SQES			0x10000000ULL
+
+/*
+ * Filled with the offset for mmap(2)
+ */
+struct io_sqring_offsets {
+	__u32 head;
+	__u32 tail;
+	__u32 ring_mask;
+	__u32 ring_entries;
+	__u32 flags;
+	__u32 dropped;
+	__u32 array;
+	__u32 resv[3];
+};
+
+struct io_cqring_offsets {
+	__u32 head;
+	__u32 tail;
+	__u32 ring_mask;
+	__u32 ring_entries;
+	__u32 overflow;
+	__u32 cqes;
+	__u32 resv[4];
+};
+
+/*
+ * io_uring_enter(2) flags
+ */
+#define IORING_ENTER_GETEVENTS	(1 << 0)
+
+/*
+ * Passed in for io_uring_setup(2). Copied back with updated info on success
+ */
+struct io_uring_params {
+	__u32 sq_entries;
+	__u32 cq_entries;
+	__u32 flags;
+	__u16 resv[10];
+	struct io_sqring_offsets sq_off;
+	struct io_cqring_offsets cq_off;
+};
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index d47cb77a220e..ce7bd7af9312 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1402,6 +1402,15 @@ config AIO
 	  by some high performance threaded applications. Disabling
 	  this option saves about 7k.
 
+config IO_URING
+	bool "Enable IO uring support" if EXPERT
+	select ANON_INODES
+	default y
+	help
+	  This option enables support for the io_uring interface, enabling
+	  applications to submit and completion IO through submission and
+	  completion rings that are shared between the kernel and application.
+
 config ADVISE_SYSCALLS
 	bool "Enable madvise/fadvise syscalls" if EXPERT
 	default y
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index ab9d0e3c6d50..ee5e523564bb 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -46,6 +46,8 @@ COND_SYSCALL(io_getevents);
 COND_SYSCALL(io_pgetevents);
 COND_SYSCALL_COMPAT(io_getevents);
 COND_SYSCALL_COMPAT(io_pgetevents);
+COND_SYSCALL(io_uring_setup);
+COND_SYSCALL(io_uring_enter);
 
 /* fs/xattr.c */
 
-- 
2.17.1

