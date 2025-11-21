Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14803274FC1;
	Fri, 21 Nov 2025 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702953; cv=none; b=JfZovredfvKkOYnNZ71ZmZcSSpe16TXXOAFL7QhDuWTM6ARqKsqHiwh19tVpHn6i/vfEdIS+3Dd81Y3PhZvVEeuJx+0by1FPMJMKVfhGfWPT70iwqZL08UFy5q22GPQXl8LnMW9d6Lmq+05WAWhCIoDlvvnTSp0MweW9+HRPe6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702953; c=relaxed/simple;
	bh=zkjh/O0OgNa9iuTJbXMvEMEbwAiES0st4Y742djBilM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2jgtKrXd2vvR5dyNp+BLmAMwZ/NPVZfIi4vMNk3Jk5Yfb1XURy5BLrwCBcywm5Kxn4ECzsAm0r5ZGcGW/EDYq/2ro3/5kmkaOHG6tMeteSqocN6um0AK3L6SmbxyZ4n4Jpjytcf7eANeJiZfTLkhzXXO0jkvycw3rXJP4X3oIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0EBC4CEFB;
	Fri, 21 Nov 2025 05:29:10 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com
Subject: [PATCH v6 3/8] blk-mq: factor out a helper blk_mq_limit_depth()
Date: Fri, 21 Nov 2025 13:28:50 +0800
Message-ID: <20251121052901.1341976-4-yukuai@fnnas.com>
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

There are no functional changes, just make code cleaner.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq.c | 62 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2650c97a75e..6c505ebfab65 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -497,6 +497,42 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 	return rq_list_pop(data->cached_rqs);
 }
 
+static void blk_mq_limit_depth(struct blk_mq_alloc_data *data)
+{
+	struct elevator_mq_ops *ops;
+
+	/* If no I/O scheduler has been configured, don't limit requests */
+	if (!data->q->elevator) {
+		blk_mq_tag_busy(data->hctx);
+		return;
+	}
+
+	/*
+	 * All requests use scheduler tags when an I/O scheduler is
+	 * enabled for the queue.
+	 */
+	data->rq_flags |= RQF_SCHED_TAGS;
+
+	/*
+	 * Flush/passthrough requests are special and go directly to the
+	 * dispatch list, they are not subject to the async_depth limit.
+	 */
+	if ((data->cmd_flags & REQ_OP_MASK) == REQ_OP_FLUSH ||
+	    blk_op_is_passthrough(data->cmd_flags))
+		return;
+
+	WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
+	data->rq_flags |= RQF_USE_SCHED;
+
+	/*
+	 * By default, sync requests have no limit, and async requests are
+	 * limited to async_depth.
+	 */
+	ops = &data->q->elevator->type->ops;
+	if (ops->limit_depth)
+		ops->limit_depth(data->cmd_flags, data);
+}
+
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
@@ -515,31 +551,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(data->cmd_flags, data->ctx);
 
-	if (q->elevator) {
-		/*
-		 * All requests use scheduler tags when an I/O scheduler is
-		 * enabled for the queue.
-		 */
-		data->rq_flags |= RQF_SCHED_TAGS;
-
-		/*
-		 * Flush/passthrough requests are special and go directly to the
-		 * dispatch list.
-		 */
-		if ((data->cmd_flags & REQ_OP_MASK) != REQ_OP_FLUSH &&
-		    !blk_op_is_passthrough(data->cmd_flags)) {
-			struct elevator_mq_ops *ops = &q->elevator->type->ops;
-
-			WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
-
-			data->rq_flags |= RQF_USE_SCHED;
-			if (ops->limit_depth)
-				ops->limit_depth(data->cmd_flags, data);
-		}
-	} else {
-		blk_mq_tag_busy(data->hctx);
-	}
-
+	blk_mq_limit_depth(data);
 	if (data->flags & BLK_MQ_REQ_RESERVED)
 		data->rq_flags |= RQF_RESV;
 
-- 
2.51.0

