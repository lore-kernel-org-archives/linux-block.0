Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980C2F3C25;
	Fri, 21 Nov 2025 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702951; cv=none; b=CVHnUEC2C7FNFA/a1P2neptbYmSClowozLiByRGZ4QxywJKt9lsFvIH0w2JQWaC9z/kNz16dQDuoYjlWqPzuLscHJpI293b3FvDer8kIwj5RsvVfVFRSVlfT4IZ7pHHyCdewZwfkVyLnzy7Oh9wyUw+jAv94IvFes8QiId5h/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702951; c=relaxed/simple;
	bh=2SYVMAkHeDw7C9g9Y+5XW1vaMycGDebGX7q51sKGAUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEarWrRdCsKg9kr3DpgomQdxYHyIpvVyFhP4ZItLjulOIj0SlC+6aL7ZcRcLIlRf3SqKLeH/o+kTEPuvriuXuP8HpxqrUWFUktF6IWXiWIJQSa7lYth164lFOKg09QrQQWcu/XYNUohfArQqAeirY1P7grzV69kFCtZIGkImDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF6C116D0;
	Fri, 21 Nov 2025 05:29:08 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com
Subject: [PATCH v6 2/8] blk-mq-sched: unify elevators checking for async requests
Date: Fri, 21 Nov 2025 13:28:49 +0800
Message-ID: <20251121052901.1341976-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121052901.1341976-1-yukuai@fnnas.com>
References: <20251121052901.1341976-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bfq and mq-deadline consider sync writes as async requests and only
reserve tags for sync reads by async_depth, however, kyber doesn't
consider sync writes as async requests for now.

Consider the case there are lots of dirty pages, and user use fsync to
flush dirty pages. In this case sched_tags can be exhausted by sync writes
and sync reads can stuck waiting for tag. Hence let kyber follow what
mq-deadline and bfq did, and unify async requests checking for all
elevators.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/bfq-iosched.c   | 2 +-
 block/blk-mq-sched.h  | 5 +++++
 block/kyber-iosched.c | 2 +-
 block/mq-deadline.c   | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4a8d3d96bfe4..35f1a5de48f3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -697,7 +697,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	unsigned int limit, act_idx;
 
 	/* Sync reads have full depth available */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_is_sync_read(opf))
 		limit = data->q->nr_requests;
 	else
 		limit = bfqd->async_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 02c40a72e959..5678e15bd33c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -137,4 +137,9 @@ static inline void blk_mq_set_min_shallow_depth(struct request_queue *q,
 						depth);
 }
 
+static inline bool blk_mq_is_sync_read(blk_opf_t opf)
+{
+	return op_is_sync(opf) && !op_is_write(opf);
+}
+
 #endif
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index c1b36ffd19ce..2b3f5b8959af 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -556,7 +556,7 @@ static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
 	 * Async requests can be limited at this stage.
 	 */
-	if (!op_is_sync(opf)) {
+	if (!blk_mq_is_sync_read(opf)) {
 		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
 
 		data->shallow_depth = kqd->async_depth;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e3719093aec..29d00221fbea 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -495,7 +495,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
 	/* Do not throttle synchronous reads. */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_is_sync_read(opf))
 		return;
 
 	/*
-- 
2.51.0

