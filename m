Received: from mail-ot1-f101.google.com (mail-ot1-f101.google.com [209.85.210.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E884C7E
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532537; cv=none; b=WJL6dMRi4OpQ1q+KvRSmltesaeEs93BlkQlKfgio3RprGVUqFTgYBAV1gnfC4riBlMPdAURh4XBMNFOiB3MVoPyHQGL8wSPrP8ty+f8GGHfrJ4LP7q49aw9dA2HtLRY6t/IQnF91AMTPNoW4+c1MPTIxGrKazXOV/G5y3d7SUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532537; c=relaxed/simple;
	bh=denZ3I4baDt0qOPYcBDwVMkE8nOZHdysFCSIBVHg+DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2mbmB8Oq+vaHVTUEadtQKI1s0CTWwX1grXr5K9gV04uIxnZBB/kdrkdwlPmtJFdotTe0jS2OjzxQTrq1zeESNeQ2vqN9ridN8Cd30VYom9JvO5cmonQgK89VGyJV71L7Q3dvdeEsxT253RIm35OByKz9KCkPw8Yaqy5qqCb4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fkzK0+13; arc=none smtp.client-ip=209.85.210.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fkzK0+13"
Received: by mail-ot1-f101.google.com with SMTP id 46e09a7af769-712422564aaso854051a34.0
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726532534; x=1727137334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY20McgVt8zeEokl2t4x+9nKjS7C2srtz41PtEnI54U=;
        b=fkzK0+13Vvzi/nzQr09lYAGjqotXT86p4TcZZG7GrzPXkBqdQhY56NaIGLj7SNRsPj
         uG3GnhtJq2bsC+mtuYeGX++39GXbPLpa6Cg1oh5rONVO83Hap3MGeFXoYT/8zrgQ3sqU
         RVmhUAXP/Va4wLtr1zba7TBvcDpGwsEwdJpODm6SmLo7HqRu692NM/oSwXOP2AdpuGL4
         Qo+tt6w7qxBVBXyFj3ui5nuxIp7pXM7TxtNTkkfPJ2Q4V37+AcHViKmh+iefecFIF4Lz
         8XTayHv4nKT7I8HJjgt+eYqmJh/zSqWyv7tYJEn5xVLgc6QSkr45k7XqAG+7/VsASFID
         V2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532534; x=1727137334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BY20McgVt8zeEokl2t4x+9nKjS7C2srtz41PtEnI54U=;
        b=IEg5enu93fwGQ53ueK3zHLQ4H93TNVpzIK57dVblpiFNXLRwCfDkK2ldtNDuEgIDS9
         MaBwLy03D0LF2/GiRyLza/Ni2xeov35/ShcJYtaAbn2S3HghI51e8JOBoAqnnLRrRQsW
         ORZw+re6AaM2kF3zGjyGmXuiL4A24r7A+yLjlFrZNbluxD5CXxsfsHsjdLfNBQ7Q8yES
         3TgrCMC2p3kH/cmd5qZPO9u0S3M7eavD7owbvj3DHianQ2eKwyT7F5v+kVo15TOzP19t
         n4OTGuRkG9DiWcjJrizoKQXsviQKSe+ldbpWJJ2Q2otsSxB+ZLT8k42pQ8imHqpkj5XM
         F73A==
X-Forwarded-Encrypted: i=1; AJvYcCWvMajeBJGcAhjfESEZ85oDsjfrGxDeW6xS/eo2rNZ/T7rg4eG6qqCTynt6frFwlbmX8iiZtg2zLVTGzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5D6hroLqr+rrzXCGV5Gy+nlKMpyej5/8573wNNSbzH32TnAj
	URap7spMpEJSRLTIPCmwCpjFDuFrmr3H7IElVrhp3yUrniB+WJlwaSO8cNAyWIKdlpV2CaQtlZ8
	BW0OBrTK4dZS7svD+bIbtar3PN6B8cUpZ2Ua/hIbXeLbGZPdq
X-Google-Smtp-Source: AGHT+IHwbZX3irZ9m7OfbpFZ+PKysC3F0tonUD/m9v/FWeMtAJuh26gZyQaVX1n3QlpRMsk4HO5fsDKU0Yqy
X-Received: by 2002:a05:6870:219b:b0:260:25ef:c5a0 with SMTP id 586e51a60fabf-27c3e88dc51mr8626114fac.5.1726532534006;
        Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-27c9598f99fsm268567fac.48.2024.09.16.17.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:22:13 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7B633342244;
	Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 74A18E40F10; Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 4/4] ublk: support device recovery without I/O queueing
Date: Mon, 16 Sep 2024 18:21:55 -0600
Message-Id: <20240917002155.2044225-5-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240917002155.2044225-1-ushankar@purestorage.com>
References: <20240917002155.2044225-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk currently supports the following behaviors on ublk server exit:

A: outstanding I/Os get errors, subsequently issued I/Os get errors
B: outstanding I/Os get errors, subsequently issued I/Os queue
C: outstanding I/Os get reissued, subsequently issued I/Os queue

and the following behaviors for recovery of preexisting block devices by
a future incarnation of the ublk server:

1: ublk devices stopped on ublk server exit (no recovery possible)
2: ublk devices are recoverable using start/end_recovery commands

The userspace interface allows selection of combinations of these
behaviors using flags specified at device creation time, namely:

default behavior: A + 1
UBLK_F_USER_RECOVERY: B + 2
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

The behavior A + 2 is currently unsupported. Add support for this
behavior under the new flag combination
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_FAIL_IO.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes since v1 (https://lore.kernel.org/linux-block/20240617194451.435445-5-ushankar@purestorage.com/):
- Change flag name from UBLK_F_USER_RECOVERY_NOQUEUE to
  UBLK_F_USER_RECOVERY_FAIL_IO
- Require UBLK_F_USER_RECOVERY to be set along with the new flag for it
  to be effective. This makes more sense, as UBLK_F_USER_RECOVERY
  essentially selects behavior 2 above (and not setting
  UBLK_F_USER_RECOVERY selects behavior 1).
- Add per-ublk-queue flag which is true iff device state is
  UBLK_S_DEV_FAIL_IO. This lets us avoid fetching the device in the fast
  path.

 drivers/block/ublk_drv.c      | 75 ++++++++++++++++++++++++++++-------
 include/uapi/linux/ublk_cmd.h | 18 +++++++++
 2 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c7a0493b3545..548043eeefb9 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -60,10 +60,12 @@
 		| UBLK_F_UNPRIVILEGED_DEV \
 		| UBLK_F_CMD_IOCTL_ENCODE \
 		| UBLK_F_USER_COPY \
-		| UBLK_F_ZONED)
+		| UBLK_F_ZONED \
+		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE)
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
@@ -146,6 +148,7 @@ struct ublk_queue {
 	bool force_abort;
 	bool timeout;
 	bool canceling;
+	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	unsigned short nr_io_ready;	/* how many ios setup */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
@@ -690,7 +693,8 @@ static inline bool ublk_nosrv_should_reissue_outstanding(struct ublk_device *ub)
  */
 static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
 {
-	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
+	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
+	       !(ub->dev_info.flags & UBLK_F_USER_RECOVERY_FAIL_IO);
 }
 
 /*
@@ -700,7 +704,8 @@ static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
  */
 static inline bool ublk_nosrv_should_queue_io(struct ublk_queue *ubq)
 {
-	return ubq->flags & UBLK_F_USER_RECOVERY;
+	return (ubq->flags & UBLK_F_USER_RECOVERY) &&
+	       !(ubq->flags & UBLK_F_USER_RECOVERY_FAIL_IO);
 }
 
 /*
@@ -712,7 +717,14 @@ static inline bool ublk_nosrv_should_queue_io(struct ublk_queue *ubq)
 static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
 {
 	return (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY)) &&
-	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE));
+	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE)) &&
+	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_FAIL_IO));
+}
+
+static inline bool ublk_dev_in_recoverable_state(struct ublk_device *ub)
+{
+	return ub->dev_info.state == UBLK_S_DEV_QUIESCED ||
+	       ub->dev_info.state == UBLK_S_DEV_FAIL_IO;
 }
 
 static void ublk_free_disk(struct gendisk *disk)
@@ -1276,6 +1288,10 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	blk_status_t res;
 
+	if (unlikely(ubq->fail_io)) {
+		return BLK_STS_TARGET;
+	}
+
 	/* fill iod to slot in io cmd buffer */
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
@@ -1626,6 +1642,7 @@ static void ublk_nosrv_work(struct work_struct *work)
 {
 	struct ublk_device *ub =
 		container_of(work, struct ublk_device, nosrv_work);
+	int i;
 
 	if (ublk_nosrv_should_stop_dev(ub)) {
 		ublk_stop_dev(ub);
@@ -1635,7 +1652,18 @@ static void ublk_nosrv_work(struct work_struct *work)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto unlock;
-	__ublk_quiesce_dev(ub);
+
+	if (ublk_nosrv_dev_should_queue_io(ub)) {
+		__ublk_quiesce_dev(ub);
+	} else {
+		blk_mq_quiesce_queue(ub->ub_disk->queue);
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+			ublk_get_queue(ub, i)->fail_io = true;
+		}
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+	}
+
  unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
@@ -2389,8 +2417,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		return -EPERM;
 
 	/* forbid nonsense combinations of recovery flags */
-	if ((info.flags & UBLK_F_USER_RECOVERY_REISSUE) &&
-	    !(info.flags & UBLK_F_USER_RECOVERY)) {
+	switch (info.flags & UBLK_F_ALL_RECOVERY_FLAGS) {
+	case 0:
+	case UBLK_F_USER_RECOVERY:
+	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE):
+	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_FAIL_IO):
+		break;
+	default:
 		pr_warn("%s: invalid recovery flags %llx\n", __func__,
 			info.flags & UBLK_F_ALL_RECOVERY_FLAGS);
 		return -EINVAL;
@@ -2722,14 +2755,18 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	 *     and related io_uring ctx is freed so file struct of /dev/ublkcX is
 	 *     released.
 	 *
+	 * and one of the following holds
+	 *
 	 * (2) UBLK_S_DEV_QUIESCED is set, which means the quiesce_work:
 	 *     (a)has quiesced request queue
 	 *     (b)has requeued every inflight rqs whose io_flags is ACTIVE
 	 *     (c)has requeued/aborted every inflight rqs whose io_flags is NOT ACTIVE
 	 *     (d)has completed/camceled all ioucmds owned by ther dying process
+	 *
+	 * (3) UBLK_S_DEV_FAIL_IO is set, which means the queue is not
+	 *     quiesced, but all I/O is being immediately errored
 	 */
-	if (test_bit(UB_STATE_OPEN, &ub->state) ||
-			ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
+	if (test_bit(UB_STATE_OPEN, &ub->state) || !ublk_dev_in_recoverable_state(ub)) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
@@ -2753,6 +2790,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
+	int i;
 
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
@@ -2767,18 +2805,27 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 
-	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
+	if (!ublk_dev_in_recoverable_state(ub)) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
+
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		ublk_get_queue(ub, i)->fail_io = false;
+	}
 	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	pr_devel("%s: queue unquiesced, dev id %d.\n",
-			__func__, header->dev_id);
-	blk_mq_kick_requeue_list(ub->ub_disk->queue);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	if (ublk_nosrv_dev_should_queue_io(ub)) {
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+		pr_devel("%s: queue unquiesced, dev id %d.\n",
+				__func__, header->dev_id);
+		blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	}
+
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index c8dc5f8ea699..a2b3ea344639 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -147,8 +147,18 @@
  */
 #define UBLK_F_NEED_GET_DATA (1UL << 2)
 
+/*
+ * - Block devices are recoverable if ublk server exits and restarts
+ * - Outstanding I/O when ublk server exits is met with errors
+ * - I/O issued while there is no ublk server queues
+ */
 #define UBLK_F_USER_RECOVERY	(1UL << 3)
 
+/*
+ * - Block devices are recoverable if ublk server exits and restarts
+ * - Outstanding I/O when ublk server exits is reissued
+ * - I/O issued while there is no ublk server queues
+ */
 #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
 
 /*
@@ -184,10 +194,18 @@
  */
 #define UBLK_F_ZONED (1ULL << 8)
 
+/*
+ * - Block devices are recoverable if ublk server exits and restarts
+ * - Outstanding I/O when ublk server exits is met with errors
+ * - I/O issued while there is no ublk server is met with errors
+ */
+#define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
 #define UBLK_S_DEV_QUIESCED	2
+#define UBLK_S_DEV_FAIL_IO 	3
 
 /* shipped via sqe->cmd of io_uring command */
 struct ublksrv_ctrl_cmd {
-- 
2.34.1

