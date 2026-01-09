Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FF2DF703
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941586; cv=none; b=g5TSDSN31dcgHa5EQzdGa93waWzhf08dZTLt3+G9tu+QFnTRbp322iDQN9WqXP2AU4Utweps4nJr1LfaD3TZFwyXB0Ss8SKfoHQrK5E5s7WLGYoXUtI4YuX3t1d2ag1gxGJ6MDExpihYQVO7eJT9f1kcsr6qiZKjVilwlHWI0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941586; c=relaxed/simple;
	bh=O+ZIlfaYxp6tZC4YU2TD9m0DCZc3gFoKqYhyvOhTRq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NToWdfBmRwlUS7OuMrf+FJsxvkFIF7rkKUVDfOpcGzHgErQ74xWKgUGtZ9W/KfOqSBvRLueCap7exTJ8idVoRRl1Dk9QVMNChc1Lb9BPb868Q/gjAu2306ie+A/oUkTXMwPYF8+Otm5jIyalt9L0moHsRcyaz/MYsTwnMtHyJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BC5C4CEF1;
	Fri,  9 Jan 2026 06:53:02 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v8 7/8] blk-mq-debugfs: add missing debugfs_mutex in blk_mq_debugfs_register_hctxs()
Date: Fri,  9 Jan 2026 14:52:29 +0800
Message-ID: <20260109065230.653281-8-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109065230.653281-1-yukuai@fnnas.com>
References: <20260109065230.653281-1-yukuai@fnnas.com>
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
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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

