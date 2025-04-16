Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F95224B1A
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832781; cv=none; b=InS1vevdu6hiVvb81mS1n2qSaYP79uvIREvUGdkV6IWmsACJLpz3wC1AOUSwuCDM9wNgRc5MKa0EPbKKNujDFihibyQavhUDREqGgaOIUwQxPClTU3sw1BgFQa0puDbly1afbTpcJWgqLRSPJlIFERYxJIOAi8C+bunooWdQKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832781; c=relaxed/simple;
	bh=tYWKo49qWwobGHivnVbrXRT7o/0NtMaP2FGGsVhHUk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpjdMSB5AbycO2IvXDK91qyxs400BqE7hUrbm1MXaaDnftie6/HHj237jUaHZPf7tF0AqHyiQBSqpnVyGZAdBM9q8KaQiu3jAffAWCVbKuIzyFXqt3i6aHvigNrznRSX7rxs1Lcp3WbWCxsdkYcZ1OjiKmpJQ1FP+LZeX2cwtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=P9cxdZWM; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P9cxdZWM"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-6f768e9be1aso12534957b3.0
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744832777; x=1745437577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OofhF9O27cVrb8WKj94QBUeimdnvDakh4zV4gN59Auk=;
        b=P9cxdZWMqrsCEMoQNaOHOiknddPAA1vvdcpLEjhLd4R83CD+6hgWg7dH8XJTTW13mY
         2d/fnmrqKEnjH9bwhSKDQFfPhRq3lQ0sIHwNWw5nTDiNpjk9/IPttXKXJoh6CNaH8tDW
         F/eutFH7mAhqNETC+Wbs867u+qQXTINblJue93iVWnzsYjkAaHcODWwNYS6LzhSB0t1v
         QVRj0nM1brG95gwRkyLKM8egeDf/5+VPmf+QsQ8mJeO8voGhDL1r3gfEKIUfSVCM2udF
         4m7ukMr/e48tUWIXxUelwf/H1jMSxRHOAPbdKT8UVlTdr51y1sYNOz0z0e3//iT2LnhD
         SlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744832777; x=1745437577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OofhF9O27cVrb8WKj94QBUeimdnvDakh4zV4gN59Auk=;
        b=llH5Svv/ly5T7xLdEgXlv/WCF/vp08Q7wykLRq4S24b1v76FUXgk1LrsAiEl+SzMzu
         P/0pn8F5BmwXbG3XZ19gMndGRyX6x9WFAzz13RFMMoSduP5gFFsWc7vwIRRsmwebnQjE
         va2zIcwsajsqFUXIpU4mEUKCEp6RusUfpbuNF5VLUC20mXhBjXcnNWj0UPPnjcOsXsFv
         cAwWoyA6IKXgxF1B63+9yTCZXcstn8i6TGQe1R1cNBb9WgmxtI5VcKZmSr3lcdVQdIJW
         eITkTdoemLmz+SghyOxk/Woc2a08BTdjDM1immrj62dKEH6VUKDon4gHXyw+hfpRvHD7
         sRsg==
X-Gm-Message-State: AOJu0YwiQnaZKDMYF4JENNX5WdEAp1K0oqpp1KtozPdHyZPRQNdrpKDj
	kzqLQBdzOFv1ALD+aOXSsPnG7qkkrpmCyk5FRt09c5VP6r2CEtQs1bKh4B0mJ2nWhOvHxVCyaZ8
	UL1HfHBTl3fEEUxfT4JHSXEpvTGQcmwBA
X-Gm-Gg: ASbGncsgbFJ8LkE8sA3ga5LFCbiYK+FWuahRt9fHCE5Z/DcJ8UCeFiB1jSL8NX2QGIM
	KIii9xghRgqZ6NeTVP+lFBuVFCM0snTlOqFR4FAZaqkjvErrit/WF3XaykOrugr5FfErE+GxZJS
	c2bu/OatvzBs09rqCM9DGUvbE2d0H3YaI3ReNQjYZ6XF4MOtVPRbhO5wHsXVqgD4bkfhvjOFXqf
	56/zfOR3mkvpSjdDcE76v3OP7SFbxYhlXTVzuNIbtm3R885Jp11/3wdMBcKon7GtDEsXCz2iSUB
	qkgfWXnoQr2MRWWNQbrSo/J4nnYNmFEM84gmUoNQO4u20Q==
X-Google-Smtp-Source: AGHT+IHK6kJ+1KjaTnTQVEhaL8MlXYaxdyW3jy6ShqO7QymT3Ojn4Obrefs2o7lpRfVUMFUZ8u7oSSQml4nx
X-Received: by 2002:a05:690c:3393:b0:6f9:4c00:53ae with SMTP id 00721157ae682-706beb2df29mr1335057b3.8.1744832777325;
        Wed, 16 Apr 2025 12:46:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7053e0f43b6sm7203417b3.11.2025.04.16.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:46:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8D61C340424;
	Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 81E3FE402BD; Wed, 16 Apr 2025 13:46:16 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 16 Apr 2025 13:46:05 -0600
Subject: [PATCH v5 1/4] ublk: require unique task per io instead of unique
 task per hctx
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-ublk_task_per_io-v5-1-9261ad7bff20@purestorage.com>
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
In-Reply-To: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Currently, ublk_drv associates to each hardware queue (hctx) a unique
task (called the queue's ubq_daemon) which is allowed to issue
COMMIT_AND_FETCH commands against the hctx. If any other task attempts
to do so, the command fails immediately with EINVAL. When considered
together with the block layer architecture, the result is that for each
CPU C on the system, there is a unique ublk server thread which is
allowed to handle I/O submitted on CPU C. This can lead to suboptimal
performance under imbalanced load generation. For an extreme example,
suppose all the load is generated on CPUs mapping to a single ublk
server thread. Then that thread may be fully utilized and become the
bottleneck in the system, while other ublk server threads are totally
idle.

This issue can also be addressed directly in the ublk server without
kernel support by having threads dequeue I/Os and pass them around to
ensure even load. But this solution requires inter-thread communication
at least twice for each I/O (submission and completion), which is
generally a bad pattern for performance. The problem gets even worse
with zero copy, as more inter-thread communication would be required to
have the buffer register/unregister calls to come from the correct
thread.

Therefore, address this issue in ublk_drv by requiring a unique task per
I/O instead of per queue/hctx. Imbalanced load can then be balanced
across all ublk server threads by having threads issue FETCH_REQs in a
round-robin manner. As a small toy example, consider a system with a
single ublk device having 2 queues, each of queue depth 4. A ublk server
having 4 threads could issue its FETCH_REQs against this device as
follows (where each entry is the qid,tag pair that the FETCH_REQ
targets):

poller thread:	T0	T1	T2	T3
		0,0	0,1	0,2	0,3
		1,3	1,0	1,1	1,2

Since tags appear to be allocated in sequential chunks, this setup
provides a rough approximation to distributing I/Os round-robin across
all ublk server threads, while letting I/Os stay fully thread-local.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 76 ++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cdb1543fa4a9817aa2ca2fca66720f589cf222be..4e4863d873e6593ad94c72cbf971f792df5795ae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -150,6 +150,7 @@ struct ublk_io {
 	int res;
 
 	struct io_uring_cmd *cmd;
+	struct task_struct *task;
 };
 
 struct ublk_queue {
@@ -157,11 +158,9 @@ struct ublk_queue {
 	int q_depth;
 
 	unsigned long flags;
-	struct task_struct	*ubq_daemon;
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
-	bool timeout;
 	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	unsigned short nr_io_ready;	/* how many ios setup */
@@ -1072,11 +1071,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
 }
 
-static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
-{
-	return ubq->ubq_daemon->flags & PF_EXITING;
-}
-
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req)
 {
@@ -1224,13 +1218,13 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 	/*
 	 * Task is exiting if either:
 	 *
-	 * (1) current != ubq_daemon.
+	 * (1) current != io->task.
 	 * io_uring_cmd_complete_in_task() tries to run task_work
-	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
+	 * in a workqueue if cmd's task is PF_EXITING.
 	 *
 	 * (2) current->flags & PF_EXITING.
 	 */
-	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
+	if (unlikely(current != io->task || current->flags & PF_EXITING)) {
 		__ublk_abort_rq(ubq, req);
 		return;
 	}
@@ -1336,23 +1330,20 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[rq->tag];
 	unsigned int nr_inflight = 0;
 	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
-		if (!ubq->timeout) {
-			send_sig(SIGKILL, ubq->ubq_daemon, 0);
-			ubq->timeout = true;
-		}
-
+		send_sig(SIGKILL, io->task, 0);
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
+	if (!(io->task->flags & PF_EXITING))
 		return BLK_EH_RESET_TIMER;
 
 	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
+		io = &ubq->ios[i];
 
 		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 			nr_inflight++;
@@ -1552,8 +1543,8 @@ static void ublk_commit_completion(struct ublk_device *ub,
 }
 
 /*
- * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
- * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
+ * Called from io task context via cancel fn, meantime quiesce ublk
+ * blk-mq queue, so we are called exclusively with blk-mq and io task
  * context, so everything is serialized.
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
@@ -1669,13 +1660,13 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		return;
 
 	task = io_uring_cmd_get_task(cmd);
-	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
+	io = &ubq->ios[pdu->tag];
+	if (WARN_ON_ONCE(task && task != io->task))
 		return;
 
 	ub = ubq->dev;
 	need_schedule = ublk_abort_requests(ub, ubq);
 
-	io = &ubq->ios[pdu->tag];
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, io, issue_flags);
 
@@ -1836,8 +1827,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
-		ubq->ubq_daemon = current;
-		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
 
 		if (capable(CAP_SYS_ADMIN))
@@ -1934,6 +1923,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
+	struct task_struct *task;
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 	u32 cmd_op = cmd->cmd_op;
@@ -1952,13 +1942,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	if (!ubq || ub_cmd->q_id != ubq->q_id)
 		goto out;
 
-	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
-		goto out;
-
 	if (tag >= ubq->q_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
+	task = READ_ONCE(io->task);
+	if (task && task != current)
+		goto out;
 
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
@@ -2011,6 +2001,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+		WRITE_ONCE(io->task, get_task_struct(current));
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
@@ -2248,9 +2239,15 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
 	int size = ublk_queue_cmd_buf_size(ub, q_id);
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
+	struct ublk_io *io;
+	int i;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		io = &ubq->ios[i];
+		if (io->task)
+			put_task_struct(io->task);
+	}
 
-	if (ubq->ubq_daemon)
-		put_task_struct(ubq->ubq_daemon);
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 }
@@ -2936,15 +2933,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
 
-	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
-
 	/* All old ioucmds have to be completed */
 	ubq->nr_io_ready = 0;
-	/* old daemon is PF_EXITING, put it now */
-	put_task_struct(ubq->ubq_daemon);
-	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
-	ubq->ubq_daemon = NULL;
-	ubq->timeout = false;
 	ubq->canceling = false;
 
 	for (i = 0; i < ubq->q_depth; i++) {
@@ -2954,6 +2944,10 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 		io->flags = 0;
 		io->cmd = NULL;
 		io->addr = 0;
+
+		WARN_ON_ONCE(!(io->task && (io->task->flags & PF_EXITING)));
+		put_task_struct(io->task);
+		io->task = NULL;
 	}
 }
 
@@ -2993,7 +2987,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	/* set to NULL, otherwise new tasks cannot mmap the io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
@@ -3011,14 +3005,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	int ret = -EINVAL;
 	int i;
 
-	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
-			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
-	/* wait until new ubq_daemon sending all FETCH_REQ */
+	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
+		 header->dev_id);
+
 	if (wait_for_completion_interruptible(&ub->completion))
 		return -EINTR;
 
-	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
-			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
+	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
+		 header->dev_id);
 
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))

-- 
2.34.1

