Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A53221FDA
	for <linux-block@vger.kernel.org>; Sat, 30 Aug 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520336; cv=none; b=Xu3+bBD23dkf6xFb4VxYUsXClDFK3t4ctdUQofl1ahax0NFU6wCvAieJaeg4ppwkdXJ3Hf+ph4wjzMm63ItLjDhHPMItOU7B32C5Bx8WVJkznnyoZmaj9VZT/w2C+Rvbfl586xzPjNrF6HfFTjo5OZPv+vJrkZcV0xORwTdZ4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520336; c=relaxed/simple;
	bh=XpdT1YS1YBNLDgdcbNHF8AJMyasAeExyLw1UVw6UDNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNJJnyv5PlL29c02SMN7RzrJ+yXG++UmoZ7VmTymvYZeKxOy/8s2FXRa6scxPH5RbyHnlrynMaoUIkA/aBAUs63iGzsTSvpJJ5NcpAfqYwhWmJj190wQrzjOKMrdiv5SSX0N7Xhv9+UPZjJfawVIwgRPQgxsv+2xuS0M2q8E1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NshMoPJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NshMoPJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756520333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEQ3rJ2su8s4baTvaqAjyOfj57YDG6n84CcB9aAm+gc=;
	b=NshMoPJQ8mQYjfc7BJRAD7KPwSK0NztU0eRuTL5om3CHI/MrHdMZBPgoMveen3WbT31J/p
	WSFb0U5w1tU0ztP2iBm1dGVceiEtoJPSjURkbzHk2M8ZaN2K3lPyru4UXLQ+b6nWJQadM9
	7bLLzFd9tgIVKhC+jK+/a6mT89f48NM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-R9HSNUfVOpSgK5NEYejPXg-1; Fri,
 29 Aug 2025 22:18:51 -0400
X-MC-Unique: R9HSNUfVOpSgK5NEYejPXg-1
X-Mimecast-MFC-AGG-ID: R9HSNUfVOpSgK5NEYejPXg_1756520330
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8AFF195608D;
	Sat, 30 Aug 2025 02:18:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F4A11800446;
	Sat, 30 Aug 2025 02:18:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/5] blk-mq: Defer freeing flush queue to SRCU callback
Date: Sat, 30 Aug 2025 10:18:22 +0800
Message-ID: <20250830021825.2859325-5-ming.lei@redhat.com>
In-Reply-To: <20250830021825.2859325-1-ming.lei@redhat.com>
References: <20250830021825.2859325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The freeing of the flush queue/request in blk_mq_exit_hctx() can race with
tag iterators that may still be accessing it. To prevent a potential
use-after-free, the deallocation should be deferred until after a grace
period. With this way, we can replace the big tags->lock in tags iterator
code path with srcu for solving the issue.

This patch introduces an SRCU-based deferred freeing mechanism for the
flush queue.

The changes include:
- Adding a `rcu_head` to `struct blk_flush_queue`.
- Creating a new callback function, `blk_free_flush_queue_callback`,
  to handle the actual freeing.
- Replacing the direct call to `blk_free_flush_queue()` in
  `blk_mq_exit_hctx()` with `call_srcu()`, using the `tags_srcu`
  instance to ensure synchronization with tag iterators.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 11 ++++++++++-
 block/blk.h    |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 14bfdc6eadce..c9c6e954bfbc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3912,6 +3912,14 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
 	spin_unlock_irqrestore(&tags->lock, flags);
 }
 
+static void blk_free_flush_queue_callback(struct rcu_head *head)
+{
+	struct blk_flush_queue *fq =
+		container_of(head, struct blk_flush_queue, rcu_head);
+
+	blk_free_flush_queue(fq);
+}
+
 /* hctx->ctxs will be freed in queue's release handler */
 static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
@@ -3931,7 +3939,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
-	blk_free_flush_queue(hctx->fq);
+	call_srcu(&set->tags_srcu, &hctx->fq->rcu_head,
+			blk_free_flush_queue_callback);
 	hctx->fq = NULL;
 
 	xa_erase(&q->hctx_table, hctx_idx);
diff --git a/block/blk.h b/block/blk.h
index 46f566f9b126..7d420c247d81 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -41,6 +41,7 @@ struct blk_flush_queue {
 	struct list_head	flush_queue[2];
 	unsigned long		flush_data_in_flight;
 	struct request		*flush_rq;
+	struct rcu_head		rcu_head;
 };
 
 bool is_flush_rq(struct request *req);
-- 
2.47.0

