Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EEC18132A
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103674; cv=none; b=ZHivYznVKuXK8KpsWkNgXtzkKvDYRG3z5uqIfsZ2A30psKaHMikXpxT6Vg1vkhvqk3TCBJMfvSqmp8iQjPQN6j0FNpoc10UKK+J7wGchkAnNrBrVxOosvOH1PxkssqRKJL/+q9/0D9FlV9oghRH2k9fhorecCqhq6vP1sqx/mw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103674; c=relaxed/simple;
	bh=sLKiBRrQzliZS5EauWutuXQcJMgKBXS5dTyqBWUbmv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWCiEpmB4Zi0IC12AQGRTbEdj8XCySvgzDnL9yiFdlsDaTfblob9nhyxmjyy1qPTId0BlBN60nSGcn3KDxQKV3oB6ffg398s8kWKiAktZsS1MBlkWw94MijazP7COOmiuqR1msAfyJZJE4DlouT8e8T9zNU5MZIcRdAzxLw/LzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfkKC6bE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfkKC6bE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zM0LxXjIcrRWYRqpl5YfwCfb8GR7Xn5MKtORf1nwdo=;
	b=FfkKC6bEb5RWP8tB9rtG+rxyEudb3KNKa/u1O+39E7+ckW4YZLKJjrb2MLzC6Zw/x1AExj
	A9Z88kXcx007x82jRjvPlQqKfLbFyItEH7127q9YHbrvZy5AIE7WaWcYOyXLHRmliAftkN
	2N614N9innPD2hgUtINOKw/52zot37w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-BqqQMo-QNAm6JS9I6CHSbg-1; Sun,
 09 Feb 2025 07:21:07 -0500
X-MC-Unique: BqqQMo-QNAm6JS9I6CHSbg-1
X-Mimecast-MFC-AGG-ID: BqqQMo-QNAm6JS9I6CHSbg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D78E1800374;
	Sun,  9 Feb 2025 12:21:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FF6F1956094;
	Sun,  9 Feb 2025 12:21:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/7] block: remove q->sched_debugfs_dir
Date: Sun,  9 Feb 2025 20:20:27 +0800
Message-ID: <20250209122035.1327325-4-ming.lei@redhat.com>
In-Reply-To: <20250209122035.1327325-1-ming.lei@redhat.com>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

For each request_queue, its sched debugfs path is fixed, which can be
queried from its parent dentry directly, so it isn't necessary to cache
it in request_queue instance because it isn't used in fast path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 10 +++++-----
 block/blk-sysfs.c      |  1 -
 include/linux/blkdev.h |  1 -
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3abb38ea2577..3d3346fc4c4e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -628,7 +628,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	 * didn't exist yet (because we don't know what to name the directory
 	 * until the queue is registered to a gendisk).
 	 */
-	if (q->elevator && !q->sched_debugfs_dir)
+	if (q->elevator)
 		blk_mq_debugfs_register_sched(q);
 
 	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
@@ -745,6 +745,7 @@ void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 void blk_mq_debugfs_register_sched(struct request_queue *q)
 {
 	struct elevator_type *e = q->elevator->type;
+	struct dentry *sched_dir;
 
 	lockdep_assert_held(&q->debugfs_mutex);
 
@@ -758,17 +759,16 @@ void blk_mq_debugfs_register_sched(struct request_queue *q)
 	if (!e->queue_debugfs_attrs)
 		return;
 
-	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
+	sched_dir = debugfs_create_dir("sched", q->debugfs_dir);
 
-	debugfs_create_files(q->sched_debugfs_dir, q, e->queue_debugfs_attrs);
+	debugfs_create_files(sched_dir, q, e->queue_debugfs_attrs);
 }
 
 void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 {
 	lockdep_assert_held(&q->debugfs_mutex);
 
-	debugfs_remove_recursive(q->sched_debugfs_dir);
-	q->sched_debugfs_dir = NULL;
+	debugfs_lookup_and_remove("sched", q->debugfs_dir);
 }
 
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6f548a4376aa..35d92ed10fdb 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -748,7 +748,6 @@ static void blk_debugfs_remove(struct gendisk *disk)
 	blk_trace_shutdown(q);
 	debugfs_remove_recursive(q->debugfs_dir);
 	q->debugfs_dir = NULL;
-	q->sched_debugfs_dir = NULL;
 	q->rqos_debugfs_dir = NULL;
 	mutex_unlock(&q->debugfs_mutex);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..5efe6f00d86f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -598,7 +598,6 @@ struct request_queue {
 	struct list_head	tag_set_list;
 
 	struct dentry		*debugfs_dir;
-	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 	/*
 	 * Serializes all debugfs metadata operations using the above dentries.
-- 
2.47.0

