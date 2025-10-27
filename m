Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B22FFDF3
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565817; cv=none; b=P8liK0RgDpvRBKaAD8IFUKR1XIkTJMhqRaBPQ6j6I8ztQ3lR7Kyefxbl0+KSYgMONYz62aKjk3g42Sx45AkGt9k0iHTdQh170TZEhI/lf8nHZ+OhKX91to1R1bg17z9audrop2rxCSLc5FpHm2LDUoiM2Ex4ilSYpA1LdCFglp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565817; c=relaxed/simple;
	bh=ygRswTERXm9wFgoEjqVWmP3kEbXpZ775W5IA8sdcU3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mveIuxUXAamoL2+BePmmH8TxxVmcLTjAhDkbZ9adm/m0HQcAmZdRzCCpzvpJZSuZO+psmXEXiPwCLUpdlHRfbw1Samvu+Ng2s0QnnV28JxI13fzbXYT2K33j+lIhL9SA04KzSvjWrYQFjRzA88Dl0a5hvqpmn536PArx4Uokabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0SZc9c6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0SZc9c6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761565813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcGrtEcpa9imCh7AQqoCfR9+CjvLUPJZc2vOIypkoVA=;
	b=b0SZc9c6Hwz4ILGKg1wRoW+MjOw7B5UAsEPqLrNVEX/Uk4RI8O2KFebvqD6OB3lBSSuQOv
	Gr8yqFCoX3w7yGiKW2YNnSlTmRKEs91yrGzgWY21tdKH5S5xxW4b69zVXQOmq6yKYEl46y
	IFLIZroVCKiufYzgH/7urf01dxmyeMs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-OcPjHM3bNyeFwIQuhy8TFg-1; Mon,
 27 Oct 2025 07:50:10 -0400
X-MC-Unique: OcPjHM3bNyeFwIQuhy8TFg-1
X-Mimecast-MFC-AGG-ID: OcPjHM3bNyeFwIQuhy8TFg_1761565809
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A6511956070;
	Mon, 27 Oct 2025 11:50:09 +0000 (UTC)
Received: from localhost (unknown [10.72.120.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28E313000223;
	Mon, 27 Oct 2025 11:50:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] ublk: implement NUMA-aware memory allocation
Date: Mon, 27 Oct 2025 19:49:46 +0800
Message-ID: <20251027114950.129414-3-ming.lei@redhat.com>
In-Reply-To: <20251027114950.129414-1-ming.lei@redhat.com>
References: <20251027114950.129414-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement NUMA-friendly memory allocation for ublk driver to improve
performance on multi-socket systems.

This commit includes the following changes:

1. Change __queues from char* to struct ublk_queue** pointer array
   to enable per-queue NUMA-aware allocation. Update ublk_get_queue()
   helper to use simple array indexing.

2. Add ublk_get_queue_numa_node() helper function to determine the
   appropriate NUMA node for a queue by finding the first CPU mapped
   to that queue via tag_set.map[HCTX_TYPE_DEFAULT].mq_map[] and
   converting it to a NUMA node using cpu_to_node().

3. Allocate each queue structure on its local NUMA node using
   kvzalloc_node() in ublk_init_queues().

4. Pass the calculated NUMA node from ublk_init_queues() to
   ublk_init_queue() and allocate the I/O command buffer on the
   same NUMA node using alloc_pages_node().

5. Update ublk_deinit_queues() to free each queue individually.

This reduces memory access latency on multi-socket NUMA systems by
ensuring each queue's data structures are local to the CPUs that
access them.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 48 +++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2569566bf5e6..a3f596022b6d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -209,7 +209,7 @@ struct ublk_queue {
 struct ublk_device {
 	struct gendisk		*ub_disk;
 
-	char	*__queues;
+	struct ublk_queue	**__queues;
 
 	unsigned int	queue_size;
 	struct ublksrv_ctrl_dev_info	dev_info;
@@ -781,7 +781,7 @@ static noinline void ublk_put_device(struct ublk_device *ub)
 static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
 		int qid)
 {
-       return (struct ublk_queue *)&(dev->__queues[qid * dev->queue_size]);
+	return dev->__queues[qid];
 }
 
 static inline bool ublk_rq_has_data(const struct request *rq)
@@ -2678,11 +2678,11 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
 }
 
-static int ublk_init_queue(struct ublk_device *ub, int q_id)
+static int ublk_init_queue(struct ublk_device *ub, int q_id, int numa_node)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
-	void *ptr;
+	struct page *page;
 	int size;
 
 	spin_lock_init(&ubq->cancel_lock);
@@ -2691,11 +2691,12 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	ubq->q_depth = ub->dev_info.queue_depth;
 	size = ublk_queue_cmd_buf_size(ub);
 
-	ptr = (void *) __get_free_pages(gfp_flags, get_order(size));
-	if (!ptr)
+	/* Allocate I/O command buffer on local NUMA node */
+	page = alloc_pages_node(numa_node, gfp_flags, get_order(size));
+	if (!page)
 		return -ENOMEM;
 
-	ubq->io_cmd_buf = ptr;
+	ubq->io_cmd_buf = page_address(page);
 	ubq->dev = ub;
 	return 0;
 }
@@ -2708,11 +2709,26 @@ static void ublk_deinit_queues(struct ublk_device *ub)
 	if (!ub->__queues)
 		return;
 
-	for (i = 0; i < nr_queues; i++)
+	for (i = 0; i < nr_queues; i++) {
 		ublk_deinit_queue(ub, i);
+		kvfree(ub->__queues[i]);
+	}
 	kvfree(ub->__queues);
 }
 
+static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
+{
+	unsigned int cpu;
+
+	/* Find first CPU mapped to this queue */
+	for_each_possible_cpu(cpu) {
+		if (ub->tag_set.map[HCTX_TYPE_DEFAULT].mq_map[cpu] == q_id)
+			return cpu_to_node(cpu);
+	}
+
+	return NUMA_NO_NODE;
+}
+
 static int ublk_init_queues(struct ublk_device *ub)
 {
 	int nr_queues = ub->dev_info.nr_hw_queues;
@@ -2721,12 +2737,24 @@ static int ublk_init_queues(struct ublk_device *ub)
 	int i, ret = -ENOMEM;
 
 	ub->queue_size = ubq_size;
-	ub->__queues = kvcalloc(nr_queues, ubq_size, GFP_KERNEL);
+	ub->__queues = kvcalloc(nr_queues, sizeof(struct ublk_queue *),
+				GFP_KERNEL);
 	if (!ub->__queues)
 		return ret;
 
 	for (i = 0; i < nr_queues; i++) {
-		if (ublk_init_queue(ub, i))
+		int numa_node;
+
+		/* Determine NUMA node based on queue's CPU affinity */
+		numa_node = ublk_get_queue_numa_node(ub, i);
+
+		/* Allocate this queue on its local NUMA node */
+		ub->__queues[i] = kvzalloc_node(ubq_size, GFP_KERNEL,
+						numa_node);
+		if (!ub->__queues[i])
+			goto fail;
+
+		if (ublk_init_queue(ub, i, numa_node))
 			goto fail;
 	}
 
-- 
2.47.0

