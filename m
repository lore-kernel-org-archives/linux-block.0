Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF6C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506582173C
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FCrGdQyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfAHQ5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:04 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44999 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfAHQ5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:03 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so3649453iod.11
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7R2IfTG4avxh76saoXVhrgN1LaherVS7cakqxI17bRw=;
        b=FCrGdQyBib03o0MiK+9n44bzt/lfTixP+eT+mNDjTmTG2N1pfJeulo5N9oObc41jO4
         85WhG1mWH2TlDLwOwP0Uo/qkMEEceL5Bv9ZbSy7ARBzpD01Kvl566xZVpkew+KFbP2eA
         gCuWPPN2TudN2K4F4A+KSAJnigvvAKt1NisaBOXi82K+Wi3JNPefyhSYP1WWc9JOiBNN
         AMCZrqb6UapncEUfarHmhlEFIWcK+RfTDmkQN2+JIzc97uGcHBiuEnM0OPSFvRIyWjjK
         u/LDkQcqcPudMEcLgzUHSQjcLUXCe51dH50gT446zIii5EvnxKe4Gsx6lvegR9BcH8lJ
         lkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7R2IfTG4avxh76saoXVhrgN1LaherVS7cakqxI17bRw=;
        b=m/476odl1uYCqn+4bcBDFzfE678v/6k6YcLnE7hiSj6TcgK085wvznmFUHYZY4aTWu
         srJCS9rOBZQUDvyQIdWCMmd4GXI3iiEloD1pPcXiSxbS1bvgcclKjvqwHPiDmwxs7leq
         viROQmtxnqOJ7Ryj82hvJDmwgrXAfwqE0CCQZC+UWG6HWln4gk8/yQWrXWsLoErG2cOq
         jOvn0kU73w9fq1M/H3ZTCKUUy0aVKBwsex0YNcazZJSKnQmfwNHSfwk8ftoWzW9Da5No
         PJRTwgnXQcXxo2B9/T40t9x9iwtVNK3GKuB88Khr2CETXBdZ1DHV/NIz/gtGtZQ/YvNU
         pt8g==
X-Gm-Message-State: AJcUukcT51Cji1mnmKLMOCrFv/yaTd4XHNhPGoL0QYf3XvLBR0VUWL0a
        YY85tgPvk7O1iPr947r2rIdncnC1FVWVIw==
X-Google-Smtp-Source: ALg8bN773XkVw9au/mz1NbapXKjnoPkMJbTmt2YgpF9KFxqGZ64mneTCkxlQ95XcP8LQ09cqkCrudQ==
X-Received: by 2002:a5d:8491:: with SMTP id t17mr1561013iom.11.1546966621991;
        Tue, 08 Jan 2019 08:57:01 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/16] Add io_uring IO interface
Date:   Tue,  8 Jan 2019 09:56:34 -0700
Message-Id: <20190108165645.19311-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The submission queue (SQ) and completion queue (CQ) rings are shared
between the application and the kernel. This eliminates the need to
copy data back and forth to submit and complete IO.

IO submissions use the io_uring_iocb data structure, and completions
are generated in the form of io_uring_event data structures. The SQ
ring is an index into the iocb_io_uring array, which makes it possible
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

Sample application: http://git.kernel.dk/cgit/fio/plain/t/io_uring.c

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/Makefile                            |   2 +-
 fs/io_uring.c                          | 849 +++++++++++++++++++++++++
 include/linux/syscalls.h               |   5 +
 include/uapi/linux/io_uring.h          | 101 +++
 kernel/sys_ni.c                        |   2 +
 6 files changed, 960 insertions(+), 1 deletion(-)
 create mode 100644 fs/io_uring.c
 create mode 100644 include/uapi/linux/io_uring.h

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
index 293733f61594..9ef9987b4192 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_SIGNALFD)		+= signalfd.o
 obj-$(CONFIG_TIMERFD)		+= timerfd.o
 obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
-obj-$(CONFIG_AIO)               += aio.o
+obj-$(CONFIG_AIO)               += aio.o io_uring.o
 obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
diff --git a/fs/io_uring.c b/fs/io_uring.c
new file mode 100644
index 000000000000..ae2b886282bb
--- /dev/null
+++ b/fs/io_uring.c
@@ -0,0 +1,849 @@
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
+#include <linux/refcount.h>
+#include <linux/uio.h>
+
+#include <linux/sched/signal.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/mmu_context.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/blkdev.h>
+#include <linux/anon_inodes.h>
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
+	u32			array[0];
+};
+
+struct io_cq_ring {
+	struct io_uring		r;
+	u32			ring_mask;
+	u32			ring_entries;
+	u32			overflow;
+	struct io_uring_event	events[0];
+};
+
+struct io_iocb_ring {
+	struct			io_sq_ring *ring;
+	unsigned		entries;
+	unsigned		ring_mask;
+	struct io_uring_iocb	*iocbs;
+};
+
+struct io_event_ring {
+	struct io_cq_ring	*ring;
+	unsigned		entries;
+	unsigned		ring_mask;
+};
+
+struct io_ring_ctx {
+	struct percpu_ref	refs;
+
+	unsigned int		flags;
+	unsigned int		max_reqs;
+
+	struct io_iocb_ring	sq_ring;
+	struct io_event_ring	cq_ring;
+
+	struct work_struct	work;
+
+	struct {
+		struct mutex uring_lock;
+	} ____cacheline_aligned_in_smp;
+
+	struct {
+		struct mutex    ring_lock;
+		wait_queue_head_t wait;
+	} ____cacheline_aligned_in_smp;
+
+	struct {
+		spinlock_t      completion_lock;
+	} ____cacheline_aligned_in_smp;
+};
+
+struct fsync_iocb {
+	struct work_struct	work;
+	struct file		*file;
+	bool			datasync;
+};
+
+struct io_kiocb {
+	union {
+		struct kiocb		rw;
+		struct fsync_iocb	fsync;
+	};
+
+	struct io_ring_ctx	*ki_ctx;
+	unsigned long		ki_index;
+	struct list_head	ki_list;
+	unsigned long		ki_flags;
+};
+
+#define IO_PLUG_THRESHOLD		2
+
+static struct kmem_cache *kiocb_cachep, *ioctx_cachep;
+
+static const struct file_operations io_scqring_fops;
+
+static void io_ring_ctx_free(struct work_struct *work);
+static void io_ring_ctx_ref_free(struct percpu_ref *ref);
+
+static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
+{
+	struct io_ring_ctx *ctx;
+
+	ctx = kmem_cache_zalloc(ioctx_cachep, GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free, 0, GFP_KERNEL)) {
+		kmem_cache_free(ioctx_cachep, ctx);
+		return NULL;
+	}
+
+	ctx->flags = p->flags;
+	ctx->max_reqs = p->sq_entries;
+
+	INIT_WORK(&ctx->work, io_ring_ctx_free);
+
+	spin_lock_init(&ctx->completion_lock);
+	mutex_init(&ctx->ring_lock);
+	init_waitqueue_head(&ctx->wait);
+	mutex_init(&ctx->uring_lock);
+
+	return ctx;
+}
+
+static void io_inc_cqring(struct io_ring_ctx *ctx)
+{
+	struct io_cq_ring *ring = ctx->cq_ring.ring;
+
+	ring->r.tail++;
+	smp_wmb();
+}
+
+static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
+{
+	struct io_cq_ring *ring = ctx->cq_ring.ring;
+	unsigned tail;
+
+	smp_rmb();
+	tail = READ_ONCE(ring->r.tail);
+	if (tail + 1 == READ_ONCE(ring->r.head))
+		return NULL;
+
+	return &ring->events[tail & ctx->cq_ring.ring_mask];
+}
+
+static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	percpu_ref_get(&ctx->refs);
+	req->ki_ctx = ctx;
+	INIT_LIST_HEAD(&req->ki_list);
+	req->ki_flags = 0;
+	return req;
+}
+
+static inline void iocb_put(struct io_kiocb *iocb)
+{
+	percpu_ref_put(&iocb->ki_ctx->refs);
+	kmem_cache_free(kiocb_cachep, iocb);
+}
+
+static void io_complete_iocb(struct io_ring_ctx *ctx, struct io_kiocb *iocb)
+{
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+	iocb_put(iocb);
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
+static void io_fill_event(struct io_uring_event *ev, struct io_kiocb *kiocb,
+			  long res, unsigned flags)
+{
+	ev->index = kiocb->ki_index;
+	ev->res = res;
+	ev->flags = flags;
+}
+
+static void io_cqring_fill_event(struct io_kiocb *iocb, long res,
+				 unsigned ev_flags)
+{
+	struct io_ring_ctx *ctx = iocb->ki_ctx;
+	struct io_uring_event *ev;
+	unsigned long flags;
+
+	/*
+	 * If we can't get a cq entry, userspace overflowed the
+	 * submission (by quite a lot). Increment the overflow count in
+	 * the ring.
+	 */
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+	ev = io_peek_cqring(ctx);
+	if (ev) {
+		io_fill_event(ev, iocb, res, ev_flags);
+		io_inc_cqring(ctx);
+	} else
+		ctx->cq_ring.ring->overflow++;
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+}
+
+static void io_complete_scqring(struct io_kiocb *iocb, long res, unsigned flags)
+{
+	io_cqring_fill_event(iocb, res, flags);
+	io_complete_iocb(iocb->ki_ctx, iocb);
+}
+
+static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
+{
+	struct io_kiocb *iocb = container_of(kiocb, struct io_kiocb, rw);
+
+	kiocb_end_write(kiocb);
+
+	fput(kiocb->ki_filp);
+	io_complete_scqring(iocb, res, 0);
+}
+
+static int io_prep_rw(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
+{
+	struct kiocb *req = &kiocb->rw;
+	int ret;
+
+	req->ki_filp = fget(iocb->fd);
+	if (unlikely(!req->ki_filp))
+		return -EBADF;
+	req->ki_pos = iocb->off;
+	req->ki_flags = iocb_flags(req->ki_filp);
+	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
+	if (iocb->ioprio) {
+		ret = ioprio_check_cap(iocb->ioprio);
+		if (ret)
+			goto out_fput;
+
+		req->ki_ioprio = iocb->ioprio;
+	} else
+		req->ki_ioprio = get_current_ioprio();
+
+	ret = kiocb_set_rw_flags(req, iocb->rw_flags);
+	if (unlikely(ret))
+		goto out_fput;
+
+	/* no one is going to poll for this I/O */
+	req->ki_flags &= ~IOCB_HIPRI;
+	req->ki_complete = io_complete_scqring_rw;
+	return 0;
+out_fput:
+	fput(req->ki_filp);
+	return ret;
+}
+
+static int io_setup_rw(int rw, const struct io_uring_iocb *iocb,
+		       struct iovec **iovec, struct iov_iter *iter)
+{
+	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
+	size_t ret;
+
+	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
+	*iovec = NULL;
+	return ret;
+}
+
+static inline void io_rw_done(struct kiocb *req, ssize_t ret)
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
+		req->ki_complete(req, ret, 0);
+	}
+}
+
+static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
+{
+	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct kiocb *req = &kiocb->rw;
+	struct iov_iter iter;
+	struct file *file;
+	ssize_t ret;
+
+	ret = io_prep_rw(kiocb, iocb);
+	if (ret)
+		return ret;
+	file = req->ki_filp;
+
+	ret = -EBADF;
+	if (unlikely(!(file->f_mode & FMODE_READ)))
+		goto out_fput;
+	ret = -EINVAL;
+	if (unlikely(!file->f_op->read_iter))
+		goto out_fput;
+
+	ret = io_setup_rw(READ, iocb, &iovec, &iter);
+	if (ret)
+		goto out_fput;
+
+	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
+	if (!ret)
+		io_rw_done(req, call_read_iter(file, req, &iter));
+	kfree(iovec);
+out_fput:
+	if (unlikely(ret))
+		fput(file);
+	return ret;
+}
+
+static ssize_t io_write(struct io_kiocb *kiocb,
+			const struct io_uring_iocb *iocb)
+{
+	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct kiocb *req = &kiocb->rw;
+	struct iov_iter iter;
+	struct file *file;
+	ssize_t ret;
+
+	ret = io_prep_rw(kiocb, iocb);
+	if (ret)
+		return ret;
+	file = req->ki_filp;
+
+	ret = -EBADF;
+	if (unlikely(!(file->f_mode & FMODE_WRITE)))
+		goto out_fput;
+	ret = -EINVAL;
+	if (unlikely(!file->f_op->write_iter))
+		goto out_fput;
+
+	ret = io_setup_rw(WRITE, iocb, &iovec, &iter);
+	if (ret)
+		goto out_fput;
+	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
+	if (!ret) {
+		/*
+		 * Open-code file_start_write here to grab freeze protection,
+		 * which will be released by another thread in
+		 * io_complete_rw().  Fool lockdep by telling it the lock got
+		 * released so that it doesn't complain about the held lock when
+		 * we return to userspace.
+		 */
+		if (S_ISREG(file_inode(file)->i_mode)) {
+			__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
+			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+		}
+		req->ki_flags |= IOCB_WRITE;
+		io_rw_done(req, call_write_iter(file, req, &iter));
+	}
+	kfree(iovec);
+out_fput:
+	if (unlikely(ret))
+		fput(file);
+	return ret;
+}
+
+static void io_fsync_work(struct work_struct *work)
+{
+	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
+	struct io_kiocb *iocb = container_of(req, struct io_kiocb, fsync);
+	int ret;
+
+	ret = vfs_fsync(req->file, req->datasync);
+	fput(req->file);
+
+	io_complete_scqring(iocb, ret, 0);
+}
+
+static int io_fsync(struct fsync_iocb *req, const struct io_uring_iocb *iocb,
+		    bool datasync)
+{
+	if (unlikely(iocb->addr || iocb->off || iocb->len || iocb->__resv))
+		return -EINVAL;
+
+	req->file = fget(iocb->fd);
+	if (unlikely(!req->file))
+		return -EBADF;
+	if (unlikely(!req->file->f_op->fsync)) {
+		fput(req->file);
+		return -EINVAL;
+	}
+
+	req->datasync = datasync;
+	INIT_WORK(&req->work, io_fsync_work);
+	schedule_work(&req->work);
+	return 0;
+}
+
+static int __io_submit_one(struct io_ring_ctx *ctx,
+			   const struct io_uring_iocb *iocb,
+			   unsigned long ki_index)
+{
+	struct io_kiocb *req;
+	ssize_t ret;
+
+	/* enforce forwards compatibility on users */
+	if (unlikely(iocb->flags))
+		return -EINVAL;
+
+	req = io_get_req(ctx);
+	if (unlikely(!req))
+		return -EAGAIN;
+
+	ret = -EINVAL;
+	if (ki_index >= ctx->max_reqs)
+		goto out_put_req;
+	req->ki_index = ki_index;
+
+	ret = -EINVAL;
+	switch (iocb->opcode) {
+	case IORING_OP_READ:
+		ret = io_read(req, iocb);
+		break;
+	case IORING_OP_WRITE:
+		ret = io_write(req, iocb);
+		break;
+	case IORING_OP_FSYNC:
+		ret = io_fsync(&req->fsync, iocb, false);
+		break;
+	case IORING_OP_FDSYNC:
+		ret = io_fsync(&req->fsync, iocb, true);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	/*
+	 * If ret is 0, ->ki_complete() has either been called, or will get
+	 * called later on. Anything else, we need to free the req.
+	 */
+	if (ret)
+		goto out_put_req;
+	return 0;
+out_put_req:
+	iocb_put(req);
+	return ret;
+}
+
+static void io_inc_sqring(struct io_ring_ctx *ctx)
+{
+	struct io_sq_ring *ring = ctx->sq_ring.ring;
+
+	ring->r.head++;
+	smp_wmb();
+}
+
+static const struct io_uring_iocb *io_peek_sqring(struct io_ring_ctx *ctx,
+						  unsigned *iocb_index)
+{
+	struct io_sq_ring *ring = ctx->sq_ring.ring;
+	unsigned head;
+
+	smp_rmb();
+	head = READ_ONCE(ring->r.head);
+	if (head == READ_ONCE(ring->r.tail))
+		return NULL;
+
+	head = ring->array[head & ctx->sq_ring.ring_mask];
+	if (head < ctx->sq_ring.entries) {
+		*iocb_index = head;
+		return &ctx->sq_ring.iocbs[head];
+	}
+
+	/* drop invalid entries */
+	ring->r.head++;
+	ring->dropped++;
+	smp_wmb();
+	return NULL;
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
+		const struct io_uring_iocb *iocb;
+		unsigned iocb_index;
+
+		iocb = io_peek_sqring(ctx, &iocb_index);
+		if (!iocb)
+			break;
+
+		ret = __io_submit_one(ctx, iocb, iocb_index);
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
+	struct io_cq_ring *ring = ctx->cq_ring.ring;
+	DEFINE_WAIT(wait);
+	int ret;
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
+static void io_free_scq_urings(struct io_ring_ctx *ctx)
+{
+	if (ctx->sq_ring.ring) {
+		page_frag_free(ctx->sq_ring.ring);
+		ctx->sq_ring.ring = NULL;
+	}
+	if (ctx->sq_ring.iocbs) {
+		page_frag_free(ctx->sq_ring.iocbs);
+		ctx->sq_ring.iocbs = NULL;
+	}
+	if (ctx->cq_ring.ring) {
+		page_frag_free(ctx->cq_ring.ring);
+		ctx->cq_ring.ring = NULL;
+	}
+}
+
+static void io_ring_ctx_free(struct work_struct *work)
+{
+	struct io_ring_ctx *ctx = container_of(work, struct io_ring_ctx, work);
+
+	io_free_scq_urings(ctx);
+	percpu_ref_exit(&ctx->refs);
+	kmem_cache_free(ioctx_cachep, ctx);
+}
+
+static void io_ring_ctx_ref_free(struct percpu_ref *ref)
+{
+	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
+
+	schedule_work(&ctx->work);
+}
+
+static int io_scqring_release(struct inode *inode, struct file *file)
+{
+	struct io_ring_ctx *ctx = file->private_data;
+
+	file->private_data = NULL;
+	percpu_ref_kill(&ctx->refs);
+	return 0;
+}
+
+static int io_scqring_mmap(struct file *file, struct vm_area_struct *vma)
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
+		ptr = ctx->sq_ring.ring;
+		break;
+	case IORING_OFF_IOCB:
+		ptr = ctx->sq_ring.iocbs;
+		break;
+	case IORING_OFF_CQ_RING:
+		ptr = ctx->cq_ring.ring;
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
+	long ret = -EBADF;
+	struct fd f;
+
+	f = fdget(fd);
+	if (f.file) {
+		struct io_ring_ctx *ctx;
+
+		ret = -EOPNOTSUPP;
+		if (f.file->f_op != &io_scqring_fops)
+			goto err;
+
+		ctx = f.file->private_data;
+		ret = -EBUSY;
+		if (!mutex_trylock(&ctx->uring_lock))
+			goto err;
+
+		ret = __io_uring_enter(ctx, to_submit, min_complete, flags);
+		mutex_unlock(&ctx->uring_lock);
+err:
+		fdput(f);
+	}
+
+	return ret;
+}
+
+static const struct file_operations io_scqring_fops = {
+	.release	= io_scqring_release,
+	.mmap		= io_scqring_mmap,
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
+
+	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));
+	if (!sq_ring)
+		return -ENOMEM;
+
+	ctx->sq_ring.ring = sq_ring;
+	sq_ring->ring_mask = p->sq_entries - 1;
+	sq_ring->ring_entries = p->sq_entries;
+	ctx->sq_ring.ring_mask = sq_ring->ring_mask;
+	ctx->sq_ring.entries = sq_ring->ring_entries;
+
+	ctx->sq_ring.iocbs = io_mem_alloc(sizeof(struct io_uring_iocb) *
+						p->sq_entries);
+	if (!ctx->sq_ring.iocbs)
+		goto err;
+
+	cq_ring = io_mem_alloc(struct_size(cq_ring, events, p->cq_entries));
+	if (!cq_ring)
+		goto err;
+
+	ctx->cq_ring.ring = cq_ring;
+	cq_ring->ring_mask = p->cq_entries - 1;
+	cq_ring->ring_entries = p->cq_entries;
+	ctx->cq_ring.ring_mask = cq_ring->ring_mask;
+	ctx->cq_ring.entries = cq_ring->ring_entries;
+	return 0;
+err:
+	io_free_scq_urings(ctx);
+	return -ENOMEM;
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
+	p->cq_off.events = offsetof(struct io_cq_ring, events);
+}
+
+static int io_uring_create(unsigned entries, struct io_uring_params *p)
+{
+	struct io_ring_ctx *ctx;
+	int ret;
+
+	/*
+	 * Use twice as many entries for the CQ ring. It's possible for the
+	 * application to drive a higher depth than the size of the SQ ring,
+	 * since the iocbs are only used at submission time. This allows for
+	 * some flexibility in overcommitting a bit.
+	 */
+	p->sq_entries = roundup_pow_of_two(entries);
+	p->cq_entries = 2 * p->sq_entries;
+
+	ctx = io_ring_ctx_alloc(p);
+	if (!ctx)
+		return -ENOMEM;
+
+	ret = io_allocate_scq_urings(ctx, p);
+	if (ret)
+		goto err;
+
+	ret = anon_inode_getfd("[io_uring]", &io_scqring_fops, ctx,
+				O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto err;
+
+	io_fill_offsets(p);
+	return ret;
+err:
+	percpu_ref_kill(&ctx->refs);
+	return ret;
+}
+
+/*
+ * sys_io_uring_setup:
+ *	Sets up an aio uring context, and returns the fd. Applications asks
+ *	for a ring size, we return the actual sq/cq ring sizes (among other
+ *	things) in the params structure passed in.
+ */
+SYSCALL_DEFINE3(io_uring_setup, u32, entries, struct iovec __user *, iovecs,
+		struct io_uring_params __user *, params)
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
+	if (iovecs)
+		return -EINVAL;
+
+	ret = io_uring_create(entries, &p);
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user(params, &p, sizeof(p)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static int __init io_uring_setup(void)
+{
+	kiocb_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	ioctx_cachep = KMEM_CACHE(io_ring_ctx, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	return 0;
+};
+__initcall(io_uring_setup);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..6d40939f65cd 100644
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
+asmlinkage long sys_io_uring_setup(u32 entries, struct iovec __user *iov,
+				struct io_uring_params __user *p);
+asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
+				u32 min_complete, u32 flags);
 
 /* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
new file mode 100644
index 000000000000..c31ac84d9f53
--- /dev/null
+++ b/include/uapi/linux/io_uring.h
@@ -0,0 +1,101 @@
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
+ * IO submission data structure
+ */
+struct io_uring_iocb {
+	__u8	opcode;
+	__u8	flags;
+	__u16	ioprio;
+	__s32	fd;
+	__u64	off;
+	union {
+		void	*addr;
+		__u64	__pad;
+	};
+	__u32	len;
+	union {
+		__kernel_rwf_t	rw_flags;
+		__u32		__resv;
+	};
+};
+
+#define IORING_OP_READ		1
+#define IORING_OP_WRITE		2
+#define IORING_OP_FSYNC		3
+#define IORING_OP_FDSYNC	4
+
+/*
+ * IO completion data structure
+ */
+struct io_uring_event {
+	__u64	index;		/* what iocb this event came from */
+	__s32	res;		/* result code for this event */
+	__u32	flags;
+};
+
+/*
+ * io_uring_event->flags
+ */
+#define IOEV_FLAG_CACHEHIT	(1 << 0)	/* IO did not hit media */
+
+/*
+ * Magic offsets for the application to mmap the data it needs
+ */
+#define IORING_OFF_SQ_RING		0ULL
+#define IORING_OFF_CQ_RING		0x8000000ULL
+#define IORING_OFF_IOCB			0x10000000ULL
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
+	__u32 events;
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

