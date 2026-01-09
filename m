Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E02E7BB6
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941573; cv=none; b=NpnrRcGh4q6b5Zk5bEJRK5jLrG7Ccdo/IyHG600xRFzW56r7uPtc4RJjWeVZ7cpcFgaoJS5cbLevCRXg7H5pLXSngBuoLkbzyOBiRNmkqGR7vhOlSfvPrs8HwkWUVw9ChNA5nsxgx8JZ0ZNKiRVaufNbAeSXn6JFwrqZY35XztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941573; c=relaxed/simple;
	bh=l1wxiaTxUKhWLbzr3tVHFvmismKC4kVnblZIPEg5yRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+w2ZS3H1qOlahDVXoWn2Y+BqcH2zHK73uLsutcQIFXt2wD23JWDorv1fJcYSC08ngaTi53uM5RfynDBDEXMDMEOBLNQSkyFti5GYf4tJFQpITMIHjApmmOFsa+MQgduO6OAbpDQgcJfhEvdMMyiyF6oqGGYiX+EDsxms7lU1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6B1C4CEF1;
	Fri,  9 Jan 2026 06:52:50 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v8 3/8] blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
Date: Fri,  9 Jan 2026 14:52:25 +0800
Message-ID: <20260109065230.653281-4-yukuai@fnnas.com>
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

There is already a helper blk_mq_debugfs_register_rqos() to register
one rqos, however this helper is called synchronously when the rqos is
created with queue frozen.

Prepare to fix possible deadlock to create blk-mq debugfs entries while
queue is still frozen.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c | 23 +++++++++++++++--------
 block/blk-mq-debugfs.h |  5 +++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4896525b1c05..4fe164b6d648 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -631,14 +631,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
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
@@ -769,6 +762,20 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
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
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 					struct blk_mq_hw_ctx *hctx)
 {
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

