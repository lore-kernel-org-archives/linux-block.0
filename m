Received: from mail-ed1-f104.google.com (mail-ed1-f104.google.com [209.85.208.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDAB1DDC32
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325475; cv=none; b=ntTjA3681yCLYrHwljsDhoKYxFrmK5dQnzdQODQVXIG4CWW9HHF860/aXafpDqHIOaik1b9cBBdmcPdeLX22OxCKtsUGjZZw+/7eWT+YRjqB0pBB3FBXyDcK+nS7glEPbWt5brNBkJlYFTBRMZIQb6pb+QU0C1racEpXdBn6ffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325475; c=relaxed/simple;
	bh=+2yeGZOGUjgWkvwGxUKH3XKuycbfw4OGi1abjQnPJdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayFgBngVG7ieavrJfeTXXelFTIirubLfNriEIM82Uk/aEp4O8TVDlrYHc5Kph916I9uNcP9YFPKHAwM+/aYJPfIf1nTNfR8PDKPG+u/WETFbvDufxcKpYhHUC6gZTqoW7vNs9JMXN2MUTwHtM4PVj7MCJAQgJu5EJcVOuScbzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PomkSCir; arc=none smtp.client-ip=209.85.208.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PomkSCir"
Received: by mail-ed1-f104.google.com with SMTP id 4fb4d7f45d1cf-5c881aa669fso5839538a12.0
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1728325472; x=1728930272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0H5UANoZHToB9rgvSi2MaCgzreFgIPa7pZTdPrm7xg=;
        b=PomkSCirmnunYHKwG3P+iNbQV0uEOqN7uAmRKSzqHi3f3Vfi0aSzEXSRBHo5E414vd
         tn1bRnimPeTdqJjjtlVDBuvkpJdTcIcV7b9N+P7P51XInUPRgelDqSt1Lah+K05q7of4
         FTUNMtRKOkVYRLPYfcmSBthcERRtr+prj5dfV7an8V6hh1UgPgjSp6XdSG560X9ygEe2
         CulmN//0ntGVUYdamr0DZAgBLQlVJLWG7qLXywyagEV3JOmu0Oed4weKj1bKof8v9Pkg
         HzPm6rJC3V3oSSWoOG7LjF8KmveAiPPcPZAwHmYhIeUSNW2MMqn/mxHDA8FnqZQXpjQ0
         R+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325472; x=1728930272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0H5UANoZHToB9rgvSi2MaCgzreFgIPa7pZTdPrm7xg=;
        b=YaRR/gNAr+5OQOCnFLJ+DQ68CgRWSzTGKQavI07R+S2ibLMhl490mQshbn22ml9/YR
         30K4FtqSVd9mP2gQcNiZ0DLOaQ53YT7ODY2SabN+mb09x8P5YZ1+syQ0/ryE4az/EFZV
         T8s/O/5YsRqmZZnJHERyH5rLoKnbtcMDUI5anSd11JdEXD2Fb8sLP6GfY+3OMGLryob1
         BUv3KbOdS11uMpwQRNj/XM3Ov5I0ucXbXG6L1f9nyoxWn7clmiKMuhl5rysEm+y5nhu5
         1PmIsCuT5O1pvmhPcvXWvx2fWYWDdQ7IyRc/5uPC+Uu2CII3KmPNp7vVUMXVtOv0xAsa
         PZsw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Iw0CkN6PWMlqqJbFJyWHd25h19UH8IcMQ7oYC/YWC/h5nHoCQQJolFDd+S9qo3MRSA9iKewsaCJmNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytF/tt88vqCSVpxmLwEbjNXTwG7tIeNDYkCiZveG9Pzz1itaW6
	RXANFEy28VIIADLBDF2qfJLNkUSl1GqsvHVrvBVZBxGVkYkPHH4bTBQQJ5QwFx7Nn9UVcbzZmJm
	9rCTPoTe3bwOddM/d3DUT0TWIF6KBg9cqW9IlmDKyCkojmvIA
X-Google-Smtp-Source: AGHT+IGNk3Y43MYHgLbF6OholHcwuUlH43K4CIEcj5UM0DVy/lYFbYONxkLL20mWRt36SwzaWT+I+DHJGmfA
X-Received: by 2002:a17:907:2cc2:b0:a99:6476:ce78 with SMTP id a640c23a62f3a-a99647705c3mr88621066b.17.1728325471502;
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-a992e784a60sm10104866b.124.2024.10.07.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 464DF3410EA;
	Mon,  7 Oct 2024 12:24:30 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4197AE41358; Mon,  7 Oct 2024 12:24:30 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 4/5] ublk: support device recovery without I/O queueing
Date: Mon,  7 Oct 2024 12:24:17 -0600
Message-Id: <20241007182419.3263186-5-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007182419.3263186-1-ushankar@purestorage.com>
References: <20241007182419.3263186-1-ushankar@purestorage.com>
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
Changes since v3 (https://lore.kernel.org/linux-block/20241002220949.3087902-5-ushankar@purestorage.com/):
- Do ub->dev_info.state = UBLK_S_DEV_FAIL_IO state update while queue is
  quiesced

 drivers/block/ublk_drv.c      | 78 ++++++++++++++++++++++++++++-------
 include/uapi/linux/ublk_cmd.h | 18 ++++++++
 2 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d5edef7bde43..60f6d86ea1e6 100644
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
@@ -714,6 +719,12 @@ static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
 	return !(ub->dev_info.flags & UBLK_F_USER_RECOVERY);
 }
 
+static inline bool ublk_dev_in_recoverable_state(struct ublk_device *ub)
+{
+	return ub->dev_info.state == UBLK_S_DEV_QUIESCED ||
+	       ub->dev_info.state == UBLK_S_DEV_FAIL_IO;
+}
+
 static void ublk_free_disk(struct gendisk *disk)
 {
 	struct ublk_device *ub = disk->private_data;
@@ -1275,6 +1286,10 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	blk_status_t res;
 
+	if (unlikely(ubq->fail_io)) {
+		return BLK_STS_TARGET;
+	}
+
 	/* fill iod to slot in io cmd buffer */
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
@@ -1625,6 +1640,7 @@ static void ublk_nosrv_work(struct work_struct *work)
 {
 	struct ublk_device *ub =
 		container_of(work, struct ublk_device, nosrv_work);
+	int i;
 
 	if (ublk_nosrv_should_stop_dev(ub)) {
 		ublk_stop_dev(ub);
@@ -1634,7 +1650,18 @@ static void ublk_nosrv_work(struct work_struct *work)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto unlock;
-	__ublk_quiesce_dev(ub);
+
+	if (ublk_nosrv_dev_should_queue_io(ub)) {
+		__ublk_quiesce_dev(ub);
+	} else {
+		blk_mq_quiesce_queue(ub->ub_disk->queue);
+		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+			ublk_get_queue(ub, i)->fail_io = true;
+		}
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	}
+
  unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
@@ -2387,8 +2414,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
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
@@ -2720,14 +2752,18 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
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
@@ -2751,6 +2787,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
+	int i;
 
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
@@ -2765,18 +2802,29 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	pr_devel("%s: queue unquiesced, dev id %d.\n",
-			__func__, header->dev_id);
-	blk_mq_kick_requeue_list(ub->ub_disk->queue);
-	ub->dev_info.state = UBLK_S_DEV_LIVE;
+
+	if (ublk_nosrv_dev_should_queue_io(ub)) {
+		ub->dev_info.state = UBLK_S_DEV_LIVE;
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+		pr_devel("%s: queue unquiesced, dev id %d.\n",
+				__func__, header->dev_id);
+		blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	} else {
+		blk_mq_quiesce_queue(ub->ub_disk->queue);
+		ub->dev_info.state = UBLK_S_DEV_LIVE;
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+			ublk_get_queue(ub, i)->fail_io = false;
+		}
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
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

