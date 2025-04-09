Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B7198E76
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744162954; cv=none; b=SaagS3lLkjiW+NyaU1CYAkRnVJ9KqD1iy/v8/vZBXKmxRCFHy6CFh8tAeGsQx+jkBk9DFPJjk2O3YQ2mdfBLJKVJNFyDNriQwfV1XtmU+ZEWnc5mxOyHfIJBYkRPbJDRXTBxTlw8kiTqpWdbl20gYx7Qm7T2HQeB8wF2PRa1rIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744162954; c=relaxed/simple;
	bh=GTrKKsElufLUl6LIESiQiKtGw4NJXYmSyb2jdCZTTTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Li8rVkUYOibRgioX7hIn8HzwzuakIRoh6BrzRnJWbVUyh63nLRV0fV3fI1schD1NXWdjCuDUyUK/vhPYwwsDwDHdSJmSKrJUVs0AQjC45Y/vHBlYGUyG1+RsK0HTxGNahrZCrXfvHe9z55uWb74R3tNJLSDxmfGRFWLsD7/nVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bRqVxVhM; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bRqVxVhM"
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso60384565ab.1
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744162951; x=1744767751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TFDQmxEY/oTpesIZpeWcZDgn8XPPYKLm/+q8z+3Hdw=;
        b=bRqVxVhMnj0e2/eEGpjMu3u5gnzEegk+5EEcFESE+Ktmj0n4RjcJct/3AyK4VlSfUx
         36LUIe2XA4aKICUjRaGgzvIEOnhLByw2ZtlrVOv6lUntk7KXaawnXygFLyZmVQ3KZUdI
         RXNuiw5wIVf7lVRVFZyBfUcG1VsFgbV8Zfyz3m5K32i/eCkuf3lZABAtdADWJSElmweD
         o0P96EelGgQ2zQ8K12KbAgAmOeVyx7uhrDEEp9yr+RZWXdrrtdn5j0f2prB39BB0F1qZ
         QycjHeEkQPKcy4PNnAF9bUYOGIEIbHDwS8lVTGN0qTou0kvyPbM5EAbu/CUf1ManeHgW
         ENUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744162951; x=1744767751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TFDQmxEY/oTpesIZpeWcZDgn8XPPYKLm/+q8z+3Hdw=;
        b=LStyhWwqMCDWct7UEO/qpUtqIrpKiBjYzuH9toU4oEYT40MtsqxRwEZD/6rOjLBcLW
         XHL1qCZ76XtqujS0gwVS1RvS6gwCKcrqPQ3d9wfc5icZfHfJvMGQyt8DYUwfnIYCSNvV
         7RXsoHt57fbgxVU4UCX0oUk4bSkcC6k/NmhcHU2U7eOZ3AIsTtzOmjqimfuQsECqeTq+
         BksSSeV9Xb5Akxmir7/uC6q7PesC7pi7bvHpkLLBYIKow7fczHTwatN4E2SkMcFCLtml
         Sv05wZFMoR2bOORfwDTPDoCqz5Mox35lNPEraINQFDrhrPXoRz5OdnwrOo1JYIOpt4Ze
         zGzw==
X-Gm-Message-State: AOJu0Yx9MvhklKITrOyhdZipMJ5Y7YEPS15xmXD/GRNGxVa9jEmXc7DL
	La6vPkiOrK+MLnSI0Ih9MnRaRlpV/66ftxMChTqmiHn6y/rbBglDMQ4tXy6xIOY3aZK79sAY/Zc
	mQEK1Hz+h7xsd2pCj6Tr4va+TAjzxRYNUIjxvWZ2HIeiYTU3H
X-Gm-Gg: ASbGncs5lUXZnPwkkQPDocQ6IgVbecCK58icfp/y6IUjPwx0pakVcwGcBoM7Ki5+Oe+
	5vjf1PdhX4NP+7uEHqNp+/Z6vjTkIuFTAojfeHehhvbys1k2WzlOIyCD4GzXcch9rBa47eCRiiC
	IDX+zV7ebtaog9zObuq8sWA2KO8q+YwksvPl5PVODbcSN7uCNazVEISjp/d+vivoswwCCp4xlXF
	dkrtJKrQrzEQ8QO3dauPAxHLywWJRPaiTDJ9vzCwdA2FRoEbS4p3gJS/TleT7wGqycwF4g1ONh3
	m0wMEWhx1UWVa3tuQVbjR8RyyWx3DZ+rXlY=
X-Google-Smtp-Source: AGHT+IHPTMkBOR6/4UJLfhoawTK5/aiDlDFszMj/FEtwjJYaSspXxcx8wqq8hH1xe8z31Nb75fDS6moFSsmf
X-Received: by 2002:a05:6e02:2165:b0:3d0:4e0c:2c96 with SMTP id e9e14a558f8ab-3d776c93eebmr16101355ab.2.1744162951232;
        Tue, 08 Apr 2025 18:42:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f505cfbc5bsm6609173.13.2025.04.08.18.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:42:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 58ED334059A;
	Tue,  8 Apr 2025 19:42:30 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4A394E40F92; Tue,  8 Apr 2025 19:42:29 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 08 Apr 2025 19:42:08 -0600
Subject: [PATCH v2 2/2] ublk: require unique task per io instead of unique
 task per hctx
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-ublk_task_per_io-v2-2-b97877e6fd50@purestorage.com>
References: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com>
In-Reply-To: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
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
---
 drivers/block/ublk_drv.c | 75 ++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5535073ccd23dfbbd25830c1722c360146b95662..e51c72ae1f7e2a9832e3b446bd31b0d49aef98b5 100644
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
@@ -1202,13 +1196,13 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
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
@@ -1314,23 +1308,20 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
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
@@ -1529,8 +1520,8 @@ static void ublk_commit_completion(struct ublk_device *ub,
 }
 
 /*
- * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
- * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
+ * Called from io task context via cancel fn, meantime quiesce ublk
+ * blk-mq queue, so we are called exclusively with blk-mq and io task
  * context, so everything is serialized.
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
@@ -1646,13 +1637,13 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
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
 
@@ -1813,8 +1804,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
-		ubq->ubq_daemon = current;
-		get_task_struct(ubq->ubq_daemon);
 		ub->nr_queues_ready++;
 
 		if (capable(CAP_SYS_ADMIN))
@@ -1928,14 +1917,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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
@@ -1989,6 +1978,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
+		io->task = get_task_struct(current);
 		mutex_unlock(&ub->mutex);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
@@ -2228,9 +2218,15 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
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
@@ -2921,15 +2917,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
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
@@ -2939,6 +2928,10 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 		io->flags = 0;
 		io->cmd = NULL;
 		io->addr = 0;
+
+		WARN_ON_ONCE(!(io->task && (io->task->flags & PF_EXITING)));
+		put_task_struct(io->task);
+		io->task = NULL;
 	}
 }
 
@@ -2979,7 +2972,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	/* set to NULL, otherwise new tasks cannot mmap the io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
 	ub->nr_privileged_daemon = 0;
@@ -2998,14 +2991,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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

