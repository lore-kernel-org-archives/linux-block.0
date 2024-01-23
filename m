Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E180039
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031631; cv=none; b=o06StOyzVpbgHceZJqrIZhuQWWzx3xnJZV6E51F+oE1ekj4/3wfNEME0sM11GtN1MO0Jc78NBUhnLcbunYYfuyOpjm4qg2YrYbbauLN2b1bLoo/yALsNY06W2Odm/GdNpNLGj7KdrRjcadGHtizi4YKnEQZ05rqH1NLTUK2aNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031631; c=relaxed/simple;
	bh=HKjrUm09tWm2y8NxmKTbCZTTthQcNTD7sCcoEi7D7q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB3J2nJwYTfeAwA3snQFyA7cMuuWbFI/h+UWHpllXOLFq34Q8OHiPTNDt1jyw9AaYAYpDYSRwLhpQTbMxatOVy2A+TAneeb3PCjeviWm7UIQ/0dYnIc3xsYDr4MSLv9KTfbJt/7IRTU84uNM/5zUACYH01Loei4L1ukDfP+1/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UoixmkBv; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UoixmkBv"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so51895939f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031628; x=1706636428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPFAUZtHFunfe8V5aVWd0ro+6nJcJ7bLRkCM9nE4cp8=;
        b=UoixmkBvrw6aWutFPz5smkSMw8vHw+pT5u4GPeXJEi9YDia4Z2CohRCoMwKkUUBBDD
         Ht3tzLZJ3YUfx8Nspo7BqzhbVJ9+uS7QN0YmuXWwZLrBcJTnzZ+PuGss3BoUsu09V/LA
         kRJqt4NVm1NUdfK9D1ANMtQRkjX3bQ/DtZc41QSikMuGy3WJayPMNjAmP8yWZqB3pcDr
         05x9zHUwBGzRD2qjOoKhvweD3szfkOnoOWwx4IrWu9CkDo0l0KrBnr28Q7+anCpn7ZA3
         8gQ1i9JMgMotcrAPfajKT+zHnGfoShTzRCKmRw+aiS2N0tvvTUKQpoD7sDGk4lSm3XjL
         wJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031628; x=1706636428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPFAUZtHFunfe8V5aVWd0ro+6nJcJ7bLRkCM9nE4cp8=;
        b=DN+cp0HxNWbsUKEfoVMoXqeE1ZMu9aA3Gba5w0pIKZPkYn7N6AZNffa7wD0fdJCLPx
         /4ZnCmHFiuBDObSAAQwukHOJGLbl99mBHBaEKHYRJ3ME34UYSIF7hi9LhSrgD4NCZfhw
         a6fHdTruol7E2GmeelSoU1jr2rV5xwGBbV3EOWJRLc665o5zDCR/bfp9g8z7XKOcYf5I
         +s7da+nlIwKJDUtY+T8BM9Km9wT7B51A+7z1e2Lnnad3b7WAUdn1nzeMbjulamOKTcw6
         NfIZcE01gUMzgcRy1ytfJUnzBhEoBf3b9ym3fexcxwmOmjbEY99747cB6oXcO6AR8C35
         xEtQ==
X-Gm-Message-State: AOJu0Yww46hZ0Hob5+s2Ql4ApuqkQT2X27Qz5Vc9VmwqqhXviA5aLukJ
	Up8RnxAdy2WT6DhnhHeCer/b8OjJCD54f7tvgp8sAgZmxZBQFjwUcYeiYBKdtxnC/68mzcsK/LQ
	nO5M=
X-Google-Smtp-Source: AGHT+IFVg2nRmNdwqYXo4ThEpQ+hr3WQeAXgGMqtk9FoTK7TK/ofcrUdXLLLfivod0DtcY+FlM8Dwg==
X-Received: by 2002:a05:6602:123b:b0:7be:edbc:629f with SMTP id z27-20020a056602123b00b007beedbc629fmr10390570iot.0.1706031627890;
        Tue, 23 Jan 2024 09:40:27 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] block/mq-deadline: serialize request dispatching
Date: Tue, 23 Jan 2024 10:34:14 -0700
Message-ID: <20240123174021.1967461-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123174021.1967461-1-axboe@kernel.dk>
References: <20240123174021.1967461-1-axboe@kernel.dk>
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
index 9b7563e9d638..79bc3b6784b3 100644
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
+	    test_and_set_bit_lock(DD_DISPATCHING, &dd->run_state))
+		return NULL;
+
 	spin_lock(&dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
@@ -616,6 +635,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	}
 
 unlock:
+	clear_bit_unlock(DD_DISPATCHING, &dd->run_state);
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

