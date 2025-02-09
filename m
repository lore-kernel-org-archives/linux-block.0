Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535861D5170
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103677; cv=none; b=RgdXFPfhkTTP0s4J0B6eH+pbVr+dSZiMSbK58W92Kdu1N9Yub8hpk0faK2C5GpWILOuTdxyKGG0T+b64YmjmbkWVt6oKvC0TFHQYW2DI8lnG0LaBiO9tFmCT3B+w56GxhxalThNLJ6iExrxs4VsImeXb+6pDy+ohYKSqpQVpiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103677; c=relaxed/simple;
	bh=AfNgNKKDZM9ZM3mzHEmSiah6JxqWVzP7XPxmWxqUGkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkfTAzgDnpxy/Z9fg5WIuyxFX+r/9pXYmlNcd0XV/obJfSsUhq4q/WZ5MKyiTVP5DgD446K9kPWrpf09bcjAo/Th4MLTKwk+0CFl4YIp4p3vMoE7ov/wptFWwXcag2ZAtRYVqAzieLds3+8ddeMZGRAKWi5UICq446doypEXzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBeWviFZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBeWviFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezmciec7ag/xJTN47wZ9wFBbwQakbRbuYurnXAEVsJw=;
	b=GBeWviFZse89ahCeJk16ZDH/Oxmou4P9IndoZKiiweyPk1vi/KvlWDZpL1WMjg9GpXCWco
	UBJIpg35+5EHZ456RdX6JuiWhcXz3Az6OrMrV+Xsolf3OYU4uPBneDBmi3fS3ott4N5DXo
	LUeun33ONTHubK9J4/5jAJvFATWMY6Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-3bS3kezwN-qd0f5mIhotNQ-1; Sun,
 09 Feb 2025 07:21:11 -0500
X-MC-Unique: 3bS3kezwN-qd0f5mIhotNQ-1
X-Mimecast-MFC-AGG-ID: 3bS3kezwN-qd0f5mIhotNQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A43501800268;
	Sun,  9 Feb 2025 12:21:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C0D9180087A;
	Sun,  9 Feb 2025 12:21:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/7] block: remove q->rqos_debugfs_dir
Date: Sun,  9 Feb 2025 20:20:28 +0800
Message-ID: <20250209122035.1327325-5-ming.lei@redhat.com>
In-Reply-To: <20250209122035.1327325-1-ming.lei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For each request_queue, its rqos debugfs path is fixed, which can be
queried from its parent dentry directly, so it isn't necessary to cache
it in request_queue instance because it isn't used in fast path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 12 ++++++++----
 block/blk-sysfs.c      |  1 -
 include/linux/blkdev.h |  1 -
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3d3346fc4c4e..9ccaf506514e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -638,6 +638,8 @@ void blk_mq_debugfs_register(struct request_queue *q)
 			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
+	debugfs_create_dir("rqos", q->debugfs_dir);
+
 	if (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 
@@ -798,17 +800,19 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->disk->queue;
 	const char *dir_name = rq_qos_id_to_name(rqos->id);
+	struct dentry *rqos_top;
 
 	lockdep_assert_held(&q->debugfs_mutex);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
 
-	if (!q->rqos_debugfs_dir)
-		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
-							 q->debugfs_dir);
+	rqos_top = debugfs_lookup("rqos", q->debugfs_dir);
+	if (IS_ERR_OR_NULL(rqos_top))
+		return;
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name, q->rqos_debugfs_dir);
+	rqos->debugfs_dir = debugfs_create_dir(dir_name, rqos_top);
+	dput(rqos_top);
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 35d92ed10fdb..0679116bb195 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -748,7 +748,6 @@ static void blk_debugfs_remove(struct gendisk *disk)
 	blk_trace_shutdown(q);
 	debugfs_remove_recursive(q->debugfs_dir);
 	q->debugfs_dir = NULL;
-	q->rqos_debugfs_dir = NULL;
 	mutex_unlock(&q->debugfs_mutex);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5efe6f00d86f..7663f0c482de 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -598,7 +598,6 @@ struct request_queue {
 	struct list_head	tag_set_list;
 
 	struct dentry		*debugfs_dir;
-	struct dentry		*rqos_debugfs_dir;
 	/*
 	 * Serializes all debugfs metadata operations using the above dentries.
 	 */
-- 
2.47.0

