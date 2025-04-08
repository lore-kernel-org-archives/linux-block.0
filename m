Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3F26159D
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097115; cv=none; b=Cn/28iu6ShcBsn3dslm1cwq+j2O74PQ6dy8kHGRcKgBOo6Z/YqE0zL5xs5mTc2jECJAcUZBuy4mYVZC/RyyZrrb4yU2/x0hS2jgJ3dBtqLKsF49vsHcSDm8zx7nlb0S4oiqDIdwIDhMORNWuDL37NE4Ic6RIvFYhcyazjFuhmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097115; c=relaxed/simple;
	bh=WSn55HNSjK73FJgZTX6a8vlykCJtHjRCO5T2qcP7rPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsTwZF2zM4Ly2meSQk9UkSNlXtpxRiddLokgfRyVAipCjyG+GbAZFruYxyPy+hJuE47MvIlZpYK9Yb0wdq7NPSfZY5AAHVcU2mH/28iH7syXrB86hnAvDQxcNqzADfIxBoDMLqKsWJJfwUi++DHTQQcGS+cePHW7LhL2cdXg+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rvz6jkZr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvz6jkZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744097112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJiMb7FnaQmla2b+vbyTYTqXw9oV6f2gOzOXmbirKQA=;
	b=Rvz6jkZrr1DB8IQYEmtWkdjSaXqI99eQPltRynbc4dDCO0VY8gaPmxavdTM8TBqu+rvG+S
	yNlMBGI9mMVleFfZFHOUmPzj2vJzNPDFh7gIhukNS4rs8qWdTuOzoyS2XJ4VFffrLM7gH+
	oF2pKvLbEL1Mz7xstdAori5dZAICdSI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-DDHtV5YqPJiUFyotixmiCw-1; Tue,
 08 Apr 2025 03:25:09 -0400
X-MC-Unique: DDHtV5YqPJiUFyotixmiCw-1
X-Mimecast-MFC-AGG-ID: DDHtV5YqPJiUFyotixmiCw_1744097108
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CD4F180025C;
	Tue,  8 Apr 2025 07:25:07 +0000 (UTC)
Received: from localhost (unknown [10.72.120.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7124180B486;
	Tue,  8 Apr 2025 07:25:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] ublk: don't fail request for recovery & reissue in case of ubq->canceling
Date: Tue,  8 Apr 2025 15:24:38 +0800
Message-ID: <20250408072440.1977943-3-ming.lei@redhat.com>
In-Reply-To: <20250408072440.1977943-1-ming.lei@redhat.com>
References: <20250408072440.1977943-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

ubq->canceling is set with request queue quiesced when io_uring context is
exiting. Recovery & reissue(UBLK_F_USER_RECOVERY_REISSUE) requires
request to be re-queued and re-dispatch after device is recovered.

However commit d796cea7b9f3 ("ublk: implement ->queue_rqs()") still may
fail any request in case of ubq->canceling, this way breaks
UBLK_F_USER_RECOVERY_REISSUE.

Fix it by calling __ublk_abort_rq() in case of ubq->canceling.

Reported-by: Uday Shankar <ushankar@purestorage.com>
Closes: https://lore.kernel.org/linux-block/Z%2FQkkTRHfRxtN%2FmB@dev-ushankar.dev.purestorage.com/
Fixes: commit d796cea7b9f3 ("ublk: implement ->queue_rqs()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 41bed67508f2..d6ca2f1097ad 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1371,7 +1371,8 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 	return BLK_EH_RESET_TIMER;
 }
 
-static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
+static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq,
+				  bool check_cancel)
 {
 	blk_status_t res;
 
@@ -1390,7 +1391,7 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
 	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
-	if (unlikely(ubq->canceling))
+	if (check_cancel && unlikely(ubq->canceling))
 		return BLK_STS_IOERR;
 
 	/* fill iod to slot in io cmd buffer */
@@ -1409,7 +1410,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	blk_status_t res;
 
-	res = ublk_prep_req(ubq, rq);
+	res = ublk_prep_req(ubq, rq, false);
 	if (res != BLK_STS_OK)
 		return res;
 
@@ -1441,7 +1442,7 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 			ublk_queue_cmd_list(ubq, &submit_list);
 		ubq = this_q;
 
-		if (ublk_prep_req(ubq, req) == BLK_STS_OK)
+		if (ublk_prep_req(ubq, req, true) == BLK_STS_OK)
 			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
-- 
2.47.0

