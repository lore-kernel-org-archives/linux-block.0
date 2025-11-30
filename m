Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360D537E9
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764470640; cv=none; b=MYkYE2gsiT5f6HEBjAw7Wg2NgToeS8lRiO9MZubHBoFjX02c1Ds58r7+qPhOX+q/TrYcnhSDUkfzPw7HfpY7/WAZSZndNsvI3gac6ZuD1cMDH/KJN2nHAZtjFWmtWyMqU8pBQpt0n+zQ+YMfddY4Y+sLB/X6ot426p7XfINo/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764470640; c=relaxed/simple;
	bh=7io5gauzaLWGYdMCWcfKV2yUhVgtNcFmCCxTnMgMlF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFW/+TVI9+Sn/ZdhYnP32VKwMuHUQNnLtRQRu/CiIxvb8wm4zhz4/vRR4grDuEqkPslkRGunyCsEMYDk3EtYMSFDHsJ9QqGJ5O49/oW5gu4QF9f0Uug7vBlUF4uAHTg9XNAdEB2wXJ6W+NQRKpcBMrMMMxGDqc2dx6qQulrDRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C92C116C6;
	Sun, 30 Nov 2025 02:43:58 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v3 03/10] blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
Date: Sun, 30 Nov 2025 10:43:42 +0800
Message-ID: <20251130024349.2302128-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251130024349.2302128-1-yukuai@fnnas.com>
References: <20251130024349.2302128-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because it's only used inside blk-mq-debugfs.c now.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c | 4 +++-
 block/blk-mq-debugfs.h | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 128d2aa6a20d..99466595c0a4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -14,6 +14,8 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
+
 static int queue_poll_stat_show(void *data, struct seq_file *m)
 {
 	return 0;
@@ -758,7 +760,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
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

