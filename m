Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871B1E411D
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292180; cv=none; b=GKPFL5Zl5RkZPXnCIZUuAL6jQefQfz/8O+t8cD/mrqeWs+O3t9RqYXc0XPpzlVknPz1fnWoxA+32jbUBLcMpL1A+gKomhx/YmLUxQQ5sO4lwe98beNxIdz11ya0X93tg+kuFJNiuRSjMHa8vb0Rd0msD+vaqHaIQQDQYv+4BHmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292180; c=relaxed/simple;
	bh=AB85rTZ5YPUJXxdwH7AeqhFiZd1VN69oG+BBqjTfOME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6ZCM25zYGma7F1XlMMzNrlUVtCdK/I+RNDK6uMx1pMD0M1fsS4Nk2tt9kS6A1y9YMFpyS/vEfbfthBQld4OvlJ2fovWcsRuJZRkXq8zI1cYe6aPzKNJWXIkgWrFLtsZzX/rO8zSmCkqwBe2BQeQCXGOgXeMb1RIVolywW+b9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfedK+G8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfedK+G8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730292177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj51ZyDnTf64k5sb/MgIMzO8F3KLT7gNACXbK+gTyKU=;
	b=HfedK+G8DVl35sXRpnSAd8CXs6AtYABgO826aWchBfbXNtt8Dh816yTusSci0p+KBc6umj
	RnAIrNzI/Z+be9XKvMGjfvn7moyxJA70S5cQkj2nSBiSfdZUi5HSlc/KdLOsqv+JM8ALGq
	cs7jygQXXkFe1FA2Ba0vff7yLYxgRHk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-UPKqMo2jNWigriaMOavfjw-1; Wed,
 30 Oct 2024 08:42:55 -0400
X-MC-Unique: UPKqMo2jNWigriaMOavfjw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCCEA1955DAF;
	Wed, 30 Oct 2024 12:42:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67D5B19560AA;
	Wed, 30 Oct 2024 12:42:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/5] block: remove blk_freeze_queue()
Date: Wed, 30 Oct 2024 20:42:33 +0800
Message-ID: <20241030124240.230610-2-ming.lei@redhat.com>
In-Reply-To: <20241030124240.230610-1-ming.lei@redhat.com>
References: <20241030124240.230610-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

No one use blk_freeze_queue(), so remove it and the obsolete comment.

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

