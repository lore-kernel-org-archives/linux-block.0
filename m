Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4F314B69
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706515; cv=none; b=Ri49nBBXu2Izy82tErrBbyVj9FcZuvfid1Ny9nMFQQ+5E5IWe6h/raYLnYlI2e7xi+7/j4JOc1af/BsJZob5lnoIo1RMjBmfaeo29M1X7+H8wOmFJ0RNa6FSbdAEjPkNxzTIRmm9fW3b/Q9MZ2ZnMOJhwREoinVYv9ZkoUhI4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706515; c=relaxed/simple;
	bh=p4BcUpuIs14uNaw9HaLj2jhCYqH/h4CaJW5byaCKOno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+rYfMBz6+SRIDpjQzRlY5vwNh8L5iHcY3b4ZwgrjhQ9ixAH7JwJCt5znUXRI1BHnligebDOkh2ybBcsqSYRSRGyr2n1E+JGMqL/P4wT9CaAH+OOzIaRwFP1gnfK2CqnL7luknxFNLXf3U7yJ2e1Q+AnNc//A/AfOAU7VhwErYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C8CC116D0;
	Fri, 21 Nov 2025 06:28:33 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v2 1/9] blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
Date: Fri, 21 Nov 2025 14:28:21 +0800
Message-ID: <20251121062829.1433332-2-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121062829.1433332-1-yukuai@fnnas.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already a helper blk_mq_debugfs_register_rqos() to register
one rqos, however this helper is called synchronously when the rqos is
created with queue frozen.

Prepare to fix possible deadlock to create blk-mq debugfs entries while
queue is still frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c | 23 +++++++++++++++--------
 block/blk-mq-debugfs.h |  5 +++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4896525b1c05..128d2aa6a20d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -619,6 +619,20 @@ static void debugfs_create_files(struct dentry *parent, void *data,
 				    (void *)attr, data, &blk_mq_debugfs_fops);
 }
 
+void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
+{
+	lockdep_assert_held(&q->debugfs_mutex);
+
+	if (q->rq_qos) {
+		struct rq_qos *rqos = q->rq_qos;
+
+		while (rqos) {
+			blk_mq_debugfs_register_rqos(rqos);
+			rqos = rqos->next;
+		}
+	}
+}
+
 void blk_mq_debugfs_register(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -631,14 +645,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 			blk_mq_debugfs_register_hctx(q, hctx);
 	}
 
-	if (q->rq_qos) {
-		struct rq_qos *rqos = q->rq_qos;
-
-		while (rqos) {
-			blk_mq_debugfs_register_rqos(rqos);
-			rqos = rqos->next;
-		}
-	}
+	blk_mq_debugfs_register_rq_qos(q);
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index c80e453e3014..54948a266889 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -33,6 +33,7 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx);
 void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
+void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
 #else
@@ -78,6 +79,10 @@ static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 }
 
+static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
+{
+}
+
 static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 }
-- 
2.51.0

