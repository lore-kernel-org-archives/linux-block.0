Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44D7FBD7
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031204; cv=none; b=fjuzC/LUrpINrXL65hMjurHJF/BfeXTcw7ZtWBHH8cAXFA3rxHnQtxiBnd/XiDR73cTQSyUXsBpRcVkn1Xj0tygXnk4Jpng2Q/6Pu746u6kotPuzkLcTsU9Ia+lG+ISAfckwHq7INH0oP3V7esCm1cAetM8gCpwTctDbnL7scaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031204; c=relaxed/simple;
	bh=cHEVYaZrC0cKZQbM1XCitnRvrM7dSUljuu8ypkDVvuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW/DK0jQdzVsqEij3OCtfVld7qxT5MlUIfnNcw5R8zQ2qQYEuDssQs0GN7y7EU8betZ0lql71W0ELJHAMjr/2hXximXdgIyDFVIBiaroeF47AICQY+/Gw05+MkIfMkvng5lvmTIbKPTdAOkwz8HLtLdzlbfZepJWPCxVmfZBTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2m74Jqyj; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2m74Jqyj"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so61633539f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031201; x=1706636001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxbR1PijRVCdMvYYvc9G6hASa6voFvqAh71Hnsi23v8=;
        b=2m74JqyjFQGd4OvTYn0RRWyO0+y3byXZYSvyXfak2Q4U9K+BZSDyawbA16YcZtvScv
         pe+ejBD/KYFjmPaf4Warx0nRI+5aofjfuNm7YxyajbIROjS0vCGRKEUA533xuGphcj/T
         UKi+G7g/SoAD2BWEOYjIZjrI6yDLKa0Qkb5gVSqHbgvE7UZZ7wDrHgqzNCoT6c91vl6N
         jzNTueBji7TuF0ZpFz0koAfS5C5t0LZFGZ2V4i27jkrMkWLlHDwnmVjTjDrv3R/5Fnl6
         5BGempXHxrc/jftT7YW7D3UHFija9U9vRM3OIbZkSRqSUSY5clBWdoGDeV/8NudGRC3H
         iznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031201; x=1706636001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxbR1PijRVCdMvYYvc9G6hASa6voFvqAh71Hnsi23v8=;
        b=Nnnec2ONoJZQbF3oQjS9wRSM3mTxnCBe4p5CeF0JGU9Q3kb7biCpWmR0vqfmiPJsWv
         vvB1G0263uTWqoAx1dfuP6XJ3RaVytOiZmO4727HdcP88xiI3NwYMlzNc4Ao36982510
         +bJQ0fHoJPDwrp4AQ8P1YHxEwTzc1YGGlyHb+ZAx2CQqvTYtvW0VbBXootNddvdPfr+v
         swFpPizXqpYa6+X1yzSAJQf970uReRKlwD6QZdAz3C9N4T2gKqahMSpBLkVEH3MSjbNY
         YC7xonKjzFsI+jnh2Ndh1Qs9nPUElY2koUyUHXkUUhj7FkEYN+IoX8odc9iURYoDVwZL
         VgGg==
X-Gm-Message-State: AOJu0Yw7bJryIB28uDpj5iYHnEMlSeRjOokfi30eAidBznykOJkwJm0/
	XNhMI1AyjgxBWeiJowfGnvzg+Fa+dQ3R4y3q0zrntaAQS5Eunule73VB8U+6vApjx9HFx2NBWO4
	oAJI=
X-Google-Smtp-Source: AGHT+IGwhS+Gfjyer4EGMf4Ee+ZRUoyF9JnKZfz9ky6ZsWBW1yW1Egb+jzpjnmZ8pRLV0G4aKd5SLw==
X-Received: by 2002:a5d:8e0b:0:b0:7bf:4758:2a12 with SMTP id e11-20020a5d8e0b000000b007bf47582a12mr10047787iod.0.1706031201396;
        Tue, 23 Jan 2024 09:33:21 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu12-20020a0566382e0c00b0046df4450843sm3640708jab.50.2024.01.23.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:33:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/6] block: update cached timestamp post schedule/preemption
Date: Tue, 23 Jan 2024 10:30:36 -0700
Message-ID: <20240123173310.1966157-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123173310.1966157-1-axboe@kernel.dk>
References: <20240123173310.1966157-1-axboe@kernel.dk>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |  2 ++
 include/linux/blkdev.h | 20 +++++++++++++++++++-
 include/linux/sched.h  |  2 +-
 kernel/sched/core.c    |  4 +++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cc4db4d92c75..71c6614a97fe 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1173,6 +1173,8 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 	 */
 	if (unlikely(!rq_list_empty(plug->cached_rq)))
 		blk_mq_free_plug_rqs(plug);
+
+	current->flags &= ~PF_BLOCK_TS;
 }
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d59610483619..9660a65bb927 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -977,6 +977,18 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
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
+	current->flags &= ~PF_BLOCK_TS;
+}
+
 static inline u64 blk_time_get_ns(void)
 {
 	struct blk_plug *plug = current->plug;
@@ -989,8 +1001,10 @@ static inline u64 blk_time_get_ns(void)
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
 
@@ -1062,6 +1076,10 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
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
index cdb8ea53c365..801233cef2fc 100644
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

