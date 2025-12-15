Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64914281368
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781774; cv=none; b=MPHkuzAcPAKlRYT3kzcWu6LjoHp/nDLTzeoNleqJ1Z4ej25GpYQ3R1p1QHi9053ZiQFGUb5J4odoF0HruDcbMJq+NHSDJHp7vIt9qdIWdLF6T3cXGAmox8xg4Soc3iLEDj3xW9YhEcVQp7jdnG5bwL7t+hE1VW9K11ukTEaD1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781774; c=relaxed/simple;
	bh=79opj8NZkFNg898HWB9O145CzL4VZAVxcB5xEICScLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJnSmsXnW5/8sj06qd8z/RuAFUXjm/Pupf8F/2MfZPggjvjdCpAwbM80ncLbQWVxr7YvtY1wsqBBFEwyRpzYSPKclW7wC1Y1VMB8ukFTkfXzQ4AYQfn/m3vqf2QMSoiivAh8updMK912owgfL7uhTzXjRN5HTRkhR1/7YBXbfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbpp82sR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbpp82sR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so3522517b3a.3
        for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 22:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765781772; x=1766386572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrsC/iU0zJOTYOnrS7wUECAMx+d7ilNEeIYGVhk8BXs=;
        b=Pbpp82sRIroc+951MIaYgqKcSC8XJVHiVW6wopVhP5ttaz8cMl9kSPXD7Da7hYI/JZ
         5Y8b1jh9pArFYElZkYccAVUSXcqdFSUeYCJqo8YWEjgtua2owxacdFZ4y83VgcmJtpla
         wNbf15wNDCZK86IAgWHpRszZZxOrZ943bBo48KWh8PkldHXPhSAmAobA/4GPjFjlWovz
         NsK7NoMITx7YSm3W/OEreIf6ymJAoE52qYpQuG7RF+318z2657Tjl1HKOhE76VXxJQ6D
         gW2NL9IGjufkV5EErJyYEoUbgepnN6OX079Oz/+J11ZE5m9GNOuYS8NJF4QtyRxvrltu
         kyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765781772; x=1766386572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrsC/iU0zJOTYOnrS7wUECAMx+d7ilNEeIYGVhk8BXs=;
        b=EyK1JE/dLUGcOfNcBlWUo7HSFbJbRLoMI5jRzcLpFOTQni8ZuTfke7baFiT4Mon6TJ
         hZGmmOrP2sCrBxClCbKJN0/gnuYloLmeve6kSTAexsnEc9da+sgxupjt8PCMoiQhNhvX
         LAJH+BVLj8Mk+Kw/9AG8C7D5jWLdxZSlZ7a0pQlLwevihK4p3O9vBAVrKBWsKrFdUQbe
         B/CFJgdh32pwC+rVG+TQ8AntJw1+jWq59yTwIaie7Geyi4d2167lNYSyA9noee4W097M
         x9V6i3pOMoJ0E/gzBasprQfcgqEglGULq3pkBT7AzK9Kdd3oQJHH7YIqdZuaU19li+bV
         y95A==
X-Gm-Message-State: AOJu0YwsBpDtIbPuOe9Yct4hysrh4Y+Z6vFC7YHDH03Mx3hIBFbHuiXJ
	ebEAhpK4gTSky4DWClVKN0qyoz5o4Tv7hSc9keEdx8yBUOKxnYWHlGphiIdQrIXzki4=
X-Gm-Gg: AY/fxX6fyzLjMXxNCrB1M9ZNqpOnYjoB2cc1Iuvur2yqn5FkpcHgYSsFssQJN7VGpgO
	o+evYvcFZZmZUQ06JJL1HDDD7KlRxUb45FKR9kLp9JufOF1+5mSMM4zN9IBeiwhShYdyyngKLVX
	FnAGr4aFU5gP3ekArx4ZsWT83tsXcTaOkwov5l8nMUun8rogKoUiP/n0TbuRtQaeetzmmr3p3z8
	Orw3Xa1KTtWL7L8Pi0KuyNG/DObzG5XaI097jRqCH9Fcj1/D44U5GyZMMQVF0dLrzycZbpJcJpM
	1dklwevX+TGIsRr+u2MJcdLE91TlwXDB4baOswZGdvBt6MEpZR0HprR/ItThRzf7VPY3S4BCkmD
	k+Zp1NG8ue6rSxkGyvOqPeN6gl0gud23+v5Z/0B7maD2YXc7lnhz12Az5dEGAWcocigyxqyNSpo
	87Ewp8YyUwals7hqjchEB7uaPHJn4QPqOCJ9RfZKVAQH54pwZmXxxzssDcedLYuEVfb0nY
X-Google-Smtp-Source: AGHT+IHHWaIGnuKmLID0+Cme7I2MoGVWfhDcVaenV/JEWF8fyMzjzJEqrMUKrno2AhfBPeKvqwcjEA==
X-Received: by 2002:a05:6a00:2999:b0:7e8:43f5:bd20 with SMTP id d2e1a72fcca58-7f66969f9ffmr9876944b3a.53.1765781771460;
        Sun, 14 Dec 2025 22:56:11 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22848a7sm11665027b3a.3.2025.12.14.22.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 22:56:11 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH 1/1] loop: convert lo_state to atomic_t type to ensure atomic state checks in queue_rq path
Date: Mon, 15 Dec 2025 14:54:59 +0800
Message-ID: <20251215065458.1452317-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

lo_state is currently defined as an int, which does not guarantee
atomicity for state checks. In the queue_rq path, ensuring correct state
checks requires holding lo->lo_mutex, which may increase I/O submission
latency. This patch converts lo_state to atomic_t type. The main changes
are:
1. Updates to lo_state still require holding lo->lo_mutex, since the
state must be validated before modification, and the lock ensures that
no concurrent operation can change the state.
2. Read-only accesses to lo_state no longer require holding lo->lo_mutex.

This allows atomic state checks in the queue_rq fast path while avoiding
unnecessary locking overhead.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 drivers/block/loop.c | 67 ++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 272bc608e528..bc661ecb449a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -59,7 +59,7 @@ struct loop_device {
 	gfp_t		old_gfp_mask;
 
 	spinlock_t		lo_lock;
-	int			lo_state;
+	atomic_t		lo_state;
 	spinlock_t              lo_work_lock;
 	struct workqueue_struct *workqueue;
 	struct work_struct      rootcg_work;
@@ -94,6 +94,16 @@ static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
 
+static inline int loop_device_get_state(struct loop_device *lo)
+{
+	return atomic_read(&lo->lo_state);
+}
+
+static inline void loop_device_set_state(struct loop_device *lo, int state)
+{
+	atomic_set(&lo->lo_state, state);
+}
+
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
  *
@@ -200,7 +210,7 @@ static bool lo_can_use_dio(struct loop_device *lo)
 static inline void loop_update_dio(struct loop_device *lo)
 {
 	lockdep_assert_held(&lo->lo_mutex);
-	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
+	WARN_ON_ONCE(loop_device_get_state(lo) == Lo_bound &&
 		     lo->lo_queue->mq_freeze_depth == 0);
 
 	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
@@ -495,7 +505,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 			return -EBADF;
 
 		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
-		if (l->lo_state != Lo_bound)
+		if (loop_device_get_state(l) != Lo_bound)
 			return -EINVAL;
 		/* Order wrt setting lo->lo_backing_file in loop_configure(). */
 		rmb();
@@ -563,7 +573,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (error)
 		goto out_putf;
 	error = -ENXIO;
-	if (lo->lo_state != Lo_bound)
+	if (loop_device_get_state(lo) != Lo_bound)
 		goto out_err;
 
 	/* the loop device has to be read-only */
@@ -1019,7 +1029,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		goto out_bdev;
 
 	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
+	if (loop_device_get_state(lo) != Lo_unbound)
 		goto out_unlock;
 
 	error = loop_validate_file(file, bdev);
@@ -1082,7 +1092,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	/* Order wrt reading lo_state in loop_validate_file(). */
 	wmb();
 
-	lo->lo_state = Lo_bound;
+	loop_device_set_state(lo, Lo_bound);
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
@@ -1179,7 +1189,7 @@ static void __loop_clr_fd(struct loop_device *lo)
 	if (!part_shift)
 		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 	mutex_lock(&lo->lo_mutex);
-	lo->lo_state = Lo_unbound;
+	loop_device_set_state(lo, Lo_unbound);
 	mutex_unlock(&lo->lo_mutex);
 
 	/*
@@ -1206,7 +1216,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	err = loop_global_lock_killable(lo, true);
 	if (err)
 		return err;
-	if (lo->lo_state != Lo_bound) {
+	if (loop_device_get_state(lo) != Lo_bound) {
 		loop_global_unlock(lo, true);
 		return -ENXIO;
 	}
@@ -1218,7 +1228,7 @@ static int loop_clr_fd(struct loop_device *lo)
 
 	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 	if (disk_openers(lo->lo_disk) == 1)
-		lo->lo_state = Lo_rundown;
+		loop_device_set_state(lo, Lo_rundown);
 	loop_global_unlock(lo, true);
 
 	return 0;
@@ -1235,7 +1245,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
-	if (lo->lo_state != Lo_bound) {
+	if (loop_device_get_state(lo) != Lo_bound) {
 		err = -ENXIO;
 		goto out_unlock;
 	}
@@ -1289,7 +1299,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		return ret;
-	if (lo->lo_state != Lo_bound) {
+	if (loop_device_get_state(lo) != Lo_bound) {
 		mutex_unlock(&lo->lo_mutex);
 		return -ENXIO;
 	}
@@ -1408,7 +1418,7 @@ static int loop_set_capacity(struct loop_device *lo)
 {
 	loff_t size;
 
-	if (unlikely(lo->lo_state != Lo_bound))
+	if (unlikely(loop_device_get_state(lo) != Lo_bound))
 		return -ENXIO;
 
 	size = lo_calculate_size(lo, lo->lo_backing_file);
@@ -1422,7 +1432,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 	bool use_dio = !!arg;
 	unsigned int memflags;
 
-	if (lo->lo_state != Lo_bound)
+	if (loop_device_get_state(lo) != Lo_bound)
 		return -ENXIO;
 	if (use_dio == !!(lo->lo_flags & LO_FLAGS_DIRECT_IO))
 		return 0;
@@ -1464,7 +1474,7 @@ static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
 	if (err)
 		goto abort_claim;
 
-	if (lo->lo_state != Lo_bound) {
+	if (loop_device_get_state(lo) != Lo_bound) {
 		err = -ENXIO;
 		goto unlock;
 	}
@@ -1716,16 +1726,11 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 static int lo_open(struct gendisk *disk, blk_mode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
-	int err;
-
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
+	int state = loop_device_get_state(lo);
 
-	if (lo->lo_state == Lo_deleting || lo->lo_state == Lo_rundown)
-		err = -ENXIO;
-	mutex_unlock(&lo->lo_mutex);
-	return err;
+	if (state == Lo_deleting || state == Lo_rundown)
+		return -ENXIO;
+	return 0;
 }
 
 static void lo_release(struct gendisk *disk)
@@ -1742,10 +1747,10 @@ static void lo_release(struct gendisk *disk)
 	 */
 
 	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
-		lo->lo_state = Lo_rundown;
+	if (loop_device_get_state(lo) == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
+		loop_device_set_state(lo, Lo_rundown);
 
-	need_clear = (lo->lo_state == Lo_rundown);
+	need_clear = (loop_device_get_state(lo) == Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
 
 	if (need_clear)
@@ -1858,7 +1863,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	if (lo->lo_state != Lo_bound)
+	if (loop_device_get_state(lo) != Lo_bound)
 		return BLK_STS_IOERR;
 
 	switch (req_op(rq)) {
@@ -2016,7 +2021,7 @@ static int loop_add(int i)
 	lo->worker_tree = RB_ROOT;
 	INIT_LIST_HEAD(&lo->idle_worker_list);
 	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE);
-	lo->lo_state = Lo_unbound;
+	loop_device_set_state(lo, Lo_unbound);
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -2168,13 +2173,13 @@ static int loop_control_remove(int idx)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		goto mark_visible;
-	if (lo->lo_state != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
+	if (loop_device_get_state(lo) != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
 		mutex_unlock(&lo->lo_mutex);
 		ret = -EBUSY;
 		goto mark_visible;
 	}
 	/* Mark this loop device as no more bound, but not quite unbound yet */
-	lo->lo_state = Lo_deleting;
+	loop_device_set_state(lo, Lo_deleting);
 	mutex_unlock(&lo->lo_mutex);
 
 	loop_remove(lo);
@@ -2198,7 +2203,7 @@ static int loop_control_get_free(int idx)
 		return ret;
 	idr_for_each_entry(&loop_index_idr, lo, id) {
 		/* Hitting a race results in creating a new loop device which is harmless. */
-		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
+		if (lo->idr_visible && loop_device_get_state(lo) == Lo_unbound)
 			goto found;
 	}
 	mutex_unlock(&loop_ctl_mutex);
-- 
2.43.0

