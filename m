Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C225622
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523796; cv=none; b=rrgYNQjwsVlp5haBPtBpDC+E/aEhsjqrlm4gwVBbNX+SC6QlO6wdOa/Q3ZmY/MS8jbjgHY9CruYGIEcyQUHp8lgDEFJhvzMtVqcLwv9VBMDBZ3RpIkmkHF3hQhWxEZkIS/qPbqV4BXdQx1IUF0GpTxkqnriQUqDwJxjuOE2skzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523796; c=relaxed/simple;
	bh=wgRJoyMhS8Pfe7eihC9NGU5nwYZA0RGXOCZ4787xPMw=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=NjHR4m1dHSQDGRdS50dQXDLQeOUf3Yx9ibVfvPHgZNa5YvvgTUwbMu2IEDnTYDNjn7siqmZ0+ZVcMmpeXwNay678rY6/CiTY5ORbPFMeRckGp6ZnlSCQyTE0Cv29W3sC0vqn8IrlYMKeTkJgRxTOc2oxR7XcPMah7oDYdx/Wz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b050e88cso6579105b3a.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 12:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705523794; x=1706128594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/YF5ZTlr+01PFbVd323OhgYAkSO8+NyObftFAbLtlg=;
        b=ROqn6/BCwzLhtKVj0kPhwcpKMRYOrhDEvniIq+o8fjZ7LOD5V+tcrC/r1z3JaV3gYL
         2PnBa1TKAZKFYgeHi0jvHdbmv4mLUylI0avap8g2oDPBW/Y8S7WgS6hdhwZbE3f54YMo
         6hMU1EquUyqiiG2G0slsX1GtLSW5W67xqm2RIHB18+bztzlpO4jS58MYT5KC8BrDv7sy
         C0wakZ/h+MY4xRc8MPQ5Cykko/fetveR1usS7HwhhNm6NCZrjvEAO2+EPAYRFAvCqZGY
         d2+q23AXws7dz16bIFJO/11XWi2S/7yTfUAssWYLtG2KQ7YrIz9Gs51JKsdSFeCDtTlU
         MJlA==
X-Gm-Message-State: AOJu0YwA9LgsiiruBMiaXYdad4RKnaInzABhLJ/oo2EaqQ6tf1jUW5D4
	j6J5l65yu2K3rmE/RiAgM2A=
X-Google-Smtp-Source: AGHT+IE4ZF6vohHVxROTNHgxiqgT9LsjHZ5TrJ6PszS0u+1ftMcI/qb+6Ch4/YMt0/GDyLXfmu4Z9g==
X-Received: by 2002:a05:6a00:4205:b0:6db:82a1:a224 with SMTP id cd5-20020a056a00420500b006db82a1a224mr4391590pfb.57.1705523794559;
        Wed, 17 Jan 2024 12:36:34 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id ks11-20020a056a004b8b00b006d6b91c6eb6sm1927956pfb.13.2024.01.17.12.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 12:36:34 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Gabriel Ryan <gabe@cs.columbia.edu>
Subject: [PATCH] blk-mq: Remove the hctx 'run' debugfs attribute
Date: Wed, 17 Jan 2024 12:36:09 -0800
Message-ID: <20240117203609.4122520-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody uses the debugfs hctx 'run' attribute. Hence remove this
attribute and also the code that updates the corresponding member
variable.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Cc: Gabriel Ryan <gabe@cs.columbia.edu>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c | 18 ------------------
 block/blk-mq-sched.c   |  2 --
 include/linux/blk-mq.h |  3 ---
 3 files changed, 23 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5cbeb9344f2f..94668e72ab09 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -479,23 +479,6 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	return res;
 }
 
-static int hctx_run_show(void *data, struct seq_file *m)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-
-	seq_printf(m, "%lu\n", hctx->run);
-	return 0;
-}
-
-static ssize_t hctx_run_write(void *data, const char __user *buf, size_t count,
-			      loff_t *ppos)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-
-	hctx->run = 0;
-	return count;
-}
-
 static int hctx_active_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
@@ -624,7 +607,6 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"tags_bitmap", 0400, hctx_tags_bitmap_show},
 	{"sched_tags", 0400, hctx_sched_tags_show},
 	{"sched_tags_bitmap", 0400, hctx_sched_tags_bitmap_show},
-	{"run", 0600, hctx_run_show, hctx_run_write},
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
 	{"type", 0400, hctx_type_show},
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 67c95f31b15b..451a2c1f1f32 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -324,8 +324,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
 		return;
 
-	hctx->run++;
-
 	/*
 	 * A return of -EAGAIN is an indication that hctx->dispatch is not
 	 * empty and we must run again in order to avoid starving flushes.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a676e116085f..7a8150a5f051 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -391,9 +391,6 @@ struct blk_mq_hw_ctx {
 	 */
 	struct blk_mq_tags	*sched_tags;
 
-	/** @run: Number of dispatched requests. */
-	unsigned long		run;
-
 	/** @numa_node: NUMA node the storage adapter has been connected to. */
 	unsigned int		numa_node;
 	/** @queue_num: Index of this hardware queue. */
