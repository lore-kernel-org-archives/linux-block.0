Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D571991BE
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381866; cv=none; b=mvre89ZHP/pi6ThtYsEodJjL8xH3a4OIoPHA+wzDgcf10gy8uicrmDT8wZft/QYKOduZPlUVHOB5W73DQ1XYWuHuyp1PaoAArhIC/P9rMLfGnguxIr4u5q298Wy1Wq3z2z/GcAp/VS35AkDQP6kye1QLjbgLLp7prCfQWBetOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381866; c=relaxed/simple;
	bh=4VnatvB/PDJUYV+KendAqjVshlEXb2PzZIahqgsqTDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLApWf7tczij1UvFN9Nb2tOVzHvCKxCkx0YeMntfmAjKjF2AQ3jMNJUqxawl8HEqlWQZ3ctc2tIkOlZz3sThRMUmoeSldd5rwNS2Mo3MvVeAxxmDzOG2swJkIS7bKqMgHpQlMBSA1OziUqigcL1r79hUmBS8TZiNHKFNipeRxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JT0FPG4l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT0FPG4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730381863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr2LBenbpdSrWz4LoeZDqd7c5XAhCpZQgIPTczb2xT8=;
	b=JT0FPG4lG+e4RjHnzsZjRuUu69QftUPbi+ZoY16KrWsX1qTNYdQaIIJSkk4iI2aZTjmUPU
	NHvCc99kd31u8rv6+GGsLoq7P1JaiyXBwaj5qnthQfpelLtBm5XaUAzzdniZI1+ZEe8Bgx
	tGNVLTBbfrSffBP19sH56e1cwWY2ImI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-Ssd5VTExP1CgZitVc459Jw-1; Thu,
 31 Oct 2024 09:37:38 -0400
X-MC-Unique: Ssd5VTExP1CgZitVc459Jw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74DFE1955EAD;
	Thu, 31 Oct 2024 13:37:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59F631956088;
	Thu, 31 Oct 2024 13:37:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/4] block: remove blk_freeze_queue()
Date: Thu, 31 Oct 2024 21:37:17 +0800
Message-ID: <20241031133723.303835-2-ming.lei@redhat.com>
In-Reply-To: <20241031133723.303835-1-ming.lei@redhat.com>
References: <20241031133723.303835-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

No one use blk_freeze_queue(), so remove it and the obsolete comment.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 22 +---------------------
 block/blk.h    |  1 -
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4ae7eb335fbd..5f4496220432 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,31 +161,11 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
 
-/*
- * Guarantee no request is in use, so we can change any data structure of
- * the queue afterward.
- */
-void blk_freeze_queue(struct request_queue *q)
+void blk_mq_freeze_queue(struct request_queue *q)
 {
-	/*
-	 * In the !blk_mq case we are only calling this to kill the
-	 * q_usage_counter, otherwise this increases the freeze depth
-	 * and waits for it to return to zero.  For this reason there is
-	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
-	 * exported to drivers as the only user for unfreeze is blk_mq.
-	 */
 	blk_freeze_queue_start(q);
 	blk_mq_freeze_queue_wait(q);
 }
-
-void blk_mq_freeze_queue(struct request_queue *q)
-{
-	/*
-	 * ...just an alias to keep freeze and unfreeze actions balanced
-	 * in the blk_mq_* namespace
-	 */
-	blk_freeze_queue(q);
-}
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
diff --git a/block/blk.h b/block/blk.h
index 63d5df0dc29c..ac48b79cbf80 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -35,7 +35,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
-void blk_freeze_queue(struct request_queue *q);
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
 bool __blk_freeze_queue_start(struct request_queue *q);
-- 
2.47.0

