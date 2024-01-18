Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A72E41A
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605838; cv=none; b=htTx51smYRG0WoyixOwGhcjcmNkO6KmCypkslY4jsTUs4W255abzk50VPc77Z2XEhOPs2Jx5t/6+nCOC4zpFGTh//0rwxVG6zyRg0BFG6ZrbGGkMbMr4R6n+R/Gl0um9fhhbY1CyJ4CZ50aTsVxT77+DhTXzLWyAydrbPV2lXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605838; c=relaxed/simple;
	bh=KY5qKDHUEdtAiLOzRKB7ikeqsfi0OBJRwdVu0qawenM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0cdxVBxNSL77B9QTfi6orGmsTd7brevDeysNzN4dBLm73lZkEiYQj5cvaE0pxgsxsweq06nPuAxCQDfW93yjIMVxFUrlpEcbpPoW3ZgljsNXrC3eLSUoopkYOpM0CTUXB08KRVjgf8dyENw8NJ6q5dec19rYwMHIxLMA6ijxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GeV2daDf; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GeV2daDf"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso99839f.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705605835; x=1706210635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG9bYwLCypK88nVwwMvHo/MQtnbDeCQ4odqIEB4uqt8=;
        b=GeV2daDfrIthDUAVh8jqG5h7djRbQM7FiBxD7lldiz0Di9M5GkkyasFELO0HhRUkZ+
         42RgMl8dsfBGvyt+pvHhcKboPBNB8a6aHdop3RzfzECfVmIPp54NaO5jRvK5nl1sznyJ
         d040dEJB+Wo3Kvh75SJcZmAZBUFl1WG5goDaTUT75FAg4KxDfjWIoElgvjLWRpnAVBJj
         PJiDfEQ4xSgAWDo/hzMzK23Bsr2fCyHRtt7ROWr2j3mqAioez9+fnm/bjpCijemas2sF
         Dh8TL/HOFGZn/RsBq4XkmBCIhlUebl+4njsQWvSUTgwMClEZ6Accd8HbaYKQ0VbNfNcC
         0wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605835; x=1706210635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG9bYwLCypK88nVwwMvHo/MQtnbDeCQ4odqIEB4uqt8=;
        b=ozTvEX/vpiGimVluLp4U2rtnL2JUnjYrMzU4/rERL4UKbHUif945VYC1Cwe3WXWPbC
         MKzhlWya+liT3Y9G3MHUDpceQPjlYwG1wxky4hgsNG5HeFE27RWGNS1crXxjTY0yWVSC
         PZiZPqzl52KmIQlV6Aee7CYmRbxBzTOsSQrr0HCFLExuP9oMPwLdUFKwtBnX1mzOR6NJ
         jn9zGzAn9u5DGAgUjYyU97K8699L+YPFzk/5U5cdLScTaljWzrFkbz/5/X8Qga+RXWhH
         oyeay0RG6jdxw7+LG4dGTL0WN5ZFvNMV43YwF1W5dwz7ZHrSc8Ryd7KszBDMOmy3/5Gq
         KNBA==
X-Gm-Message-State: AOJu0Yw7LpFM8Ywegb6S+EjIgXHDHvv4uqOCCe5PrDw4y3UckqWp4m9c
	NG6Nyp8wmEEAJ52DLNceq6fQJAzvVeYQ2gp/g2UI31iJMRC7HiC/Q/JfxwC+sTeCB9LpY5ozhjm
	1PW4=
X-Google-Smtp-Source: AGHT+IGPbRNmeIwwoBg/o1yVOjJ1Tf0T7e9UDGPZFa3nmr4E9dl/ef2YvgRft6cnQUkFNwxbmgmNqA==
X-Received: by 2002:a5e:8302:0:b0:7be:e376:fc44 with SMTP id x2-20020a5e8302000000b007bee376fc44mr357826iom.2.1705605834694;
        Thu, 18 Jan 2024 11:23:54 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gc18-20020a056638671200b0046e5c69376asm1155588jab.40.2024.01.18.11.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:23:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/6] block: update cached timestamp post schedule/preemption
Date: Thu, 18 Jan 2024 12:20:55 -0700
Message-ID: <20240118192343.953539-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118192343.953539-1-axboe@kernel.dk>
References: <20240118192343.953539-1-axboe@kernel.dk>
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
index 26226afaeb91..518c77d1f0c3 100644
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
 
@@ -1057,6 +1071,10 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
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

