Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E3226D1F
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263268; cv=none; b=thq7zM/v8Axgf6SGFEY0Lg+yRgFNlbPG5m4fcJe6hHr6abL8JZPPjU7bVsKp3KI+ISJyK+p0lzJuqaWN9GwdYUD8+JaJ1dw5r8owIAtu6TZ1bQjwbTDKA82d4N/0bCDc81JLBX4N+nlBHmrgjx1PAKPMjWCyMi/Vl30tsJXZGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263268; c=relaxed/simple;
	bh=RMl+bpZY8STQtEjCpuMjIEBsLfx+SnACPoEuGzH2zdM=;
	h=From:Message-Id:To:Subject:Mime-Version:Content-Type:Cc:Date; b=SIuYosH6YU33FYOGM8fE8aZ3dtlkqUXdMq7ewnKT2vsiWrWDE6JNb7i9kx7FUnXSSSd3QUXhRynU8Sks7fZ4mG+zyqUpAr4PqluU4BwA1us9sDQGxfr7/B7owN9hJbQv/ji6QwwfI9qM+PJpxLG2d7dhfhIwZFnc7WH+lJl8Mpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=xHyjbF3a; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="xHyjbF3a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763263259;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Q+IOxo4l6kTKykmJS8eiXfUCMNlhCagu+jDYl1pBhrk=;
 b=xHyjbF3a9kab7LLE94SL+uRg6t/v0O5OIKd+/zDgiqVKe7wGCo7KTu/vdz2csj/IdZJTCI
 gxNUarGbxc4smIoNC3xJ2GtVgnpsVJBvN21nTYnuhxV5T+fumi4G+yeC81YpwXDkHI8aEI
 RCMBCJU/KwswR0rsFga7wQ5D1HjMHdM/as+bEGunO9NCeGNZ8clFqnfB0zST0Iq7r9dw5C
 qZx/0dGeo6CkdY9XZkxhSIZmAOANekbcR8E2akPXaNqx2XAQzq0aB+wvd00FNarU4g25+3
 6WVkwzOQ64kMgh21WKoX9YBf0JEJ1sKXmJsKvesMirj5Lvxejtb09XjwMF0kjA==
From: "Yu Kuai" <yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Message-Id: <20251116032044.118664-3-yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269194319+8824eb+vger.kernel.org+yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:20:56 +0800
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v4 2/7] blk-mq-sched: unify elevators checking for async requests
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Cc: <yukuai@fnnas.com>, <nilay@linux.ibm.com>, <bvanassche@acm.org>
Date: Sun, 16 Nov 2025 11:20:36 +0800
Content-Transfer-Encoding: 7bit

bfq and mq-deadline consider sync writes as async requests and only
resver tags for sync reads by async_depth, however, kyber doesn't
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
index 3e3719093aec..1aef6ce2e78e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -495,7 +495,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
 	/* Do not throttle synchronous reads. */
-	if (op_is_sync(opf) && !op_is_write(opf))
+	if (blk_mq_sched_sync_request(opf))
 		return;
 
 	/*
-- 
2.51.0
