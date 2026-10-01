Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7812348C6D
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859294; cv=none; b=gdjD8YnGAkXytiGo9jixzNDSSAxXElBf7TvLFimG9TFdhNX2HgrMWIlEks1dsA73DwXLaqlLQcduZwYXeVe8ezvJ4X97MnNwLjIaa2FokUNd5OeBAVvjoHWsHdIlznyO0YSENhBqAxcRXa8CW/xFS2FpBkeAto2uI80aGWd9geM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859294; c=relaxed/simple;
	bh=aD06SEw7H3rxs6TGsEYPwJZ8N+oDorxCidqfqOS5z+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcntSI3GuE4O35yOZyG99Su/E+cJZUd1Gcc7jEgN5QdOuUeIhnnPW1VCLZ66U9a33rS4dQo6DnbdLPwpYenVLWTHlOGk6pwjt/H4Oipgs2AJmZunUQ55GDkBsOAm74piVCMZtU9E8YAaqWFnCs9jZjM2pSjCA4h/h8oPRtunX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcESpxHo; arc=none smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcESpxHo"
Received: by mail-oo2-f35.google.com with SMTP id 46e09a7af769-821b8443e13so82785a34.0
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859291; x=1791464091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8+AbODICVvOoemSKuxB75iduMeIMOS5+TsJTtQICMc=;
        b=AcESpxHo2vNJ6QjTtuXBFMCAAzQEi7shF2deYy21qjxXU3dVfu99gSkahWoYpQGkil
         SRQ3VLvOLEB6l+74TNh02PKpKlWzlObx6xU03jITbmPhuSyTZgwWGGvLtf0BVZZrdQUN
         AIx1y5dZ9y1CEika7qOd1/Lk1D+sVqviTOINPwUXjUxuaQsaB4QRgc7s19xxdrUaWCLW
         osJCuX8Zpjh+0zooNAQbP1CQ6PkKwbVUHp15eWQURtbt532hc+VFTCdss9dLwmQtBML0
         kDQ4MXkPcr3FzsiROZAAF7SOx50dnXOfF1m9BRqTjeUd2QOUGfO7j3B/RWmxAgQH2KKK
         as6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859291; x=1791464091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8+AbODICVvOoemSKuxB75iduMeIMOS5+TsJTtQICMc=;
        b=q2FkKNBZ5ibnSf1TAPe0gi3ua1+ic0eTYsu7ijOE5TBx3P/dMe8ZpIPO3MtfAGDX12
         PWwaiXu3yxESr9pLbVrFm9N1e6BgYdJbu7jEjgb2MxnWqppooklKURNHKR35kNAxvaLP
         yFNo9DzclMPuxhTxW9UfYa17TjQTEF3Y6U3FcfF1CYXIG+4yyxYW7cXHeWFsvLpii6dP
         9WjvUzBF/m+Gp088kB6f5uIwr+iTg2T3Trc2Izbq7VsBV3hhkdJfxFWhFtOWWqXHIH00
         VN4/fMppCZaw62Uf95HjymV61p4llj+jXEaF/TQFHIq447PUyVvsqJi2Pp0NzfnzJt/C
         6Kdg==
X-Gm-Message-State: AFuF++kH2bt2/AOyNogiGxwXjMjJzzKJzROvy/BhMQ4MmZcItAGafRKF
	kmmKpSY+40Z0mxT3pt+itW/b3s+1on8wOFvPDjXuKJx+AkG6pHC7m1xMsC7uMw==
X-Gm-Gg: AYBFou2DVeoAW/hn1/zVtMGqtO6lBpJ6hEfu2L0cNxQcA2ulDBoFXR8U69wVX94a6p5
	ndLWh069uTefqvV8zqj07rrW6UDKplcTTpG8LnZ3u8UcNmXMQBTwLzl1Tn/42ESGBMLkyyCCzpC
	2Inz1ZhYkFXRcsxHj85AMn3tvSvd7BCBtOxSNyRVIACHGd/qLkZ+uIc5KBiTatV2oUT3oUMKIDY
	y7XlWVWKvidG3w968HFWxjy+YNtrjqtgSVctkJokjFvFQuAUTfGJ9J1MENFzZ3nYbAZpOg9Of8i
	X2hxXttZ1y1wqdarYfabWtEavblvR5EaQ5vD6dkV+mPGDh0+QzVeeSzjvfR/+4R8D0OsiUYkxXh
	HB8hQnDvgpftkQ0H0BHlR80i/mzH5sBEQg4CagBR1vBOUOWi40zRShFTSi1qf378FtAkNtg6SGa
	zGKpIdG639GpbSBOfcnCqbchgnXqlptT+CuX6b1R5rBF2DkumqGT8EnBiakMHFOPpZ1+0yRHUTK
	SVB0Ga7PgDtkgLfdK7T9v+XH4F537z5/StfMuhqfgZSRquJ+dIuUpZo/xszlwFsBUDLUMMPHt/T
	DmqerWLk12b4ww+WZ4meXZhTaDm0Vlf2GBhwRA==
X-Received: by 2002:a05:6830:91d:b0:81c:b7d6:e6e0 with SMTP id 46e09a7af769-821212811fbmr2519846a34.10.1790859291378;
        Thu, 01 Oct 2026 05:54:51 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:51 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6/8] ublk: let STOP_DEV cancel the server's commands before its release
Date: Thu,  1 Oct 2026 07:54:20 -0500
Message-ID: <20261001125422.1364260-7-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

STOP_DEV cancels the fetched commands after dropping ub->mutex, so
START_DEV and FETCH can run in between:

  STOP_DEV                          START_DEV / FETCH
  lock ub->mutex
    ublk_stop_dev_unlocked()        (not started: does nothing)
  unlock ub->mutex
                                    START_DEV goes live, schedules scan
                                    FETCH publishes a new command
  cancel_work_sync(scan)            cancels the new disk's scan
  ublk_cancel_dev()                 takes the new command: NULL io->cmd
                                    on a queue which isn't canceling

A START_DEV after STOP_DEV also goes live over the canceled commands.

Hold a reference on the server's /dev/ublkcN while canceling:

  STOP_DEV
  lock ub->mutex
    ublk_stop_dev_unlocked()
    cancel_work_sync(scan)
    server attached: take a reference on its file, set STOPPING
  unlock ub->mutex
  ublk_cancel_dev()
  drop the reference

 - STOPPING makes FETCH and PREP get UBLK_IO_RES_ABORT and START_DEV
   -EBUSY; a START_DEV or END_USER_RECOVERY waiting for the device
   to get ready wakes up too; the reset in the server's release
   clears it
 - the release can't run before the reference is dropped, so no new
   server can attach, and the cancel only meets this server's commands
 - the cancel still runs after the unlock: io_uring_cmd_done() may take
   uring_lock, under which FETCH takes ub->mutex

ublk_ch_open() saves the file in ->ch_file and ublk_ch_release() clears
it, under cancel_mutex. The release runs after the last reference is
gone, so take ours with file_ref_get(). Drop it with __fput_sync(): if
it is the last one, fput() would defer the release to this task, which
DEL_DEV then makes wait for the device to be freed.

A server which opened the device but hasn't fetched is stopped too. The
cancel callback's io->cmd check allows NULL: the cancel may take the
command meanwhile.

Fixes: 85248d670b71 ("ublk: move ublk_cancel_dev() out of ub->mutex")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 85 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 162a4d1a2e2a..f57d544c1da2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -321,6 +321,8 @@ struct ublk_device {
 #define UB_STATE_OPEN		0
 #define UB_STATE_USED		1
 #define UB_STATE_DELETED	2
+/* STOP_DEV canceled the server's commands, until its release */
+#define UB_STATE_STOPPING	3
 	unsigned long		state;
 	int			ub_number;
 
@@ -334,6 +336,8 @@ struct ublk_device {
 	u16			nr_queue_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
+	/* the open /dev/ublkcN, protected by cancel_mutex */
+	struct file *ch_file;
 	/*
 	 * A cancel started in this FETCH round. Set by ublk_set_canceling(),
 	 * cleared only by ublk_reset_ch_dev() when a new round starts. While
@@ -2406,6 +2410,9 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	filp->private_data = ub;
 	ub->ublksrv_tgid = current->tgid;
+	mutex_lock(&ub->cancel_mutex);
+	ub->ch_file = filp;
+	mutex_unlock(&ub->cancel_mutex);
 	return 0;
 }
 
@@ -2432,6 +2439,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	ub->nr_queue_ready = 0;
 	ub->unprivileged_daemons = false;
 	ub->ublksrv_tgid = -1;
+	clear_bit(UB_STATE_STOPPING, &ub->state);
 }
 
 static struct gendisk *ublk_get_disk(struct ublk_device *ub)
@@ -2635,6 +2643,9 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
 
+	mutex_lock(&ub->cancel_mutex);
+	ub->ch_file = NULL;
+	mutex_unlock(&ub->cancel_mutex);
 	/*
 	 * Grab ublk device reference, so it won't be gone until we are
 	 * really released from work function.
@@ -2896,6 +2907,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
+	struct io_uring_cmd *cur;
 	struct task_struct *task;
 	struct ublk_io *io;
 
@@ -2912,7 +2924,9 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 
 	ublk_start_cancel(ubq->dev);
 
-	WARN_ON_ONCE(io->cmd != cmd);
+	/* NULL if STOP_DEV's cancel took it meanwhile */
+	cur = READ_ONCE(io->cmd);
+	WARN_ON_ONCE(cur && cur != cmd);
 	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
@@ -3023,13 +3037,54 @@ static void ublk_stop_dev_unlocked(struct ublk_device *ub)
 	put_disk(disk);
 }
 
+static struct file *ublk_get_ch_file(struct ublk_device *ub)
+{
+	struct file *file;
+
+	mutex_lock(&ub->cancel_mutex);
+	file = ub->ch_file;
+	if (file && !file_ref_get(&file->f_ref))
+		file = NULL;
+	mutex_unlock(&ub->cancel_mutex);
+	return file;
+}
+
 static void ublk_stop_dev(struct ublk_device *ub)
 {
+	struct file *file;
+
+	/*
+	 * FETCH, PREP and START_DEV take ub->mutex. If a server has
+	 * /dev/ublkcN open, set STOPPING, which turns it away, and hold a
+	 * reference on the file: the server's release, whose reset clears
+	 * STOPPING and lets a new server attach, can't run before we drop it.
+	 * So the cancel can run after the unlock and only meets this server's
+	 * commands; it has to: io_uring_cmd_done() may take uring_lock, under
+	 * which FETCH takes ub->mutex.
+	 */
 	mutex_lock(&ub->mutex);
 	ublk_stop_dev_unlocked(ub);
-	mutex_unlock(&ub->mutex);
 	cancel_work_sync(&ub->partition_scan_work);
+	file = ublk_get_ch_file(ub);
+	if (file) {
+		/*
+		 * The server has to close /dev/ublkcN before this device can
+		 * be started again: the reset in its release clears STOPPING.
+		 */
+		set_bit(UB_STATE_STOPPING, &ub->state);
+		/* for wake_up_var() below, see wake_up_bit() */
+		smp_mb__after_atomic();
+	}
+	mutex_unlock(&ub->mutex);
+
+	/* no server: nothing to cancel */
+	if (!file)
+		return;
+
+	/* wake a START_DEV waiting for the device to get ready */
+	wake_up_var(&ub->nr_queue_ready);
 	ublk_cancel_dev(ub);
+	__fput_sync(file);
 }
 
 static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
@@ -3295,6 +3350,9 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 			struct ublk_io *io, u16 q_id)
 {
+	if (test_bit(UB_STATE_STOPPING, &ub->state))
+		return UBLK_IO_RES_ABORT;
+
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
 		return -EBUSY;
@@ -4473,22 +4531,27 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 	return ub->ublksrv_tgid == ublksrv_pid;
 }
 
+static bool ublk_dev_ready_or_stopping(const struct ublk_device *ub)
+{
+	return ublk_dev_ready(ub) || test_bit(UB_STATE_STOPPING, &ub->state);
+}
+
 /*
- * Wait until all queues have fetched their I/O commands, and return with
- * ub->mutex held and readiness guaranteed. The queues stay canceling if
- * this round saw a cancel, see ublk_queue_reset_io_flags(). Ready may
- * regress between wakeup and mutex_lock() (F_BATCH UNPREP, daemon death),
- * so re-check it under the mutex and wait again.
+ * Wait until all queues have fetched their I/O commands, or STOP_DEV set
+ * UB_STATE_STOPPING, and return with ub->mutex held. The queues stay
+ * canceling if this round saw a cancel, see ublk_queue_reset_io_flags().
+ * Ready may regress between wakeup and mutex_lock() (F_BATCH UNPREP,
+ * daemon death), so re-check it under the mutex and wait again.
  */
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
 {
 	while (true) {
 		if (wait_var_event_interruptible(&ub->nr_queue_ready,
-						 ublk_dev_ready(ub)))
+						 ublk_dev_ready_or_stopping(ub)))
 			return -EINTR;
 
 		mutex_lock(&ub->mutex);
-		if (ublk_dev_ready(ub))
+		if (ublk_dev_ready_or_stopping(ub))
 			return 0;
 		mutex_unlock(&ub->mutex);
 	}
@@ -4588,6 +4651,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		ret = -EEXIST;
 		goto out_unlock;
 	}
+	if (test_bit(UB_STATE_STOPPING, &ub->state)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
 
 	disk = blk_mq_alloc_disk(&ub->tag_set, &lim, NULL);
 	if (IS_ERR(disk)) {
-- 
2.55.0

