Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDE3B6BF0
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791691; cv=none; b=oDcVIfkpy6uMoWPBROE/6tEGZkfy2co20ESFtcpOxQWR2rhok/0WYosC22XgdUWTludH2/sjlA+9TRLxjwEUTgb/ZzwTl/wBJ1sHiIprSd2cyPvLV41X5PddrCNIm5AbbRViOQYm4+96LPzzI3k2IVGG6AL3PJii+G76q46D92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791691; c=relaxed/simple;
	bh=9acBFwHuoe1WjBcMr0Xej+GgpA3/dG8koVdNsnmmatw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2YmGzTCt/9qSTNs9GTvw2TQj0MQD7CkXDeP57xkRZOBV9sIk3c3r8yt+d5yjTvs8wFT/2+blAMh5JkNvvqoNqejjGaD7tFaXQzenEfq/TVUd3KT/fFSV6UyhOcqdRywz5cBENn9a3FqKQpGes1PCd8miC3QQThkmmijxi/fw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G1wejPQr; arc=none smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G1wejPQr"
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-4a453848173so493300b6e.1
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785791685; x=1786396485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uczeYpDC/SttNe9telPi5/5P4P2/v7kOCg4CCf1zw7s=;
        b=G1wejPQrYslJGiG4PDO4PcNu4a7nr7geQkg51aHduQhBLYccVJO0lOQmYSAkozkrMp
         bwq/JF1a7H6BNTgDpZx6l0Yo+TFkvwk4Bs97M27FFyhkkeFGIw0bGvU0Lz+EzSlUyesa
         O2OSiZ5qvrNPRE4nZBGX/i2D0tx9qbhXIrvGXhvW/mUhjVoKo1C1U3BMy2gtRho7ODD+
         2nC7U+vQU51nCuXKUhAArcbBvkmzTRFNMRVTRhTBWGSf6bVhdU9ZgnAxNh9z/PuJ8ARa
         suOGpd2U2h4i8fw5lFkm4nOK3khezMwfi9hmk+OGB8hfthJWr2g1j/W/vdiQ/y9JO5R9
         dSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791685; x=1786396485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uczeYpDC/SttNe9telPi5/5P4P2/v7kOCg4CCf1zw7s=;
        b=a4v82ev/AQAgnWudVDKgX6bFLKFjvO81dt0Mq2nL7po+QFTfnsOHx9Jge6yCRRXTCj
         stOZ70EiXIO/oBQpnLMCocwp2nza+Fwt0f3THMFyL/48oicTN83a39Oy6BmTLNyKWZVA
         LRZOgvuwoTjjXixfFyt1cQqtHV6GAm5dUB03euFFSi7lBGdY6blK5T5gR+fpr1WAGE/3
         Yvw0XIUvUpJ+HIdZZpng6I33cZ2RPpjyHNrvR5yaw+nzLQPwTSDf30TReOtykniY2VJf
         JYvHr4Ly9E282UxVN/zpp38y0R8ZkNuGNqpvhEBcaVtT5uMe4pFxDVNjLdvtboyqNvuC
         yaQQ==
X-Gm-Message-State: AOJu0Yzd+8t/vtgvr4qX2Knk6nmAKb6B2GIgrFE+tOk3oc8oJz5FaZch
	IWJ8W7K7ByZ7S3otjMbpi+e4wuEQuxxgHhbJ3foIIl++p+EZexNLdRXMSROraWcMxFVG7tCivAc
	zlv5gGTvRepPqkUW/EP+QInZhqHSx08MoJEZg
X-Gm-Gg: AR+sD12lCmM1thB2BHLNS9Q6PZJETerawSSc+zcvTzHJ5LelIa255ghkI+XS6O2duuR
	qdTfV1bjeY+k/qtAQSRTm11nWY8a6K0NltLvyYemH3tPp1PhFCMm6l6QBONqP18FtBFPB8JpDz5
	v9hjY3F6jzsp5BiLm4TWk+ZnVIxelLg7GcKxAnFiIvpivg/4S62O9/o7540qTw64KHoSkPHWVZK
	lCW0XUewnjTmnDjJUvHns53hoHJw1ww4vOiV5G6CNmserkJixEsL5p9nl6Q+p+Z4P9NnA0L/X3g
	fn0Jcmy/9/7T+TTA4M6R41b3CKOT9r1ice4BO1NF0hrRHomouOkUqtvOzYKEZoRiAfx6DdGjssd
	RSjO8QPEQy4oauAsqQJyTv8r7iv5G0IQ6
X-Received: by 2002:a05:6808:50a7:b0:496:d5:7b22 with SMTP id 5614622812f47-4af5df715e8mr12303752b6e.1.1785791685069;
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-458f6639937sm1031268fac.9.2026.08.03.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id A39C0402B3;
	Mon,  3 Aug 2026 15:14:44 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A0BB7E4041D; Mon,  3 Aug 2026 15:14:44 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/8] ublk: consistently use u16 for queue and tag numbers
Date: Mon,  3 Aug 2026 15:14:33 -0600
Message-ID: <20260803211441.2538144-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803211441.2538144-1-csander@purestorage.com>
References: <20260803211441.2538144-1-csander@purestorage.com>
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
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 80 ++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index dd5d336eba29..da88c8042db6 100644
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
@@ -1665,11 +1664,11 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
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
@@ -1776,11 +1775,11 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
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
@@ -2366,11 +2365,11 @@ static const struct blk_mq_ops ublk_batch_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	int i;
+	u16 i;
 
 	ubq->nr_io_ready = 0;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -2411,11 +2410,11 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
 static void ublk_reset_ch_dev(struct ublk_device *ub)
 {
-	int i;
+	u16 i;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
 		/* Sync with ublk_cancel_cmd() */
@@ -2483,20 +2482,20 @@ static void ublk_partition_scan_work(struct work_struct *work)
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
@@ -2525,11 +2524,11 @@ static bool ublk_check_and_reset_active_ref(struct ublk_device *ub)
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
@@ -2644,11 +2643,12 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
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
@@ -2717,11 +2717,11 @@ static void ublk_abort_batch_queue(struct ublk_device *ub,
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
@@ -2760,11 +2760,11 @@ static void ublk_start_cancel(struct ublk_device *ub)
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
@@ -2911,11 +2911,11 @@ static inline bool ublk_dev_ready(const struct ublk_device *ub)
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
@@ -2925,11 +2925,11 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
 static void ublk_cancel_dev(struct ublk_device *ub)
 {
-	int i;
+	u16 i;
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_cancel_queue(ublk_get_queue(ub, i));
 }
 
@@ -2959,11 +2959,11 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
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
@@ -3156,11 +3156,11 @@ ublk_config_io_buf(const struct ublk_device *ub, struct ublk_io *io,
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
@@ -3960,12 +3960,12 @@ static int ublk_handle_non_batch_cmd(struct io_uring_cmd *cmd,
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
@@ -4167,11 +4167,12 @@ static const struct file_operations ublk_ch_batch_io_fops = {
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
@@ -4188,22 +4189,22 @@ static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queue *ubq)
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
@@ -4212,18 +4213,19 @@ static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
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
@@ -4264,19 +4266,20 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
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
@@ -5179,11 +5182,11 @@ static int ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_
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
@@ -5217,12 +5220,11 @@ static int ublk_wait_for_idle_io(struct ublk_device *ub,
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

