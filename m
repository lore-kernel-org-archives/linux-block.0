Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FC2441A0;
	Fri, 10 Oct 2025 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063306; cv=none; b=Kxr5DAhC5rrXDBwMFzdH8/iPzsYRdcBw/qClJVq6H0mA2YUBxxVPibK0df/lvcgwrcjir5ihdE4bl2pECDjPETQ5KsaxVZHzXzXsdSx3sKht//cxTNFW/oLriDBd7p4fwAG78teBhkoZJOJQmM5SqpAgUiSv8G68PaPVamvSXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063306; c=relaxed/simple;
	bh=kTfc8t+GGw7EWJ9kYxVrpISeWOIQnou3+v5NU3S3DiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+OyCXdTXOkaOTTCypVfm4YOk4j/CSvkW1MpgNQBqfRoyJzPOgycMBso+PeXFKdvaqP4lf7lBdbUVq7Wf5/aErfJ47KEIZ3O+dWc2CH4BjnE0GA1hdSti9WFdKx933vYW2t0ulxsGHE0MZbr+YylWZT8xAGHYdwmnIG8/ENXL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6HMnPC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6HMnPC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A89EC4CEF5;
	Fri, 10 Oct 2025 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063305;
	bh=kTfc8t+GGw7EWJ9kYxVrpISeWOIQnou3+v5NU3S3DiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6HMnPC5p9MLGcpFyovZj8aK0MAYR1MLC0/F3AaQI9kozmz9pJyjWZLB+AmnaFgKU
	 cP8OpFOX3VenuH7OIXaq6D6J++bAtgQchG9ZoZZ8OxqcV1j1hLS/QilMHA3zy2fpQj
	 E0fkIkbnlS4rV1sTvVmTg25Ydazz0ITyQE4tXrKulH8KYhU5y7nE37B21LfGWkMeyO
	 k6o9kFSFzzAwCs4yVD+mlIBBxmKgjEoe0hlqr9iZx7Fx4mTmFm4pX2y1LKDlxtmCI+
	 gPljh8W/0fyXtPTl6dGDYbk+3nt/zxaFLA0beWvIEJL4+pFQGWM0+gAi6D5uhUDzBg
	 4Jjs1ezwcT6OQ==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 2/7] blk-mq-sched: unify elevators checking for async requests
Date: Fri, 10 Oct 2025 10:28:04 +0800
Message-ID: <20251010022812.2985286-3-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010022812.2985286-1-yukuai@kernel.org>
References: <20251010022812.2985286-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

bfq and mq-deadline consider sync writes as async requests and only
resver tags for sync reads by async_depth, however, kyber doesn't
consider sync writes as async requests for now.

Consider the case there are lots of dirty pages, and user use fsync to
flush dirty pages. In this case sched_tags can be exhausted by sync writes
and sync reads can stuck waiting for tag. Hence let kyber follow what
mq-deadline and bfq did, and unify async requests checking for all
elevators.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/bfq-iosched.c   | 2 +-
 block/blk-mq-sched.h  | 5 +++++
 block/kyber-iosched.c | 2 +-
 block/mq-deadline.c   | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4a8d3d96bfe4..63452e791f98 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -697,7 +697,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	unsigned int limit, act_idx;
 
 	/* Sync reads have full depth available */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_sched_sync_request(opf))
 		limit = data->q->nr_requests;
 	else
 		limit = bfqd->async_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 8e21a6b1415d..ae747f9053c7 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -103,4 +103,9 @@ static inline void blk_mq_set_min_shallow_depth(struct request_queue *q,
 						depth);
 }
 
+static inline bool blk_mq_sched_sync_request(blk_opf_t opf)
+{
+	return op_is_sync(opf) && !op_is_write(opf);
+}
+
 #endif
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 18efd6ef2a2b..cf243a457175 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -544,7 +544,7 @@ static void kyber_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	 * We use the scheduler tags as per-hardware queue queueing tokens.
 	 * Async requests can be limited at this stage.
 	 */
-	if (!op_is_sync(opf)) {
+	if (!blk_mq_sched_sync_request(opf)) {
 		struct kyber_queue_data *kqd = data->q->elevator->elevator_data;
 
 		data->shallow_depth = kqd->async_depth;
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e741d33142d..592dd853f6e5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -492,7 +492,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
 	/* Do not throttle synchronous reads. */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_sched_sync_request(opf))
 		return;
 
 	/*
-- 
2.51.0

