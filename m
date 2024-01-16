Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0B1CF92
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424306; cv=none; b=We+rjJ/yBH6KkphkIXoByeWTBzwZ6G7K1Sr1SwsW7MQh6i1jMU+WKTfUiZkheSFLdvmvPESj3BjDgHVNH9QMWekgsF0ybnP7LbkZ6NkfAYjYfB2g4kH8NUyT7krEoEqVUivIrfrmhQpBp7Os5xOK0d+vWGEP945Ur+BkgoDlsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424306; c=relaxed/simple;
	bh=7SLxeynCNIOGxfRnllxkpIfue8vzgpQqvWGeqPpIRp8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=EwT8N+iNKZguMXA/9HrxFRGkDaMkZ88sIuYHviuVmNcq0bWt6uyE8IbIAw4wk8UvOs1yLISwBG1MOrw9jCiR9D78hPn/99w1+t9zLVsWStU59NwDbX4mFlLfEaIPzKHKVvlqcGZJbooXb673WDZZHoQIAMyJ050Jduj21rmSjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qb/h7mcS
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qb/h7mcS"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3608ec05dc2so4820235ab.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424303; x=1706029103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sual2oOzcDgWB9m2hWR3owp6IlX6MibNTQZBGYSJ128=;
        b=Qb/h7mcSW5spvUAeC6GjMR4jaOY3C6DXChYVgrgVs7uLdnyP2gixxYpRvP0kZKinu+
         mydax3unsr0uaIxkHtXBF5/fjN89Gy+CpGwl8lkxCjVUw1R04Np7cQDTm5Z9+ITweaCx
         krTdV/5GyCIiF3nbY5G2jaT8NRD/E46GvI+8yxC2mTgwlzIpH9uPVNTfvBg42FTNxRBZ
         9J9M746+RpHwVHJxhbOekT/vI2/ZM7z5xzeiEzZLN+dynfg0lb0ivEt3YipyLhdG8V/8
         0cKdAFXSq82ZRzgPVtb1tulJdXvSdURP212Jaimp9g6DnF2PMObZukBWjTJgsvHeYJ4E
         JIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424303; x=1706029103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sual2oOzcDgWB9m2hWR3owp6IlX6MibNTQZBGYSJ128=;
        b=a5Frx0QxH7B25BUNOaCcxgEQOskakxn3rUudn3+wSuv8zfDKO1SiMVWIGydtEzwREU
         ma6zV+TfG1iE1hU0Q+Pk+vulnZS5FUZaNA6Onfe5O/0ouNKsnbm/CuUfK73Ayaipwcs/
         kiPHePyybnK54IWPTLqH3rWCp3jP5BtD6OWH7zqFvZd2V98a4plcoh1EihMClqC8Zyug
         uPH7K4Sf9JaTK7ukmQFAk1MIwCyDoTa4/OTiBslAfArAZLSRWzog3EuCFAMOfer077jZ
         VJm7EGjp3xljJhme3laZ/yvaBWyvdQmZxtIDje4YJ2JRW6qbtxl1fcNlHP/ntYFc8MbU
         EMlA==
X-Gm-Message-State: AOJu0YxhZfYhEZ8SeWi5hvphliNUW5AKylUq04YgMivEMiNWLTNVjBPA
	jWVM205dwbAFHnGha57kWkOZv/wSqtRL85UyNYh3Eg5d2prOwg==
X-Google-Smtp-Source: AGHT+IFQ4VxksXYerPgpKIkS/xKA/MNa/oMqYtflmkdkdF1mJ4t9lKhvsWps3fU88wyW2b91pP69PQ==
X-Received: by 2002:a05:6e02:1d07:b0:35f:da7a:3797 with SMTP id i7-20020a056e021d0700b0035fda7a3797mr14778198ila.1.1705424303289;
        Tue, 16 Jan 2024 08:58:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c14-20020a02a60e000000b0046ea43e4d0csm71744jam.168.2024.01.16.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: kbusch@kernel.org,
	joshi.k@samsung.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] block: update cached timestamp post schedule/preemption
Date: Tue, 16 Jan 2024 09:54:24 -0700
Message-ID: <20240116165814.236767-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116165814.236767-1-axboe@kernel.dk>
References: <20240116165814.236767-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark the task as having a cached timestamp when set assign it, so we
can efficiently check if it needs updating post being scheduled back in.
This covers both the actual schedule out case, which would've flushed
the plug, and the preemption case which doesn't touch the plugged
requests (for many reasons, one of them being then we'd need to have
preemption disabled around plug state manipulation).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blkdev.h | 19 ++++++++++++++++++-
 include/linux/sched.h  |  2 +-
 kernel/sched/core.c    |  4 +++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2d5c94e99792..81a7fca1b4f7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -976,6 +976,17 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
 
+/*
+ * tsk == current here
+ */
+static inline void blk_plug_invalidate_ts(struct task_struct *tsk)
+{
+	struct blk_plug *plug = tsk->plug;
+
+	if (plug)
+		plug->cur_ktime = 0;
+}
+
 static inline u64 blk_time_get_ns(void)
 {
 	struct blk_plug *plug = current->plug;
@@ -988,8 +999,10 @@ static inline u64 blk_time_get_ns(void)
 	 * a valid timestamp" separately, just accept that we'll do an extra
 	 * ktime_get_ns() if we just happen to get 0 as the current time.
 	 */
-	if (!plug->cur_ktime)
+	if (!plug->cur_ktime) {
 		plug->cur_ktime = ktime_get_ns();
+		current->flags |= PF_BLOCK_TS;
+	}
 	return plug->cur_ktime;
 }
 #else /* CONFIG_BLOCK */
@@ -1013,6 +1026,10 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 {
 }
 
+static inline void blk_plug_invalidate_ts(struct task_struct *tsk)
+{
+}
+
 static inline int blkdev_issue_flush(struct block_device *bdev)
 {
 	return 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9a66147915b2..d8a073b06495 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1642,7 +1642,7 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
-#define PF__HOLE__20000000	0x20000000
+#define PF_BLOCK_TS		0x20000000	/* plug has ts that needs updating */
 #define PF__HOLE__40000000	0x40000000
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..4675d59313ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6787,7 +6787,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
+		if (tsk->flags & PF_BLOCK_TS)
+			blk_plug_invalidate_ts(tsk);
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
 		else
-- 
2.43.0

