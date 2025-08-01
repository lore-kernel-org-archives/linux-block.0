Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B6221FBE
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048715; cv=none; b=T1yP6pvfRINf8zsxsTekGIbaPo7tG3DssXyoKxcXZIIs13kwK6nyyZwYwVzAQP8Y6PK5EdXjwnJSJVWu9UWbyFXaHfGt4M/ufVmR8m5K0egbIi+NP4ZVoCru8TvtaPT6TPOndmdp1+IglD8w6cGEYpTHetUa5rFYJ3z4eB3uMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048715; c=relaxed/simple;
	bh=CVzqDNMuKOLXGNDE0gZs36rxj4tSusQS1HskAVKNiyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWbrUA5nR3Op0hHkl5grL13l7qkNrRsRvup0SDrARgtW3jrMJnKoipbo7yQUx5AhRoqk5mPrb5bc2CtLniumTTCUEuME7X+WUD/oC391YJrFdUin4Od9VGWgxNhixq4XPCKjksypEq3IqVpoiUbzdm7Cfe59qd3uF3fnvzer2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPpO3RBW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPpO3RBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754048713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjVVyYvMwZXXqsoh1ukyv7ZsE+4QfPAVtfwcO6w/AbQ=;
	b=iPpO3RBWWiq6siftqFVIMPK25TdK8sNuW2z6ogpI5KirZ9siB90+nkweIrxpBHyUDFf8Wz
	Mij4MfZnmlZBzBEO0gQ50jLr3pgIUw/KfZFQ8PM2zKBSYqUo/7c1cNOj+rXClnFmXTgdPr
	69y+Rw+1mjpZF70j4T2UCYcPHVwYUQ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-u0OMWkCZMXCLetMOveJBTQ-1; Fri,
 01 Aug 2025 07:45:10 -0400
X-MC-Unique: u0OMWkCZMXCLetMOveJBTQ-1
X-Mimecast-MFC-AGG-ID: u0OMWkCZMXCLetMOveJBTQ_1754048709
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2622419773E6;
	Fri,  1 Aug 2025 11:45:09 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9A081800D8C;
	Fri,  1 Aug 2025 11:45:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] blk-mq: Defer freeing flush queue to SRCU callback
Date: Fri,  1 Aug 2025 19:44:36 +0800
Message-ID: <20250801114440.722286-5-ming.lei@redhat.com>
In-Reply-To: <20250801114440.722286-1-ming.lei@redhat.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 11 ++++++++++-
 block/blk.h    |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f14aa0a19ef0..7b4ab8e398b6 100644
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
index 76901a39997f..c7e52552290f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -39,6 +39,7 @@ struct blk_flush_queue {
 	struct list_head	flush_queue[2];
 	unsigned long		flush_data_in_flight;
 	struct request		*flush_rq;
+	struct rcu_head		rcu_head;
 };
 
 bool is_flush_rq(struct request *req);
-- 
2.47.0

