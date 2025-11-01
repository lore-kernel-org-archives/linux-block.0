Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C129460
	for <linux-block@vger.kernel.org>; Sat,  1 Nov 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003908; cv=none; b=QeZYqmqfpljdWsE04VlrfiLhGhgkELrO36invhR8PjkT7erJ2DojzUOyCeX4ClZou+krVGOAdzzpm1qnb5jqRIEXBgOHysK5G1lRz8nq6t5uyarx4luz3epdvIEv907nyhfeZXoEEI1x/JcTITTURdvX5Pd+7pGQMo6ZIIfg/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003908; c=relaxed/simple;
	bh=018WYY0EqPqwLmBE18IVXCSJYohDoGCQw8K5cQFr9B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT+vq7t9rNBIzDPFZAzaZf0S2znThG2ijdUPQ5fAD4+9tQ+0ovFLObG139wJa2hquYPKmpvZZ/yfi0zQVj5xafnw+skg0LqyHtm7cUzn/t3YKYOil6qvWYZAW9eEHEZlSWQlB3catm8Zh0Qo+zZWtYgveinNScgtvDDnR8WfWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfIzBF9E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfIzBF9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762003905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/o8IklOxvwXgYp+MAI4cDFz9SsKoUzpqlWJgZhlHgGQ=;
	b=dfIzBF9EDENe28i6TW2pF85WQwnQM4llY2PnsO7j38BrvNb4EfuGqez4tRh1fvk32dBpwq
	4XiXOibFmyNb3UPZN2nA7lO/zqhabs4mTXbN5lHEjinqyomwAPUhqjtA7s8DJjmVwTR6wF
	cf9p8S5twhi9koaoy/xGPUdoSUhRd4w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-YoGZ4TbNPZ2jVooHPugEsg-1; Sat,
 01 Nov 2025 09:31:42 -0400
X-MC-Unique: YoGZ4TbNPZ2jVooHPugEsg-1
X-Mimecast-MFC-AGG-ID: YoGZ4TbNPZ2jVooHPugEsg_1762003901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5829180034C;
	Sat,  1 Nov 2025 13:31:41 +0000 (UTC)
Received: from localhost (unknown [10.72.120.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A96371800576;
	Sat,  1 Nov 2025 13:31:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/5] ublk: implement NUMA-aware memory allocation
Date: Sat,  1 Nov 2025 21:31:17 +0800
Message-ID: <20251101133123.670052-3-ming.lei@redhat.com>
In-Reply-To: <20251101133123.670052-1-ming.lei@redhat.com>
References: <20251101133123.670052-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Implement NUMA-friendly memory allocation for ublk driver to improve
performance on multi-socket systems.

This commit includes the following changes:

1. Rename __queues to queues, dropping the __ prefix since the field is
   now accessed directly throughout the codebase rather than only through
   the ublk_get_queue() helper.

2. Remove the queue_size field from struct ublk_device as it is no longer
   needed.

3. Move queue allocation and deallocation into ublk_init_queue() and
   ublk_deinit_queue() respectively, improving encapsulation. This
   simplifies ublk_init_queues() and ublk_deinit_queues() to just
   iterate and call the per-queue functions.

4. Add ublk_get_queue_numa_node() helper function to determine the
   appropriate NUMA node for a queue by finding the first CPU mapped
   to that queue via tag_set.map[HCTX_TYPE_DEFAULT].mq_map[] and
   converting it to a NUMA node using cpu_to_node(). This function is
   called internally by ublk_init_queue() to determine the allocation
   node.

5. Allocate each queue structure on its local NUMA node using
   kvzalloc_node() in ublk_init_queue().

6. Allocate the I/O command buffer on the same NUMA node using
   alloc_pages_node().

This reduces memory access latency on multi-socket NUMA systems by
ensuring each queue's data structures are local to the CPUs that
access them.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 84 +++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2569566bf5e6..d920f7cf4dad 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -209,9 +209,6 @@ struct ublk_queue {
 struct ublk_device {
 	struct gendisk		*ub_disk;
 
-	char	*__queues;
-
-	unsigned int	queue_size;
 	struct ublksrv_ctrl_dev_info	dev_info;
 
 	struct blk_mq_tag_set	tag_set;
@@ -239,6 +236,8 @@ struct ublk_device {
 	bool canceling;
 	pid_t 	ublksrv_tgid;
 	struct delayed_work	exit_work;
+
+	struct ublk_queue       *queues[];
 };
 
 /* header of ublk_params */
@@ -781,7 +780,7 @@ static noinline void ublk_put_device(struct ublk_device *ub)
 static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
 		int qid)
 {
-       return (struct ublk_queue *)&(dev->__queues[qid * dev->queue_size]);
+	return dev->queues[qid];
 }
 
 static inline bool ublk_rq_has_data(const struct request *rq)
@@ -2662,9 +2661,13 @@ static const struct file_operations ublk_ch_fops = {
 
 static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
-	int size = ublk_queue_cmd_buf_size(ub);
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-	int i;
+	struct ublk_queue *ubq = ub->queues[q_id];
+	int size, i;
+
+	if (!ubq)
+		return;
+
+	size = ublk_queue_cmd_buf_size(ub);
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -2676,57 +2679,76 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 
 	if (ubq->io_cmd_buf)
 		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
+
+	kvfree(ubq);
+	ub->queues[q_id] = NULL;
+}
+
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
 }
 
 static int ublk_init_queue(struct ublk_device *ub, int q_id)
 {
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
+	int depth = ub->dev_info.queue_depth;
+	int ubq_size = sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
-	void *ptr;
+	struct ublk_queue *ubq;
+	struct page *page;
+	int numa_node;
 	int size;
 
+	/* Determine NUMA node based on queue's CPU affinity */
+	numa_node = ublk_get_queue_numa_node(ub, q_id);
+
+	/* Allocate queue structure on local NUMA node */
+	ubq = kvzalloc_node(ubq_size, GFP_KERNEL, numa_node);
+	if (!ubq)
+		return -ENOMEM;
+
 	spin_lock_init(&ubq->cancel_lock);
 	ubq->flags = ub->dev_info.flags;
 	ubq->q_id = q_id;
-	ubq->q_depth = ub->dev_info.queue_depth;
+	ubq->q_depth = depth;
 	size = ublk_queue_cmd_buf_size(ub);
 
-	ptr = (void *) __get_free_pages(gfp_flags, get_order(size));
-	if (!ptr)
+	/* Allocate I/O command buffer on local NUMA node */
+	page = alloc_pages_node(numa_node, gfp_flags, get_order(size));
+	if (!page) {
+		kvfree(ubq);
 		return -ENOMEM;
+	}
+	ubq->io_cmd_buf = page_address(page);
 
-	ubq->io_cmd_buf = ptr;
+	ub->queues[q_id] = ubq;
 	ubq->dev = ub;
 	return 0;
 }
 
 static void ublk_deinit_queues(struct ublk_device *ub)
 {
-	int nr_queues = ub->dev_info.nr_hw_queues;
 	int i;
 
-	if (!ub->__queues)
-		return;
-
-	for (i = 0; i < nr_queues; i++)
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_deinit_queue(ub, i);
-	kvfree(ub->__queues);
 }
 
 static int ublk_init_queues(struct ublk_device *ub)
 {
-	int nr_queues = ub->dev_info.nr_hw_queues;
-	int depth = ub->dev_info.queue_depth;
-	int ubq_size = sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io);
-	int i, ret = -ENOMEM;
+	int i, ret;
 
-	ub->queue_size = ubq_size;
-	ub->__queues = kvcalloc(nr_queues, ubq_size, GFP_KERNEL);
-	if (!ub->__queues)
-		return ret;
-
-	for (i = 0; i < nr_queues; i++) {
-		if (ublk_init_queue(ub, i))
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		ret = ublk_init_queue(ub, i);
+		if (ret)
 			goto fail;
 	}
 
@@ -3128,7 +3150,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 		goto out_unlock;
 
 	ret = -ENOMEM;
-	ub = kzalloc(sizeof(*ub), GFP_KERNEL);
+	ub = kzalloc(struct_size(ub, queues, info.nr_hw_queues), GFP_KERNEL);
 	if (!ub)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
-- 
2.47.0

