Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F264D8BD
	for <linux-block@vger.kernel.org>; Sun, 11 Aug 2024 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371585; cv=none; b=dC4gBw0tRDIshDztyQ60jTyvLTFD+JHAjx1WIHg/lheRjImEYVWFAV+KZsorTMVUT8oQx7XovHA5+HwF+YgRp1LPKibgi+n7P29NWy5CkxjKG1UwUjB84JrPla/2BAv+egk3m33X3wR2V5v51rcA8YfSBo4KJivqkE0F4X1br7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371585; c=relaxed/simple;
	bh=/1eM/KOiyGmp7R3yAOpaP4qJdimrFBpaEBE6Erne01k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMIkLJZYNdpjX0CbDjIP7BRhvR7mlpviMSi1/pO8Hfn0BOGT3JSn9iZdGQl0NI1x+7/XAK7B1mv57jcWbwCOhva370yOTlpAYgHj7r7+ZylVsMSLUwa8kATcx/LpAa9PQitCUjDgUZE3dSuhufuDIUl3EUBTxzX2Mr8Pc8d25g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S2LqvYBy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S2LqvYBy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd640a6454so26965385ad.3
        for <linux-block@vger.kernel.org>; Sun, 11 Aug 2024 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723371583; x=1723976383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIZMdYQrQP44xaCgPEOO0G1aVB5mHBqSKoNfWGusOBY=;
        b=S2LqvYByH6OxwVMYRv9+E5xUu7m2fik90U84BdZpvgFlYYPO8QjSXs6xEgxSIDVtE7
         ILDhh7M1UAd6H8PAEm1NOdBuHQsvn5cueHzA8rx5LZQPkl03LkGwttCghjdx6WUncdoA
         FLuy9vUVe0+WF5nEnGrIB31uq8LoAOADiAirjEs1ecKyUWPNbDfcluZw6Y2amKyRMpgF
         kzWY+iGPhyL5mSKgVUY/kcdSC4oQN0Pr2iCj6Ai6jb+TKRofKxOv/lMulWJ/CKo2MmYr
         tOeijUBAjWEKGUwEBO9yWRig82D1NpINxk9djJpTK9wyNXnDMgHSdjg2f8cLNaA5T81z
         cPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371583; x=1723976383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIZMdYQrQP44xaCgPEOO0G1aVB5mHBqSKoNfWGusOBY=;
        b=JHJGixDCvZOhqO+jXuhg4oWeiZmqZtWR0JGt7Zf3BKZ2IThLbwv8Vl9XuoO9AP73RF
         z7Llf7m/VbF0s0PA5Yhps05Y89VMwALyfS+PCQjuVC1aSHu/QFm70SESBH4KPGwrv8J2
         JK6t/DFM7XDtxa6GcLtOiQOdUg8YPxtzQkdC6wX1jzp9yFNjeUCT/d3KjxWX1BFH4I7d
         wvlttGKnIzH5qm5EJpNgQT0tV3zZK4iEofHX+yAJdiXMeO9bT+YWjv7hCU5OWIGyh4+c
         xFS+qt+S69/YxUyUTOaY5u48V0qJNimhW3yFQBQuRxhu5j74x2vfUpNac56HZWg8ez5q
         q2vg==
X-Gm-Message-State: AOJu0Yys6LXDVr4jbnMeqE6x4rTjY0Qxxwa2qr6LZwiNUpM9u4VmDNXr
	i2BZXKLB88EhbXb6XFzbJJ9ODpOmT/ePIgGOPIf35CxT6zfBwfJpPqzsooF1aXo=
X-Google-Smtp-Source: AGHT+IEmgTi5qvtkHw8I1YhlxEDcSWuSsse8TTFfstC3EcNNkAaqrvnRF74AUV8RBR/aZ18EZX8wiQ==
X-Received: by 2002:a17:902:ea12:b0:1fd:a503:88f0 with SMTP id d9443c01a7336-200ae597a39mr56929905ad.34.1723371582987;
        Sun, 11 Aug 2024 03:19:42 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb48b81sm20992155ad.297.2024.08.11.03.19.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Aug 2024 03:19:42 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/4] block: fix missing smp_mb in blk_mq_{delay_}run_hw_queues
Date: Sun, 11 Aug 2024 18:19:20 +0800
Message-Id: <20240811101921.4031-4-songmuchun@bytedance.com>
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

Supposing the following scenario with a virtio_blk driver.

CPU0                                                                CPU1

/*
 * Add request to dispatch list or set bitmap of
 * software queue.                      1) store                    virtblk_done()
 */
blk_mq_run_hw_queues()/blk_mq_delay_run_hw_queues()                     blk_mq_start_stopped_hw_queues()
    if (blk_mq_hctx_stopped())          2) load                             blk_mq_start_stopped_hw_queue()
        continue                                                                clear_bit(BLK_MQ_S_STOPPED)                 3) store
    blk_mq_run_hw_queue()/blk_mq_delay_run_hw_queue()                           blk_mq_run_hw_queue()
                                                                                    if (!blk_mq_hctx_has_pending())         4) load
                                                                                        return
                                                                                    blk_mq_sched_dispatch_requests()

The full memory barrier should be inserted between 1) and 2), as well as between
3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1
sees dispatch list or setting of bitmap of software queue. Otherwise, either CPU
will not re-run the hardware queue causing starvation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-mq.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6f18993b8f454..385a74e566874 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2299,6 +2299,18 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	sq_hctx = NULL;
 	if (blk_queue_sq_sched(q))
 		sq_hctx = blk_mq_get_sq_hctx(q);
+
+	/*
+	 * This barrier is used to order adding of dispatch list or setting
+	 * of bitmap of any software queue outside of this function and the
+	 * test of BLK_MQ_S_STOPPED in the following routine. Pairs with the
+	 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
+	 * of bitmap of any software queue to avoid missing dispatching
+	 * requests.
+	 */
+	smp_mb();
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
 			continue;
@@ -2327,6 +2339,18 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 	sq_hctx = NULL;
 	if (blk_queue_sq_sched(q))
 		sq_hctx = blk_mq_get_sq_hctx(q);
+
+	/*
+	 * This barrier is used to order adding of dispatch list or setting
+	 * of bitmap of any software queue outside of this function and the
+	 * test of BLK_MQ_S_STOPPED in the following routine. Pairs with the
+	 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
+	 * of bitmap of any software queue to avoid missing dispatching
+	 * requests.
+	 */
+	smp_mb();
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
 			continue;
-- 
2.20.1

