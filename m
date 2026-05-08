Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461B2F8EA9
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230247; cv=none; b=p6FkMlMDUfVXzoTPkrrY2i3BNg7ST1taqyY+lZb+7a/kYvNQAsurOAyw5fpQ8ilPYEM3ZM0WkYUCucEodNXYDU5T1Ub22+vZ3vawinKm2p2IS8kr3zbjl/9dFHY882Z5FkC0Cna7C2XFzXOv8eoMG+vh0zI97p0cBhlKOp5xcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230247; c=relaxed/simple;
	bh=PE9EIJRDSFXQ0GiM9MkcUIHGlokeliwyI9Q259F+kK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WFLcpTqS6UDh3HxMRMotQK+WvDrDBBnvSF5vNDq3/U47XwNke4ms5dDWeTpQOItFw72BJpfjotWTDDD1RWZRVFNaZYSzpcKcStTG8A8qKJxWmoGupQI8CYmJaHKVnCaUnyMKCUyuThdRz2qAX5iDUR4xBnmGoIIxgoI/TTu8isM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udnuTRBg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udnuTRBg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82346bdb00so2061890a12.0
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778230246; x=1778835046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGFRFy1WoEV55J2RPFTdCgdsXVvquGiPRRD2auMcPnE=;
        b=udnuTRBgY1HGwUN7XImYPIp+07hQXRSp3peLAC6uoGsMu4fkc7RYukO5PcH8PE3KUI
         hG83jUQ8wro1UBJhtzRKZyC0WYkJr1vK7DZbXTuNGOTcMiRIrOID6LciLvU7H0q6tIwN
         LmEY9UCRdE39p/F1EKRx6QCC9xBHF2KKCVJXvFm8f6Wm/a0p91oSgmlt7aE2mq6zQVgK
         kmmgoo2J49jxG4jlMm6+PfhUcHpMoAt+CnDzrYV+MFJ7W2MTzUplKNX3/RC1P4nIPTsb
         gduhqmumiQmF6u2t3pJzeDXAjXdzVTXEenxb1yzf2sqBs7c06djYbKHx2L6Fai++YC3c
         KFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778230246; x=1778835046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGFRFy1WoEV55J2RPFTdCgdsXVvquGiPRRD2auMcPnE=;
        b=qDKqmRHnMSod+g2Z503wMX2X2hUYBguVgeJW6st1TZUBNjfJrO2olXTDf8ZxDIk8HQ
         +VMx+vLbxGkg71jCEl3OITDs2MudBJV+3Gpj4jRE79BMoI/6I7cryfjPWdB42ZkGbXi7
         wytROaIwwBU66CGXoFpUb542dKcgRO6u944vnlrOEgvkEgOWGWwj60E0Qfr/zgxPLJQD
         5e0Lwe3kypfXblOreU2mfwyUvV9GmPPFbHxLH4YW6va3N4p/sJUkZwdcL3E+0WDYrbEB
         S2jfOiHbdE3Vazn3CROTt1ZZRVfGl5AWDIDxDTLTPrTTvGzqmGRnl5gm+o5feERGcUxw
         39DQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VKdA8JRdgOmAwuvEQgPEg1sEEZfv1dpqcBJ2dstrrx+oahdzdnBgtNR0a1DtMDBQkyaW4MDoYxKelbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaku6XYKz/WaQz2uK1dm1zzF4nKvrd0e+mfTx++eggfNEqrcFl
	PxdZLH9ixrvnMyXrYmxmCF4RzVqAph+/Av2pOWbl30j/xgQUvdE3PEHvPCebzyf+u+DIZbmC1tq
	doWTnAhYmeXdValVb/NzP
X-Received: from pgww20.prod.google.com ([2002:a05:6a02:2c94:b0:c76:5ef4:ec3])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d91:b0:3a8:236a:7df2 with SMTP id adf61e73a8af0-3aa5abc86a4mr12929465637.44.1778230245628;
 Fri, 08 May 2026 01:50:45 -0700 (PDT)
Date: Fri,  8 May 2026 08:49:33 +0000
In-Reply-To: <af1BNwmyHK6aU_uT@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <af1BNwmyHK6aU_uT@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508084933.3730661-1-richardycc@google.com>
Subject: [PATCH v2] zram: fix use-after-free in zram_writeback_endio
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>
Content-Type: text/plain; charset="UTF-8"

A crash was observed in zram_writeback_endio due to a NULL pointer
dereference in wake_up. The root cause is a race condition between the
bio completion handler (zram_writeback_endio) and the writeback task.

In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
releasing wb_ctl->done_lock. This creates a race window where the
writeback task can see num_inflight become 0, return, and free wb_ctl
before zram_writeback_endio calls wake_up().

CPU 0 (zram_writeback_endio)     CPU 1 (writeback_store)
============================     ============================
                                 zram_writeback_slots
                                   zram_submit_wb_request
                                   zram_submit_wb_request
                                   wait_event(wb_ctl->done_wait)
spin_lock(&wb_ctl->done_lock);
list_add(&req->entry, &wb_ctl->done_reqs);
spin_unlock(&wb_ctl->done_lock);
wake_up(&wb_ctl->done_wait);
                                   zram_complete_done_reqs
spin_lock(&wb_ctl->done_lock);
list_add(&req->entry, &wb_ctl->done_reqs);
spin_unlock(&wb_ctl->done_lock);
                                   while (num_inflight) > 0)
                                     spin_lock(&wb_ctl->done_lock);
                                     list_del(&req->entry);
                                     spin_unlock(&wb_ctl->done_lock);
                                     // num_inflight becomes 0
                                     atomic_dec(num_inflight);

                                 // Leave zram_writeback_slots
                                 // Free wb_ctl
                                 release_wb_ctl(wb_ctl);
// UAF crash!
wake_up(&wb_ctl->done_wait);

This patch fixes this race by using RCU. By protecting wb_ctl with
rcu_read_lock() in zram_writeback_endio and using kfree_rcu() to free
it, we ensure that wb_ctl remains valid during the execution of
zram_writeback_endio.

Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Richard Chang <richardycc@google.com>
---
V1 -> V2: use RCU to manage the wb_ctl lifetime

 drivers/block/zram/zram_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..07111455eecf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
 #include <linux/kernel_read_file.h>
+#include <linux/rcupdate.h>
 
 #include "zram_drv.h"
 
@@ -504,6 +505,7 @@ struct zram_wb_ctl {
 	wait_queue_head_t done_wait;
 	spinlock_t done_lock;
 	atomic_t num_inflight;
+	struct rcu_head rcu;
 };
 
 struct zram_wb_req {
@@ -847,7 +849,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 		release_wb_req(req);
 	}
 
-	kfree(wb_ctl);
+	kfree_rcu(wb_ctl, rcu);
 }
 
 static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
@@ -964,11 +966,13 @@ static void zram_writeback_endio(struct bio *bio)
 	struct zram_wb_ctl *wb_ctl = bio->bi_private;
 	unsigned long flags;
 
+	rcu_read_lock();
 	spin_lock_irqsave(&wb_ctl->done_lock, flags);
 	list_add(&req->entry, &wb_ctl->done_reqs);
 	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
 	wake_up(&wb_ctl->done_wait);
+	rcu_read_unlock();
 }
 
 static void zram_submit_wb_request(struct zram *zram,
-- 
2.54.0.563.g4f69b47b94-goog

