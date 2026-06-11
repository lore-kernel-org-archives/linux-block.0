Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F976368D49
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163750; cv=none; b=TJRe0kGN6GyNsLQaYdXM7elj4NfMvqsOWP8YkXWROpdFzNYwP8XVZa40hjV64znjl/AKs/cfO3kq5rbc5WBRM6KLyDDKUkzMNJccAmkby7jfEI2/MTse60QUoVn/9V3xZe4QNjkmS75MwXg0dWb2D/a0I31O3RoRnS96Hoix89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163750; c=relaxed/simple;
	bh=5L4SO/49ff+vr91M5IIOTrTOod3ojk/RYbJSS9hnzhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWHsfhFlHjyZoAcXZKcrl0br52IzdqudzUX85WI/5O6rFJ1mVKzV/kzEDy8elEQHEizxmtr8qEf/k+7CRvywfWY6GEIZvEvhYXsJNBqr2NqACzsGFku3AZq5c7lXkps7K5/rICWD3iJwTiWDKr0Vf8dzI3facNeAaaRXS9LtJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ytf5TrT9; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ytf5TrT9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781163749; x=1812699749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5L4SO/49ff+vr91M5IIOTrTOod3ojk/RYbJSS9hnzhI=;
  b=Ytf5TrT95gtbAMcW5fhPBaUhGGHdsE3zrn0maI4duco8FKsMH8x7UCp4
   yyyax66ldMq0lVp7xBrDs+IsKkHqZYtuM6PSNM5pQqjJB6VFF6wW4ggL6
   x8eyLSKcSyO3rwLjuW16aPTG1CC0limZLosFYroXL74e4+BzeyyxdH2uw
   tBmT4DfPD/CgYjXMhrIZP9CkD/Fntg3FGBM9ZxSYn+JsOmVwBdM7N/Aks
   Y3lIyh5YYpglMfBiZRmi4a14Q5Ky1Xwkj+iw9MvQ6lGLGs8DiCh/mPIHS
   ohxNhtgYo+DJ8CDXVMiOJTtQvxx/cF8YkO4pHE+/NFZ96xXDouVSIUN9Z
   w==;
X-CSE-ConnectionGUID: FrY8WIaYRYqBO5NHXCni4w==
X-CSE-MsgGUID: 5f2z8W6TTAy+40D3xXyT5Q==
X-IronPort-AV: E=Sophos;i="6.24,198,1774281600"; 
   d="scan'208";a="147412567"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2026 15:42:21 +0800
X-CSE-ConnectionGUID: ncvNs7EpTPqse9zE4WXf6A==
X-CSE-MsgGUID: XmoJnr3wSWaCAA/qRfI2Sg==
IronPort-SDR: 6a2a66cb_DOUcuB8a2LVrOMRR31GCn2X2pWcObMPfdBS0AP/JVow/8Of
 hSCbxCTVKtyQbQyT0P93HlOYfop8haB72lhp4vQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2026 00:42:03 -0700
X-CSE-ConnectionGUID: UV5sIO9BQma4lshxpfJTAQ==
X-CSE-MsgGUID: XCPWcC0LQJuQKyGxdjva2Q==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 11 Jun 2026 00:42:01 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH RFC 1/1] block: serialize whole elevator change steps for the same queue
Date: Thu, 11 Jun 2026 16:42:00 +0900
Message-ID: <20260611074200.474676-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When elevator_change() is called concurrently for the same queue, the
elevator_change_done() function runs concurrently as well. This function
adds or deletes kobjects for the debugfs entry of the queue. Then the
concurrent calls cause memory corruption of the kobjects and result in a
process hang. The core part of the elevator switch is protected by queue
freeze and q->elevator_lock. However, since the commit 559dc11143eb
("block: move elv_register[unregister]_queue out of elevator_lock"), the
elevator_change_done() is not serialized. Hence the memory corruption
and the hang.

The failures are observed when udev-worker writes to a sysfs
queue/scheduler attribute file while the blktests test case block/005
writes to the same attribute file. The failure also can be recreated by
running two processes that write to the same queue/scheduler file
concurrently. The failure is observed since another commit 370ac285f23a
("block: avoid cpu_hotplug_lock depedency on freeze_lock"). This commit
changed the behavior of queue freeze and it unveiled the failure.

Fix the failure by adding a new per-queue lock 'elevator_queue_lock',
which serializes the whole elevator switch steps for the same queue
including the elevator_change_done() call.

Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 block/blk-core.c       | 1 +
 block/elevator.c       | 9 +++++++++
 include/linux/blkdev.h | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..c6418889897a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -430,6 +430,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	refcount_set(&q->refs, 1);
 	mutex_init(&q->debugfs_mutex);
 	mutex_init(&q->elevator_lock);
+	mutex_init(&q->elevator_queue_lock);
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
diff --git a/block/elevator.c b/block/elevator.c
index 3bcd37c2aa34..65bdea27aa8a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -665,6 +665,13 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 			return ret;
 	}
 
+	/*
+	 * Acquire elevator_queue_lock to serialize the debugfs (un)register
+	 * steps for the same queue. The elevator switch core part is protected
+	 * by queue freezing and ->elevator_lock.
+	 */
+	mutex_lock(&q->elevator_queue_lock);
+
 	memflags = blk_mq_freeze_queue(q);
 	/*
 	 * May be called before adding disk, when there isn't any FS I/O,
@@ -690,6 +697,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	if (!ctx->new)
 		blk_mq_free_sched_res(&ctx->res, ctx->type, set);
 
+	mutex_unlock(&q->elevator_queue_lock);
+
 	return ret;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1c..cfeddd3ded95 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -606,6 +606,13 @@ struct request_queue {
 	 */
 	struct mutex		elevator_lock;
 
+	/*
+	 * Serializes the whole elevator change operation for the same queue,
+	 * including the debugfs (un)register steps. Must be acquired before
+	 * freezing the queue and acquiring elevator_lock.
+	 */
+	struct mutex		elevator_queue_lock;
+
 	struct mutex		sysfs_lock;
 	/*
 	 * Protects queue limits and also sysfs attribute read_ahead_kb.
-- 
2.54.0

