Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F219D098
	for <linux-block@vger.kernel.org>; Sat, 14 Sep 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299060; cv=none; b=GCqwi8ufPcOXGl/bbbO76rj8hmHBGARlX5gWjREqMXAUtfEPijVYzDHfcChGUBbtMWM9d0De81fXK+358/hCP05fo0dI8zgZTpwk8zzfBacsKD/vkQGEM08tmb6Afgns4Id4R/ORM5GHZm61fVnPipHs+HQ1+JYeB6L1v2DMXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299060; c=relaxed/simple;
	bh=KPYlAEycxQewUTOUahfTRncxoD2+pw617t+q4Tal4uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VrF2KBz1yFYgsIPvDNMSdE2wa3xGUKz1w/sj8DArxOZ1JKj/ShTeJdVIczemcBqKU7vKsjlGye7Oz73OcEri9gB1DefZowQ9j8vNsZiuOLavQn0GNpSewC9Gussj/71J1Pgb5WY0rtB4XA32JAlzrPbpkhktQaHFfXIQIa1KUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ROPYQzDg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ROPYQzDg"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718d606726cso1911303b3a.3
        for <linux-block@vger.kernel.org>; Sat, 14 Sep 2024 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726299058; x=1726903858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08ooLorU1l3a5zJ7wHu/dTOBgAYH9XEx3vZXzuZBYRU=;
        b=ROPYQzDgQr5oHOSBnoXaq9/UzDSftmVWVuR6JKwj/zXA8dYrTapQHCRtGHuEeNYDCt
         /16zmyOk7fI/NEUcQHshR4U7SXRm2k/JsSMDzWpIeHNufqCNBnhTJPz2XV3C9rfIDGKw
         I0zcQhZ6rn9hqsLagME57Rg/YdxKvKemarvP4kDNl9dlAucB/lrYiosoSkPnfMY2Ye8C
         ZYT6mF96xIc6/bXkMHdMAyM5yiRyXunOGjJSzhtkfkiC6stnZ5H6HoRXU0j289/XgSsh
         szVUY2GnW8B5IpZWjmtmQiQWU2Ysya1w6Bvh/D3hL1gNFK40iBI8FivEikDrC1OlkTBM
         fziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726299058; x=1726903858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08ooLorU1l3a5zJ7wHu/dTOBgAYH9XEx3vZXzuZBYRU=;
        b=IW/1nxX8WlcWXkIr4yqaCyyJG1sHN3/oov8tqq+El0n0/7LV7ZrpR+1mublTLu+gOD
         KuOLfshewxU8/NionyIVWCEii3+O78fi+8DUQbobCBFPC4jlP7JLJOmN/1NgxMjq01ip
         8pJ0+jyjyyTHtThxB3gQKiagHdZdD0hb3TiTRluOXCGqGns14ZjI9MUUQKScpob8XLiM
         WTcetsRhoDTaq1Y+A+jH97ah2BotHnw2GYmG1xrTj/4Ma10nFGW5qUzGslIkC+I6MeYs
         VMPnCsFP68+Io2sedmhQp8rwIoVNKAJ+5yoZRAvuTIepMfAiaJJMpxz741JUIoDwfhfl
         z+yw==
X-Gm-Message-State: AOJu0YyXBbScbGUiEdS+9AyOxGFgKz/ILgy91cIWkqsMeQ2CDB60Zatd
	eR1dEYnBNVHNR0ttv6apXyXq2PRIGRD8ife34tRMmAM9GEp4GvNcOHSkLV7gekY=
X-Google-Smtp-Source: AGHT+IGZG9wrGWEYM7ouukqw6bRDRDCHTs/ZJP2/izZHnuPe05qp1RIBdiw0AkIVpTS2FuGBrP35Tg==
X-Received: by 2002:a05:6a00:1883:b0:706:58ef:613 with SMTP id d2e1a72fcca58-719262066efmr13431606b3a.27.1726299058203;
        Sat, 14 Sep 2024 00:30:58 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ac05sm555687b3a.155.2024.09.14.00.30.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Sep 2024 00:30:57 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests
Date: Sat, 14 Sep 2024 15:28:43 +0800
Message-Id: <20240914072844.18150-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240914072844.18150-1-songmuchun@bytedance.com>
References: <20240914072844.18150-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario.

CPU0                        CPU1

blk_mq_insert_request()     1) store
                            blk_mq_unquiesce_queue()
                            blk_queue_flag_clear()                3) store
                              blk_mq_run_hw_queues()
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
blk_mq_run_hw_queue()
  if (blk_queue_quiesced()) 2) load
    return
  blk_mq_sched_dispatch_requests()

The full memory barrier should be inserted between 1) and 2), as well as
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
Otherwise, either CPU will not rerun the hardware queue causing starvation.

So the first solution is to 1) add a pair of memory barrier to fix the
problem, another solution is to 2) use hctx->queue->queue_lock to
synchronize QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory
barrier is not easy to be maintained.

Fixes: f4560ffe8cec ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2d0f22de0c7f..ff6df6c7eeb25 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
+static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
+{
+	bool need_run;
+
+	/*
+	 * When queue is quiesced, we may be switching io scheduler, or
+	 * updating nr_hw_queues, or other things, and we can't run queue
+	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
+	 *
+	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
+	 * quiesced.
+	 */
+	__blk_mq_run_dispatch_ops(hctx->queue, false,
+		need_run = !blk_queue_quiesced(hctx->queue) &&
+		blk_mq_hctx_has_pending(hctx));
+	return need_run;
+}
+
 /**
  * blk_mq_run_hw_queue - Start to run a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
@@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
 
-	/*
-	 * When queue is quiesced, we may be switching io scheduler, or
-	 * updating nr_hw_queues, or other things, and we can't run queue
-	 * any more, even __blk_mq_hctx_has_pending() can't be called safely.
-	 *
-	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
-	 * quiesced.
-	 */
-	__blk_mq_run_dispatch_ops(hctx->queue, false,
-		need_run = !blk_queue_quiesced(hctx->queue) &&
-		blk_mq_hctx_has_pending(hctx));
+	need_run = blk_mq_hw_queue_need_run(hctx);
+	if (!need_run) {
+		unsigned long flags;
 
-	if (!need_run)
-		return;
+		/*
+		 * Synchronize with blk_mq_unquiesce_queue(), because we check
+		 * if hw queue is quiesced locklessly above, we need the use
+		 * ->queue_lock to make sure we see the up-to-date status to
+		 * not miss rerunning the hw queue.
+		 */
+		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		need_run = blk_mq_hw_queue_need_run(hctx);
+		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
+
+		if (!need_run)
+			return;
+	}
 
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
-- 
2.20.1

