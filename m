Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D21714B3
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629986; cv=none; b=RGVhFKudyBiNKwFXyc11tLm2Fr83ReLhBnvWsljRJJVbEP1hPR6HKaI10tkMg1LRYZRMXAASGZkXAx/RZGykHyI3SR5Kk2Fx3Yql4kwa96san/XyDtVLQyifEzdVtud3HyI8ar/xvJwTgVLmR4jSp3vssFQbMeYbW2X2B2yTqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629986; c=relaxed/simple;
	bh=dJWd2/sGcVrEzzZV7FDr7edRLM0Vgn8b0SwCZTieU3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDorGY5ns20VS/5/T0f0V9VBT9oPJg+Wv3jY7KhtdhcP+HYliq9bY+jpu0amHRNtMd2Zg3kgFQDvKMtzGXr8cy9OZMJ6hBCoMuPRo0MYJY+Cs71jiTrcgo35ZSsEIWsdS2qCSeP8ileW7XO7Cpsya5IqPc+5Da9Zpx1CMv1+RFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWvgCc2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWvgCc2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744629983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmL+Ec/bMroZw8lO25Kn9AnUoxoTDehQKayZnfM7mGI=;
	b=PWvgCc2aF+MoGGMBSgQ1l4FpM/9CjHcYicbn3A72OKsRDk9c5+W4SJQwPuky28bvZM1RFs
	zjVXEEe4araJQ9FgxgxMk7jBrmogKOraLo3QU+U4PW9bTwSM10Z0cpBb3ue3SvhLyfKavW
	nWQtIHk2hKnd4H+dSrbxg2Hx2FCTUrY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-h0OBa34hOdyq8J0052sE4g-1; Mon,
 14 Apr 2025 07:26:19 -0400
X-MC-Unique: h0OBa34hOdyq8J0052sE4g-1
X-Mimecast-MFC-AGG-ID: h0OBa34hOdyq8J0052sE4g_1744629978
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5F861955BC1;
	Mon, 14 Apr 2025 11:26:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 343B1195609D;
	Mon, 14 Apr 2025 11:26:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/9] ublk: move device reset into ublk_ch_release()
Date: Mon, 14 Apr 2025 19:25:46 +0800
Message-ID: <20250414112554.3025113-6-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

ublk_ch_release() is called after ublk char device is closed, when all
uring_cmd are done, so it is perfect fine to move ublk device reset to
ublk_ch_release() from ublk_ctrl_start_recovery().

This way can avoid to grab the exiting daemon task_struct too long.

However, reset of the following ublk IO flags has to be moved until ublk
io_uring queues are ready:

- ubq->canceling

For requeuing IO in case of ublk_nosrv_dev_should_queue_io() before device
is recovered

- ubq->fail_io

For failing IO in case of UBLK_F_USER_RECOVERY_FAIL_IO before device is
recovered

- ublk_io->flags

For preventing using io->cmd

With this way, recovery is simplified a lot.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 121 +++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e0213222e3cf..b68bd4172fa8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1074,7 +1074,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 
 static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 {
-	return ubq->ubq_daemon->flags & PF_EXITING;
+	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
 }
 
 /* todo: handle partial completion */
@@ -1470,6 +1470,37 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
+static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	/* All old ioucmds have to be completed */
+	ubq->nr_io_ready = 0;
+
+	/*
+	 * old daemon is PF_EXITING, put it now
+	 *
+	 * It could be NULL in case of closing one quisced device.
+	 */
+	if (ubq->ubq_daemon)
+		put_task_struct(ubq->ubq_daemon);
+	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
+	ubq->ubq_daemon = NULL;
+	ubq->timeout = false;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		/*
+		 * UBLK_IO_FLAG_CANCELED is kept for avoiding to touch
+		 * io->cmd
+		 */
+		io->flags &= UBLK_IO_FLAG_CANCELED;
+		io->cmd = NULL;
+		io->addr = 0;
+	}
+}
+
 static int ublk_ch_open(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = container_of(inode->i_cdev,
@@ -1481,10 +1512,26 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void ublk_reset_ch_dev(struct ublk_device *ub)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	ub->nr_privileged_daemon = 0;
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
 
+	/* all uring_cmd has been done now, reset device & ubq */
+	ublk_reset_ch_dev(ub);
+
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1831,6 +1878,24 @@ static void ublk_nosrv_work(struct work_struct *work)
 	ublk_cancel_dev(ub);
 }
 
+/* reset ublk io_uring queue & io flags */
+static void ublk_reset_io_flags(struct ublk_device *ub)
+{
+	int i, j;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		/* UBLK_IO_FLAG_CANCELED can be cleared now */
+		spin_lock(&ubq->cancel_lock);
+		for (j = 0; j < ubq->q_depth; j++)
+			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
+		spin_unlock(&ubq->cancel_lock);
+		ubq->canceling = false;
+		ubq->fail_io = false;
+	}
+}
+
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	__must_hold(&ub->mutex)
@@ -1844,8 +1909,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		if (capable(CAP_SYS_ADMIN))
 			ub->nr_privileged_daemon++;
 	}
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
+
+	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+		/* now we are ready for handling ublk io request */
+		ublk_reset_io_flags(ub);
 		complete_all(&ub->completion);
+	}
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
@@ -2943,41 +3012,14 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	return ret;
 }
 
-static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
-{
-	int i;
-
-	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
-
-	/* All old ioucmds have to be completed */
-	ubq->nr_io_ready = 0;
-	/* old daemon is PF_EXITING, put it now */
-	put_task_struct(ubq->ubq_daemon);
-	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
-	ubq->ubq_daemon = NULL;
-	ubq->timeout = false;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		/* forget everything now and be ready for new FETCH_REQ */
-		io->flags = 0;
-		io->cmd = NULL;
-		io->addr = 0;
-	}
-}
-
 static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
 	int ret = -EINVAL;
-	int i;
 
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
-	if (!ub->nr_queues_ready)
-		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
 	 *
@@ -3001,12 +3043,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
-	ub->mm = NULL;
-	ub->nr_queues_ready = 0;
-	ub->nr_privileged_daemon = 0;
 	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
@@ -3019,7 +3055,6 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 {
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
-	int i;
 
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
@@ -3039,22 +3074,10 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
-
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
-	ub->dev_info.state = UBLK_S_DEV_LIVE;
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = false;
-		ubq->fail_io = false;
-	}
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	pr_devel("%s: queue unquiesced, dev id %d.\n",
-			__func__, header->dev_id);
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
-
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-- 
2.47.0

