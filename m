Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A9CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D78421D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="07BB6myJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407485AbfJYRXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:23:01 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40348 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389658AbfJYRXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 13:23:00 -0400
Received: by mail-il1-f194.google.com with SMTP id d83so2498978ilk.7
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZC7Od+wfNzjVKhdWjAyclTSxzHeAfs2JhL+5Rl3k6Kc=;
        b=07BB6myJG6u1DtCSVhZQBwePl16QlohvNWNxJeGJtHXD8F/Bhg7etXnPLGo3y2FCcG
         xnwASYapDwC4mCckknuaM/QBfYkzse1FMXNa3CtjBM7cNjPympz2HiZ0AwV5KemDTGcv
         9JFVM1HrIv9GW9698NFGkE+4vTNQEjEpHUdUy0RfISuMSOFcU0ur84nxJM7TnJ4X40a/
         wfK8tN4c6F2N+RbaWMhq6ApfiGD3WGl/9r9LZC4Z7Cx8PG4wncexl5rBHlNc2EmEyGyJ
         GCx4xJ6Yv8UxFDtO8yXMLphPB3g3K8Wx3zyuAf4R2BWoeM7qGvBKjgtzFDUrFxZo9Nb9
         INMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZC7Od+wfNzjVKhdWjAyclTSxzHeAfs2JhL+5Rl3k6Kc=;
        b=Xt/23XHsQdfmW+K9kDLfiI75xKnlHg/xcnkNWuElDr0HYT/sZbA8v3SHU9zdNAs1wA
         Bb8jM0BqIMQuEGBrHuiOono6bi0/ULAsAxiqeZ3YDQHTSUo7VU4QJyxcXAGAaUJyv+3S
         +F+jV8XeNLmX243HhWPoiKjXLeluDvh8LVZGfSXQoSdVMBLgRmm095o2zICzY+ayTWDD
         DvQKEXx6GA7WxPC1DdV/rp02sH76VxtW9DJuUvRm4vGRGgV4KZ4ytHWBCPD5zf0iBU/V
         HZv3u/iYEa7kzr88k0vlXqBwsiyi21BvA2FVWsBNJUDEcKeDXl1g6F1MFkFCEQzKPURY
         7mMg==
X-Gm-Message-State: APjAAAXXZnBO6n5+94S1LUkAiVMN7/yFWod8aeo41l/zX6SUH076OR9p
        7GmQFYViqoRC+GuYR0Y1uIomNss4HfzouA==
X-Google-Smtp-Source: APXvYqyyNUMoX2LFjGcIJX+fBLxl4ATc9Pb+XD34cHbSZWJzsEnwKS1hWEcsgCG0mkPJo86BVkppFA==
X-Received: by 2002:a92:c509:: with SMTP id r9mr5781952ilg.79.1572024176795;
        Fri, 25 Oct 2019 10:22:56 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm324082iok.87.2019.10.25.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:22:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io-wq: small threadpool implementation for io_uring
Date:   Fri, 25 Oct 2019 11:22:50 -0600
Message-Id: <20191025172251.12830-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025172251.12830-1-axboe@kernel.dk>
References: <20191025172251.12830-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds support for io-wq, a smaller and specialized thread pool
implementation. This is meant to replace workqueues for io_uring. Among
the reasons for this addition are:

- We can assign memory context smarter and more persistently if we
  manage the life time of threads.

- We can drop various work-arounds we have in io_uring, like the
  async_list.

- We can implement hashed work insertion, to manage concurrency of
  buffered writes without needing a) an extra workqueue, or b)
  needlessly making the concurrency of said workqueue very low
  which hurts performance of multiple buffered file writers.

- We can implement cancel through signals, for cancelling
  interruptible work like read/write (or send/recv) to/from sockets.

- We need the above cancel for being able to assign and use file tables
  from a process.

- We can implement a more thorough cancel operation in general.

- We need it to move towards a syslet/threadlet model for even faster
  async execution. For that we need to take ownership of the used
  threads.

This list is just off the top of my head. Performance should be the
same, or better, at least that's what I've seen in my testing. io-wq
supports basic NUMA functionality, setting up a pool per node.

io-wq hooks up to the scheduler schedule in/out just like workqueue
and uses that to drive the need for more/less workers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/Kconfig            |   3 +
 fs/Makefile           |   1 +
 fs/io-wq.c            | 805 ++++++++++++++++++++++++++++++++++++++++++
 fs/io-wq.h            |  55 +++
 include/linux/sched.h |   1 +
 kernel/sched/core.c   |  16 +-
 6 files changed, 877 insertions(+), 4 deletions(-)
 create mode 100644 fs/io-wq.c
 create mode 100644 fs/io-wq.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 2501e6f1f965..7b623e9fc1b0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -322,4 +322,7 @@ source "fs/nls/Kconfig"
 source "fs/dlm/Kconfig"
 source "fs/unicode/Kconfig"
 
+config IO_WQ
+	bool
+
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 14231b4cf383..1148c555c4d3 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
 obj-$(CONFIG_AIO)               += aio.o
 obj-$(CONFIG_IO_URING)		+= io_uring.o
+obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
diff --git a/fs/io-wq.c b/fs/io-wq.c
new file mode 100644
index 000000000000..99ac5e338d99
--- /dev/null
+++ b/fs/io-wq.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic worker thread pool for io_uring
+ *
+ * Copyright (C) 2019 Jens Axboe
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched/signal.h>
+#include <linux/mm.h>
+#include <linux/mmu_context.h>
+#include <linux/sched/mm.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/kthread.h>
+#include <linux/rculist_nulls.h>
+
+#include "io-wq.h"
+
+#define WORKER_IDLE_TIMEOUT	(5 * HZ)
+
+enum {
+	IO_WORKER_F_UP		= 1,	/* up and active */
+	IO_WORKER_F_RUNNING	= 2,	/* account as running */
+	IO_WORKER_F_FREE	= 4,	/* worker on free list */
+	IO_WORKER_F_EXITING	= 8,	/* worker exiting */
+	IO_WORKER_F_FIXED	= 16,	/* static idle worker */
+};
+
+enum {
+	IO_WQ_BIT_EXIT		= 0,	/* wq exiting */
+	IO_WQ_BIT_CANCEL	= 1,	/* cancel work on list */
+};
+
+enum {
+	IO_WQE_FLAG_STALLED	= 1,	/* stalled on hash */
+};
+
+/*
+ * One for each thread in a wqe pool
+ */
+struct io_worker {
+	refcount_t ref;
+	unsigned flags;
+	struct hlist_nulls_node nulls_node;
+	struct task_struct *task;
+	wait_queue_head_t wait;
+	struct io_wqe *wqe;
+	struct io_wq_work *cur_work;
+
+	struct rcu_head rcu;
+	struct mm_struct *mm;
+};
+
+struct io_wq_nulls_list {
+	struct hlist_nulls_head head;
+	unsigned long nulls;
+};
+
+#if BITS_PER_LONG == 64
+#define IO_WQ_HASH_ORDER	6
+#else
+#define IO_WQ_HASH_ORDER	5
+#endif
+
+/*
+ * Per-node worker thread pool
+ */
+struct io_wqe {
+	struct {
+		spinlock_t lock;
+		struct list_head work_list;
+		unsigned long hash_map;
+		unsigned flags;
+	} ____cacheline_aligned_in_smp;
+
+	int node;
+	unsigned nr_workers;
+	unsigned max_workers;
+	atomic_t nr_running;
+
+	struct io_wq_nulls_list free_list;
+	struct io_wq_nulls_list busy_list;
+
+	struct io_wq *wq;
+};
+
+/*
+ * Per io_wq state
+  */
+struct io_wq {
+	struct io_wqe **wqes;
+	unsigned long state;
+	unsigned nr_wqes;
+
+	struct task_struct *manager;
+	struct mm_struct *mm;
+	refcount_t refs;
+	struct completion done;
+};
+
+static void io_wq_free_worker(struct rcu_head *head)
+{
+	struct io_worker *worker = container_of(head, struct io_worker, rcu);
+
+	kfree(worker);
+}
+
+static bool io_worker_get(struct io_worker *worker)
+{
+	return refcount_inc_not_zero(&worker->ref);
+}
+
+static void io_worker_release(struct io_worker *worker)
+{
+	if (refcount_dec_and_test(&worker->ref))
+		wake_up_process(worker->task);
+}
+
+/*
+ * Note: drops the wqe->lock if returning true! The caller must re-acquire
+ * the lock in that case. Some callers need to restart handling if this
+ * happens, so we can't just re-acquire the lock on behalf of the caller.
+ */
+static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
+	__must_hold(wqe->lock)
+	__releases(wqe->lock)
+{
+	/*
+	 * If we have an active mm, we need to drop the wq lock before unusing
+	 * it. If we do, return true and let the caller retry the idle loop.
+	 */
+	if (worker->mm) {
+		spin_unlock(&wqe->lock);
+		__set_current_state(TASK_RUNNING);
+		set_fs(KERNEL_DS);
+		unuse_mm(worker->mm);
+		mmput(worker->mm);
+		worker->mm = NULL;
+		return true;
+	}
+
+	return false;
+}
+
+static void io_worker_exit(struct io_worker *worker)
+{
+	struct io_wqe *wqe = worker->wqe;
+	bool all_done = false;
+
+	/*
+	 * If we're not at zero, someone else is holding a brief reference
+	 * to the worker. Wait for that to go away.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (!refcount_dec_and_test(&worker->ref))
+		schedule();
+	__set_current_state(TASK_RUNNING);
+
+	preempt_disable();
+	current->flags &= ~PF_IO_WORKER;
+	if (worker->flags & IO_WORKER_F_RUNNING)
+		atomic_dec(&wqe->nr_running);
+	worker->flags = 0;
+	preempt_enable();
+
+	spin_lock(&wqe->lock);
+	hlist_nulls_del_rcu(&worker->nulls_node);
+	if (__io_worker_unuse(wqe, worker))
+		spin_lock(&wqe->lock);
+	wqe->nr_workers--;
+	all_done = !wqe->nr_workers;
+	spin_unlock(&wqe->lock);
+
+	/* all workers gone, wq exit can proceed */
+	if (all_done && refcount_dec_and_test(&wqe->wq->refs))
+		complete(&wqe->wq->done);
+
+	call_rcu(&worker->rcu, io_wq_free_worker);
+}
+
+static void io_worker_start(struct io_wqe *wqe, struct io_worker *worker)
+{
+	allow_kernel_signal(SIGINT);
+
+	current->flags |= PF_IO_WORKER;
+
+	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
+	atomic_inc(&wqe->nr_running);
+}
+
+/*
+ * Worker will start processing some work. Move it to the busy list, if
+ * it's currently on the freelist
+ */
+static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
+			     struct io_wq_work *work)
+	__must_hold(wqe->lock)
+{
+	if (worker->flags & IO_WORKER_F_FREE) {
+		worker->flags &= ~IO_WORKER_F_FREE;
+		hlist_nulls_del_init_rcu(&worker->nulls_node);
+		hlist_nulls_add_head_rcu(&worker->nulls_node,
+						&wqe->busy_list.head);
+	}
+	worker->cur_work = work;
+}
+
+/*
+ * No work, worker going to sleep. Move to freelist, and unuse mm if we
+ * have one attached. Dropping the mm may potentially sleep, so we drop
+ * the lock in that case and return success. Since the caller has to
+ * retry the loop in that case (we changed task state), we don't regrab
+ * the lock if we return success.
+ */
+static bool __io_worker_idle(struct io_wqe *wqe, struct io_worker *worker)
+{
+	if (!(worker->flags & IO_WORKER_F_FREE)) {
+		worker->flags |= IO_WORKER_F_FREE;
+		hlist_nulls_del_init_rcu(&worker->nulls_node);
+		hlist_nulls_add_head_rcu(&worker->nulls_node,
+						&wqe->free_list.head);
+	}
+
+	return __io_worker_unuse(wqe, worker);
+}
+
+static struct io_wq_work *io_get_next_work(struct io_wqe *wqe, unsigned *hash)
+	__must_hold(wqe->lock)
+{
+	struct io_wq_work *work;
+
+	list_for_each_entry(work, &wqe->work_list, list) {
+		/* not hashed, can run anytime */
+		if (!(work->flags & IO_WQ_WORK_HASHED)) {
+			list_del(&work->list);
+			return work;
+		}
+
+		/* hashed, can run if not already running */
+		*hash = work->flags >> IO_WQ_HASH_SHIFT;
+		if (!(wqe->hash_map & BIT_ULL(*hash))) {
+			wqe->hash_map |= BIT_ULL(*hash);
+			list_del(&work->list);
+			return work;
+		}
+	}
+
+	return NULL;
+}
+
+static void io_worker_handle_work(struct io_worker *worker)
+	__releases(wqe->lock)
+{
+	struct io_wq_work *work, *old_work;
+	struct io_wqe *wqe = worker->wqe;
+	struct io_wq *wq = wqe->wq;
+
+	do {
+		unsigned hash = -1U;
+
+		/*
+		 * If we got some work, mark us as busy. If we didn't, but
+		 * the list isn't empty, it means we stalled on hashed work.
+		 * Mark us stalled so we don't keep looking for work when we
+		 * can't make progress, any work completion or insertion will
+		 * clear the stalled flag.
+		 */
+		work = io_get_next_work(wqe, &hash);
+		if (work)
+			__io_worker_busy(wqe, worker, work);
+		else if (!list_empty(&wqe->work_list))
+			wqe->flags |= IO_WQE_FLAG_STALLED;
+
+		spin_unlock(&wqe->lock);
+		if (!work)
+			break;
+next:
+		if ((work->flags & IO_WQ_WORK_NEEDS_USER) && !worker->mm &&
+		    wq->mm && mmget_not_zero(wq->mm)) {
+			use_mm(wq->mm);
+			set_fs(USER_DS);
+			worker->mm = wq->mm;
+		}
+		if (test_bit(IO_WQ_BIT_CANCEL, &wq->state))
+			work->flags |= IO_WQ_WORK_CANCEL;
+		if (worker->mm)
+			work->flags |= IO_WQ_WORK_HAS_MM;
+
+		old_work = work;
+		work->func(&work);
+
+		spin_lock(&wqe->lock);
+		worker->cur_work = NULL;
+		if (hash != -1U) {
+			wqe->hash_map &= ~BIT_ULL(hash);
+			wqe->flags &= ~IO_WQE_FLAG_STALLED;
+		}
+		if (work && work != old_work) {
+			spin_unlock(&wqe->lock);
+			/* dependent work not hashed */
+			hash = -1U;
+			goto next;
+		}
+	} while (1);
+}
+
+static inline bool io_wqe_run_queue(struct io_wqe *wqe)
+	__must_hold(wqe->lock)
+{
+	if (!list_empty_careful(&wqe->work_list) &&
+	    !(wqe->flags & IO_WQE_FLAG_STALLED))
+		return true;
+	return false;
+}
+
+static int io_wqe_worker(void *data)
+{
+	struct io_worker *worker = data;
+	struct io_wqe *wqe = worker->wqe;
+	struct io_wq *wq = wqe->wq;
+	DEFINE_WAIT(wait);
+
+	io_worker_start(wqe, worker);
+
+	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
+		prepare_to_wait(&worker->wait, &wait, TASK_INTERRUPTIBLE);
+
+		spin_lock(&wqe->lock);
+		if (io_wqe_run_queue(wqe)) {
+			__set_current_state(TASK_RUNNING);
+			io_worker_handle_work(worker);
+			continue;
+		}
+		/* drops the lock on success, retry */
+		if (__io_worker_idle(wqe, worker))
+			continue;
+		spin_unlock(&wqe->lock);
+		if (signal_pending(current))
+			flush_signals(current);
+		if (schedule_timeout(WORKER_IDLE_TIMEOUT))
+			continue;
+		/* timed out, exit unless we're the fixed worker */
+		if (test_bit(IO_WQ_BIT_EXIT, &wq->state) ||
+		    !(worker->flags & IO_WORKER_F_FIXED))
+			break;
+	}
+
+	finish_wait(&worker->wait, &wait);
+
+	if (test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
+		spin_lock(&wqe->lock);
+		if (!list_empty(&wqe->work_list))
+			io_worker_handle_work(worker);
+		else
+			spin_unlock(&wqe->lock);
+	}
+
+	io_worker_exit(worker);
+	return 0;
+}
+
+/*
+ * Check head of free list for an available worker. If one isn't available,
+ * caller must wake up the wq manager to create one.
+ */
+static bool io_wqe_activate_free_worker(struct io_wqe *wqe)
+	__must_hold(RCU)
+{
+	struct hlist_nulls_node *n;
+	struct io_worker *worker;
+
+	n = rcu_dereference(hlist_nulls_first_rcu(&wqe->free_list.head));
+	if (is_a_nulls(n))
+		return false;
+
+	worker = hlist_nulls_entry(n, struct io_worker, nulls_node);
+	if (io_worker_get(worker)) {
+		wake_up(&worker->wait);
+		io_worker_release(worker);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We need a worker. If we find a free one, we're good. If not, and we're
+ * below the max number of workers, wake up the manager to create one.
+ */
+static void io_wqe_wake_worker(struct io_wqe *wqe)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = io_wqe_activate_free_worker(wqe);
+	rcu_read_unlock();
+
+	if (!ret && wqe->nr_workers < wqe->max_workers)
+		wake_up_process(wqe->wq->manager);
+}
+
+/*
+ * Called when a worker is scheduled in. Mark us as currently running.
+ */
+void io_wq_worker_running(struct task_struct *tsk)
+{
+	struct io_worker *worker = kthread_data(tsk);
+	struct io_wqe *wqe = worker->wqe;
+
+	if (!(worker->flags & IO_WORKER_F_UP))
+		return;
+	if (worker->flags & IO_WORKER_F_RUNNING)
+		return;
+	worker->flags |= IO_WORKER_F_RUNNING;
+	atomic_inc(&wqe->nr_running);
+}
+
+/*
+ * Called when worker is going to sleep. If there are no workers currently
+ * running and we have work pending, wake up a free one or have the manager
+ * set one up.
+ */
+void io_wq_worker_sleeping(struct task_struct *tsk)
+{
+	struct io_worker *worker = kthread_data(tsk);
+	struct io_wqe *wqe = worker->wqe;
+
+	if (!(worker->flags & IO_WORKER_F_UP))
+		return;
+	if (!(worker->flags & IO_WORKER_F_RUNNING))
+		return;
+
+	worker->flags &= ~IO_WORKER_F_RUNNING;
+
+	if (atomic_dec_and_test(&wqe->nr_running) && io_wqe_run_queue(wqe))
+		io_wqe_wake_worker(wqe);
+}
+
+static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe)
+{
+	struct io_worker *worker;
+
+	worker = kcalloc_node(1, sizeof(*worker), GFP_KERNEL, wqe->node);
+	if (!worker)
+		return;
+
+	refcount_set(&worker->ref, 1);
+	worker->nulls_node.pprev = NULL;
+	init_waitqueue_head(&worker->wait);
+	worker->wqe = wqe;
+
+	worker->task = kthread_create_on_node(io_wqe_worker, worker, wqe->node,
+						"io_wqe_worker-%d", wqe->node);
+	if (IS_ERR(worker->task)) {
+		kfree(worker);
+		return;
+	}
+
+	spin_lock(&wqe->lock);
+	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list.head);
+	worker->flags |= IO_WORKER_F_FREE;
+	if (!wqe->nr_workers)
+		worker->flags |= IO_WORKER_F_FIXED;
+	wqe->nr_workers++;
+	spin_unlock(&wqe->lock);
+
+	wake_up_process(worker->task);
+}
+
+static inline bool io_wqe_need_new_worker(struct io_wqe *wqe)
+	__must_hold(wqe->lock)
+{
+	if (!wqe->nr_workers)
+		return true;
+	if (hlist_nulls_empty(&wqe->free_list.head) &&
+	    wqe->nr_workers < wqe->max_workers && io_wqe_run_queue(wqe))
+		return true;
+
+	return false;
+}
+
+/*
+ * Manager thread. Tasked with creating new workers, if we need them.
+ */
+static int io_wq_manager(void *data)
+{
+	struct io_wq *wq = data;
+
+	while (!kthread_should_stop()) {
+		int i;
+
+		for (i = 0; i < wq->nr_wqes; i++) {
+			struct io_wqe *wqe = wq->wqes[i];
+			bool fork_worker = false;
+
+			spin_lock(&wqe->lock);
+			fork_worker = io_wqe_need_new_worker(wqe);
+			spin_unlock(&wqe->lock);
+			if (fork_worker)
+				create_io_worker(wq, wqe);
+		}
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (schedule_timeout(HZ))
+			continue;
+#ifdef IO_WQ_MANAGER_DEBUG
+		printk("manager: now workers=%d/running=%d/work_empty=%d\n", wq->nr_workers, atomic_read(&wq->nr_running), list_empty(&wq->work_list));
+#endif
+	}
+
+	return 0;
+}
+
+static void io_wqe_enqueue(struct io_wqe *wqe, struct io_wq_work *work)
+{
+	spin_lock(&wqe->lock);
+	list_add_tail(&work->list, &wqe->work_list);
+	wqe->flags &= ~IO_WQE_FLAG_STALLED;
+	spin_unlock(&wqe->lock);
+
+	if (!atomic_read(&wqe->nr_running))
+		io_wqe_wake_worker(wqe);
+}
+
+void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work)
+{
+	struct io_wqe *wqe = wq->wqes[numa_node_id()];
+
+	io_wqe_enqueue(wqe, work);
+}
+
+/*
+ * Enqueue work, hashed by some key. Work items that hash to the same value
+ * will not be done in parallel. Used to limit concurrent writes, generally
+ * hashed by inode.
+ */
+void io_wq_enqueue_hashed(struct io_wq *wq, struct io_wq_work *work, void *val)
+{
+	struct io_wqe *wqe = wq->wqes[numa_node_id()];
+	unsigned bit;
+
+
+	bit = hash_ptr(val, IO_WQ_HASH_ORDER);
+	work->flags |= (IO_WQ_WORK_HASHED | (bit << IO_WQ_HASH_SHIFT));
+	io_wqe_enqueue(wqe, work);
+}
+
+static bool io_wqe_worker_send_sig(struct io_worker *worker, void *data)
+{
+	send_sig(SIGINT, worker->task, 1);
+	return false;
+}
+
+/*
+ * Iterate the passed in list and call the specific function for each
+ * worker that isn't exiting
+ */
+static bool io_wq_for_each_worker(struct io_wqe *wqe,
+				  struct io_wq_nulls_list *list,
+				  bool (*func)(struct io_worker *, void *),
+				  void *data)
+{
+	struct hlist_nulls_node *n;
+	struct io_worker *worker;
+	bool ret = false;
+
+restart:
+	hlist_nulls_for_each_entry_rcu(worker, n, &list->head, nulls_node) {
+		if (io_worker_get(worker)) {
+			ret = func(worker, data);
+			io_worker_release(worker);
+			if (ret)
+				break;
+		}
+	}
+	if (!ret && get_nulls_value(n) != list->nulls)
+		goto restart;
+	return ret;
+}
+
+void io_wq_cancel_all(struct io_wq *wq)
+{
+	int i;
+
+	set_bit(IO_WQ_BIT_CANCEL, &wq->state);
+
+	/*
+	 * Browse both lists, as there's a gap between handing work off
+	 * to a worker and the worker putting itself on the busy_list
+	 */
+	rcu_read_lock();
+	for (i = 0; i < wq->nr_wqes; i++) {
+		struct io_wqe *wqe = wq->wqes[i];
+
+		io_wq_for_each_worker(wqe, &wqe->busy_list,
+					io_wqe_worker_send_sig, NULL);
+		io_wq_for_each_worker(wqe, &wqe->free_list,
+					io_wqe_worker_send_sig, NULL);
+	}
+	rcu_read_unlock();
+}
+
+static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
+{
+	struct io_wq_work *work = data;
+
+	if (worker->cur_work == work) {
+		send_sig(SIGINT, worker->task, 1);
+		return true;
+	}
+
+	return false;
+}
+
+static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
+					    struct io_wq_work *cwork)
+{
+	struct io_wq_work *work;
+	bool found;
+
+	cwork->flags |= IO_WQ_WORK_CANCEL;
+
+	/*
+	 * First check pending list, if we're lucky we can just remove it
+	 * from there. CANCEL_OK means that the work is returned as-new,
+	 * no completion will be posted for it.
+	 */
+	spin_lock(&wqe->lock);
+	list_for_each_entry(work, &wqe->work_list, list) {
+		if (work == cwork) {
+			list_del(&work->list);
+			spin_unlock(&wqe->lock);
+			return IO_WQ_CANCEL_OK;
+		}
+	}
+	spin_unlock(&wqe->lock);
+
+	/*
+	 * Now check if a free (going busy) or busy worker has the work
+	 * currently running. If we find it there, we'll return CANCEL_RUNNING
+	 * as an indication that we attempte to signal cancellation. The
+	 * completion will run normally in this case.
+	 */
+	rcu_read_lock();
+	found = io_wq_for_each_worker(wqe, &wqe->free_list, io_wq_worker_cancel,
+					cwork);
+	if (found)
+		goto done;
+
+	found = io_wq_for_each_worker(wqe, &wqe->busy_list, io_wq_worker_cancel,
+					cwork);
+done:
+	rcu_read_unlock();
+	return found ? IO_WQ_CANCEL_RUNNING : IO_WQ_CANCEL_NOTFOUND;
+
+}
+
+enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork)
+{
+	enum io_wq_cancel ret = IO_WQ_CANCEL_NOTFOUND;
+	int i;
+
+	for (i = 0; i < wq->nr_wqes; i++) {
+		struct io_wqe *wqe = wq->wqes[i];
+
+		ret = io_wqe_cancel_work(wqe, cwork);
+		if (ret != IO_WQ_CANCEL_NOTFOUND)
+			break;
+	}
+
+	return ret;
+}
+
+struct io_wq_flush_data {
+	struct io_wq_work work;
+	struct completion done;
+};
+
+static void io_wq_flush_func(struct io_wq_work **workptr)
+{
+	struct io_wq_work *work = *workptr;
+	struct io_wq_flush_data *data;
+
+	data = container_of(work, struct io_wq_flush_data, work);
+	complete(&data->done);
+}
+
+/*
+ * Doesn't wait for previously queued work to finish. When this completes,
+ * it just means that previously queued work was started.
+ */
+void io_wq_flush(struct io_wq *wq)
+{
+	struct io_wq_flush_data data;
+	int i;
+
+	for (i = 0; i < wq->nr_wqes; i++) {
+		struct io_wqe *wqe = wq->wqes[i];
+
+		init_completion(&data.done);
+		INIT_IO_WORK(&data.work, io_wq_flush_func);
+		io_wqe_enqueue(wqe, &data.work);
+		wait_for_completion(&data.done);
+	}
+}
+
+struct io_wq *io_wq_create(unsigned concurrency, struct mm_struct *mm)
+{
+	int ret = -ENOMEM, i, node;
+	struct io_wq *wq;
+
+	wq = kcalloc(1, sizeof(*wq), GFP_KERNEL);
+	if (!wq)
+		return ERR_PTR(-ENOMEM);
+
+	wq->nr_wqes = num_online_nodes();
+	wq->wqes = kcalloc(wq->nr_wqes, sizeof(struct io_wqe *), GFP_KERNEL);
+	if (!wq->wqes) {
+		kfree(wq);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	i = 0;
+	refcount_set(&wq->refs, wq->nr_wqes);
+	for_each_online_node(node) {
+		struct io_wqe *wqe;
+
+		wqe = kcalloc_node(1, sizeof(struct io_wqe), GFP_KERNEL, node);
+		if (!wqe)
+			break;
+		wq->wqes[i] = wqe;
+		wqe->node = node;
+		wqe->max_workers = concurrency;
+		wqe->node = node;
+		wqe->wq = wq;
+		spin_lock_init(&wqe->lock);
+		INIT_LIST_HEAD(&wqe->work_list);
+		INIT_HLIST_NULLS_HEAD(&wqe->free_list.head, 0);
+		wqe->free_list.nulls = 0;
+		INIT_HLIST_NULLS_HEAD(&wqe->busy_list.head, 1);
+		wqe->busy_list.nulls = 1;
+		atomic_set(&wqe->nr_running, 0);
+
+		i++;
+	}
+
+	init_completion(&wq->done);
+
+	if (i != wq->nr_wqes)
+		goto err;
+
+	/* caller must have already done mmgrab() on this mm */
+	wq->mm = mm;
+
+	wq->manager = kthread_create(io_wq_manager, wq, "io_wq_manager");
+	if (!IS_ERR(wq->manager)) {
+		wake_up_process(wq->manager);
+		return wq;
+	}
+
+	ret = PTR_ERR(wq->manager);
+	wq->manager = NULL;
+err:
+	complete(&wq->done);
+	io_wq_destroy(wq);
+	return ERR_PTR(ret);
+}
+
+static bool io_wq_worker_wake(struct io_worker *worker, void *data)
+{
+	wake_up_process(worker->task);
+	return false;
+}
+
+void io_wq_destroy(struct io_wq *wq)
+{
+	int i;
+
+	if (wq->manager) {
+		set_bit(IO_WQ_BIT_EXIT, &wq->state);
+		kthread_stop(wq->manager);
+	}
+
+	rcu_read_lock();
+	for (i = 0; i < wq->nr_wqes; i++) {
+		struct io_wqe *wqe = wq->wqes[i];
+
+		if (!wqe)
+			continue;
+		io_wq_for_each_worker(wqe, &wqe->free_list, io_wq_worker_wake,
+						NULL);
+		io_wq_for_each_worker(wqe, &wqe->busy_list, io_wq_worker_wake,
+						NULL);
+	}
+	rcu_read_unlock();
+
+	wait_for_completion(&wq->done);
+
+	for (i = 0; i < wq->nr_wqes; i++)
+		kfree(wq->wqes[i]);
+	kfree(wq->wqes);
+	kfree(wq);
+}
diff --git a/fs/io-wq.h b/fs/io-wq.h
new file mode 100644
index 000000000000..be8f22c8937b
--- /dev/null
+++ b/fs/io-wq.h
@@ -0,0 +1,55 @@
+#ifndef INTERNAL_IO_WQ_H
+#define INTERNAL_IO_WQ_H
+
+struct io_wq;
+
+enum {
+	IO_WQ_WORK_CANCEL	= 1,
+	IO_WQ_WORK_HAS_MM	= 2,
+	IO_WQ_WORK_HASHED	= 4,
+	IO_WQ_WORK_NEEDS_USER	= 8,
+
+	IO_WQ_HASH_SHIFT	= 24,	/* upper 8 bits are used for hash key */
+};
+
+enum io_wq_cancel {
+	IO_WQ_CANCEL_OK,	/* cancelled before started */
+	IO_WQ_CANCEL_RUNNING,	/* found, running, and attempted cancelled */
+	IO_WQ_CANCEL_NOTFOUND,	/* work not found */
+};
+
+struct io_wq_work {
+	struct list_head list;
+	void (*func)(struct io_wq_work **);
+	unsigned flags;
+};
+
+#define INIT_IO_WORK(work, _func)			\
+	do {						\
+		(work)->func = _func;			\
+		(work)->flags = 0;			\
+	} while (0)					\
+
+struct io_wq *io_wq_create(unsigned concurrency, struct mm_struct *mm);
+void io_wq_destroy(struct io_wq *wq);
+
+void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work);
+void io_wq_enqueue_hashed(struct io_wq *wq, struct io_wq_work *work, void *val);
+void io_wq_flush(struct io_wq *wq);
+
+void io_wq_cancel_all(struct io_wq *wq);
+enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork);
+
+#if defined(CONFIG_IO_WQ)
+extern void io_wq_worker_sleeping(struct task_struct *);
+extern void io_wq_worker_running(struct task_struct *);
+#else
+static inline void io_wq_worker_sleeping(struct task_struct *tsk)
+{
+}
+static inline void io_wq_worker_running(struct task_struct *tsk)
+{
+}
+#endif
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 67a1d86981a9..6666e25606b7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1468,6 +1468,7 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_IO_WORKER		0x20000000	/* Task is an IO worker */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd05a378631a..a95a2f05f3b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -16,6 +16,7 @@
 #include <asm/tlb.h>
 
 #include "../workqueue_internal.h"
+#include "../../fs/io-wq.h"
 #include "../smpboot.h"
 
 #include "pelt.h"
@@ -4103,9 +4104,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * we disable preemption to avoid it calling schedule() again
 	 * in the possible wakeup of a kworker.
 	 */
-	if (tsk->flags & PF_WQ_WORKER) {
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		preempt_disable();
-		wq_worker_sleeping(tsk);
+		if (tsk->flags & PF_WQ_WORKER)
+			wq_worker_sleeping(tsk);
+		else
+			io_wq_worker_sleeping(tsk);
 		preempt_enable_no_resched();
 	}
 
@@ -4122,8 +4126,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & PF_WQ_WORKER)
-		wq_worker_running(tsk);
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+		if (tsk->flags & PF_WQ_WORKER)
+			wq_worker_running(tsk);
+		else
+			io_wq_worker_running(tsk);
+	}
 }
 
 asmlinkage __visible void __sched schedule(void)
-- 
2.17.1

