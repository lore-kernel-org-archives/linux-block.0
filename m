Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E33ACEF9
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459576; cv=none; b=SSnH1FCcBlQuJBc3Mxi2A1qr8LBUpDuZUfNwXqVNhmS/a33u4fJjt7WOs3d+AB6dfljntfi4Rsyze0HzGkrFUvkSj3oFMARXLBlrnE3/O9gDZEZu3UvPke/GqF8bATNPI+FIW2YFrC+P8L85ocjrfXG8OPKqqCBo3n1Y2Kqrm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459576; c=relaxed/simple;
	bh=QsusyigYZvGLQiZSdlb+xLnhFphhI2dxm7bFiLbOMeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYWi+8MG19cnfQ8EASmsH1E8H+eMdOSi6TTLRmqhTVToXzncG/ssAiJox+9TTw0/TensE0FoyBXHHx+qx8B/9fGCaB4/sHgqdOHb/sfXZHwQu6BgY384B7Nlr9F3U6T/VybZx11o+xufOisH8lQVkejxPnBmqINjQM+0C0+Ti/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPtZdWpp; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPtZdWpp"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-81c5aac8478so1738599a34.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459573; x=1792064373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqiF4hMaOUDHr0lOLxu6QfcPt/9XdxDI99BwaagnhD0=;
        b=GPtZdWppDU876orrh5QnyklqDrXHcHYa2vZgOPx357K7JCMC/emMpv+/wqBsyrqlRS
         F3E1w+RSGEwoGL/c9LvqL2q88xgk80GW6tPyCG5JlRM6fjC2MLJfve/NbcTGBZPxRZvI
         rCdK/CrnjCvPll4eRY3kjGs0W3t9KPZeTYSfIvauyERqUXIPGsTmAd1PvOqJcZiNu1Cp
         A6UvwkAw60Zspitb8LjqFHeY0GUaNwpj6URrZ5OPYCJ8iJ5r39DYvExdU1dGcaJ56VRY
         eNqGZkV8cE12dwTAzumR5P8pJx4BvgW0y2tpBiM5loYxMSgKeeHAuGnzks9BWyIe7xLz
         A4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459573; x=1792064373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VqiF4hMaOUDHr0lOLxu6QfcPt/9XdxDI99BwaagnhD0=;
        b=mxuIXRArLX4YkFOK8N1eq+0Cn9GtnXvoI98/9fP9/JBl2VkFYbCWU4uwYnnDXxsEdz
         mCeOmgPFiTHYpcVkf44/1CwKZLpPjJ42PGNoqqqnSVJyvfj9CT8gYNeh3ul5Xr+tRDLW
         2QKK5k2ghwcHjMcLkQrlZtOZ5iFuvmOqf5KBszLb6ImzPshhGuBJvwq5YMNc6RlpuQAI
         KBFWZRYNql0E1VFuY5/s0oA0PiEKeLzSRJ0MBTZll2dOTbIWypR7BSH89zRvUzJa22FN
         VF7MKT7dbYzyfjTS5gg8I7PXOXOcylIcM5QPBPIbnM65s8E6/heankqCijLKGSkU8LvB
         ZOmA==
X-Gm-Message-State: AFuF++mskl+SY+iIWVTZYCZldtkclylneyE4cdgjRHTX61B48ZGzz8JK
	6yoCbbTRxYOy5lSCDCnd2gLKx1wyzhtdBlGAiO7AwnHL8NTCo7z2Vf3Y70r08TSo
X-Gm-Gg: AYBFou1qlp4wNwtfIFPbzjwloGqKFQRHSzZHZ0qAgMCvs5CdlFlrx5GbViR8EfSa2UT
	f8+PuH97+cjo8X2Z9o/qwoHC3ThWmaCu5xkS9iOvH3bTEPG41cjSPd0fIf7JV/6tGRQf22NIwdm
	fdwSW1YZjP1ZhEPmPyyB8yWkHsz3LiV353xv0r0mIEKWehTimxzor4cwGHjDSTlYTMLgzxvaPfa
	HkEtt044bNI6k2V/nK77NRCAHFuEaxo+vcLCRAtzod9hS7l95QMmFoOqBsmPzXR2q6xUiNRwl60
	9PyIhCkxgCZwYXwKpVdGLrQu1+brTixt+LWXamyVUexICiLELCglcv5DAlGJVylYQw+ZdZocwKe
	aRzTARnawqcsZScXzz2lZ6gzeB2sLu5QSM5zMNyNWZ0Uk9HV3Dx+uAUawEhhAfd1O8KLsJyfK5d
	KtFktQquxmlaedywnUAEjVueaxK9MTsq9KCZscL1nur9mj8w8pOqWrEF5lbNN7gYBlLPUGZB62O
	sGA4RwJnAOphtyKvo/pIuXOK4FGKw6Ewtsr9IcZlQNBDeSZOsLvaDxIpv+LSU5u/5CJvoza5Jzy
	twhbPnR1xVib0FtSyKPHxcqE2U4=
X-Received: by 2002:a05:6830:6d23:b0:814:b62d:3122 with SMTP id 46e09a7af769-82ad01bf819mr5868407a34.22.1791459573321;
        Thu, 08 Oct 2026 04:39:33 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:32 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 07/11] ublk: let STOP_DEV cancel the server's commands before its release
Date: Thu,  8 Oct 2026 06:39:03 -0500
Message-ID: <20261008113907.4000838-8-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
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

A server which opened the device but hasn't fetched is stopped too.
Document what a server sees after STOP_DEV in ublk.rst.

Fixes: 85248d670b71 ("ublk: move ublk_cancel_dev() out of ub->mutex")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 Documentation/block/ublk.rst |  7 ++++
 drivers/block/ublk_drv.c     | 80 ++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 28300fee22bf..ed3285e361ad 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -126,6 +126,13 @@ managing and controlling ublk devices with help of several control commands:
   ublk server will release resources (such as destroying I/O handler threads &
   io_uring).
 
+  If a server has ``/dev/ublkc*`` open, its fetched I/O commands complete with
+  ``UBLK_IO_RES_ABORT``. Until it closes ``/dev/ublkc*``, new
+  ``UBLK_IO_FETCH_REQ`` and ``UBLK_U_IO_PREP_IO_CMDS`` commands complete with
+  ``UBLK_IO_RES_ABORT`` too, and ``UBLK_CMD_START_DEV`` fails with ``-EBUSY``,
+  even if the server hadn't fetched anything. The device can be started again
+  by a server that opens ``/dev/ublkc*`` after that.
+
 - ``UBLK_CMD_DEL_DEV``
 
   Remove ``/dev/ublkc*``. When this command returns, the allocated ublk device
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd0c265ed20..176fbf84737c 100644
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
@@ -3026,13 +3037,54 @@ static void ublk_stop_dev_unlocked(struct ublk_device *ub)
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
@@ -3298,6 +3350,9 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 			struct ublk_io *io, u16 q_id)
 {
+	if (test_bit(UB_STATE_STOPPING, &ub->state))
+		return UBLK_IO_RES_ABORT;
+
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
 		return -EBUSY;
@@ -4476,22 +4531,27 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
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
@@ -4591,6 +4651,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
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

