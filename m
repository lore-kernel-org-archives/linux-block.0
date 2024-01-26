Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4124B3E
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305119; cv=none; b=l84lRIt5BfW4lYteq8M/oh6kje5zym/415xxlvZHJCrbDTFgVBxptXD2sT1SvTHrLYyN/CMZdjjPEZoJIdBr7A/+1cGYDFpwR0u0romrAa9ebkDyWibUB6zrx+5rYuyvCCSTv7cSfwR2Ohg8JMFJlxqS7/S4zKSV27QQRjuKgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305119; c=relaxed/simple;
	bh=pNpKJqLL3guAmgPoZxYYn0HJELvDLdN8UWcOlz5cr60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuMqDD+8bxJtjZ9LJrZIsmnw0pQ9Dy/0dwCdsFeHgtxk4iNiBi4qZ0sxrArBiSdEdlfAlexYQMkznjezzN8tkfIrd7lXLgxwp40bMX8fjCGLBaHmPQJU0mzcnfGOD2La+6W1ogZYAxN7an0s1wjEo5jx4/spo3nbpFFFq5vSmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hHYVq+SP; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hHYVq+SP"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so16261939f.0
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706305116; x=1706909916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuY7+pH+/TkeUw21hOKFz7+jbmiYqASJG1Y8JAh+Vdo=;
        b=hHYVq+SPPg3KvBOULDVeDccJ0nmi914FvaMRQ2aLYBj2j4fyneBYCW1jvPRdrJyuCd
         70bWO3gMvEKtwg/eoNh9CDYZaPaOwJRsWTfGdAFuuGyUHYbWNC8VyPZKQYwvjw0J9IE2
         6QqZ+oNcs6XbjEoaB4MTF2axtTkizTD10LbXnSQ+vJOCPzfIRMqrtGcDxCXn01d3Y4+9
         92npgsqCnBBD/d74I/wQinZZv6XTo8GCx1XQJZi09p+WC+IGbSuFMUhQJiPbuR4FyONX
         nO9OgZqrpNc1piROoQfRv5BK9Slpfg3rBLUKjQ7/GtRBJdQbRe8LB76NAaWmiikT3lGj
         Sy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305116; x=1706909916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuY7+pH+/TkeUw21hOKFz7+jbmiYqASJG1Y8JAh+Vdo=;
        b=WOxuCJts7Yvp6EZWVZMymGjMZg9kjF4xvPjnHkNRMLodefpMTxOI6aJqJtIc+X49Ux
         kOgkv07fmIUmWoZYD18NhOhWBAL9HQprgaFCMpdx5zMNmq/WPgj5w14D0t51ifDts04/
         vAoCq2It8K9q1caUF2J83pUeYly1quR/LBNvUiVZwLa17KUpDcK3v1U39xU0DsjI/yRA
         EbC3TcREPQLwK6SPTsm4DmdK5qtsOC0AYgCzZKkeGf6RdRFxSd/NK0NWvEgpWgMt2uuI
         UU4zZCHnUhaKIXGy92RN1grqkcbWyGMrOCJ1qPVRTy94zQbiDaAp6B9XeTZncf8gM45X
         x5xQ==
X-Gm-Message-State: AOJu0YyiMR0hSXgqu2GLYTuGb92LOE6Q6/6kx65flOhD2GePZ6yfO6nc
	beKgmeGtSVyGosbUEe9zyRa4xzPhBwr1yrTexF9BLkgePmYfHtLYfKjhYYq2wLUNMW9hTubGrCP
	vFtc=
X-Google-Smtp-Source: AGHT+IGMv1HkgRrsYBQRjG4bAVKZH5Dhpg9vcn0RTGWr7Jr6uM8bAdo/K2d101wFXIjVNh2r7rtSpw==
X-Received: by 2002:a05:6602:4b08:b0:7be:e080:6869 with SMTP id eo8-20020a0566024b0800b007bee0806869mr867003iob.1.1706305116409;
        Fri, 26 Jan 2024 13:38:36 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b4-20020a029a04000000b0046f34484578sm471788jal.126.2024.01.26.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:38:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/4] block: update cached timestamp post schedule/preemption
Date: Fri, 26 Jan 2024 14:30:34 -0700
Message-ID: <20240126213827.2757115-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126213827.2757115-1-axboe@kernel.dk>
References: <20240126213827.2757115-1-axboe@kernel.dk>
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
 block/blk.h            |  4 +++-
 include/linux/blkdev.h | 16 ++++++++++++++++
 include/linux/sched.h  |  2 +-
 kernel/sched/core.c    |  6 ++++--
 5 files changed, 26 insertions(+), 4 deletions(-)

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
diff --git a/block/blk.h b/block/blk.h
index 14bbc4b780f2..913c93838a01 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -529,8 +529,10 @@ static inline u64 blk_time_get_ns(void)
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
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 996d2ad756ff..d7cac3de65b3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -973,6 +973,18 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 		__blk_flush_plug(plug, async);
 }
 
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
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
 #else /* CONFIG_BLOCK */
@@ -996,6 +1008,10 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
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
index 9116bcc90346..083f2258182d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6787,10 +6787,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
+		if (tsk->flags & PF_BLOCK_TS)
+			blk_plug_invalidate_ts(tsk);
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
-		else
+		else if (tsk->flags & PF_IO_WORKER)
 			io_wq_worker_running(tsk);
 	}
 }
-- 
2.43.0

