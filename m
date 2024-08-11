Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCC56452
	for <linux-block@vger.kernel.org>; Sun, 11 Aug 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371588; cv=none; b=DxZQWw4Dyv6eVVnob2/oSYKyEGh4HrtBYcBvZu22Z6QblZK2tXmSdk1bMAwktKY7ROg58RPdxzVvdIwt01SbPB8lOx9b7agnKN+GfeuK9gNAArzHRCiHNJJOzsv4oKQRaa4v01YbGPx6kv26ei9r/4Ahk1lFAdcJd4nw742mh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371588; c=relaxed/simple;
	bh=yv62PE+HHdpS6svbT+CRG1qAc/38LkE6TMF1vR09V/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iURvo9/UQoud/tJYdgdHm0l08X/XRJTAHGXLqNMOeExGcdXvgGsHAFiS0iFsPk3c6vs2/vXQp2Zhyyvf8uQMrcMAjabSb6lcsEhVr3ZtUIxdSEzsS5sYJQysPv9ifuXektawpe81mm7lXR+Krza6BbrPCxXaniCckCZTj56r1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OTwUzk6L; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTwUzk6L"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc4fcbb131so26121405ad.3
        for <linux-block@vger.kernel.org>; Sun, 11 Aug 2024 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723371586; x=1723976386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeL46knJ+ZqHC6WT5dXT2aP7zuNbEux3//I19LuUM/0=;
        b=OTwUzk6L5nbjJxLvTk57t2KBqvW1ZODkQks7xyGlW9FJXhnQxFnZVagL4ECEzMFg9U
         9/J9GkvjfRQKeLjxV5i2hCMnb3hMMpUrMUpZEalrVwsrRSbYUZTBuFWNaa0T7Xavw+Cj
         Rt5mCKkx+kNGo6YwZNDAsyWwtUD9+bs1pyjWxqgT5EafV70n4UZFOhB3yrbR1KSRieUx
         gjI62/b3XrfBFUOLc8bYEnHXoqkQbh166rcWJSpwj10bjHeDbREs6oeMTC9bHLM1p3Za
         Gf8sFp8OTrmENp+C/mpqIk10P7mrm2iw6tD19hLTqqUbyulnI8xfiMYAr6gqIJguKYUy
         iaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371586; x=1723976386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeL46knJ+ZqHC6WT5dXT2aP7zuNbEux3//I19LuUM/0=;
        b=PYjhH+bMB9mF9DeglYuPOjifxIIq2xYe95gKvSXAZq+8BUNeqIIgivttJJnVyP0ZZd
         MU8cHBDX5Wwr35zAwZhBygaiVeF7Nmxkuo2pJAf7dTZOlh8VPCJaiVY8pQBG2xWzB2TF
         DaWv8i9luPbFjr7GnXC2uZARYfoa595RL1ALPzS1YUTHw5wrwhss2nqpKqdTDB1m9ccg
         pz9ENn/WWqBKvvHAf5JA1WUEsh7cezPC8S/56kMjJu7YMDY5p4WdQZlK7RRO4dLfUNwt
         fCVLaWyv9s8FAyU/1ILGTxds1GOEDpIb04cvVq9bs/0UPW4m3jy1ZEondzosj+R+R0Jz
         BciA==
X-Gm-Message-State: AOJu0YxZfl8HLdB8I3Abt1aQlDT9wp0ky3QAcd9Ow3HGiZdhQqx3a4B0
	SdQPRoU4kLKm/rb+FQHBuW9DQkGwWfvW5c8m2oPje6B7A7tZLuQRoLh48tsa/1A=
X-Google-Smtp-Source: AGHT+IEQlVNibHSTFhZ2s10HfYkPh8ARzQx4wM3RfJLUDq+guzel8WQQIkhmkI9Swx2NtwrIvNj/lw==
X-Received: by 2002:a17:902:ced0:b0:1fb:2e9a:beea with SMTP id d9443c01a7336-200ae258491mr73318225ad.0.1723371585843;
        Sun, 11 Aug 2024 03:19:45 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb48b81sm20992155ad.297.2024.08.11.03.19.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Aug 2024 03:19:45 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/4] block: fix fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
Date: Sun, 11 Aug 2024 18:19:21 +0800
Message-Id: <20240811101921.4031-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240811101921.4031-1-songmuchun@bytedance.com>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario.

CPU0                                                                CPU1

blk_mq_request_issue_directly()                                     blk_mq_unquiesce_queue()
    if (blk_queue_quiesced())                                           blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
        blk_mq_insert_request()                                         blk_mq_run_hw_queues()
            /*                                                              blk_mq_run_hw_queue()
             * Add request to dispatch list or set bitmap of                    if (!blk_mq_hctx_has_pending())     4) load
             * software queue.                  1) store                            return
             */
        blk_mq_run_hw_queue()
            if (blk_queue_quiesced())           2) load
                return
            blk_mq_sched_dispatch_requests()

The full memory barrier should be inserted between 1) and 2), as well as
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
Otherwise, either CPU will not re-run the hardware queue causing starvation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-mq.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 385a74e566874..66b21407a9a6c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -264,6 +264,13 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 		;
 	} else if (!--q->quiesce_depth) {
 		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+		/**
+		 * The need of memory barrier is in blk_mq_run_hw_queues() to
+		 * make sure clearing of QUEUE_FLAG_QUIESCED is before the
+		 * checking of dispatch list or bitmap of any software queue.
+		 *
+		 * smp_mb__after_atomic();
+		 */
 		run_queue = true;
 	}
 	spin_unlock_irqrestore(&q->queue_lock, flags);
@@ -2222,6 +2229,21 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	bool need_run;
 
+	/*
+	 * This barrier is used to order adding of dispatch list or setting
+	 * of bitmap of any software queue outside of this function and the
+	 * test of BLK_MQ_S_STOPPED in the following routine. Pairs with the
+	 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
+	 * of bitmap of any software queue to avoid missing dispatching
+	 * requests.
+	 *
+	 * This barrier is also used to order adding of dispatch list or
+	 * setting of bitmap of any software queue outside of this function
+	 * and test of QUEUE_FLAG_QUIESCED below.
+	 */
+	smp_mb();
+
 	/*
 	 * We can't run the queue inline with interrupts disabled.
 	 */
@@ -2244,17 +2266,6 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	if (!need_run)
 		return;
 
-	/*
-	 * This barrier is used to order adding of dispatch list or setting
-	 * of bitmap of any software queue outside of this function and the
-	 * test of BLK_MQ_S_STOPPED in the following routine. Pairs with the
-	 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code could
-	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
-	 * of bitmap of any software queue to avoid missing dispatching
-	 * requests.
-	 */
-	smp_mb();
-
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
 		return;
@@ -2308,6 +2319,11 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
 	 * of bitmap of any software queue to avoid missing dispatching
 	 * requests.
+	 *
+	 * This barrier is also used to order clearing of QUEUE_FLAG_QUIESCED
+	 * outside of this function in blk_mq_unquiesce_queue() and checking
+	 * of dispatch list or bitmap of any software queue in
+	 * blk_mq_run_hw_queue().
 	 */
 	smp_mb();
 
-- 
2.20.1

