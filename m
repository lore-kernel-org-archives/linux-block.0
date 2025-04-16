Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01E204C3B
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765215; cv=none; b=Dxk8u8kRwvnXNGYjLD6gWdQI/hM1dR2YfjS/zkoIiE4vZXZuzQsJVv8GiqrfANxL0TfRbtJkT8xcClrAQ7uGljpMusqdOOAK83jqvp3l8kUCRBsNNhjJOj5gNECOD4ShfOJdikdnMeLsad1kd/Rz4MDbFxRc53WSucoSPmI5Krs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765215; c=relaxed/simple;
	bh=sfK3HXHKQ+vsF7uU0m2uSfGubbYYOuDDGvuSqM8XGkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrVIFtxIBncsRG3YSxEb/dFg9QP2QunqJFWpf4mgWXSjSsZJnMG/hHDFmf1xJmUikmM+d4Gkc2EDiFMPOF++DoYOoTvIArXQDSF5zSH7vURMqtZVNgogNVzJBBbH0bzNpQ713VwPJS6BVnp8tKEkzIZYGbaBoNYX9a/eGC+Mr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LIoezgcW; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LIoezgcW"
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e6deb3eb7dbso5042855276.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744765210; x=1745370010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVNNZ8nNV1VeIw2zvsjmKAcduOkjz1KfbzQYh61/aXM=;
        b=LIoezgcWXwBgHXA6vmmJpnF9QTI2KF/mpZOcQCLD5cXwLioOFCYrawm2qpeCeg3zlc
         sJ9qJR71cEZqSkm2tn/sF7eT3QGWQSMEIodq+usDOE24c4DCi357lLZLtKzYDgrpf2v6
         No1wxL9l24HlRSTpV3oW6oA1X1skyDyEG8eZ45UjmfbVl45/2ojMDD5mr3Nqxh/q93DD
         EHUWuy6C5G1fThH6U4N01JvQprxLfYvLL3iFVJXfxWZGyADyiYwsvivt6HsufYma8TJM
         akn2R4QM7dlM1Zq8xv71q9H8NhnOP3lobbzleqqbleCZveizVjcTWcjFhIlr+ckLDcgk
         VPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765210; x=1745370010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVNNZ8nNV1VeIw2zvsjmKAcduOkjz1KfbzQYh61/aXM=;
        b=p2x5ql7Sdl3LIIJuz+8sk32PIwGnD9Slx1J+y4+Y4eLqy/2UI4t6UXhCXWhIlFZ6M0
         BS/2vZiifSUoy2EeReO4UrHVDkXGh5L9IjOv4C0uB4mvz9LdRe6SgXfTJBV6CxU5ggqd
         Fd5wpD8gdp6cGYHt8naUYXIpZngzKkAR+Hg/zhvbLlCaC/Uz9ItcnUvzz6PWuab2/kc4
         k6DsMu+wNQiQFZHFhVacm6zVgVhaIoa0CwiFQr2Wgy2tJ4s25ENtXnkNiLNIOx3wFiDi
         AcjeU8kPLyxR0Rl+7C9d12a0OLkjIXv2sNNTChGLRNSSggNsQpmX2txodQBPDJEZaBTV
         2BOQ==
X-Gm-Message-State: AOJu0YxMpSeXErWcnf3O6jyr+Jd6MnXgenJS+Z7ggMlTXKGxQLLPmVvL
	UTBhBLIVVTeD/U0L9U7/QtvKx3t6/4J2t3seMIM9f4DeB3m8M+Tt86Bh4aYlnissftZK9wZvkur
	Drx20j2uefe0MJGuP7T5zVemnkRWxlnhT
X-Gm-Gg: ASbGncv2iE51j27XvsB63v/JEXzwx2LRE+jYcjb8KFto2UqhpTY8nBSMLj6px1xJINV
	5PwRjAaTWrZpbygdYkn972slv+jipIOQJdItYY4gCDC0CwmVkxwWBUty7JWwTPZDIK4l6+KYlSI
	diZRIXZA4kFxk8GAlol5EkfOVkRGZ3qr2bUn2VnrDDhFFKmqQ7FU4PiOmMBucI8dPf+CJgcqFXK
	Wm1GleZqK2lVG58bWgPNXjnTYPuj4wz/u6G5qtkd/Am13GiazOVr2QcrFZU4SuXRJxeHl6zebQo
	QE9c9btj5OV/Kx3e9kClFOyFU/7FyToJSaiOqrW/CP3smw==
X-Google-Smtp-Source: AGHT+IHT2/nszmvKTAlkI/lLHpEoLtoU6fdUwc06HofmppuXRb6QZJ46E3HhXJfyV87/DEtapoejWU1kixdH
X-Received: by 2002:a05:6902:18d4:b0:e5b:4482:a4f7 with SMTP id 3f1490d57ef6-e726e644c5fmr2101574276.12.1744765209351;
        Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e703245aac1sm399992276.9.2025.04.15.18.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4DA7F3404A1;
	Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F05B4E40318; Tue, 15 Apr 2025 19:00:07 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 15 Apr 2025 18:59:37 -0600
Subject: [PATCH v4 1/4] ublk: require unique task per io instead of unique
 task per hctx
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-ublk_task_per_io-v4-1-54210b91a46f@purestorage.com>
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
In-Reply-To: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
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
 drivers/block/ublk_drv.c | 75 ++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cdb1543fa4a9817aa2ca2fca66720f589cf222be..9a0d2547512fc8119460739230599d48d2c2a306 100644
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
@@ -1952,14 +1941,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	if (!ubq || ub_cmd->q_id != ubq->q_id)
 		goto out;
 
-	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
-		goto out;
-
 	if (tag >= ubq->q_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
 
+	if (io->task && io->task != current)
+		goto out;
+
 	/* there is pending io cmd, something must be wrong */
 	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
 		ret = -EBUSY;
@@ -2012,6 +2001,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
+		io->task = get_task_struct(current);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
@@ -2248,9 +2238,15 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
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
@@ -2936,15 +2932,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
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
@@ -2954,6 +2943,10 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 		io->flags = 0;
 		io->cmd = NULL;
 		io->addr = 0;
+
+		WARN_ON_ONCE(!(io->task && (io->task->flags & PF_EXITING)));
+		put_task_struct(io->task);
+		io->task = NULL;
 	}
 }
 
@@ -2993,7 +2986,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	/* set to NULL, otherwise new tasks cannot mmap the io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
@@ -3011,14 +3004,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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

