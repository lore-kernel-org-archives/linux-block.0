Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7E256C84
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806688; cv=none; b=UXBc/J7I3iITfzX++qpXIuDHPj4t2CahZkl0adW1DEKirITgECIkys0HT59Ci7Mb4O4Fj2DumyjiGqFhd5oV+GLmys2o0pwI5H22Bhp1zNa6FGjDzSVX2BVrLDiZH3avkbFNUa0h/F+NBphXgG4jTkXkZQ47m/hrKV8PQHZNmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806688; c=relaxed/simple;
	bh=zXReJ0xZtAEUbW9iN8i8XAUY9AzMK05uH0OiySwA4gI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lslsf6UMveuo9+PhQ0wHVzK1wVTljzf7kHuUnFeV/7CwzOVb4GGAiRKkvB+fhF5pByO3TGeKtKhsE+muBC4XiRqxajQ8Mhv7JFFggYrvNlr3vvrarrgFknS7hJI48hot2zM3rUaFqa0FHuvaQP/Tt2O20t1Ex4mWWMV0ZsrlRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCTUDXbz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCTUDXbz"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35b97ed057cso1910039a91.1
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773806687; x=1774411487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4ZwCltDgx8HwyT7YZYjRbDYnvxHyISfhXEjsdcFf7s=;
        b=CCTUDXbz4HERAlZE/kIJtr5gLpB1wKNJIyifecrqUbym4TQLnGA8zFtX6fDRLWG7H2
         Toq+asapNtbBVZagO1x/qxwWgToLgrkP3JZhzi1mpN3bfd4MfO89tEOs6G5n4bcshm7e
         ZStDRcKXxyTKMMTZZQX38FAo1vLn8FCMPMDxUIPVodIkDKpcLkZvkLlUYYh8fcJYgXCw
         GIh11rwZlwCqpWR2ZhbZlh+ZWr0ay7HUl7uNA88BQxV1xOiZ3Ofc9SrbtAUp5fwfN/j9
         QmzrVaubiP37ekL5aOxF2FIcvbRT4I173vStPx18O2/7RA4KzwB+VaFj5LLpaS8NAajw
         AQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773806687; x=1774411487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4ZwCltDgx8HwyT7YZYjRbDYnvxHyISfhXEjsdcFf7s=;
        b=SUqpaLMewRjyW2vHeDMs4kklu8jX10muk5fRY5WxmnateSmhtWOBi44bjA78vPCsln
         m01UikXvxkPpPxWCYd+6Es3F3oCOLpW2I7PZYLoRtXxG75unqjOKiYraVNG/Nnn54sl7
         SbRwl4He50FOtJ97MNKnPftYygTQSFaN6Ykm9ibMK7EHhFjeen51oBgHr6GUdoE/23vS
         isR70aaxc/rcQzy8CKiwvm8C3uRREMqU4R4vrU5yULoyhMxhd5pxPHWBZVStFe1m8qdz
         kE+/iPWuSp230HWAxPtFgi7C1h57YDbn0ZScacd0E8aokCf7sza8xhvVMLX2u4rfeeh9
         ax7Q==
X-Gm-Message-State: AOJu0YwN+HLmkmTsbIHRr7fVOE3im+weYxYrsf/qI18PW6+sv+Ko27Ui
	BnVQodWrWc5BvhJxqzdANiGte9mb68oBVDE4xdUyC7vvy4KZEcARtUTe
X-Gm-Gg: ATEYQzxLW3JUxazNkci/jXWVIWAWFFuz0q8BQ4WytjvPPdykZSA14OIUTppd9A8NH5t
	ir/dx3pluJKNDXwTzbLLO9X4i53tYxspgj3WX51gUIjVhi/+O2IIiihYeZRuZstNPPN+KFjfZ64
	Wui1CgEs9bKjFKUXGWKqZ2VsvFVlP1wCyVvrIBmZPPHiliLfGBVq6X6rCTjfDLDbXENL+i6xXdI
	nyJmKFr7zmoz0wieTC2FepOKPeK8t9auWvjKUezu8ucergy4SUA1rGQw7t7knE77JLImq06QxkY
	QGvG+F7NilZWPu4MIoKKQHPB3PJbDp4jmhsKX5jojvkHutUgj1UKLe331HTHQA9DbLQifR3KjBt
	bsySv0ckQQP7BSTytusCqO/VgJDJe+UaOn24KzOdsrJ+hwKYkefoWtxjG0HUaCOY3zIGToO1urq
	SRIPOazPAnbWeblFQzQW0oocFL3Cvw
X-Received: by 2002:a17:90b:2e49:b0:34e:63c1:4a08 with SMTP id 98e67ed59e1d1-35bb9ef60abmr1389724a91.20.1773806686531;
        Tue, 17 Mar 2026 21:04:46 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bba5b8606sm924354a91.14.2026.03.17.21.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 21:04:46 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: efremov@linux.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH v2] floppy: annotate data-races around command_status and floppy_work_fn
Date: Wed, 18 Mar 2026 11:48:10 +0800
Message-Id: <20260318034810.3089217-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

command_status is accessed by multiple contexts:
 - generic_done() and do_wakeup() write it from the floppy
   workqueue context.
 - wait_til_done() reads it in wait_event conditions without
   holding fdc_busy.
 - is_alive() reads it locklessly to check driver liveness.
 - floppy_queue_rq(), lock_fdc(), and unlock_fdc() write it
   during FDC ownership transitions.

There is currently no LKMM annotation for these concurrent accesses
since command_status relies on the deprecated volatile qualifier.
Remove volatile and use READ_ONCE()/WRITE_ONCE() on every access
to command_status to provide proper LKMM data-race annotations.

Also annotate floppy_work_fn with WRITE_ONCE() in schedule_bh()
and READ_ONCE() in floppy_work_workfn(), and current_type[drive]
with READ_ONCE() in drive_no_geom() where it can be read without
holding the FDC lock.

The races were found by our tools:

 1) command_status: generic_done (write) vs wait_til_done (read)

  ============ DATARACE ============
  Function: generic_done+0x54/0xa0 drivers/block/floppy.c:985
  Function: success_and_wakeup+0xeb/0x1e0 drivers/block/floppy.c:2046
  Function: setup_rw_floppy+0x15dc/0x1d80 drivers/block/floppy.c:1046
  Function: floppy_ready+0x2630/0x4000
  Function: floppy_work_workfn+0x56/0x70 drivers/block/floppy.c:1012
  Function: process_one_work kernel/workqueue.c:3236 [inline]
  Function: process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
  ============OTHER_INFO============
  Function: wait_til_done+0x134/0x740 drivers/block/floppy.c:2026
  Function: poll_drive+0x1fa/0x2a0
  Function: fd_ioctl+0x13c8/0x1da0 drivers/block/floppy.c:3873
  Function: blkdev_ioctl+0x421/0x510 block/ioctl.c:705
  Function: vfs_ioctl fs/ioctl.c:51 [inline]
  Function: __do_sys_ioctl fs/ioctl.c:598 [inline]
  Function: __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
  =================END==============

 2) current_type[drive]: drive_no_geom (read) vs set_geometry (write)

  ============ DATARACE ============
  Function: drive_no_geom drivers/block/floppy.c:606 [inline]
  Function: floppy_check_events+0x9c9/0xcf0 drivers/block/floppy.c:4187
  Function: disk_check_events+0xca/0x4d0 block/disk-events.c:193
  Function: process_one_work kernel/workqueue.c:3236 [inline]
  Function: process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
  Function: worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
  Function: kthread+0x3d4/0x800 kernel/kthread.c:463
  ============OTHER_INFO============
  Function: set_geometry+0xe1d/0x1980 drivers/block/floppy.c:2237
  Function: fd_ioctl+0xff4/0x1da0 drivers/block/floppy.c:3912
  Function: blkdev_ioctl+0x421/0x510 block/ioctl.c:705
  Function: vfs_ioctl fs/ioctl.c:51 [inline]
  Function: __do_sys_ioctl fs/ioctl.c:598 [inline]
  Function: __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
  =================END==============

 3) floppy_work_fn: schedule_bh (write) vs
    floppy_interrupt->schedule_bh (write)

  ============ DATARACE ============
  Function: schedule_bh drivers/block/floppy.c:1005 [inline]
  Function: do_wakeup+0x19c/0x220 drivers/block/floppy.c:3219
  Function: success_and_wakeup+0x192/0x1e0 drivers/block/floppy.c:1994
  Function: setup_rw_floppy+0x15dc/0x1d80 drivers/block/floppy.c:1046
  Function: floppy_ready+0x2630/0x4000
  Function: floppy_work_workfn+0x56/0x70 drivers/block/floppy.c:1012
  Function: process_one_work kernel/workqueue.c:3236 [inline]
  Function: process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
  ============OTHER_INFO============
  Function: floppy_interrupt+0xbf4/0x1220
  Function: floppy_hardint+0x432/0x630
  Function: __handle_irq_event_percpu+0x10a/0x5d0 kernel/irq/handle.c:158
  Function: handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:210
  Function: handle_edge_irq+0x223/0x9f0 kernel/irq/chip.c:855
  =================END==============

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/block/floppy.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 92e446a64371..cf8246e7155e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -502,7 +502,7 @@ static int probing;
 #define FD_COMMAND_ERROR	2
 #define FD_COMMAND_OKAY		3
 
-static volatile int command_status = FD_COMMAND_NONE;
+static int command_status = FD_COMMAND_NONE;
 static unsigned long fdc_busy;
 static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
 static DECLARE_WAIT_QUEUE_HEAD(command_done);
@@ -601,7 +601,8 @@ static inline void fdc_outb(unsigned char value, int fdc, int reg)
 
 static inline bool drive_no_geom(int drive)
 {
-	return !current_type[drive] && !ITYPE(drive_state[drive].fd_device);
+	return !READ_ONCE(current_type[drive]) &&
+	       !ITYPE(drive_state[drive].fd_device);
 }
 
 #ifndef fd_eject
@@ -640,7 +641,7 @@ static const char *timeout_message;
 static void is_alive(const char *func, const char *message)
 {
 	/* this routine checks whether the floppy driver is "alive" */
-	if (test_bit(0, &fdc_busy) && command_status < 2 &&
+	if (test_bit(0, &fdc_busy) && READ_ONCE(command_status) < 2 &&
 	    !delayed_work_pending(&fd_timeout)) {
 		DPRINT("%s: timeout handler died.  %s\n", func, message);
 	}
@@ -892,7 +893,7 @@ static int lock_fdc(int drive)
 	if (wait_event_interruptible(fdc_wait, !test_and_set_bit(0, &fdc_busy)))
 		return -EINTR;
 
-	command_status = FD_COMMAND_NONE;
+	WRITE_ONCE(command_status, FD_COMMAND_NONE);
 
 	reschedule_timeout(drive, "lock fdc");
 	set_fdc(drive);
@@ -906,7 +907,7 @@ static void unlock_fdc(void)
 		DPRINT("FDC access conflict!\n");
 
 	raw_cmd = NULL;
-	command_status = FD_COMMAND_NONE;
+	WRITE_ONCE(command_status, FD_COMMAND_NONE);
 	cancel_delayed_work(&fd_timeout);
 	do_floppy = NULL;
 	cont = NULL;
@@ -990,7 +991,9 @@ static void (*floppy_work_fn)(void);
 
 static void floppy_work_workfn(struct work_struct *work)
 {
-	floppy_work_fn();
+	void (*fn)(void) = READ_ONCE(floppy_work_fn);
+
+	fn();
 }
 
 static DECLARE_WORK(floppy_work, floppy_work_workfn);
@@ -999,7 +1002,7 @@ static void schedule_bh(void (*handler)(void))
 {
 	WARN_ON(work_pending(&floppy_work));
 
-	floppy_work_fn = handler;
+	WRITE_ONCE(floppy_work_fn, handler);
 	queue_work(floppy_wq, &floppy_work);
 }
 
@@ -1864,7 +1867,7 @@ static void show_floppy(int fdc)
 
 	pr_info("cont=%p\n", cont);
 	pr_info("current_req=%p\n", current_req);
-	pr_info("command_status=%d\n", command_status);
+	pr_info("command_status=%d\n", READ_ONCE(command_status));
 	pr_info("\n");
 }
 
@@ -1991,7 +1994,7 @@ static void do_wakeup(void)
 {
 	reschedule_timeout(MAXTIMEOUT, "do wakeup");
 	cont = NULL;
-	command_status += 2;
+	WRITE_ONCE(command_status, READ_ONCE(command_status) + 2);
 	wake_up(&command_done);
 }
 
@@ -2019,11 +2022,12 @@ static int wait_til_done(void (*handler)(void), bool interruptible)
 	schedule_bh(handler);
 
 	if (interruptible)
-		wait_event_interruptible(command_done, command_status >= 2);
+		wait_event_interruptible(command_done,
+					 READ_ONCE(command_status) >= 2);
 	else
-		wait_event(command_done, command_status >= 2);
+		wait_event(command_done, READ_ONCE(command_status) >= 2);
 
-	if (command_status < 2) {
+	if (READ_ONCE(command_status) < 2) {
 		cancel_activity();
 		cont = &intr_cont;
 		reset_fdc();
@@ -2031,18 +2035,18 @@ static int wait_til_done(void (*handler)(void), bool interruptible)
 	}
 
 	if (fdc_state[current_fdc].reset)
-		command_status = FD_COMMAND_ERROR;
-	if (command_status == FD_COMMAND_OKAY)
+		WRITE_ONCE(command_status, FD_COMMAND_ERROR);
+	if (READ_ONCE(command_status) == FD_COMMAND_OKAY)
 		ret = 0;
 	else
 		ret = -EIO;
-	command_status = FD_COMMAND_NONE;
+	WRITE_ONCE(command_status, FD_COMMAND_NONE);
 	return ret;
 }
 
 static void generic_done(int result)
 {
-	command_status = result;
+	WRITE_ONCE(command_status, result);
 	cont = &wakeup_cont;
 }
 
@@ -2873,7 +2877,7 @@ static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
 	list_add_tail(&bd->rq->queuelist, &floppy_reqs);
 	spin_unlock_irq(&floppy_lock);
 
-	command_status = FD_COMMAND_NONE;
+	WRITE_ONCE(command_status, FD_COMMAND_NONE);
 	__reschedule_timeout(MAXTIMEOUT, "fd_request");
 	set_fdc(0);
 	process_fd_request();
-- 
2.34.1

