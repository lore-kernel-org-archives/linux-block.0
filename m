Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C80276046
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707262; cv=none; b=LKeE6d/9yLubiePiTJHrcfjr5jPKC9VgI11IjxETMzYXGnnT8gRX+5q3FDrdV5BG6DmrF5f7tMFGhaQOacK2cz1abyC4LRZx77Jz+gXxLMxxKCHPnD9tt7OKXRit1NmJStYgXFbAdSsI6p/gBK7fR3Amb2rkRLSmrySrRQT5/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707262; c=relaxed/simple;
	bh=p4BcUpuIs14uNaw9HaLj2jhCYqH/h4CaJW5byaCKOno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaSk5r9QJfsHGHLSSq+efvQPK9VvSzoVzLsrme49bhoIEajyVQmGEZsOfXORFptSumAIlRDnI1CRg3Xu7LvuWJK0IxxoMlao8IOgoEmx1AaHcfzi13A/4rY2iHCbINfB83Vhu1BoxYzGM0vxxUvWTAAQ/uEQleLrVLmoOY02pYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E3BC4CEF1;
	Sun, 14 Dec 2025 10:14:19 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v5 03/13] blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
Date: Sun, 14 Dec 2025 18:13:58 +0800
Message-ID: <20251214101409.1723751-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214101409.1723751-1-yukuai@fnnas.com>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
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

