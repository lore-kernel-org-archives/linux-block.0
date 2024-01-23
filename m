Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDD7FBA1
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031206; cv=none; b=qYdfYV6fvdjf7S7ZBbwfihEPM4R1Feg5+g6iO5CbrTc24Pe5h/RWbt61r63FVotbVA9DM8qUZCDwG7wXzDdHackTeHrGet98qmmFMsdAFAiLvsn8UnJzEy54fEzxihFbPyQMCbVO/AGDibIRx9fBrC2PApX7ZSjm85x6qzsI0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031206; c=relaxed/simple;
	bh=p7vwFJau7qEQ4ufBglXQjs3pqU2/i4O3ue7lco2L1hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJdvZJ7UsjxDvjvrXkpR2gg8HeHUjKDiq8doPxqiJR8sQmYIBS/2sak4sW02smN6mv+Fa3ieAuhd4woW2xq8PHFJKGYlgXG68nIDQmRboiB6T6WgrYkoVI7ZCInQeF8MjWLLT7LXYvo9TdQlA1SXpG/neAxIyptCeTMuYREODys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sSZQmbmB; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sSZQmbmB"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bee9f626caso62081239f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031203; x=1706636003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH4lZhxqtdD3FbEMI55dx5z4UKpqUWwGArOpZ0i0C1Q=;
        b=sSZQmbmBNdylw4QsOXos2AKOHpNy9FXdq/nQZkQbpigksozGN9P/miKNSptjP6hYKX
         chRbBlth6Yo9dTTXtZI4Qc6hzGzO/8Clvp9X8NDKMMr8AYmTwK6SFbNWRlXqoBZInbL+
         DFHPqTBcBQneFziHXDOKaSryQrvVK+boVMfTUKhYYfQ7fY3M0P+sZvZ5PJEnec8f6IvC
         DNOTm4EU4JSAXBrCAZRR8VMjPFuvCr0zxUmY6TSffRokF6HrORjsuwHxaPZTHZBR3Kw/
         7XIEOU0P9fVRzDeiuK/eZNZ80ttbVb0fKSXyiW9i9V+5S19GGUM1kVdTWR71lvebpTPj
         iTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031203; x=1706636003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH4lZhxqtdD3FbEMI55dx5z4UKpqUWwGArOpZ0i0C1Q=;
        b=ULmwCmwdsJ9rfEdWTMgRz1rrRhxVtYjZbjO0kdBSmKM5IkIGc3V7a6mWA8PdNu8xyN
         bcid59ky56XP59PtCfu4txRe9vXWlO0CA3iVXmytJO7W/W9YbsItI0sstacrRfcHb4o2
         36XjRcpOmtrUGrOUZwiDRxIsyqPn0d6qW7I5P+DZnHZ8e0ZIFvb83kf5TevRDi4gVqJo
         Tx+sRPPoLuTB5CzlQFu+Sj+5SVPAqzWHxmLsLYGvLN+edeu9ucFuVhs98POFG6kq3KL+
         5gy/QWYTw2zEjLraW77Mu9x3/16mxiyUmkhYb2cdeSpDx9y5nC7ef9GAtIKLTRwfRM7N
         I+WA==
X-Gm-Message-State: AOJu0Yze17viNpg4XoxcZCsNOhIjvR8Lk9voIHlZp+QZbSVTZ7ANOFdN
	O/QXbOhhRTJTz8vVsHSWWy+KVnuyv0NetH9zPRNYucFq3JPE+BtLL3+vZtzw+aJrpon1ofwWcr9
	xpK4=
X-Google-Smtp-Source: AGHT+IHgLQJxIFtXneGZwVz9S47OXeWhgLLk2cedeglfcOKnm0WCh1YP3OXrzkQ4vjXjGkKh2d8z1A==
X-Received: by 2002:a05:6602:e04:b0:7bf:f20:2c78 with SMTP id gp4-20020a0566020e0400b007bf0f202c78mr9470693iob.1.1706031203236;
        Tue, 23 Jan 2024 09:33:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu12-20020a0566382e0c00b0046df4450843sm3640708jab.50.2024.01.23.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:33:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] block: shrink plug->{nr_ios, rq_count} to unsigned char
Date: Tue, 23 Jan 2024 10:30:37 -0700
Message-ID: <20240123173310.1966157-6-axboe@kernel.dk>
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

We never use more than 64 max in here, we can change them from unsigned
short to just a byte. Add a BUILD_BUG_ON() check, in case the max plug
count changes in the future.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 4 ++--
 block/blk-mq.c         | 2 ++
 include/linux/blkdev.h | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 71c6614a97fe..dd593008511c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1063,7 +1063,7 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
-void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
+void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned char nr_ios)
 {
 	struct task_struct *tsk = current;
 
@@ -1076,7 +1076,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	plug->cur_ktime = 0;
 	plug->mq_list = NULL;
 	plug->cached_rq = NULL;
-	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
+	plug->nr_ios = min_t(unsigned char, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
 	plug->has_elevator = false;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aff9e9492f59..a9b4a66e1e13 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1283,6 +1283,8 @@ EXPORT_SYMBOL(blk_mq_start_request);
  */
 static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 {
+	BUILD_BUG_ON(2 * BLK_MAX_REQUEST_COUNT > U8_MAX);
+
 	if (plug->multiple_queues)
 		return BLK_MAX_REQUEST_COUNT * 2;
 	return BLK_MAX_REQUEST_COUNT;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9660a65bb927..ce6d057de2f0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -944,9 +944,9 @@ struct blk_plug {
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
 	u64 cur_ktime;
-	unsigned short nr_ios;
+	unsigned char nr_ios;
 
-	unsigned short rq_count;
+	unsigned char rq_count;
 
 	bool multiple_queues;
 	bool has_elevator;
@@ -964,7 +964,7 @@ struct blk_plug_cb {
 extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug,
 					     void *data, int size);
 extern void blk_start_plug(struct blk_plug *);
-extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned short);
+extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned char);
 extern void blk_finish_plug(struct blk_plug *);
 
 void __blk_flush_plug(struct blk_plug *plug, bool from_schedule);
@@ -1060,7 +1060,7 @@ struct blk_plug {
 };
 
 static inline void blk_start_plug_nr_ios(struct blk_plug *plug,
-					 unsigned short nr_ios)
+					 unsigned char nr_ios)
 {
 }
 
-- 
2.43.0

