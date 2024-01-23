Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FF811EA
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031639; cv=none; b=qkDfhkG9D3kcxTP/aP43UBjwxuJ8EEONwKgkY2TBS6R9gZkdmIbYEtYIkJIdP3MObF4DmW+eBV5GY2ADR2nBMo6vEWp0AK3ZdqoDiMFd2Lm6P8fdElcl4XlAMG4zIYV8fSB5ejNxHykTjJe60rsKBpbrBbMvIxPsyN8D/INYN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031639; c=relaxed/simple;
	bh=CyIXnGLP8A2y0N34/5wGJIe6MOdy+ZpqA6rH5AtvyPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe4FST8U2AZEvMHGcRrm7ooIt/98y8oP6+DUrmmpQJ8UaI888MhlAYjF1AhYPpwmRPYP1AOsrmCiMsRj35G2N1Z+YjUBZ6l+WY/gVWHTUEOMr+qEWJkoN2zMOh1NxE7zcG5tRcoNKPDeUkNSmoTbFfArUjf3h8Oucuz1uyQbNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L8FqDbDv; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L8FqDbDv"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so51897539f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031636; x=1706636436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t1KcTyX6xNZnJSO32AqKQbAhtDMC9k+fof8yKQwd4E=;
        b=L8FqDbDvWcoiiRHMzOm3OVg1/ma590HBAqpEtiHLmr33VNmcN4L7aTvoszmtYlCXue
         16o+4pg1KtUUFuMhNsw99xNKIfFkGp5ejvVF6xlH9iDZMKhrHC8XrsMsAjhLPzCApNpg
         COz5/zOVB2JLRIc88p+coUObPp6xJNX4hXV8P1rzexUer12ej9SN3uT2QTvaGsAXNZs8
         zXiSzS97ib6Ob18qW6g1//Wt1Og8N5jSsD4gSMst0zVZVTMFK7MkZLnB5GlaB3X7xOIj
         jOWoqsMf94dgURYoXtC1zCJvWXwWUX3N0OAd8rKhpu1JXXyMV70DMRcA9hn/gpDXejjw
         trXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031636; x=1706636436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t1KcTyX6xNZnJSO32AqKQbAhtDMC9k+fof8yKQwd4E=;
        b=fh97nI2NsnguojizinutbNLtAm6rzIj5sM6JWrj+eSwOM9KnW36eKQx9AZwPYgGKPI
         XHq1lBKe51jamC//lZwkJS34ILJoEmBBV0OsbWX2rd8jbjrcY3+d65ng4YHaiHeG6iBi
         TwdUDT3Oq1On6ghKh020y3dCaa8VOKvGeTmps49x0bl2TDG+053ip7UZARlT79o5THEi
         SyrZ8ZA/1jgkGX1xasegjI3Gu2qxXCC4dwPCUs1ynmu9C1IqOWoYA3IyEeo/vI3X74+W
         R1zzx4duz1kOje1DZ59luOkYMR/ztAnstAy2dl109CrTKqVdJGbZNbBavO3380nbUWAr
         bb0g==
X-Gm-Message-State: AOJu0Yw9SDWUxj+qoq3Z1dFP01MW9SdbHLKI4D2TBGMcGM5u9m33fgH9
	NJoi0uj6PUaPR4qky3IInwmb03Ib8aWiXjGNZRaZFTgoW2wYY7mL9TIOqoFuTD3LGBORfIbpedy
	AtaI=
X-Google-Smtp-Source: AGHT+IHGj6oyke1phBHLOCKfyYkqGZEgsHn0v/qIKHCb4ZRaSvF40RX54etbhQ23RvjlunauNLvLsg==
X-Received: by 2002:a05:6602:123b:b0:7be:edbc:629f with SMTP id z27-20020a056602123b00b007beedbc629fmr10390915iot.0.1706031635143;
        Tue, 23 Jan 2024 09:40:35 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] block/bfq: serialize request dispatching
Date: Tue, 23 Jan 2024 10:34:18 -0700
Message-ID: <20240123174021.1967461-7-axboe@kernel.dk>
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
 block/bfq-iosched.c | 17 +++++++++++++++--
 block/bfq-iosched.h | 12 ++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7d08442474ec..5ef4a4eba572 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5304,6 +5304,18 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct bfq_queue *in_serv_queue;
 	bool waiting_rq, idle_timer_disabled = false;
 
+	/*
+	 * If someone else is already dispatching, skip this one. This will
+	 * defer the next dispatch event to when something completes, and could
+	 * potentially lower the queue depth for contended cases.
+	 *
+	 * See the logic in blk_mq_do_dispatch_sched(), which loops and
+	 * retries if nothing is dispatched.
+	 */
+	if (test_bit(BFQ_DISPATCHING, &bfqd->run_state) ||
+	    test_and_set_bit_lock(BFQ_DISPATCHING, &bfqd->run_state))
+		return NULL;
+
 	spin_lock_irq(&bfqd->lock);
 
 	in_serv_queue = bfqd->in_service_queue;
@@ -5315,6 +5327,7 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
 	}
 
+	clear_bit_unlock(BFQ_DISPATCHING, &bfqd->run_state);
 	spin_unlock_irq(&bfqd->lock);
 	bfq_update_dispatch_stats(hctx->queue, rq,
 			idle_timer_disabled ? in_serv_queue : NULL,
@@ -7210,6 +7223,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	q->elevator = eq;
 	spin_unlock_irq(&q->queue_lock);
 
+	spin_lock_init(&bfqd->lock);
+
 	/*
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
 	 * Grab a permanent reference to it, so that the normal code flow
@@ -7328,8 +7343,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	/* see comments on the definition of next field inside bfq_data */
 	bfqd->actuator_load_threshold = 4;
 
-	spin_lock_init(&bfqd->lock);
-
 	/*
 	 * The invocation of the next bfq_create_group_hierarchy
 	 * function is the head of a chain of function calls
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 467e8cfc41a2..56ff69f22163 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -504,12 +504,22 @@ struct bfq_io_cq {
 	unsigned int requests;	/* Number of requests this process has in flight */
 };
 
+enum {
+	BFQ_DISPATCHING	= 0,
+};
+
 /**
  * struct bfq_data - per-device data structure.
  *
  * All the fields are protected by @lock.
  */
 struct bfq_data {
+	struct {
+		spinlock_t lock;
+	} ____cacheline_aligned_in_smp;
+
+	unsigned long run_state;
+
 	/* device request queue */
 	struct request_queue *queue;
 	/* dispatch queue */
@@ -795,8 +805,6 @@ struct bfq_data {
 	/* fallback dummy bfqq for extreme OOM conditions */
 	struct bfq_queue oom_bfqq;
 
-	spinlock_t lock;
-
 	/*
 	 * bic associated with the task issuing current bio for
 	 * merging. This and the next field are used as a support to
-- 
2.43.0

