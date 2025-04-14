Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0C17A2FC
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629988; cv=none; b=oKnDNdpI62vU2l2M0np7ZMrCElcCPHU1VfK0Z3pgJef8IbcUdrNRF5Sj3vXhpORLEdhPXn/2gr18Nfqs77bcyFT6iO6ii/6Xodx3RkUSgmtyEhJ5TSFsYyHC58czn+0oVZ5WikiMTtZ/DIBYGwSaZfgTghB1yJGsfMswGHrqK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629988; c=relaxed/simple;
	bh=STZVdIu2l+Dcnsof9UyGM+2LCDdw4VO7eoxMPsSzh4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYjtcwcNtf7SxsRfuR1Wj/jRIgwSkowlga9o13Ngbh56svATGNIdK1pduCb4DWzsrkDtNSTYwU4TtPJdwYg1w7Des3inH7FyWXPvnAUV6NcxQpzOrK1tveTcqJuMjMOefdqhNWYPywJx7FTky8nTP5JcH+D9nD7DAU9qIQ28c3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNmpaFRa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNmpaFRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744629985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHfSMw8uGh0+G0VtyERtOGyH9JcofuJ5EmsUSUSIWYg=;
	b=KNmpaFRa3vZNprOgtDecxJCS6gpNc/LK2EUplmESfLLhdTNWmyWgr/fA2gSbAKkLMQO6md
	yk5PI7K4Ks/tsXwv8/VxobqguRo2PnoyYhDKAF60qk5N+HEFtQ1aj1EPQbvqmrmM/SRgx/
	BYdDxOGBuRzWrnGg/Adg4X6Cgq5cmrE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-v6sovVxlN4izDO1KkbVASw-1; Mon,
 14 Apr 2025 07:26:23 -0400
X-MC-Unique: v6sovVxlN4izDO1KkbVASw-1
X-Mimecast-MFC-AGG-ID: v6sovVxlN4izDO1KkbVASw_1744629982
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C15819560BB;
	Mon, 14 Apr 2025 11:26:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7142F1955BC1;
	Mon, 14 Apr 2025 11:26:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/9] ublk: improve detection and handling of ublk server exit
Date: Mon, 14 Apr 2025 19:25:47 +0800
Message-ID: <20250414112554.3025113-7-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Uday Shankar <ushankar@purestorage.com>

There are currently two ways in which ublk server exit is detected by
ublk_drv:

1. uring_cmd cancellation. If there are any outstanding uring_cmds which
   have not been completed to the ublk server when it exits, io_uring
   calls the uring_cmd callback with a special cancellation flag as the
   issuing task is exiting.
2. I/O timeout. This is needed in addition to the above to handle the
   "saturated queue" case, when all I/Os for a given queue are in the
   ublk server, and therefore there are no outstanding uring_cmds to
   cancel when the ublk server exits.

There are a couple of issues with this approach:

- It is complex and inelegant to have two methods to detect the same
  condition
- The second method detects ublk server exit only after a long delay
  (~30s, the default timeout assigned by the block layer). This delays
  the nosrv behavior from kicking in and potential subsequent recovery
  of the device.

The second issue is brought to light with the new test_generic_06 which
will be added in following patch. It fails before this fix:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 30.0611 s, 0.0 kB/s
DEAD
dd took 31 seconds to exit (>= 5s tolerance)!
generic_06 : [FAIL]

Fix this by instead detecting and handling ublk server exit in the
character file release callback. This has several advantages:

- This one place can handle both saturated and unsaturated queues. Thus,
  it replaces both preexisting methods of detecting ublk server exit.
- It runs quickly on ublk server exit - there is no 30s delay.
- It starts the process of removing task references in ublk_drv. This is
  needed if we want to relax restrictions in the driver like letting
  only one thread serve each queue

There is also the disadvantage that the character file release callback
can also be triggered by intentional close of the file, which is a
significant behavior change. Preexisting ublk servers (libublksrv) are
dependent on the ability to open/close the file multiple times. To
address this, only transition to a nosrv state if the file is released
while the ublk device is live. This allows for programs to open/close
the file multiple times during setup. It is still a behavior change if a
ublk server decides to close/reopen the file while the device is LIVE
(i.e. while it is responsible for serving I/O), but that would be highly
unusual. This behavior is in line with what is done by FUSE, which is
very similar to ublk in that a userspace daemon is providing services
traditionally provided by the kernel.

With this change in, the new test (and all other selftests, and all
ublksrv tests) pass:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.0376731 s, 0.0 kB/s
DEAD
generic_04 : [PASS]

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 231 ++++++++++++++++++++++-----------------
 1 file changed, 131 insertions(+), 100 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b68bd4172fa8..e02f205f6da4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -199,8 +199,6 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
-
-	struct work_struct	nosrv_work;
 };
 
 /* header of ublk_params */
@@ -209,8 +207,9 @@ struct ublk_params_header {
 	__u32	types;
 };
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
-
+static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
+static void __ublk_quiesce_dev(struct ublk_device *ub);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		struct ublk_queue *ubq, int tag, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
@@ -1336,8 +1335,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	unsigned int nr_inflight = 0;
-	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
@@ -1348,26 +1345,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
-		return BLK_EH_RESET_TIMER;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
-			nr_inflight++;
-	}
-
-	/* cancelable uring_cmd can't help us if all commands are in-flight */
-	if (nr_inflight == ubq->q_depth) {
-		struct ublk_device *ub = ubq->dev;
-
-		if (ublk_abort_requests(ub, ubq)) {
-			schedule_work(&ub->nosrv_work);
-		}
-		return BLK_EH_DONE;
-	}
-
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -1525,13 +1502,112 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	ub->nr_privileged_daemon = 0;
 }
 
+static struct gendisk *ublk_get_disk(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+
+	spin_lock(&ub->lock);
+	disk = ub->ub_disk;
+	if (disk)
+		get_device(disk_to_dev(disk));
+	spin_unlock(&ub->lock);
+
+	return disk;
+}
+
+static void ublk_put_disk(struct gendisk *disk)
+{
+	if (disk)
+		put_device(disk_to_dev(disk));
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	struct gendisk *disk;
+	int i;
+
+	/*
+	 * disk isn't attached yet, either device isn't live, or it has
+	 * been removed already, so we needn't to do anything
+	 */
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		goto out;
+
+	/*
+	 * All uring_cmd are done now, so abort any request outstanding to
+	 * the ublk server
+	 *
+	 * This can be done in lockless way because ublk server has been
+	 * gone
+	 *
+	 * More importantly, we have to provide forward progress guarantee
+	 * without holding ub->mutex, otherwise control task grabbing
+	 * ub->mutex triggers deadlock
+	 *
+	 * All requests may be inflight, so ->canceling may not be set, set
+	 * it now.
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = true;
+		ublk_abort_queue(ub, ubq);
+	}
+	blk_mq_kick_requeue_list(disk->queue);
+
+	/*
+	 * All infligh requests have been completed or requeued and any new
+	 * request will be failed or requeued via `->canceling` now, so it is
+	 * fine to grab ub->mutex now.
+	 */
+	mutex_lock(&ub->mutex);
+
+	/* double check after grabbing lock */
+	if (!ub->ub_disk)
+		goto unlock;
+
+	/*
+	 * Transition the device to the nosrv state. What exactly this
+	 * means depends on the recovery flags
+	 */
+	blk_mq_quiesce_queue(disk->queue);
+	if (ublk_nosrv_should_stop_dev(ub)) {
+		/*
+		 * Allow any pending/future I/O to pass through quickly
+		 * with an error. This is needed because del_gendisk
+		 * waits for all pending I/O to complete
+		 */
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+			ublk_get_queue(ub, i)->force_abort = true;
+		blk_mq_unquiesce_queue(disk->queue);
+
+		ublk_stop_dev_unlocked(ub);
+	} else {
+		if (ublk_nosrv_dev_should_queue_io(ub)) {
+			/*
+			 * keep request queue as quiesced for queuing new IO
+			 * during QUIESCED state
+			 *
+			 * request queue will be unquiesced in ending
+			 * recovery, see ublk_ctrl_end_recovery
+			 */
+			__ublk_quiesce_dev(ub);
+		} else {
+			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+				ublk_get_queue(ub, i)->fail_io = true;
+		}
+		blk_mq_unquiesce_queue(disk->queue);
+	}
+unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_disk(disk);
 
 	/* all uring_cmd has been done now, reset device & ubq */
 	ublk_reset_ch_dev(ub);
-
+out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1627,37 +1703,22 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 }
 
 /* Must be called when queue is frozen */
-static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
+static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
 {
-	bool canceled;
-
 	spin_lock(&ubq->cancel_lock);
-	canceled = ubq->canceling;
-	if (!canceled)
+	if (!ubq->canceling)
 		ubq->canceling = true;
 	spin_unlock(&ubq->cancel_lock);
-
-	return canceled;
 }
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
+static void ublk_start_cancel(struct ublk_queue *ubq)
 {
-	bool was_canceled = ubq->canceling;
-	struct gendisk *disk;
-
-	if (was_canceled)
-		return false;
-
-	spin_lock(&ub->lock);
-	disk = ub->ub_disk;
-	if (disk)
-		get_device(disk_to_dev(disk));
-	spin_unlock(&ub->lock);
+	struct ublk_device *ub = ubq->dev;
+	struct gendisk *disk = ublk_get_disk(ub);
 
 	/* Our disk has been dead */
 	if (!disk)
-		return false;
-
+		return;
 	/*
 	 * Now we are serialized with ublk_queue_rq()
 	 *
@@ -1666,15 +1727,9 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	was_canceled = ublk_mark_queue_canceling(ubq);
-	if (!was_canceled) {
-		/* abort queue is for making forward progress */
-		ublk_abort_queue(ub, ubq);
-	}
+	ublk_mark_queue_canceling(ubq);
 	blk_mq_unquiesce_queue(disk->queue);
-	put_device(disk_to_dev(disk));
-
-	return !was_canceled;
+	ublk_put_disk(disk);
 }
 
 static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
@@ -1698,6 +1753,17 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
+ *
+ * Two-stage cancel:
+ *
+ * - make every active uring_cmd done in ->cancel_fn()
+ *
+ * - aborting inflight ublk IO requests in ublk char device release handler,
+ *   which depends on 1st stage because device can only be closed iff all
+ *   uring_cmd are done
+ *
+ * Do _not_ try to acquire ub->mutex before all inflight requests are
+ * aborted, otherwise deadlock may be caused.
  */
 static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -1705,8 +1771,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_device *ub;
-	bool need_schedule;
 	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
@@ -1719,16 +1783,12 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
 		return;
 
-	ub = ubq->dev;
-	need_schedule = ublk_abort_requests(ub, ubq);
+	if (!ubq->canceling)
+		ublk_start_cancel(ubq);
 
 	io = &ubq->ios[pdu->tag];
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, io, issue_flags);
-
-	if (need_schedule) {
-		schedule_work(&ub->nosrv_work);
-	}
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1779,6 +1839,7 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
+/* Now all inflight requests have been aborted */
 static void __ublk_quiesce_dev(struct ublk_device *ub)
 {
 	int i;
@@ -1787,13 +1848,11 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
 	/* mark every queue as canceling */
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->canceling = true;
 	ublk_wait_tagset_rqs_idle(ub);
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 }
 
 static void ublk_force_abort_dev(struct ublk_device *ub)
@@ -1830,50 +1889,25 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
 	return disk;
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+static void ublk_stop_dev_unlocked(struct ublk_device *ub)
+	__must_hold(&ub->mutex)
 {
 	struct gendisk *disk;
 
-	mutex_lock(&ub->mutex);
 	if (!ub->ub_disk)
-		goto unlock;
+		return;
+
 	if (ublk_nosrv_dev_should_queue_io(ub))
 		ublk_force_abort_dev(ub);
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
- unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_cancel_dev(ub);
 }
 
-static void ublk_nosrv_work(struct work_struct *work)
+static void ublk_stop_dev(struct ublk_device *ub)
 {
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, nosrv_work);
-	int i;
-
-	if (ublk_nosrv_should_stop_dev(ub)) {
-		ublk_stop_dev(ub);
-		return;
-	}
-
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
-
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		__ublk_quiesce_dev(ub);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = true;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	}
-
- unlock:
+	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
 }
@@ -2491,7 +2525,6 @@ static void ublk_remove(struct ublk_device *ub)
 	bool unprivileged;
 
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
 	ublk_put_device(ub);
@@ -2776,7 +2809,6 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2908,7 +2940,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	return 0;
 }
 
-- 
2.47.0

