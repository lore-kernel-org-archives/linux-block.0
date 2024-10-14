Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1515667B
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898378; cv=none; b=Aol2rTzvZ3rOkyLfd+Tt8ybg+WLquueSk7A/0Vcu3pP33RklVwW0rWdx4HFR5YsmxSYKcnjC3cQ1JDbUMjDYwLLwKEFuzFvIm9538Q2e903KmKV7qnXB4/PnwnyVU1zT2S7nyU2f9lvZfHLW6HuW3aexDTy/UsdSK99lfklOV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898378; c=relaxed/simple;
	bh=Nlu7sy6nlj6YleTyQBt/cJY6uYT2Pq2MXEk7kWoy/Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VXlZA32uAVgA1QirGhhF0G1NyAE62ZCXg3ngHeynjl+JaIn70vXJOk+xzSkHkETOITparV/GEdajIX+f7sI8goqxr2t+e8Ps2/7yOTJEiEga6pfbr9/5bP7IaoCKb8zlz/NQNP84w1zNZBY35uSuv40ehI4IBKb0YtPWDrO3+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AAKMP1BU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AAKMP1BU"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so943666b3a.0
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728898376; x=1729503176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEcd+IiEv1ro72y/n/abcXpVwZU0hZ5zkZIt5HG485g=;
        b=AAKMP1BU8BI9hZ19geOjy1VFvBjhD7kzDez3f8HcKeNxgm64Aw0IUNz5Ei1pTqMO29
         6pT/HeleXMkeL2HLqK0PlnYFzcoBKg4P2MYCo66oX5z8jhqcX6oaPzvGB8IaXBwFnSKn
         RfLzFFwTUu+/JS+neT9Wul3vF0M2NGE9kKcgiw2E76Rm1Ww1as032gZpcM0UG18VCp8U
         y/rrqu+DjVTSdcFJ1RNFT9F6+DP0FNwO188aENlDXmS89mFlCZHZNl3VdraVuuf8bAyJ
         A7rgfMnHLHzEH5+lhnmP69t4RoZAMgW+9CcRyALTpvUjyJvp+8ON4js1I8cwhXrBZADs
         5Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898376; x=1729503176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEcd+IiEv1ro72y/n/abcXpVwZU0hZ5zkZIt5HG485g=;
        b=JICGR/op0M/mWtKMf+H+Af5tTCQDUN3UVi5NhV3BkinEMUsZY6LoLoh+V4m7BXBDMv
         0UJ4W4S2ceOnUDPn3UCk3ri9sE1SVHjXz+xlpNmiKh3mdw8u5b7M8iKqqnZDAr7m5iHv
         IY3acZUmZmiyYewn4XO3OVvk7rKeythMm9Ee1xCCUqRsHyKuBkkh1/iAkfT33LpsYsVc
         3AuZP4Mf0w3E8JTeaJUrWR0yTSKCRdHITl+GFb0PipYRd+d75UZxXQfei0FZ8clB2VBv
         lB54AnviR1J1PaWl0+7+cT4xSHSlvtEJLupvgKrVTI26jMd9uCil1FX5m83L7qPip5+K
         t7mQ==
X-Gm-Message-State: AOJu0YwJ7N29RRh7pMVFHXm2N+50l1THGabLUVBUKhM445pcT3gWHQMM
	0kECC6/4l85qymqpoHZuKpYEVWYgct6lDTxY2PQhU/CT1gyQbSQBQ06T+PSTGU0=
X-Google-Smtp-Source: AGHT+IGGDQPE3jEb4Z4FwIgFqUJjG8GscF+eJJXjCeNI6Tg8DZJVOarNlapFjLz/T1p6Tv1Pf0c13Q==
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71e6489127amr5134515b3a.0.1728898375926;
        Mon, 14 Oct 2024 02:32:55 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e60bbec80sm2339338b3a.95.2024.10.14.02.32.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 02:32:55 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v3 3/3] block: fix ordering between checking BLK_MQ_S_STOPPED and adding requests
Date: Mon, 14 Oct 2024 17:29:34 +0800
Message-Id: <20241014092934.53630-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014092934.53630-1-songmuchun@bytedance.com>
References: <20241014092934.53630-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing first scenario with a virtio_blk driver.

CPU0                        CPU1

blk_mq_try_issue_directly()
  __blk_mq_issue_directly()
    q->mq_ops->queue_rq()
      virtio_queue_rq()
        blk_mq_stop_hw_queue()
                            virtblk_done()
  blk_mq_request_bypass_insert()  1) store
                              blk_mq_start_stopped_hw_queue()
                                clear_bit(BLK_MQ_S_STOPPED)       3) store
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
                                  blk_mq_sched_dispatch_requests()
  blk_mq_run_hw_queue()
    if (!blk_mq_hctx_has_pending())
      return
    blk_mq_sched_dispatch_requests()
      if (blk_mq_hctx_stopped())  2) load
        return
      __blk_mq_sched_dispatch_requests()

Supposing another scenario.

CPU0                        CPU1

blk_mq_requeue_work()
  blk_mq_insert_request() 1) store
                            virtblk_done()
                              blk_mq_start_stopped_hw_queue()
  blk_mq_run_hw_queues()        clear_bit(BLK_MQ_S_STOPPED)       3) store
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
                                  blk_mq_sched_dispatch_requests()
    if (blk_mq_hctx_stopped())  2) load
      continue
    blk_mq_run_hw_queue()

Both scenarios are similar, the full memory barrier should be inserted
between 1) and 2), as well as between 3) and 4) to make sure that either
CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list.
Otherwise, either CPU will not rerun the hardware queue causing starvation
of the request.

The easy way to fix it is to add the essential full memory barrier into
helper of blk_mq_hctx_stopped(). In order to not affect the fast path
(hardware queue is not stopped most of the time), we only insert the
barrier into the slow path. Actually, only slow path needs to care about
missing of dispatching the request to the low-level device driver.

Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c |  6 ++++++
 block/blk-mq.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ff6df6c7eeb25..b90c1680cb780 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2413,6 +2413,12 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	/*
+	 * Pairs with the smp_mb() in blk_mq_hctx_stopped() to order the
+	 * clearing of BLK_MQ_S_STOPPED above and the checking of dispatch
+	 * list in the subsequent routine.
+	 */
+	smp_mb__after_atomic();
 	blk_mq_run_hw_queue(hctx, async);
 }
 EXPORT_SYMBOL_GPL(blk_mq_start_stopped_hw_queue);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 260beea8e332c..f36f3bff70d86 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -228,6 +228,19 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
+	/* Fast path: hardware queue is not stopped most of the time. */
+	if (likely(!test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
+		return false;
+
+	/*
+	 * This barrier is used to order adding of dispatch list before and
+	 * the test of BLK_MQ_S_STOPPED below. Pairs with the memory barrier
+	 * in blk_mq_start_stopped_hw_queue() so that dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list is not
+	 * empty to avoid missing dispatching requests.
+	 */
+	smp_mb();
+
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
-- 
2.20.1

