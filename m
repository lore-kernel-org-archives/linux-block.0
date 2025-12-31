Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF12DBF75
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171110; cv=none; b=p+IWeFg0qBZp5pJWT2Dn0q3EIQkshVGgVk0C6SjPpHZAQ0U6vq20veFKnf0Z+0Ozii+STjXCivz2RaXIwpYQxS2+rto1Bs06F9FpINFaJwgScjokfZUNHH25UbBC8EcP64oiOaTNalX4VJ++qulvni5gS7XzZKv1UMmLCuQNWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171110; c=relaxed/simple;
	bh=R2vb+E7fPBAG0NMpFae/19GtnwCnokFTXcHe76C2x0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO+ZdaXmvHcHMsxV+TQFYKwz7mIzZxhY7CvMgWfLHFtKrzlLCyXBOX6NMG+BuIMlOv38Ah+SPCCVu8ow7fWmoySowl2h33XzftrUHsigCKQ+rgSERyC67mAxorBrrvGtmki5q1GxzhLeIsMoK4s899S3fvXKMvUjr8/dWR9IjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C75C116D0;
	Wed, 31 Dec 2025 08:51:47 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v7 07/16] blk-mq-debugfs: add missing debugfs_mutex in blk_mq_debugfs_register_hctxs()
Date: Wed, 31 Dec 2025 16:51:17 +0800
Message-ID: <20251231085126.205310-8-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231085126.205310-1-yukuai@fnnas.com>
References: <20251231085126.205310-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In blk_mq_update_nr_hw_queues(), debugfs_mutex is not held while
creating debugfs entries for hctxs. Hence add debugfs_mutex there,
it's safe because queue is not frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 22c182b40bc3..5c7cadf51a88 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -679,8 +679,10 @@ void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
+	mutex_lock(&q->debugfs_mutex);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_register_hctx(q, hctx);
+	mutex_unlock(&q->debugfs_mutex);
 }
 
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
-- 
2.51.0

