Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671933EC
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987765; cv=none; b=H3T4ClbpFl7ZeFCfNZNfqKt9Pj0PhvgK/PWLDy9YBv5dWIn7v0JpxYGUhoLSXvCyRDJSV7tJDeO4M0s1j1ooptcqaZPmflsXU007As9NVS/cXjDdO9pojI8/ga0CDWxi/uuvQBYB4yzQ4bro9tuS7HmxOEd2JtxlzmFT3nKM/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987765; c=relaxed/simple;
	bh=t/EKpiNr92v3Dm6OSTdcOFupZpMWjwusnXVkTF3R6QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPYMc6OYAeYy7R5Y/SMQkKWACQKrGzcLhMsEsHLP7nh2iGB8m/YR4hZxMkDUpUBJue1rYVZ5k1YOzAkm/2r4VMSKedfOppaOW4Fq7T3X9gs9j+AJEWVGOTrsnzxdYapHcEC2yZtd6r8x9u8t3My6ilFc9UYIPfyZPkUsW8J6mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFauBdde; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFauBdde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pMGz5fzBWg2XXdhvNEeMJopiOIvWvFdP4J29UaiTdI=;
	b=TFauBddecZIQZumOTlw4Xmd5oJEAiOy7DpfPH100dQD5bUxcLJ9olFF3a4EFJ2/iYpxSFR
	iVn3h7cz8YBMnudf9/ps8VvHnuVg2OwxKbfeWw7Wam2Pff6IORs/lhELAci0aZ3oHQTTbm
	jXgn87kw/NbgawGl/AM7CohHKx1RTAM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-OVKlFbTUNBCCXo-dAO-ZiA-1; Wed,
 30 Apr 2025 00:35:58 -0400
X-MC-Unique: OVKlFbTUNBCCXo-dAO-ZiA-1
X-Mimecast-MFC-AGG-ID: OVKlFbTUNBCCXo-dAO-ZiA_1745987757
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E9FC1800873;
	Wed, 30 Apr 2025 04:35:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17E1F195608D;
	Wed, 30 Apr 2025 04:35:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 05/24] block: add two helpers for registering/un-registering sched debugfs
Date: Wed, 30 Apr 2025 12:35:07 +0800
Message-ID: <20250430043529.1950194-6-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add blk_mq_sched_reg_debugfs()/blk_mq_sched_unreg_debugfs() to clean up
sched init/exit code a bit.

Register & unregister debugfs for sched & sched_hctx order is changed a
bit, but it is safe because sched & sched_hctx is guaranteed to be ready
when exporting via debugfs.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 45 +++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9b81771774ef..2abc5e0704e8 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -434,6 +434,30 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
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
@@ -467,10 +491,6 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (ret)
 		goto err_free_map_and_rqs;
 
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_register_sched(q);
-	mutex_unlock(&q->debugfs_mutex);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->ops.init_hctx) {
 			ret = e->ops.init_hctx(hctx, i);
@@ -482,11 +502,11 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 				return ret;
 			}
 		}
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_register_sched_hctx(q, hctx);
-		mutex_unlock(&q->debugfs_mutex);
 	}
 
+	/* sched is initialized, it is ready to export it via debugfs */
+	blk_mq_sched_reg_debugfs(q);
+
 	return 0;
 
 err_free_map_and_rqs:
@@ -524,11 +544,10 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	unsigned long i;
 	unsigned int flags = 0;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		mutex_lock(&q->debugfs_mutex);
-		blk_mq_debugfs_unregister_sched_hctx(hctx);
-		mutex_unlock(&q->debugfs_mutex);
+	/* unexport via debugfs before exiting sched */
+	blk_mq_sched_unreg_debugfs(q);
 
+	queue_for_each_hw_ctx(q, hctx, i) {
 		if (e->type->ops.exit_hctx && hctx->sched_data) {
 			e->type->ops.exit_hctx(hctx, i);
 			hctx->sched_data = NULL;
@@ -536,10 +555,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
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

