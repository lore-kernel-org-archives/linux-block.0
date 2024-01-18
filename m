Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447A2D608
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601154; cv=none; b=Swm6wdYIimPIPtsqPUnD7jgmL37znsOk9sr8b6wwZUFt8WnJj/V4S+lIZqdr3+R8LsTkmoLbvEkg+mCMtjwfbHuQWufF5K5gBJhs7umAIaWMZJJ73f/NSjKs+8yL55NFBWloYyyXy81HZiyWttWHGGabSHAxUdjU3CS4NwilJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601154; c=relaxed/simple;
	bh=Op4Kp8hTPdJBcXksFX1xaIIuSLH/ueMSx0RyUzuZIe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzfgHaa4Cc6s5LhIjYa2eNk5FageOOAw11G8JF9GoIfBzJSmwzpbHPoSNewgZdtYg9KyQANZSuLSmCKoSvYgW02aXSdK0OPWnCd0uavYAFkkI70P0vxIbXrb62CtY0cNiPNj/GiDbKoba1PFFIDu6bG+8apz9b45CxsM6n6wuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VgzEdnCZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VgzEdnCZ"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35d374bebe3so9915495ab.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705601149; x=1706205949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5Yv2/ThtSVPIwMNI0HbpzQ4mlcRZBuPxJLVsJs0fIk=;
        b=VgzEdnCZBt0nU04BEdIrsRq4HPljO+6zEGaa+UgqUv+tGO8sSqQeLVKwg6+/NfGgBZ
         ZE7FSRl//d4ZGPkU8PmnfbLd6InlIRoeiYf6CcsIO0cP8LYq1sNmlhJn2WRCZZqR0mss
         GDz2uo+BYIU0IAvW6f1dv0ckz20ZuSlOX8YEhq3V7Et5Q8GQEN3DeCcLALS+UYTcJf6S
         X4XVj1eaYEivjD+7sYm2dba8JviiFUs034WmeVLX1lNMINweThMn02GTbzenQxpiSLaS
         ewnPwCy1Jlm5iiCNQuzriuBACVgxBsvW4yZlVi1eK7yIm+4Wdl9xKzttupfAwYUDAuHD
         mJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601149; x=1706205949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5Yv2/ThtSVPIwMNI0HbpzQ4mlcRZBuPxJLVsJs0fIk=;
        b=cQPMxsNBjwkIqM+gGOjsfDEOTzfsQDyNQqeBwoF3HfXfYpt3DmtGSQELciK3iO5Mn6
         jxHh9ise5REqmTTbiequW9wmev8m69lTH2Ag3Fxr/CnAzQobBq3NX+H6yJAEXV3jNp0L
         ULCjWoaJqoJDYCgQhJpLGnlb0M8Wq6ADiFM6GWLjyGPaIQHVVAdOspp6IbYF/yIFBfhG
         rZff05EJYUITbU4zlL90Z5l1FrilS34juM6C8xUxrj0/ENx5DkStm0oDKG9sgmikQM/A
         2f+wYxtVmYYPo7VYLvZmUpYreizUzx8wTuRxtxeK/Q7cUUxEQGApT5VwBNO9X3Q468AG
         Ic4Q==
X-Gm-Message-State: AOJu0Yy0iQildG8adT6ztAqn5YHjwx+IMZtum/iWCrzuB291hTksbnNv
	nkLITyau/Xum8RPzf82t7yA6cYFV9CLR2NlMFvt7VdR5K7rb5M8B+RdHA5dqWZtaGGDKpYiyMKJ
	TwOE=
X-Google-Smtp-Source: AGHT+IE+Lu/oGlAArWM+8UhOoIKimkOYeSdP/QidRGPdNBAwMkioVQcaFIqAX2mGii5S3TDtSYs23w==
X-Received: by 2002:a05:6e02:152d:b0:361:9667:9390 with SMTP id i13-20020a056e02152d00b0036196679390mr57313ilu.1.1705601149374;
        Thu, 18 Jan 2024 10:05:49 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bq7-20020a056e02238700b0036088147a06sm4981873ilb.1.2024.01.18.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:05:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block/mq-deadline: serialize request dispatching
Date: Thu, 18 Jan 2024 11:04:56 -0700
Message-ID: <20240118180541.930783-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118180541.930783-1-axboe@kernel.dk>
References: <20240118180541.930783-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're entering request dispatch but someone else is already
dispatching, then just skip this dispatch. We know IO is inflight and
this will trigger another dispatch event for any completion. This will
potentially cause slightly lower queue depth for contended cases, but
those are slowed down anyway and this should not cause an issue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..9e0ab3ea728a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -79,10 +79,20 @@ struct dd_per_prio {
 	struct io_stats_per_prio stats;
 };
 
+enum {
+	DD_DISPATCHING	= 0,
+};
+
 struct deadline_data {
 	/*
 	 * run time data
 	 */
+	struct {
+		spinlock_t lock;
+		spinlock_t zone_lock;
+	} ____cacheline_aligned_in_smp;
+
+	unsigned long run_state;
 
 	struct dd_per_prio per_prio[DD_PRIO_COUNT];
 
@@ -100,9 +110,6 @@ struct deadline_data {
 	int front_merges;
 	u32 async_depth;
 	int prio_aging_expire;
-
-	spinlock_t lock;
-	spinlock_t zone_lock;
 };
 
 /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -600,6 +607,15 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 	enum dd_prio prio;
 
+	/*
+	 * If someone else is already dispatching, skip this one. This will
+	 * defer the next dispatch event to when something completes, and could
+	 * potentially lower the queue depth for contended cases.
+	 */
+	if (test_bit(DD_DISPATCHING, &dd->run_state) ||
+	    test_and_set_bit(DD_DISPATCHING, &dd->run_state))
+		return NULL;
+
 	spin_lock(&dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
@@ -616,6 +632,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	}
 
 unlock:
+	clear_bit(DD_DISPATCHING, &dd->run_state);
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -706,6 +723,9 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	eq->elevator_data = dd;
 
+	spin_lock_init(&dd->lock);
+	spin_lock_init(&dd->zone_lock);
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -722,8 +742,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
-	spin_lock_init(&dd->lock);
-	spin_lock_init(&dd->zone_lock);
 
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
-- 
2.43.0

