Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB43859D1
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653090; cv=none; b=CR//bH1YJsuxSlighQ/Kybq0u1MvU21iltTIMPGjV+BzuyixvuwitDxNBaGJk+veTo2UF4wAZm4fxIx9iG8uCy+3ya8rRP6uoK0atIjl3v2LPatggCdjFyjWVmbh5Xm0kXavObpyTCsVM2/BUyiI+yaeqL1ZOoy7GAGMgOLbUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653090; c=relaxed/simple;
	bh=8uFl4BiEAWzwUnaW0z5ea2WrHrmRxA8OYTGN5rE/GBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eVGvkpwwrKxKzAz4SRuUCE8zzTz3t2ncVoG/VwLmGz8PvDxg1M7AejehjOd/ET0VvJw3yleOblQPyEH4wyBNsapaQPzpSmuP5K1gGxMbQSxwt5+HT7UMro/vydx3Yxl3TRm1tOjmGlV9Go4H5OJ9svhdxSCzlQJnUBJx6Kw5vjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvO+jJqZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvO+jJqZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adff872068so19217455ad.1
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773653088; x=1774257888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tcw4oEHn1shvNWbj1hEeDKt4rou0ix5KeX5IhU3uCQI=;
        b=cvO+jJqZc/XXme1+pKOm+LfIS7yr4A0hiDbY/lWkVTNWeLwTgHsHtM0Hx0YGXAA4IZ
         cDFUnWA7FPAuNBIJ538319no1lftn0Uv7/YYhFvzf1Ei+Ru9FBRAienY3XK46uA4TAHx
         tqOQ3rDydiRnSt6R87HK9KEIkdLyE5szPGnsFpkoXiwH5784jZW14oYsOpgKkwu6eRhq
         LSwFlD0+jlIEvjcJkOAR9OM2gjk72qmYbZKtVL7sgvKZhm4+ZgDABRYf3jvEIDwYvH+V
         +OzZkO7jAVkEqmuQm+ggbIaTOL8/YI0gnUjW3X8MitJz7ddf2ifJqyOw1Wl8sc+VZlQa
         +Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653088; x=1774257888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcw4oEHn1shvNWbj1hEeDKt4rou0ix5KeX5IhU3uCQI=;
        b=BbpjT35elD3epCWHfPHErQ6g+9I2qA8Nl+K/mYD7OwlEJg0xHFl1gB10mM7HNL9C+p
         3+a9nMcUKhzHjHDofdlGuBH0nNcFRnQokOFUdGACk1jK4AY2YE85yqQO7zv2NzLJAWM1
         TAzkviFnB4cP+VNE364dIOS0y8MwZ8yJFqdPd6NI9JVYC7aFlHvsNCf6mEYXV0DJwGjH
         QzwBa2mGP8Bez89YWzBPzfN21bN5QOLixg9R7PqaDq+7etJUKmaTHw41Wn6leSUKr3n1
         RbH1Bh1CYqx2VjcGeNmYQHVRwX0TayhDVqk4zQXV3ei0ibK7V0msvnP+7lbAGSrWipgD
         o4pA==
X-Gm-Message-State: AOJu0YyM8MLPMefJD5Ey1xSVYVvUiefV7ECNfGelDLuxPM9eCeDfuKI+
	4sxXG+sOCjfYTXgIzerf1scNSOm+lYIaKMxENu1inrymie3jawKAr3F2
X-Gm-Gg: ATEYQzyCYuboEeBhrI7BaXurinyv8MRA34RwKagLTuUoJm/t+A4mFHjOY4SDt6YyXC9
	yo7pSkFcNC1jx4kkJ/+yobMvQsxY249ANP0uhFVVoUOTPeKrBXWwb1msov4e0Tr/Fdp4bYai+is
	tZI11G5yjggqImgHXupiiuoTwFFi5GlLuAy30h2a9vAFfTYzSyRPY51JXWBxnTIhmDH4/S6Ssn5
	PoEMtqpG78feERUgung8BA2i4AaQg1Y+zbw3enKzYABE9pyoQU9jhXjhfiR7Lv4cfI0E+p7GCMY
	wtVMr7xpOpmGU27OYEyoXvHSqRvLsN06Ks2jRwZtpV7M+0rg6TT2TgF+ck0oWNr8d7nkr0ZBDRc
	Z/z0+C7+p9ZLwDnS4lwmZ9qLY3AWLtCB8jdHKbGm1BSdOFrow40N7/9AXMepWPmru6XB5Gfx9I5
	14g/PWiNyizU0rXUX9wZT79jbxjsb5
X-Received: by 2002:a17:903:1b63:b0:2b0:5682:6973 with SMTP id d9443c01a7336-2b056826d36mr30697845ad.19.1773653088199;
        Mon, 16 Mar 2026 02:24:48 -0700 (PDT)
Received: from lavm-prs74opxn5.. ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04e5cb3dbsm58910915ad.25.2026.03.16.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:24:47 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: efremov@linux.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	ziyuzhang201@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] floppy: annotate data-races around command_status and floppy_work_fn
Date: Mon, 16 Mar 2026 17:08:26 +0800
Message-Id: <20260316090826.2878527-1-zzzccc427@gmail.com>
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

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/block/floppy.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 92e446a64371..1da7947fe042 100644
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
+	WRITE_ONCE(command_status, command_status + 2);
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

