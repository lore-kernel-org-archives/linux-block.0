Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE01A2545
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454724; cv=none; b=E5uoYGZbN1nIFJze14bn4/HLdiMJc0Mq4Iq9Z2PZt6z+MaamLeUsGQDH0CSi9sZlNBzYcNvkS9EmNk6WFRuX20O2txuTm53Y43FvikRwpW6B0dcgP1TLTb9mrEzKld6+jj7aFg2hh1Hn+Bvb3xEDWQKCWYD6u06e6VKf4PvUKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454724; c=relaxed/simple;
	bh=t/EKpiNr92v3Dm6OSTdcOFupZpMWjwusnXVkTF3R6QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRsGjH+tqWSCBwZrRYfBmQ+0eHzxlQJ0BWW5ja8N+bj0xfn722aQCJ6tATXDZ6+hovz4dVpFz8EGtnCHHR+Ny75XawCpZmN1Qzg8eCAydoOHmI0gLuL1+TdKRazA9w9YreQgNWjWf/LT+ocy31soonO0s+UfmLtiO6xnjxhpl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJ+WCH7m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJ+WCH7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pMGz5fzBWg2XXdhvNEeMJopiOIvWvFdP4J29UaiTdI=;
	b=PJ+WCH7m21xwzD4SpCeEDtLwZuAsLJ/BkF0bFIo9hDN/ac01NIUR5bXcVi1C1QekmTVHrp
	u+Bjqkgakfpy6ymQR9p2sgpGcosCf33vJ7pu0+oHyib1l23cTlmpzbAOAmahBQzJZwYG2c
	i8PEZYcP+wI+AgMPbuw0g6XDQRju0cw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-rApZN8alOBKvR8w5iTaMTQ-1; Mon,
 05 May 2025 10:18:37 -0400
X-MC-Unique: rApZN8alOBKvR8w5iTaMTQ-1
X-Mimecast-MFC-AGG-ID: rApZN8alOBKvR8w5iTaMTQ_1746454716
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0829419560A2;
	Mon,  5 May 2025 14:18:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A18B71800352;
	Mon,  5 May 2025 14:18:33 +0000 (UTC)
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
Subject: [PATCH V5 05/25] block: add two helpers for registering/un-registering sched debugfs
Date: Mon,  5 May 2025 22:17:43 +0800
Message-ID: <20250505141805.2751237-6-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

