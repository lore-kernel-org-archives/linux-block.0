Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8E270EDD
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291866; cv=none; b=ifxQjqNac6VNH3Ss9FlbdIMolfj9gzRl4CMb3TBcNoWq5GlH5IUpYxOP0PKiOlXVC8LtE6qrgr/VuzQ//xm+Or+8/yHTjR9v8bf4O4fsRJRS/IwEfHaAI7lJ8Fb9ifoKLQpvBu8cVwYCJfUJhOAwZyzFeM2Pm2lpOUr9WSKbVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291866; c=relaxed/simple;
	bh=W1UdxACutlB4PXXwGop6Bj2NlUg6zghyZyBRqP7SF+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZqTiyDLFx4nJL9J+0Iebjku4zeqAHlRNC9GPaDJEBOyST/IOQcDKo193eWnZDvSw/K/OXgjjuSgFtQHQ8IA597n0g/ZBS+k9Or9z0gkcF38K2v80gsNk6hXMU3BWaDs96Py1v/ekHfeEXUKdFaey6MSGrp8mAehuXO28rRTArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cA4Qr/5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA4Qr/5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkMxNwGGiOx5QHMiE4ibpmnkcfdM3hpGrThHPVIPN10=;
	b=cA4Qr/5M8eM2Om9Ir/2Go2TM2sz1C0cOv4uK722ixvQ17WX/5mA+ylv0uFvlfDQUA3TLiX
	j+KomvLMxoGb7EIqbNk/uK/bVxr5DxTFU3Dg0EhqBBTLKOB9w5WwiJc88pIey8VrRas8K3
	VCHQJ7Vqpcoy3dGR055J/Sz7r/Qw65M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-6yON_z6VM4S2J0RfnmPUsw-1; Thu,
 10 Apr 2025 09:31:00 -0400
X-MC-Unique: 6yON_z6VM4S2J0RfnmPUsw-1
X-Mimecast-MFC-AGG-ID: 6yON_z6VM4S2J0RfnmPUsw_1744291859
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7234E180025A;
	Thu, 10 Apr 2025 13:30:59 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C8FA180175B;
	Thu, 10 Apr 2025 13:30:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/15] block: add two helpers for registering/un-registering sched debugfs
Date: Thu, 10 Apr 2025 21:30:14 +0800
Message-ID: <20250410133029.2487054-3-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add blk_mq_sched_reg_debugfs()/blk_mq_sched_unreg_debugfs() to clean
up sched init/exit code a bit.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 109611445d40..f66abaa25430 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -436,6 +436,30 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 	return 0;
 }
 
+static void blk_mq_sched_reg_debugfs(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_register_sched(q);
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_debugfs_register_sched_hctx(q, hctx);
+	mutex_unlock(&q->debugfs_mutex);
+}
+
+static void blk_mq_sched_unreg_debugfs(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	mutex_lock(&q->debugfs_mutex);
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_debugfs_unregister_sched_hctx(hctx);
+	blk_mq_debugfs_unregister_sched(q);
+	mutex_unlock(&q->debugfs_mutex);
+}
+
 /* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
@@ -469,10 +493,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (ret)
 		goto err_free_map_and_rqs;
 
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_register_sched(q);
-	mutex_unlock(&q->debugfs_mutex);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->ops.init_hctx) {
 			ret = e->ops.init_hctx(hctx, i);
@@ -484,10 +504,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 				return ret;
 			}
 		}
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_sched_hctx(q, hctx);
-		mutex_unlock(&q->debugfs_mutex);
 	}
+	blk_mq_sched_reg_debugfs(q);
 
 	return 0;
 
@@ -526,11 +544,9 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	unsigned long i;
 	unsigned int flags = 0;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_unregister_sched_hctx(hctx);
-		mutex_unlock(&q->debugfs_mutex);
+	blk_mq_sched_unreg_debugfs(q);
 
+	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->type->ops.exit_hctx && hctx->sched_data) {
 			e->type->ops.exit_hctx(hctx, i);
 			hctx->sched_data = NULL;
@@ -538,10 +554,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 		flags = hctx->flags;
 	}
 
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_unregister_sched(q);
-	mutex_unlock(&q->debugfs_mutex);
-
 	if (e->type->ops.exit_sched)
 		e->type->ops.exit_sched(e);
 	blk_mq_sched_tags_teardown(q, flags);
-- 
2.47.0

