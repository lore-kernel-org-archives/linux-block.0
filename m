Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117E37E310
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106801; cv=none; b=CiQ/9H2pyZc3Owu2Cvxg2f4cpM6EtJgY4ABs5QXSCx48fuVNalIZHje2UUqh39gtMZ6oSEq4R1l0gSbb7ix5g6NX0xB33G/lYj3gvIqKRJst+Pvxvpo+WMbXqZg26DlxEgfA3O/jfZ89XGzfrS0iaJmRrVNdySTr/axszynXGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106801; c=relaxed/simple;
	bh=+fMBxn76F0Syv9uOaA3p6vmTGWJZ6F5huDxh07+lYhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgK4TqU17MsWLHpzWdz8jS0sQLAOJ0TfseBNu5itiQmsxKrMcaiV+5EmQwpdeJlZva1VGK0aPiCnwqmlmJge3XYG7cZDsHxIiQCRzpkzCcgN+nrE7foCBYfHqKohA/0PUgxNtgbYvOOxq8Jjb3s81s9LGA35jqoioNi/K1E2ZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC60C116D0;
	Tue,  3 Feb 2026 08:19:58 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	bvanassche@acm.org,
	hare@suse.de
Subject: [PATCH v7 2/8] blk-mq-sched: unify elevators checking for async requests
Date: Tue,  3 Feb 2026 16:19:43 +0800
Message-ID: <20260203081952.732210-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203081952.732210-1-yukuai@fnnas.com>
References: <20260203081952.732210-1-yukuai@fnnas.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/bfq-iosched.c   | 2 +-
 block/blk-mq-sched.h  | 5 +++++
 block/kyber-iosched.c | 2 +-
 block/mq-deadline.c   | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 617633be8abc..89289ec283f6 100644
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

