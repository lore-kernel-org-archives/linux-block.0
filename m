Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452479;
	b=3PNVmCGfeXFxPE7l/SZ4KCw3YHdgKzEW6+/MR4cwsVhd/V5zEHufQCespTNZlxVn3KLT
	 ci5B+/pvnf4i2MuSh+lRomP2pVBBNcmwR80VSGl8hR/wuupkh6796+ij2YgDhkAkzU9OY
	 k5mbpBrnhuzUMJLT3OxobS8LY73XQABbV+NbFgt6fc6JnQhiAVWpW523koVyA4oXGGcYV
	 Z4FMhYPo+xqIfrLSrKlDgIjWZmOC1EhtKTzli2Ilg2gXNnAs6TCBleUKrUiPa7J7dXxzk
	 +pkJ+nhuLlxehA+nRGwyccS/SVtgszb/Jvr4La7Zht1ayPtFeoWO/WCcFAh/l4UqDUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452479;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=qdQW5oVjkGqg2J4U43crSPdqlobSwyO9kA5oXI4dqTg=;
	b=rOEliBPxnTIzLQY7LiNwroeYjBb3GnrTPyCQ9DcSO9ZMHE8k9xcPSzre/uaz30LFpOq7
	 bjQjhnBngRfLrwi8z0MdsT50L1XBHsamhH6VJ0ntxcLUOEFPmA8Ai7me2AygefYuxbyJT
	 Ypw1+WyQ/QQjj1UfslNC3zuFAkdxRINIV4PjhqJedQYqvbCgN+re1j+1pOgwNIVitotJc
	 s5Lwd1MGqGbCqdWTtyBz/lJRwRpm0fux2mtkb+DKvXQNADXYyCtcBZtz5xeEd5wmM0TN7
	 9kASOl2xEQC5QOFvdUFdaXyvfMcOy4mg5doL2d4jHEQs/eulGvrlqsQF7fPIKA4jwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P6dY1R5M;
	arc=none smtp.remote-ip=95.215.58.50
Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE77606A89F
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 03:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE77606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P6dY1R5M
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/LXm5rupOhDmcZE6DqDDNi3ON4n/NXEt6TSkFB6oXko=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794452477; v=1; x=1795057277;
 b=P6dY1R5MsH+NhS0D/64V7Q1Fwo5bvh9+3HEixa2thnFx84z2doevvOAlBwP0Fj3RxsmhirSw
 ZkpKg6l0V2G+W9RAnmgoqaF3wI7iXbgh/WTS2De8cHjalNYTZdqqcPpRlLnEtx8CokEWFNmwO+K
 4lEbxTBQ3q7RpDzRauF+A+yo=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5c8fe64fbd3047ea;
	Thu, 12 Nov 2026 03:01:17 +0000
X-Mizu-Trace-ID: 5c8fe64fbd3047ea
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Wed, 11 Nov 2026 22:00:59 -0500
Subject: [PATCH 2/2] block: return early when the elevator doesn't change
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-bug-block-elevator-unchanged-v1-2-583198bd4e21@linux.dev>
References: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
In-Reply-To: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

Writing the scheduler a queue already uses to queue/scheduler used to
be a no-op. elevator_change() now only checks for an unchanged elevator
after freezing the queue, and doesn't treat "none" on a queue without
an elevator as unchanged at all, so that case also quiesces the queue
in elevator_switch() and resets nr_requests.

Every such write therefore drains in-flight I/O and waits for an RCU
grace period. udev rules and tuning tools that set the scheduler
unconditionally stall I/O on live disks each time they run.

Check under elevator_lock whether anything would change before
allocating scheduler resources and freezing the queue. Elevator changes
of a queue are already serialized by QUEUE_FLAG_NO_ELV_SWITCH,
registration and update_nr_hwq_lock, so drop the check under the freeze.

Writing the current scheduler to queue/scheduler of a null_blk disk 20
times takes (median):

  operation                 before (ms)  after (ms)  change
  none -> none                     9.06        0.08    -99%
  mq-deadline -> mq-deadline       9.14        0.08    -99%

4k random reads at queue depth 1 for 10 seconds, while "none" is
written to queue/scheduler every 50 ms:

  metric             before  after  change
  IOPS               342609 395915    +16%
  max latency (us)    10839    978    -91%

Fixes: b07a889e83355 ("block: move q->sysfs_lock and queue-freeze under show/store method")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 block/elevator.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 9d9b2e84a1288..979203f518ada 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -654,10 +654,24 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
 	struct blk_mq_tag_set *set = q->tag_set;
+	bool unchanged;
 	int ret = 0;
 
 	lockdep_assert_held(&set->update_nr_hwq_lock);
 
+	/*
+	 * Callers serialize elevator changes of this queue, so q->elevator is
+	 * stable here. Skip freezing the queue if nothing would change.
+	 */
+	mutex_lock(&q->elevator_lock);
+	if (q->elevator)
+		unchanged = elevator_match(q->elevator->type, ctx->name);
+	else
+		unchanged = !strncmp(ctx->name, "none", 4);
+	mutex_unlock(&q->elevator_lock);
+	if (unchanged)
+		return 0;
+
 	if (strncmp(ctx->name, "none", 4)) {
 		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res,
 				set->nr_hw_queues);
@@ -677,8 +691,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	 */
 	blk_mq_cancel_work_sync(q);
 	mutex_lock(&q->elevator_lock);
-	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
-		ret = elevator_switch(q, ctx);
+	ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)

-- 
2.43.0

