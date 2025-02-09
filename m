Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773F18132A
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103684; cv=none; b=qXdX6693CrWOC/Q1vzSzePQbBgRtWhN8Al6/ggiGhUvnFirH5XqdPVMqQE1s8Qex6ckt7lfQiSljBcyLnpMzP/LgBg/XFou0GpeXLVxnNHiIppJN/N2SuRZHQys0v0ryOqjvI/nF4ggoAZACVzJJbnIt9hLV2XvzFyYoZoV6O9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103684; c=relaxed/simple;
	bh=ZVLyiR1o3f19kGBvpBGZzV9I2kgiaoBZJZoV73DKs3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLgUdI5TRnb6ufzeVPdsSIOVzbY9+90dH2fiivnWRBNXVzhJ3KzjJ2fMcn7FTLnqatREWvAKFnZSlmSO4haDi1FWTyx9iEmaN6sBhOKB7ouDZaFLd8q58+zDqr2vddc3iTXdLYZrYkICQeMbtPDsiMErq400UXlK6pfah9tllkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7wPAzPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7wPAzPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgNDisvTIx0HrETNPEbhoWdWx+G0dcVlCMSfhjbPwZI=;
	b=N7wPAzPmqJdmKVs5fBt56ixT4WP6DvexL9Gp7BbAjBZXADC1yB3pbUZGQIpTzhMng9DZW8
	COrNJked9pg3pslSnqdTUXwuX55hX7pM7mX8rVGdrhNGXr+c0FEnbiFArxuAlGvJFbImE6
	hv0qHj4zs8aynuWRHFW5CNro0P3uZ5c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-a5L7ZNmLM0GuzAbsPyE20Q-1; Sun,
 09 Feb 2025 07:21:16 -0500
X-MC-Unique: a5L7ZNmLM0GuzAbsPyE20Q-1
X-Mimecast-MFC-AGG-ID: a5L7ZNmLM0GuzAbsPyE20Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 955891800873;
	Sun,  9 Feb 2025 12:21:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54F1730001AB;
	Sun,  9 Feb 2025 12:21:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/7] block: remove rqos->debugfs_dir
Date: Sun,  9 Feb 2025 20:20:29 +0800
Message-ID: <20250209122035.1327325-6-ming.lei@redhat.com>
In-Reply-To: <20250209122035.1327325-1-ming.lei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

For each rqos instance, its debugfs path is fixed, which can be queried
from its parent dentry & rqos name directly, so it isn't necessary to
cache it in rqos instance because it isn't used in fast path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 30 ++++++++++++++++++++++--------
 block/blk-rq-qos.h     |  3 ---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9ccaf506514e..40eb104fc1d5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -786,14 +786,27 @@ static const char *rq_qos_id_to_name(enum rq_qos_id id)
 	return "unknown";
 }
 
+static __must_check struct dentry *blk_mq_debugfs_get_rqos_top(
+		struct request_queue *q)
+{
+	return debugfs_lookup("rqos", q->debugfs_dir);
+}
+
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
-	lockdep_assert_held(&rqos->disk->queue->debugfs_mutex);
+	struct request_queue *q = rqos->disk->queue;
+	struct dentry *rqos_top;
+
+	lockdep_assert_held(&q->debugfs_mutex);
+
+	if (!q->debugfs_dir)
+		return;
 
-	if (!rqos->disk->queue->debugfs_dir)
+	rqos_top = blk_mq_debugfs_get_rqos_top(q);
+	if (IS_ERR_OR_NULL(rqos_top))
 		return;
-	debugfs_remove_recursive(rqos->debugfs_dir);
-	rqos->debugfs_dir = NULL;
+	debugfs_lookup_and_remove(rq_qos_id_to_name(rqos->id), rqos_top);
+	dput(rqos_top);
 }
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
@@ -801,19 +814,20 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 	struct request_queue *q = rqos->disk->queue;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
 	struct dentry *rqos_top;
+	struct dentry *rqos_dir;
 
 	lockdep_assert_held(&q->debugfs_mutex);
 
-	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
+	if (!rqos->ops->debugfs_attrs)
 		return;
 
-	rqos_top = debugfs_lookup("rqos", q->debugfs_dir);
+	rqos_top = blk_mq_debugfs_get_rqos_top(q);
 	if (IS_ERR_OR_NULL(rqos_top))
 		return;
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name, rqos_top);
+	rqos_dir = debugfs_create_dir(dir_name, rqos_top);
 	dput(rqos_top);
-	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
+	debugfs_create_files(rqos_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 37245c97ee61..49c31f1e5578 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -29,9 +29,6 @@ struct rq_qos {
 	struct gendisk *disk;
 	enum rq_qos_id id;
 	struct rq_qos *next;
-#ifdef CONFIG_BLK_DEBUG_FS
-	struct dentry *debugfs_dir;
-#endif
 };
 
 struct rq_qos_ops {
-- 
2.47.0

