Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CC393DF8
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106804; cv=none; b=dXjuVj0Ecc/8kcI7KLNJH86ppswRCIigcKIIoQA5BE+n4qovEqDtMU/zZr6NtvqLnuCGrKZ8rpa5Xq1NRlFxsbUGEy69Kg3jAB1N+eg5PRM0Tlad0HeifAx2t9tQQx30e44Dr68WeB+l77uj/wOtulglAe3+aeCrzn9/xOUk0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106804; c=relaxed/simple;
	bh=Ztsq6MunkoXbauqZ+G5QVHwG1zuID+j1jb9JsYTPzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMal8Qmvh7cMpFvkbxBE49B485+dE+bVj73H0Z0NOxpaOWxdx9o9f0Ee5oIro1k1g1zLAEkHU7ZT44vOSI/rGEslfk55o4Fl+5sbt43Gioje3LwnW1n4BmcvBj81kU9PyoYkFRMam1oyveZNx5/2huAo8FW8OsOAcU2JxQ6b8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903BFC19422;
	Tue,  3 Feb 2026 08:20:01 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	bvanassche@acm.org,
	hare@suse.de
Subject: [PATCH v7 3/8] blk-mq: factor out a helper blk_mq_limit_depth()
Date: Tue,  3 Feb 2026 16:19:44 +0800
Message-ID: <20260203081952.732210-4-yukuai@fnnas.com>
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

There are no functional changes, just make code cleaner.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 62 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf1daedbb39f..b7b272e856b8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -498,6 +498,42 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
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
@@ -516,31 +552,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
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

