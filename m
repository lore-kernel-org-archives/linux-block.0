Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998B4E77F7
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611711; cv=none; b=pBNffyp62JwK7OnmK7tt4fslNqydmlKMlN2DC1ubCu0ui+hMxLJ7GacrMRP+zhE5RKZQMpy+VSe8zrTTw/Vt1VlXw8t6APojbfeWUv2Qnd3O4l0DaMeGEQOpiuZUTgDk6BC858qMzM61FYl90HwD5gBrG17TscAFcm8lNX6XcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611711; c=relaxed/simple;
	bh=kwqPqWGU/lu5O5WnPDRNz7W9uJsbb9qHjsAczhFSIQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLxHedMCmwhQfUexI9IRcpKp3yLYreF/dy2Zrfz+poX7PUqbtW+FmtJqJv0plH/zpN3mwf7swsQvQha4GiVRQZHPhDTdvhQouVZ+FLuEFcmnXmS+eugzpDSqRa9Z2n7w4DHQ8tTnG8lCCWpjogmHPj41e1YCgCspHtVCt+2gx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=RZUCXPKs; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="RZUCXPKs"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886c555c5so19943197b3.0
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790611708; x=1791216508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVTg+cJ8iEwlI+g5Z3PmYvi9KtBGqHnIrE1JgGd8h38=;
        b=RZUCXPKsVCr9U2XIQ36eFxqdUpSVfi/qr/h9VJjt1JAMNNuk/ftlU8XidIkxvfv5fm
         Dh9C0+UCL29DM74mlqbeZ0Bf3ge0UQBw8rh9Z8c/cJzQNivX2Dni1u38Yz9RWxU28ggp
         A37Cxi6kh8RV9zQJt80CH1ZQfgRXwKhwpdnhRlHqE+0UfS/936A+rbrQxCSv2oeShQcl
         LQYe9DmKVW5nnoql3uVETbWk4lTJvtUkP4BFMhT71JW6e8YzU09feXai7+XZpJD7jYZc
         zKJgSR0hnjFZzLJi3tPNE6FLIrk2/EL0kH5pAmsIixel4MaK2Td32jh1eY0LGEE0dKAj
         31/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611708; x=1791216508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVTg+cJ8iEwlI+g5Z3PmYvi9KtBGqHnIrE1JgGd8h38=;
        b=fWOIWR+hxN6M93dVbqXFYNiDv7hv85CV2ZLWkp/82Y2EMwBzE1xCKnzWh0N87D8CMx
         XZ4+bgE8bU8OeApBAEoWNU448SFLuhcA75BmuQAhCHX3pTYDbsOxvgB114i1T3r7VE62
         LtX+BsFn4DWqxjdGUNzvGOX4RlkTtQtv/C3pFyEvW97DQkQ4mQ2DTgqkF/tJJZxpq/fP
         wz5P6/giyP0duYBiHvuzrDI8EBCNVaJkFaa/G1sJWeSFPtKPVKPZDWg/UpXAQbNNy3xw
         2A+LkSalv1WcoNCBS4l5kVW5c3261dmuEYK7/ug489BwOmWOZqqq+TUDOD4CMrK605iE
         2veA==
X-Gm-Message-State: AFq9FYIF3s7/keI3zTz8v9aDyWA9G5SfRxt8fGjh/KfeoycOtMAmVEAx
	4OoyJ55LDtu1HJ9Girmb7daiY+aZkpA52yES49e08QiC4PvSgMi9z9xDLnFT9DGmvXo=
X-Gm-Gg: AYBFou3b3+e7szn+UoEMtwwVnbs6A87+5CVf8AHnf2KzGsOUJMpngpA9lpoUO6HNJE4
	PKiD0DAuzyjgQEKhwJvCaz4yNALGYTU/FVc6wVluaeeoYBZ2EIJ3fMMQ31W7T2IJmzTkRbnplvd
	stanaabFNBvPalMn+1lC0exkeTgkBTstlpbW2PzPC3oeljaM7eVzGV9AJQMlFPWvXUPq6ScyTfG
	F79eQeDJKiYPyQM1GcXTRJAAr0FSmlM38ruvIR53XyGa2csJjet/wjN62QYwV9L0mhqXk8xJsOc
	YG+gaphP8sXAk3/BgCQcVMZ/oEbt5ae3DbhE8tUkDOpA9npMr7B/NK4DtmSjisWVhF464KgzUI5
	tctMNTW+q8FYuYCR+QlM8/lh/kvt/rk7hoNhQMKB4wxeJylsJ26NO2/imbhZma678y5ike9rGUA
	Zae3QNlJkjzHLsll0FwHrAm5J5invyMCsP2rIj47Pjg6QMUFdpt6gvBXoN61j7ZjV8vcQNj+swi
	noyKuBa5l3kAigL3+4sg41O9Q==
X-Received: by 2002:a05:690c:c681:b0:8a8:5721:9098 with SMTP id 00721157ae682-8a857219668mr41750367b3.20.1790611707875;
        Mon, 28 Sep 2026 09:08:27 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813fee09sm179568685a.24.2026.09.28.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:08:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 28 Sep 2026 16:00:45 +0000
Subject: [PATCH 9/9] ublk: refuse to go live over canceled io commands
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-ublk-cancel-stop-v1-9-4a4360232a46@toxicpanda.com>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790611254; l=7836;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=kwqPqWGU/lu5O5WnPDRNz7W9uJsbb9qHjsAczhFSIQ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGcSLVl7nzeCvDJvP1fgiB+ynMcfQD0XJ1tJZLVKaA3KPxQnr8qiuhuPvwb9JVcYQUx678ZcTIY
 BM5AbDh08zgA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

START_DEV on a ready device whose commands got canceled adds a disk on
which every request fails. With UBLK_F_USER_RECOVERY, unless
UBLK_F_USER_RECOVERY_FAIL_IO is set, the requests are requeued instead
and never kicked again, so the partition scan read hangs with
disk->open_mutex held until the device is stopped again or deleted.
Every opener blocks behind it. END_USER_RECOVERY on a queue which kept
->canceling marks the device live and leaves its requests parked the
same way.

A command canceled by ublk_claim_cmd() cannot be fetched again before
the queues are reinitialized: FETCH fails with -EBUSY once the device
is ready and with -EINVAL on an active io. Since commit 1133b93fc7f6
("ublk: set canceling flag even when disk is not allocated") and the
previous patches such a device keeps ->canceling set, but nothing stops
it from going live.

In ublk_ctrl_start_dev() check for that and publish ub->ub_disk in one
cancel_mutex section, so that either START_DEV sees the canceled
commands or ublk_start_cancel() sees the disk and quiesces it.

Fix by failing START_DEV and END_USER_RECOVERY with -ENODEV when a
queue is canceling or holds a command canceled after being fetched.

Fixes: 1133b93fc7f6 ("ublk: set canceling flag even when disk is not allocated")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/block/ublk.rst | 15 +++++++++--
 drivers/block/ublk_drv.c     | 63 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 28300fee22bf..05d702f66a93 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -118,7 +118,13 @@ managing and controlling ublk devices with help of several control commands:
   After the server prepares userspace resources (such as creating I/O handler
   threads & io_uring for handling ublk IO), this command is sent to the
   driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
-  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
+  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device. The command
+  fails with ``-ENODEV`` if any fetched io command got canceled meantime,
+  by ``UBLK_CMD_STOP_DEV`` or because its io_uring is gone, and the device
+  has to be deleted then. With ``UBLK_F_BATCH_IO`` it fails the same way
+  after a ``UBLK_CMD_STOP_DEV`` sent while no process had ``/dev/ublkc*``
+  open, or after the current one opened it, even if no io command had
+  been fetched yet.
 
 - ``UBLK_CMD_STOP_DEV``
 
@@ -195,7 +201,12 @@ managing and controlling ublk devices with help of several control commands:
   command is accepted after ublk device is quiesced and a new process has
   opened ``/dev/ublkc*`` and get all ublk queues be ready. When this command
   returns, ublk device is unquiesced and new I/O requests are passed to the
-  new process.
+  new process. It fails with ``-ENODEV`` if any of the new io commands got
+  canceled already, and with ``UBLK_F_BATCH_IO`` also if the cancel of a
+  ``UBLK_CMD_QUIESCE_DEV`` reached one of its queues after the old process
+  released ``/dev/ublkc*`` and before that queue got ready. The device has
+  to be deleted then, or the recovery
+  started over after the new process has closed ``/dev/ublkc*``.
 
 - user recovery feature description
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5e86405b294b..19efa13c205a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2757,6 +2757,7 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 static struct gendisk *ublk_start_cancel(struct ublk_device *ub)
 	__must_hold(&ub->cancel_mutex)
 {
+	/* sync with ublk_ctrl_start_dev() publishing the disk */
 	struct gendisk *disk = ublk_get_disk(ub);
 
 	if (ub->canceling)
@@ -2772,10 +2773,10 @@ static struct gendisk *ublk_start_cancel(struct ublk_device *ub)
 		blk_mq_unquiesce_queue(disk->queue);
 	} else {
 		/*
-		 * Disk not yet allocated by ublk_ctrl_start_dev(), so
-		 * there is no request queue and ublk_queue_rq() cannot
-		 * be running.  Just set the flag; if start_dev proceeds
-		 * later, new I/O will see canceling and be aborted.
+		 * Disk not published by ublk_ctrl_start_dev() or detached
+		 * already, so ublk_queue_rq() cannot be running.  Just set
+		 * the flag, START_DEV fails on canceled commands instead
+		 * of adding a disk on top of them.
 		 */
 		ublk_set_canceling(ub, true);
 	}
@@ -4652,11 +4653,35 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 	return ub->ublksrv_tgid == ublksrv_pid;
 }
 
+/*
+ * The commands canceled by ublk_claim_cmd() can't be fetched again
+ * before the queues are reinitialized, so a ready device must not go live
+ * while a queue is canceling or holds a command canceled after the fetch.
+ */
+static bool ublk_dev_cmds_canceled(struct ublk_device *ub)
+	__must_hold(&ub->cancel_mutex)
+{
+	u16 i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+		bool canceled;
+
+		spin_lock(&ubq->cancel_lock);
+		canceled = ubq->canceling || ublk_queue_has_canceled_io(ubq);
+		spin_unlock(&ubq->cancel_lock);
+		if (canceled)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Wait until all queues have fetched their I/O commands, and return with
- * ub->mutex held and readiness guaranteed: then every queue's ->canceling
- * is cleared. Ready may regress between wakeup and mutex_lock() (F_BATCH
- * UNPREP, daemon death), so re-check it under the mutex and wait again.
+ * ub->mutex held and readiness guaranteed. Ready may regress between wakeup
+ * and mutex_lock() (F_BATCH UNPREP, daemon death), so re-check it under the
+ * mutex and wait again. The commands may still get canceled after being
+ * fetched, callers check ublk_dev_cmds_canceled().
  */
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
 {
@@ -4691,6 +4716,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	};
 	struct gendisk *disk;
 	int ret = -EINVAL;
+	bool canceled;
 
 	if (ublksrv_pid <= 0)
 		return -EINVAL;
@@ -4776,8 +4802,20 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	disk->fops = &ub_fops;
 	disk->private_data = ub;
 
+	/*
+	 * Check and publish under cancel_mutex, so either the canceled
+	 * commands are seen here or ublk_start_cancel() sees the disk.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	canceled = ublk_dev_cmds_canceled(ub);
+	if (!canceled)
+		ub->ub_disk = disk;
+	mutex_unlock(&ub->cancel_mutex);
+	if (canceled) {
+		ret = -ENODEV;
+		goto out_put_disk;
+	}
 	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
-	ub->ub_disk = disk;
 
 	ublk_apply_params(ub);
 
@@ -4824,6 +4862,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		ublk_detach_disk(ub);
 		ublk_put_device(ub);
 	}
+out_put_disk:
 	if (ret)
 		put_disk(disk);
 out_unlock:
@@ -5350,6 +5389,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 {
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
+	bool canceled;
 
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
 		 header->dev_id);
@@ -5372,6 +5412,13 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		ret = -EBUSY;
 		goto out_unlock;
 	}
+	mutex_lock(&ub->cancel_mutex);
+	canceled = ublk_dev_cmds_canceled(ub);
+	mutex_unlock(&ub->cancel_mutex);
+	if (canceled) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 	ub->dev_info.ublksrv_pid = ub->ublksrv_tgid;
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",

-- 
2.55.0

