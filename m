Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0D3112C0
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288617; cv=none; b=AfGBhJ+nuPUzcxiOWARudSnjQ47pyQpYbj6Dzrby1YT5J6QzBSd8BCiyqp+PEywmTpyOgmbKTVbogPqI7E+TD/093CpL4qljnxjxNgeDVXkdDFbTPbP9SYWR0oaHDGuNdWbcLy4NAcASwGUKKQvLW9YEJTuMatwX03OMivB5Rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288617; c=relaxed/simple;
	bh=LJ95ZDzWuQf9M9MNsKQxfCv9LwAoWI5xe2csiMcsgYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja+rfuLL9971aBfNBc+LZ86oMKyQ4N9hB1k7KC+oimuh/+vyxRVO7QvS84F+vfgUm5ftQ52CHiaRbVUVcg8hGF5dtBSCZmgiLGQvyUxl20iP+kY/ZcTvbkqFDSFEjPzAfWOvEnuyh08BUPHlSWZNsLS/CZjos2L76QLZjLRp4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YrlLUkI+; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YrlLUkI+"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-667b9bee563so41713d50.3
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785288605; x=1785893405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lF4S9vJCMB3B8B3Lz2AOxI5m/n+F/2UtPucxWZ5uUk=;
        b=YrlLUkI++NQq7DfBYWVxDkW9TKrRQhwQXGtzoOAYnmOCgRPKzjoSd1QQ16jg/omDFa
         j8/gf7cE46wt7j3d9TXsM77q3pzEcdmnODFSubu3xfYheLhZoq057LwIDWjM8U8L2yR4
         sfZe8tlmg7tbu1jLWxMUc9O4N3raX2XWgY2UycMEKgzIYEqGLQlf9ikx7JzWH+XiMO1b
         Ke1Z/C9EqGtafOYAkkK0W04TfnF1gfYIHizYTBIWy076ZBqxOfkSo9k00MbO8vugjgcL
         zuMYfMXm/cl4MhRB4B5BmD8H6VxjMdq8Ici2geTk8extYf6Ab9o+7INGihS/+rRFR5f7
         vxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288605; x=1785893405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lF4S9vJCMB3B8B3Lz2AOxI5m/n+F/2UtPucxWZ5uUk=;
        b=g/DHUQ27z1TMmm1mXfC2C5xKzUXs59KXmL1yIHuAq7rLHJOjJ99DQ2PRVpijb6s43K
         WQQMHzie3xj90AEWN9bhItt/Fh1KSK+frrCfwJVRMd3d3PtE2poi8UOIGQ1C4z3AoC6L
         wZhfTiM4fDT0EmZqUHTtmjEEVpA78DjksizZg52HFfx6QumlIn3u6RmbiDazJW6RFwtC
         gx5shACmRDNzimwCw/8AXu4bpiUprrdkM7nQNNDLSMRmgvqWl84I90YnCZz3Y1qbCwJl
         wBdG5qN6dg8IL2GKYqILugrnZQ3wYHlOspaBRX2ohXHZSenTFZfaovuwMw/iVYhglHZ/
         HETw==
X-Gm-Message-State: AOJu0Yww/+BIbM5HQMW88N0N5es9/34QwxNMa7CE5rtRxb/EV2XDHbiw
	/kOoFGGsFwEnEOxBWyLU+XDWHDXPLmM3zLMTcqqyWnt0kMtRszXUlnkQ2J2jLKj+D44Pya5OYWA
	sHMCPNiDGMGlFtuMEnAmXVbytzqOJ3mJ/snQmqdgS4ivUz2TEk++4
X-Gm-Gg: AR+sD13ZLAcpU+buSa8A9do1+1GWVkU6RD+QpavlXskW+1P4Fwx7euj3RInbyGCK1Iz
	FFXh7pmPri+6t/6ohBPewcN31/AneZV0wDRYSUlmBRf5umi9Kr6AhrUBLzZoum8qnzOEZKEVwY/
	qMnCFdvOS18E0lGlbenKlkVgUbvSZSgfei9QKF8rX8Lg4NfZ2hOxeTweGEpEh8Z1Rjl40Xd5nau
	eI1lUEWEdefwB2Q5nEmqFARk8AVv0rbZdCoSTUY79vVFYbT9VrLgmN/pi1MdGjGJV62sE6wK0Mp
	+H+kkwccVYjOBKRDnyLBkkvXo6v2TZiFJpKhKy4TKebZ/brbhRBS5uGgvq15Yv9iHj9aDdWbmJY
	RZ3zkoAzTM4YfV0Ko4A==
X-Received: by 2002:a05:690c:6e81:b0:81e:f5ac:e46 with SMTP id 00721157ae682-81f9908f4b6mr22151337b3.2.1785288604580;
        Tue, 28 Jul 2026 18:30:04 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-81fa28f55b4sm704777b3.15.2026.07.28.18.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:30:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 05ADA40431;
	Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 00571E402F9; Tue, 28 Jul 2026 19:30:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/6] ublk: consistently use u16 for queue and tag numbers
Date: Tue, 28 Jul 2026 19:29:46 -0600
Message-ID: <20260729012951.3744582-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729012951.3744582-1-csander@purestorage.com>
References: <20260729012951.3744582-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The u16 nr_hw_queues and queue_depth fields of the ublk UAPI struct
ublksrv_ctrl_dev_info constrain the number of queues and queue depth of
each ublk device. However, the ublk driver is a bit inconsistent with
the type it uses to represent these values, mixing u16 with int and
unsigned int. Change all queue number, queue depth, q_id, and tag
variables/fields to u16 to save some space.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 80 ++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4f30644756df..257c61bc8222 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -235,22 +235,22 @@ struct ublk_io {
 	void *buf_ctx_handle;
 	spinlock_t lock;
 } ____cacheline_aligned_in_smp;
 
 struct ublk_queue {
-	int q_id;
-	int q_depth;
+	u16 q_id;
+	u16 q_depth;
 
 	unsigned long flags;
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
 	bool canceling;
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
-	u32 nr_io_ready;
+	u16 nr_io_ready;
 
 	/*
 	 * For supporting UBLK_F_BATCH_IO only.
 	 *
 	 * Inflight ublk request tag is saved in this fifo
@@ -325,11 +325,11 @@ struct ublk_device {
 	spinlock_t		lock;
 	struct mm_struct	*mm;
 
 	struct ublk_params	params;
 
-	u32			nr_queue_ready;
+	u16			nr_queue_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
 	bool canceling;
 	pid_t 	ublksrv_tgid;
 	struct delayed_work	exit_work;
@@ -401,11 +401,11 @@ static inline void ublk_io_evts_deinit(struct ublk_queue *q)
 	WARN_ON_ONCE(!kfifo_is_empty(&q->evts_fifo));
 	kfifo_free(&q->evts_fifo);
 }
 
 static inline struct ublksrv_io_desc *
-ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
+ublk_get_iod(const struct ublk_queue *ubq, u16 tag)
 {
 	return &ubq->io_cmd_buf[tag];
 }
 
 static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
@@ -421,12 +421,11 @@ static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
 static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_SHMEM_ZC;
 }
 
-static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq,
-					unsigned int tag)
+static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq, u16 tag)
 {
 	return ublk_get_iod(ubq, tag)->op_flags & UBLK_IO_F_SHMEM_ZC;
 }
 
 static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *ub)
@@ -862,22 +861,22 @@ static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fetch_cmd *fcmd,
 static unsigned int unprivileged_ublks_max = 64;
 static unsigned int unprivileged_ublks_added; /* protected by ublk_ctl_mutex */
 
 static struct miscdevice ublk_misc;
 
-static inline unsigned ublk_pos_to_hwq(loff_t pos)
+static inline u16 ublk_pos_to_hwq(loff_t pos)
 {
 	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_QID_OFF) &
 		UBLK_QID_BITS_MASK;
 }
 
 static inline unsigned ublk_pos_to_buf_off(loff_t pos)
 {
 	return (pos - UBLKSRV_IO_BUF_OFFSET) & UBLK_IO_BUF_BITS_MASK;
 }
 
-static inline unsigned ublk_pos_to_tag(loff_t pos)
+static inline u16 ublk_pos_to_tag(loff_t pos)
 {
 	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
 		UBLK_TAG_BITS_MASK;
 }
 
@@ -1229,22 +1228,22 @@ static noinline void ublk_put_device(struct ublk_device *ub)
 {
 	put_device(&ub->cdev_dev);
 }
 
 static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
-		int qid)
+		u16 qid)
 {
 	return dev->queues[qid];
 }
 
 static inline struct ublksrv_io_desc *
-ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
+ublk_queue_cmd_buf(struct ublk_device *ub, u16 q_id)
 {
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
 }
 
-static inline int __ublk_queue_cmd_buf_size(int depth)
+static inline int __ublk_queue_cmd_buf_size(u16 depth)
 {
 	return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE);
 }
 
 static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub)
@@ -1653,11 +1652,11 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 	else
 		ublk_end_request(rq, BLK_STS_IOERR);
 }
 
 static void
-ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, unsigned tag)
+ublk_auto_buf_reg_fallback(const struct ublk_queue *ubq, u16 tag)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, tag);
 
 	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
 }
@@ -1764,11 +1763,11 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 }
 
 static void ublk_dispatch_req(struct ublk_queue *ubq, struct request *req)
 {
 	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
-	int tag = req->tag;
+	u16 tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
 
 	pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
@@ -2354,11 +2353,11 @@ static const struct blk_mq_ops ublk_batch_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	int i;
+	u16 i;
 
 	ubq->nr_io_ready = 0;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -2399,11 +2398,11 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
 static void ublk_reset_ch_dev(struct ublk_device *ub)
 {
-	int i;
+	u16 i;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
 		/* Sync with ublk_cancel_cmd() */
@@ -2471,20 +2470,20 @@ static void ublk_partition_scan_work(struct work_struct *work)
  *   means.
  */
 static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
 	__must_hold(&ub->cancel_mutex)
 {
-	int i;
+	u16 i;
 
 	ub->canceling = canceling;
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->canceling = canceling;
 }
 
 static bool ublk_check_and_reset_active_ref(struct ublk_device *ub)
 {
-	int i, j;
+	u16 i, j;
 
 	if (!ublk_dev_need_req_ref(ub))
 		return false;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
@@ -2513,11 +2512,11 @@ static bool ublk_check_and_reset_active_ref(struct ublk_device *ub)
 static void ublk_ch_release_work_fn(struct work_struct *work)
 {
 	struct ublk_device *ub =
 		container_of(work, struct ublk_device, exit_work.work);
 	struct gendisk *disk;
-	int i;
+	u16 i;
 
 	/*
 	 * For zero-copy and auto buffer register modes, I/O references
 	 * might not be dropped naturally when the daemon is killed, but
 	 * io_uring guarantees that registered bvec kernel buffers are
@@ -2632,11 +2631,12 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct ublk_device *ub = filp->private_data;
 	size_t sz = vma->vm_end - vma->vm_start;
 	unsigned max_sz = ublk_max_cmd_buf_size();
 	unsigned long pfn, end, phys_off = vma->vm_pgoff << PAGE_SHIFT;
-	int q_id, ret = 0;
+	int ret = 0;
+	u16 q_id;
 
 	spin_lock(&ub->lock);
 	if (!ub->mm)
 		ub->mm = current->mm;
 	if (current->mm != ub->mm)
@@ -2705,11 +2705,11 @@ static void ublk_abort_batch_queue(struct ublk_device *ub,
  * So no one can hold our request IO reference any more, simply ignore the
  * reference, and complete the request immediately
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	int i;
+	u16 i;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
@@ -2748,11 +2748,11 @@ static void ublk_start_cancel(struct ublk_device *ub)
 out:
 	mutex_unlock(&ub->cancel_mutex);
 	ublk_put_disk(disk);
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
+static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
 		unsigned int issue_flags)
 {
 	struct ublk_io *io = &ubq->ios[tag];
 	struct ublk_device *ub = ubq->dev;
 	struct io_uring_cmd *cmd = NULL;
@@ -2899,11 +2899,11 @@ static inline bool ublk_dev_ready(const struct ublk_device *ub)
 	return ub->nr_queue_ready == ub->dev_info.nr_hw_queues;
 }
 
 static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
-	int i;
+	u16 i;
 
 	if (ublk_support_batch_io(ubq)) {
 		ublk_batch_cancel_queue(ubq);
 		return;
 	}
@@ -2913,11 +2913,11 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
 static void ublk_cancel_dev(struct ublk_device *ub)
 {
-	int i;
+	u16 i;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_cancel_queue(ublk_get_queue(ub, i));
 }
 
@@ -2947,11 +2947,11 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
 static void ublk_force_abort_dev(struct ublk_device *ub)
 {
-	int i;
+	u16 i;
 
 	pr_devel("%s: force abort ub: dev_id %d state %s\n",
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
@@ -3144,11 +3144,11 @@ ublk_config_io_buf(const struct ublk_device *ub, struct ublk_io *io,
 	return 0;
 }
 
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 				    unsigned int issue_flags,
-				    struct ublk_queue *ubq, unsigned int tag)
+				    struct ublk_queue *ubq, u16 tag)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
 	/*
 	 * Safe to refer to @ubq since ublk_queue won't be died until its
@@ -3948,12 +3948,12 @@ static int ublk_handle_non_batch_cmd(struct io_uring_cmd *cmd,
 				     unsigned int issue_flags)
 {
 	const struct ublksrv_io_cmd *ub_cmd = io_uring_sqe_cmd(cmd->sqe,
 							       struct ublksrv_io_cmd);
 	struct ublk_device *ub = cmd->file->private_data;
-	unsigned tag = READ_ONCE(ub_cmd->tag);
-	unsigned q_id = READ_ONCE(ub_cmd->q_id);
+	u16 tag = READ_ONCE(ub_cmd->tag);
+	u16 q_id = READ_ONCE(ub_cmd->q_id);
 	unsigned index = READ_ONCE(ub_cmd->addr);
 	struct ublk_queue *ubq;
 	struct ublk_io *io;
 
 	if (cmd->cmd_op == UBLK_U_IO_UNREGISTER_IO_BUF)
@@ -4155,11 +4155,12 @@ static const struct file_operations ublk_ch_batch_io_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
 static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	int size, i;
+	int size;
+	u16 i;
 
 	size = ublk_queue_cmd_buf_size(ub);
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -4176,22 +4177,22 @@ static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 		ublk_io_evts_deinit(ubq);
 
 	kvfree(ubq);
 }
 
-static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
+static void ublk_deinit_queue(struct ublk_device *ub, u16 q_id)
 {
 	struct ublk_queue *ubq = ub->queues[q_id];
 
 	if (!ubq)
 		return;
 
 	__ublk_deinit_queue(ub, ubq);
 	ub->queues[q_id] = NULL;
 }
 
-static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
+static int ublk_get_queue_numa_node(struct ublk_device *ub, u16 q_id)
 {
 	unsigned int cpu;
 
 	/* Find first CPU mapped to this queue */
 	for_each_possible_cpu(cpu) {
@@ -4200,18 +4201,19 @@ static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
 	}
 
 	return NUMA_NO_NODE;
 }
 
-static int ublk_init_queue(struct ublk_device *ub, int q_id)
+static int ublk_init_queue(struct ublk_device *ub, u16 q_id)
 {
-	int depth = ub->dev_info.queue_depth;
+	u16 depth = ub->dev_info.queue_depth;
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size, i, ret;
+	int size, ret;
+	u16 i;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
 
 	/* Allocate queue structure on local NUMA node */
@@ -4252,19 +4254,20 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	return ret;
 }
 
 static void ublk_deinit_queues(struct ublk_device *ub)
 {
-	int i;
+	u16 i;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_deinit_queue(ub, i);
 }
 
 static int ublk_init_queues(struct ublk_device *ub)
 {
-	int i, ret;
+	int ret;
+	u16 i;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		ret = ublk_init_queue(ub, i);
 		if (ret)
 			goto fail;
@@ -5158,11 +5161,11 @@ static int ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_
 	return ret;
 }
 
 struct count_busy {
 	const struct ublk_queue *ubq;
-	unsigned int nr_busy;
+	u16 nr_busy;
 };
 
 static bool ublk_count_busy_req(struct request *rq, void *data)
 {
 	struct count_busy *idle = data;
@@ -5196,12 +5199,11 @@ static int ublk_wait_for_idle_io(struct ublk_device *ub,
 	 */
 	if (ublk_dev_support_batch_io(ub))
 		return 0;
 
 	while (elapsed < timeout_ms && !signal_pending(current)) {
-		unsigned int queues_cancelable = 0;
-		int i;
+		u16 i, queues_cancelable = 0;
 
 		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 			struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
 			queues_cancelable += !!ubq_has_idle_io(ubq);
-- 
2.54.0

