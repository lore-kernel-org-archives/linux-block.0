Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAE3D6B
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473356; cv=none; b=mV+9YfxMWLzBV8VrqgUmUJYor284Qom0LB5ngCadQtEfRxTx+nN5d4AyPcYi+QzXoQlUMAJ2DNU3s7CkUbD3CBysNdCg+n2KlLY4WVn+KQlIobqVFl8qdHWC6RJwbGGBmcASqc0yA+FfrCyc9Bb7nPf5BB4iJHI6NkAQt20XYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473356; c=relaxed/simple;
	bh=7Ps+0rtmoFFwSh9eU3qwFbHiv2OLIADBWzG0rPFN/1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjsXT/L+iMS7+jVSrBR9ZSSLHqaZSASeyAGwuKug+A9/0hBa2fk92XyAlKTLUKs/1uCyANpvOEeljPYd9yLcP5+tSXtG8kao6PyTAyRVoek4unNnOEA0CpsPhoF46Ykdz4uX55ZsG3BCix4EHHbqSo6RMpjtG1REWpXUu7uD3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkOGZnwY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkOGZnwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733473353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgqPdhJrbE8x/N7mVojPWIch7EXtoMheO7kgzkBGauY=;
	b=EkOGZnwYIl5jHQYSUg51fOZzqlI3j/N98CURQ5Vl4uQ6D2uBT7IX1y2GKBJ3KVPDeI7XoM
	aqNN4t25ZxOkfT/aTvwtVMK89eQBihJTtve/0baYQ9BwuQJmQdngTzHRjp4ti/IejJMrDW
	B/6SoPpALcVhVBniF8jbgvQl6LH9EfM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-WP4r0KwWP6isCJ6yuNU4CA-1; Fri,
 06 Dec 2024 03:22:29 -0500
X-MC-Unique: WP4r0KwWP6isCJ6yuNU4CA-1
X-Mimecast-MFC-AGG-ID: WP4r0KwWP6isCJ6yuNU4CA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9799B1956089;
	Fri,  6 Dec 2024 08:22:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B38A1955F3F;
	Fri,  6 Dec 2024 08:22:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH V2] null_blk: cleanup null_init_tag_set
Date: Fri,  6 Dec 2024 16:21:56 +0800
Message-ID: <20241206082202.949142-3-ming.lei@redhat.com>
In-Reply-To: <20241206082202.949142-1-ming.lei@redhat.com>
References: <20241206082202.949142-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The passed 'nullb' can be NULL, so cause null ptr reference.

Fix the issue, meantime cleanup null_init_tag_set for avoiding to add
similar issue in future.

Meantime set BLK_MQ_F_NO_SCHED if g_no_sched is true in case of NULL
device, same with BLK_MQ_F_TAG_HCTX_SHARED.

Cc: Vincent Fu <vincent.fu@samsung.com>
Fixes: 37ae152c7a0d ("null_blk: add configfs variables for 2 options")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- set BLK_MQ_F_NO_SCHED & BLK_MQ_F_TAG_HCTX_SHARED correctly in case
	of null device, as suggested by Vincent Fu

 drivers/block/null_blk/main.c | 53 +++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c955a07dba2d..1501c85fc9e4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1898,31 +1898,48 @@ static int null_gendisk_register(struct nullb *nullb)
 
 static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 {
+	unsigned int flags = BLK_MQ_F_SHOULD_MERGE;
+	int hw_queues, numa_node;
+	unsigned int queue_depth;
 	int poll_queues;
 
+	if (nullb) {
+		hw_queues = nullb->dev->submit_queues;
+		poll_queues = nullb->dev->poll_queues;
+		queue_depth = nullb->dev->hw_queue_depth;
+		numa_node = nullb->dev->home_node;
+		if (nullb->dev->no_sched)
+			flags |= BLK_MQ_F_NO_SCHED;
+		if (nullb->dev->shared_tag_bitmap)
+			flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+		if (nullb->dev->blocking)
+			flags |= BLK_MQ_F_BLOCKING;
+	} else {
+		hw_queues = g_submit_queues;
+		poll_queues = g_poll_queues;
+		queue_depth = g_hw_queue_depth;
+		numa_node = g_home_node;
+		if (g_no_sched)
+			flags |= BLK_MQ_F_NO_SCHED;
+		if (g_shared_tag_bitmap)
+			flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+		if (g_blocking)
+			flags |= BLK_MQ_F_BLOCKING;
+	}
+
 	set->ops = &null_mq_ops;
-	set->nr_hw_queues = nullb ? nullb->dev->submit_queues :
-						g_submit_queues;
-	poll_queues = nullb ? nullb->dev->poll_queues : g_poll_queues;
-	if (poll_queues)
-		set->nr_hw_queues += poll_queues;
-	set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
-						g_hw_queue_depth;
-	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
 	set->cmd_size	= sizeof(struct nullb_cmd);
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	if (nullb->dev->no_sched)
-		set->flags |= BLK_MQ_F_NO_SCHED;
-	if (nullb->dev->shared_tag_bitmap)
-		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
+	set->flags = flags;
 	set->driver_data = nullb;
-	if (poll_queues)
+	set->nr_hw_queues = hw_queues;
+	set->queue_depth = queue_depth;
+	set->numa_node = numa_node;
+	if (poll_queues) {
+		set->nr_hw_queues += poll_queues;
 		set->nr_maps = 3;
-	else
+	} else {
 		set->nr_maps = 1;
-
-	if ((nullb && nullb->dev->blocking) || g_blocking)
-		set->flags |= BLK_MQ_F_BLOCKING;
+	}
 
 	return blk_mq_alloc_tag_set(set);
 }
-- 
2.31.1

