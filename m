Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AE19538A
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909094; cv=none; b=pzHFFhL13mqcNdhzI3cbKNk31gDk6fQ6dO3K4gMa/nGg1XA2lNAh/RZ+BlE4P76satrRzYb92aBmtM7sS3/gTCqMmy6mS2eJf7EdlDLMTNcI07GKXlb4ZvvCYieIzphRkNiDgex5mpO8klQSIwXyMr3eeeZlIxQ0At2aeiUbLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909094; c=relaxed/simple;
	bh=/0RqKKxr/M1B+kEmHyh93EnBAMZHr2xH0tGnOz85l7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jUmsTjjmOH+8Inl7kzmREjxsrdoF8EQzKlfXZebwCMST0wht2mNLq2BQU2zEeEU5YOeGeo9CoTPfnI4L8vRHSRnFk/LBpUEcsCgJhhX62Ag9unMpDYUUBBQJ8SNib59Rs7EEUiw355Q8xj1TROIBuX6N7emkqN6bSOnc5fy/dwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G4HrVxQx; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G4HrVxQx"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-50a87472832so100989e0c.3
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727909091; x=1728513891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhVuX3J2iPKX+X0JbHlPKvDjoAsMt+b1A/JR4qkSAwM=;
        b=G4HrVxQx0QbWT+1wMAAiHkZ8Fwr3dDsD34DwZH/cRUfmrcB4U3A64yRNzlNx4T+oq0
         k7no195wVsT/Szp4U5DZ+paFD24xSG+hJyI5OjXd1iPM+N7sfKfyDRjPNGrRNqJGVb1l
         P0uJOUZkC5Sc/VFqtpH9Z/Z1lIa45DI/yCOBfsW7ODvcjIAbR/P/+S0/KkcMz2GWnZom
         xIXLid4D2ewBW5RKU0kI3XhAy7HsURzW8gK76fhVXNt0h4zX993s3E6Oy8wQ6AkrXLRF
         FPXV/yNa77O3C/Kem6TUyE2X35uUW0KcnbN4fBBot38Q6+gQFwnDrk1/q3pl2UonDxBt
         vNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909091; x=1728513891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhVuX3J2iPKX+X0JbHlPKvDjoAsMt+b1A/JR4qkSAwM=;
        b=vGTOayQaElnlcAN6h6sIk+qwzyn8GCH7FXF/pETXx+a6Z38x2+eCWoTz/jtXKWxxSH
         a6PSTwHpwhWvBRSGWQNt5Sca9dCDSfanmSaFP+mcMzkmQf14TEzXRTp8FpzdIG7jw4Bz
         4DVMOu3suAvjk6juKuNj+jj42Yp4mj3vPQIJT8XS9dbNeT87V89vG10GFCj+UZzdxdYs
         xKdjA8XF7ZB2j19Zu5AECmRtDJVsu84eYQHjcRabPCKnfxdUproYKHKV49LoEAldYLz/
         +kPRmGN8oMG0prE+GO7QbyYwFcFJIhPq38oK1eYCUAqQMt8JPkhsur9kWvK+zJykF9Ni
         Rvhw==
X-Forwarded-Encrypted: i=1; AJvYcCUkeiXfkVca/xUs4iBfcrJTGp5lAII9+NvWdkui3YEssZoKoLqGLvnxm3pqW8afCZCfutwJvajXH9UHpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YynoEjCJysccQcXoDlwCw9Kdg7BVYrpY2Iv9198dWfScTkSJI0k
	w8tlaEHvieWvsCk5W76VBvaLT6fsdHZcr3LzGfLyPoq9xA0KSBxxfMjqAHr/ae7QlhPeaEcB/A2
	+96yCt6FPeyJTnk5gNJO+LBhCh2/QiFCT
X-Google-Smtp-Source: AGHT+IHd0Y8uL6exkvbMIYb3vSXmizdkYiVHjMtlSx+WYkV9NgayiFgkJKd5bXEUPGsMNXp2E0sF40pUCJwC
X-Received: by 2002:a05:6122:2524:b0:50a:b7b5:30c6 with SMTP id 71dfb90a1353d-50c58212295mr4544689e0c.8.1727909090937;
        Wed, 02 Oct 2024 15:44:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-50c729f825fsm6201e0c.7.2024.10.02.15.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:44:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EC94C340357;
	Wed,  2 Oct 2024 16:44:48 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DFA81E413BF; Wed,  2 Oct 2024 16:44:48 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH] ublk: decouple hctx and ublk server threads
Date: Wed,  2 Oct 2024 16:44:37 -0600
Message-Id: <20241002224437.3088981-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
ensure even load. But this solution involves moving I/Os between threads
several times. This is a bad pattern for performance, and we observed a
significant regression in peak bandwidth with this solution.

Therefore, address this issue by removing the association of a unique
ubq_daemon to each hctx. This association is fairly artificial anyways,
and removing it results in simpler driver code. Imbalanced load can then
be balanced across all ublk server threads by having the threads fetch
I/Os for the same QID in a round robin manner. For example, in a system
with 4 ublk server threads, 2 hctxs, and a queue depth of 4, the threads
could issue fetch requests as follows (where each entry is of the form
qid, tag):

poller thread:	T0	T1	T2	T3
		0,0	0,1	0,2	0,3
		1,3	1,0	1,1	1,2

Since tags appear to be allocated in sequential chunks, this provides a
rough approximation to distributing I/Os round-robin across all ublk
server threads, while letting I/Os stay fully thread-local.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 105 ++++++++++++---------------------------
 1 file changed, 33 insertions(+), 72 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a6c8e5cc6051..7e0ce35dbc6f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -68,12 +68,12 @@
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
 
 struct ublk_rq_data {
-	struct llist_node node;
-
+	struct task_struct *task;
 	struct kref ref;
 };
 
 struct ublk_uring_cmd_pdu {
+	struct request *req;
 	struct ublk_queue *ubq;
 	u16 tag;
 };
@@ -133,15 +133,11 @@ struct ublk_queue {
 	int q_depth;
 
 	unsigned long flags;
-	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
 
-	struct llist_head	io_cmds;
-
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
 	bool force_abort;
-	bool timeout;
 	bool canceling;
 	unsigned short nr_io_ready;	/* how many ios setup */
 	spinlock_t		cancel_lock;
@@ -982,16 +978,12 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 	return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
 }
 
-static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
-{
-	return ubq->ubq_daemon->flags & PF_EXITING;
-}
-
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	struct ublk_io *io = &ubq->ios[req->tag];
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
@@ -1036,9 +1028,13 @@ static inline void __ublk_complete_rq(struct request *req)
 	else
 		__blk_mq_end_request(req, BLK_STS_OK);
 
-	return;
+	goto put_task;
 exit:
 	blk_mq_end_request(req, res);
+put_task:
+	WARN_ON_ONCE(!data->task);
+	put_task_struct(data->task);
+	data->task = NULL;
 }
 
 static void ublk_complete_rq(struct kref *ref)
@@ -1097,13 +1093,16 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
-static inline void __ublk_rq_task_work(struct request *req,
+static inline void __ublk_rq_task_work(struct io_uring_cmd *cmd,
 				       unsigned issue_flags)
 {
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct request *req = pdu->req;
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 	unsigned int mapped_bytes;
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
 	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
 			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
@@ -1112,13 +1111,14 @@ static inline void __ublk_rq_task_work(struct request *req,
 	/*
 	 * Task is exiting if either:
 	 *
-	 * (1) current != ubq_daemon.
+	 * (1) current != io_uring_get_cmd_task(io->cmd).
 	 * io_uring_cmd_complete_in_task() tries to run task_work
-	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
+	 * in a workqueue if cmd's task is PF_EXITING.
 	 *
 	 * (2) current->flags & PF_EXITING.
 	 */
-	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
+	if (unlikely(current != io_uring_cmd_get_task(io->cmd) ||
+		     current->flags & PF_EXITING)) {
 		__ublk_abort_rq(ubq, req);
 		return;
 	}
@@ -1173,55 +1173,32 @@ static inline void __ublk_rq_task_work(struct request *req,
 	}
 
 	ublk_init_req_ref(ubq, req);
+	WARN_ON_ONCE(data->task);
+	data->task = get_task_struct(current);
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
 }
 
-static inline void ublk_forward_io_cmds(struct ublk_queue *ubq,
-					unsigned issue_flags)
-{
-	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
-	struct ublk_rq_data *data, *tmp;
-
-	io_cmds = llist_reverse_order(io_cmds);
-	llist_for_each_entry_safe(data, tmp, io_cmds, node)
-		__ublk_rq_task_work(blk_mq_rq_from_pdu(data), issue_flags);
-}
-
-static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
-{
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-	struct ublk_queue *ubq = pdu->ubq;
-
-	ublk_forward_io_cmds(ubq, issue_flags);
-}
-
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
-
-	if (llist_add(&data->node, &ubq->io_cmds)) {
-		struct ublk_io *io = &ubq->ios[rq->tag];
-
-		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
-	}
+	struct ublk_io *io = &ubq->ios[rq->tag];
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
+	pdu->req = rq;
+	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
 }
 
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
 	unsigned int nr_inflight = 0;
 	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
-		if (!ubq->timeout) {
-			send_sig(SIGKILL, ubq->ubq_daemon, 0);
-			ubq->timeout = true;
-		}
-
+		send_sig(SIGKILL, data->task, 0);
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
+	if (!(data->task->flags & PF_EXITING))
 		return BLK_EH_RESET_TIMER;
 
 	for (i = 0; i < ubq->q_depth; i++) {
@@ -1380,8 +1357,8 @@ static void ublk_commit_completion(struct ublk_device *ub,
 }
 
 /*
- * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
- * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
+ * Called from cmd task context via cancel fn, meantime quiesce ublk
+ * blk-mq queue, so we are called exclusively with blk-mq and cmd task
  * context, so everything is serialized.
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
@@ -1478,8 +1455,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		return;
 
 	task = io_uring_cmd_get_task(cmd);
-	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
-		return;
 
 	ub = ubq->dev;
 	need_schedule = ublk_abort_requests(ub, ubq);
@@ -1623,8 +1598,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
-		ubq->ubq_daemon = current;
-		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
 
 		if (capable(CAP_SYS_ADMIN))
@@ -1703,9 +1676,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	if (!ubq || ub_cmd->q_id != ubq->q_id)
 		goto out;
 
-	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
-		goto out;
-
 	if (tag >= ubq->q_depth)
 		goto out;
 
@@ -1994,8 +1964,6 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 	int size = ublk_queue_cmd_buf_size(ub, q_id);
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 
-	if (ubq->ubq_daemon)
-		put_task_struct(ubq->ubq_daemon);
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 }
@@ -2661,15 +2629,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
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
@@ -2715,7 +2676,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	/* set to NULL, otherwise new tasks cannot mmap the io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
@@ -2733,14 +2694,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
 
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
 	if (!ublk_can_use_recovery(ub))

base-commit: ccb1526dda70e0c1bae7fe27aa3b0c96e6e2d0cd
-- 
2.34.1

