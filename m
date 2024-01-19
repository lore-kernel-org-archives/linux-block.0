Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2F54BF9
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680227; cv=none; b=XFNCz/OCxydESAWfDBJZRrT5Txye3aa6L89TRSajrXNN0LSFv3/dd2JeNtwK+Ba+hxd8AsineaYa4dl8nqM9RDGUK5IAYDZSCz2HULPUKxRD7+k6WiePw2mJRBv3UGRgenZ4StJt20geiFH2RJmKp3tC+YZ2DL3V+JigjWBjZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680227; c=relaxed/simple;
	bh=eN5cYUa2uS7egMhgMRv3rkay+tY6Azv/e0obJTDB1RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO7aRLVTHOHlFi1SxwwVOKxn9gQbW8/f1o5QI/S0/Z5dc2fv1BrwIYlHFVQLEVTmQcvqCGSvo1kAeOCMsmgZz+c4pQKnJgrv8/KxJflZxfOtsNptvitzrPy2mw0/UpAAJpCVMQ3PHVZC5B4bK0Nij2VPq0yAZEzkpEmorHJxST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0lh2hpMX; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0lh2hpMX"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bed82030faso13083739f.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705680224; x=1706285024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZgFpkGIasqO5x4x661AeTcqaj0ffo7KFA+y+n4T1k4=;
        b=0lh2hpMXMY8AL7CZB9Twla1PsdMeP33wVrXA3z/+SEXSATRHUCD+nriYnGOWbpijVj
         0zBsMAHlYLG1+J0b9VcnHFv8NC4sXsQ9ks8IBwHFQ4V8dx8Y5V0pP1CSqXdlWltphvP5
         GeeW5KkwPTkRadWMuNP/s5ZfasMXEdiLfE5UNEhddtrXoy2KKICV4X4tWaOOd3smvWTm
         5L+cIBt2Q2MMdr/bxbLdnf7lgxovDssrplAGg4XHGmatgzmyBkpYKdbIfLi4CSOz0Mve
         CJZFD5jDuX9BBWk99/ljx/kDDpsjFHhK52m/TiMYmtdfffRWQ0NKe7jvVdncJU2mxGGN
         f46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680224; x=1706285024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZgFpkGIasqO5x4x661AeTcqaj0ffo7KFA+y+n4T1k4=;
        b=BNmiSWvsnFLDqY+WQE04qVXud0Epo1TZiYyvRh8pB8WH4CCTH9UhzckWRc566D9nwC
         kOsJsPS8Ion72gg6kHNNgAWCn3cfpEhvpdvq/sGkyvaFfCKl+TW7N7kWVQSBccgAvTwa
         eG4cOSfoSfIE39gdfXJ8ysqaV1rZK4VE1qENDCsF6+MhX9oCl/gaUjS6guGxk8+Igu1m
         Xl4NXfaa5Ow8YfFfDrYTlOQaJc6XXPrZunrhFqHG+mhygVt/90aOaqJM55LdHrXHIA1o
         moD5+MfHSh5Hphnt78O9yhA8i4fkmW7uj1w7MZYXLya+6H5/n1050GmT2OTn4QR1Lhhk
         vj2A==
X-Gm-Message-State: AOJu0YzSAcbhIBKN+RgJ6sd6vO/H7ihOBtQegUDtq5iZ4XVUdBnn4OSS
	m+49Ul/sl6u1O9Ktm6Nm9wQgci2Vj8NbNsaj5fHv5lhGIDJ8u3liGWCI/x3c9VXkH+opZoZETty
	xU0M=
X-Google-Smtp-Source: AGHT+IE3upts68brXFHtCgUZLOwM3o5lCWF4GpABF0t9J7ZG7s9Yc+vSHrtuRnRO0FOA9GvPgG9a2w==
X-Received: by 2002:a05:6e02:12ee:b0:360:968d:bf98 with SMTP id l14-20020a056e0212ee00b00360968dbf98mr79056iln.1.1705680224463;
        Fri, 19 Jan 2024 08:03:44 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bc8-20020a056e02008800b0035fe37a9c09sm5645163ilb.20.2024.01.19.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 08:03:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] block/mq-deadline: serialize request dispatching
Date: Fri, 19 Jan 2024 09:02:07 -0700
Message-ID: <20240119160338.1191281-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119160338.1191281-1-axboe@kernel.dk>
References: <20240119160338.1191281-1-axboe@kernel.dk>
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

By itself, this patch doesn't help a whole lot, as the dispatch
lock contention reduction is just eating up by the same dd->lock now
seeing increased insertion contention. But it's required work to be
able to reduce the lock contention in general.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 9b7563e9d638..b579ce282176 100644
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
@@ -600,6 +607,18 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 	enum dd_prio prio;
 
+	/*
+	 * If someone else is already dispatching, skip this one. This will
+	 * defer the next dispatch event to when something completes, and could
+	 * potentially lower the queue depth for contended cases.
+	 *
+	 * See the logic in blk_mq_do_dispatch_sched(), which loops and
+	 * retries if nothing is dispatched.
+	 */
+	if (test_bit(DD_DISPATCHING, &dd->run_state) ||
+	    test_and_set_bit(DD_DISPATCHING, &dd->run_state))
+		return NULL;
+
 	spin_lock(&dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
@@ -616,6 +635,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	}
 
 unlock:
+	clear_bit(DD_DISPATCHING, &dd->run_state);
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -706,6 +726,9 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	eq->elevator_data = dd;
 
+	spin_lock_init(&dd->lock);
+	spin_lock_init(&dd->zone_lock);
+
 	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
@@ -722,8 +745,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
-	spin_lock_init(&dd->lock);
-	spin_lock_init(&dd->zone_lock);
 
 	/* We dispatch from request queue wide instead of hw queue */
 	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
-- 
2.43.0

