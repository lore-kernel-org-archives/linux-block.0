Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B982E266C;
	Mon,  2 Feb 2026 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019539; cv=none; b=k+zgCrnNDgKS1UB164+bZkzfI8EleOUsw8FdgJ41XN0XfYITWae0GCsERKBHCbg38XiOMohje1ogQytI84RVzs9JoMa2ztGt/YTTutNy1Lkn974bkSD9rCnVeS5lfwVIsyAu27675iLHKfOn4113jqqSaE9vV7Fcg8Cp9qSvLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019539; c=relaxed/simple;
	bh=DPagL1gIOlB/G6hvEmxknILuk0nDjlpNMTJ4pChBGmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj6fQqoxj5d+5Ex2YGbryt6r86mfaOKRVrr0RqP/+uFBnCPMVWDko6SZjaf+ptvP5HGklmlr5JqfhF3pJZL2dWB1+XODwUY//rVmdgFGyszSi8XjlqoHMKiKT63jsY6AE2rCZVrwnjerdIwpjd8/W+V9w5FPu0VAFmxpdx9PeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B9CC116C6;
	Mon,  2 Feb 2026 08:05:36 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	yukuai@fnnas.com
Subject: [PATCH v9 5/8] blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
Date: Mon,  2 Feb 2026 16:05:20 +0800
Message-ID: <20260202080523.3947504-6-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202080523.3947504-1-yukuai@fnnas.com>
References: <20260202080523.3947504-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because it's only used inside blk-mq-debugfs.c now.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq-debugfs.c | 2 +-
 block/blk-mq-debugfs.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4fe164b6d648..11f00a868541 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -744,7 +744,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 	rqos->debugfs_dir = NULL;
 }
 
-void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
+static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 54948a266889..d94daa66556b 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -34,7 +34,6 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
-void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
@@ -75,10 +74,6 @@ static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hc
 {
 }
 
-static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
-{
-}
-
 static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
 {
 }
-- 
2.51.0

