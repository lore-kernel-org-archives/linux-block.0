Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/17] sx8: convert to blk-mq
Date: Thu, 11 Oct 2018 10:58:54 -0600
Message-Id: <20181011165909.32615-3-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Convert from the old request_fn style driver to blk-mq.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/sx8.c | 133 +++++++++++++++++++++++++++++---------------
 1 file changed, 88 insertions(+), 45 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 4d90e5eba2f5..5402dfdf331b 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
@@ -244,6 +244,7 @@ struct carm_port {
 	unsigned int			port_no;
 	struct gendisk			*disk;
 	struct carm_host		*host;
+	struct blk_mq_tag_set		tag_set;
 
 	/* attached device characteristics */
 	u64				capacity;
@@ -279,6 +280,7 @@ struct carm_host {
 	unsigned int			state;
 	u32				fw_ver;
 
+	struct blk_mq_tag_set		tag_set;
 	struct request_queue		*oob_q;
 	unsigned int			n_oob;
 
@@ -750,7 +752,7 @@ static inline void carm_end_request_queued(struct carm_host *host,
 	struct request *req = crq->rq;
 	int rc;
 
-	__blk_end_request_all(req, error);
+	blk_mq_end_request(req, error);
 
 	rc = carm_put_request(host, crq);
 	assert(rc == 0);
@@ -760,7 +762,7 @@ static inline void carm_push_q (struct carm_host *host, struct request_queue *q)
 {
 	unsigned int idx = host->wait_q_prod % CARM_MAX_WAIT_Q;
 
-	blk_stop_queue(q);
+	blk_mq_stop_hw_queues(q);
 	VPRINTK("STOPPED QUEUE %p\n", q);
 
 	host->wait_q[idx] = q;
@@ -785,7 +787,7 @@ static inline void carm_round_robin(struct carm_host *host)
 {
 	struct request_queue *q = carm_pop_q(host);
 	if (q) {
-		blk_start_queue(q);
+		blk_mq_start_hw_queues(q);
 		VPRINTK("STARTED QUEUE %p\n", q);
 	}
 }
@@ -802,62 +804,62 @@ static inline void carm_end_rq(struct carm_host *host, struct carm_request *crq,
 	}
 }
 
-static void carm_oob_rq_fn(struct request_queue *q)
+static blk_status_t carm_oob_queue_rq(struct blk_mq_hw_ctx *hctx,
+				      const struct blk_mq_queue_data *bd)
 {
+	struct request_queue *q = hctx->queue;
 	struct carm_host *host = q->queuedata;
 	struct carm_request *crq;
-	struct request *rq;
 	int rc;
 
-	while (1) {
-		DPRINTK("get req\n");
-		rq = blk_fetch_request(q);
-		if (!rq)
-			break;
+	blk_mq_start_request(bd->rq);
+
+	spin_lock_irq(&host->lock);
 
-		crq = rq->special;
-		assert(crq != NULL);
-		assert(crq->rq == rq);
+	crq = bd->rq->special;
+	assert(crq != NULL);
+	assert(crq->rq == bd->rq);
 
-		crq->n_elem = 0;
+	crq->n_elem = 0;
 
-		DPRINTK("send req\n");
-		rc = carm_send_msg(host, crq);
-		if (rc) {
-			blk_requeue_request(q, rq);
-			carm_push_q(host, q);
-			return;		/* call us again later, eventually */
-		}
+	DPRINTK("send req\n");
+	rc = carm_send_msg(host, crq);
+	if (rc) {
+		carm_push_q(host, q);
+		spin_unlock_irq(&host->lock);
+		return BLK_STS_DEV_RESOURCE;
 	}
+
+	spin_unlock_irq(&host->lock);
+	return BLK_STS_OK;
 }
 
-static void carm_rq_fn(struct request_queue *q)
+static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
+				  const struct blk_mq_queue_data *bd)
 {
+	struct request_queue *q = hctx->queue;
 	struct carm_port *port = q->queuedata;
 	struct carm_host *host = port->host;
 	struct carm_msg_rw *msg;
 	struct carm_request *crq;
-	struct request *rq;
+	struct request *rq = bd->rq;
 	struct scatterlist *sg;
 	int writing = 0, pci_dir, i, n_elem, rc;
 	u32 tmp;
 	unsigned int msg_size;
 
-queue_one_request:
-	VPRINTK("get req\n");
-	rq = blk_peek_request(q);
-	if (!rq)
-		return;
+	blk_mq_start_request(rq);
+
+	spin_lock_irq(&host->lock);
 
 	crq = carm_get_request(host);
 	if (!crq) {
 		carm_push_q(host, q);
-		return;		/* call us again later, eventually */
+		spin_unlock_irq(&host->lock);
+		return BLK_STS_DEV_RESOURCE;
 	}
 	crq->rq = rq;
 
-	blk_start_request(rq);
-
 	if (rq_data_dir(rq) == WRITE) {
 		writing = 1;
 		pci_dir = PCI_DMA_TODEVICE;
@@ -869,15 +871,19 @@ static void carm_rq_fn(struct request_queue *q)
 	sg = &crq->sg[0];
 	n_elem = blk_rq_map_sg(q, rq, sg);
 	if (n_elem <= 0) {
+		/* request with no s/g entries? */
 		carm_end_rq(host, crq, BLK_STS_IOERR);
-		return;		/* request with no s/g entries? */
+		spin_unlock_irq(&host->lock);
+		return BLK_STS_IOERR;
 	}
 
 	/* map scatterlist to PCI bus addresses */
 	n_elem = pci_map_sg(host->pdev, sg, n_elem, pci_dir);
 	if (n_elem <= 0) {
+		/* request with no s/g entries? */
 		carm_end_rq(host, crq, BLK_STS_IOERR);
-		return;		/* request with no s/g entries? */
+		spin_unlock_irq(&host->lock);
+		return BLK_STS_IOERR;
 	}
 	crq->n_elem = n_elem;
 	crq->port = port;
@@ -927,12 +933,13 @@ static void carm_rq_fn(struct request_queue *q)
 	rc = carm_send_msg(host, crq);
 	if (rc) {
 		carm_put_request(host, crq);
-		blk_requeue_request(q, rq);
 		carm_push_q(host, q);
-		return;		/* call us again later, eventually */
+		spin_unlock_irq(&host->lock);
+		return BLK_STS_DEV_RESOURCE;
 	}
 
-	goto queue_one_request;
+	spin_unlock_irq(&host->lock);
+	return BLK_STS_OK;
 }
 
 static void carm_handle_array_info(struct carm_host *host,
@@ -1485,6 +1492,14 @@ static int carm_init_host(struct carm_host *host)
 	return 0;
 }
 
+static const struct blk_mq_ops carm_oob_mq_ops = {
+	.queue_rq	= carm_oob_queue_rq,
+};
+
+static const struct blk_mq_ops carm_mq_ops = {
+	.queue_rq	= carm_queue_rq,
+};
+
 static int carm_init_disks(struct carm_host *host)
 {
 	unsigned int i;
@@ -1494,6 +1509,7 @@ static int carm_init_disks(struct carm_host *host)
 		struct gendisk *disk;
 		struct request_queue *q;
 		struct carm_port *port;
+		struct blk_mq_tag_set *set;
 
 		port = &host->port[i];
 		port->host = host;
@@ -1513,9 +1529,19 @@ static int carm_init_disks(struct carm_host *host)
 		disk->fops = &carm_bd_ops;
 		disk->private_data = port;
 
-		q = blk_init_queue(carm_rq_fn, &host->lock);
-		if (!q) {
-			rc = -ENOMEM;
+		set = &port->tag_set;
+		set->ops = &carm_mq_ops;
+		set->nr_hw_queues = 1;
+		set->queue_depth = max_queue;
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		rc = blk_mq_alloc_tag_set(set);
+		if (rc)
+			break;
+
+		q = blk_mq_init_queue(set);
+		if (IS_ERR(q)) {
+			rc = PTR_ERR(q);
 			break;
 		}
 		disk->queue = q;
@@ -1533,14 +1559,18 @@ static void carm_free_disks(struct carm_host *host)
 	unsigned int i;
 
 	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		struct gendisk *disk = host->port[i].disk;
+		struct carm_port *port = &host->port[i];
+		struct gendisk *disk = port->disk;
+
 		if (disk) {
 			struct request_queue *q = disk->queue;
 
 			if (disk->flags & GENHD_FL_UP)
 				del_gendisk(disk);
-			if (q)
+			if (q) {
+				blk_mq_free_tag_set(&port->tag_set);
 				blk_cleanup_queue(q);
+			}
 			put_disk(disk);
 		}
 	}
@@ -1568,6 +1598,7 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	unsigned int pci_dac;
 	int rc;
 	struct request_queue *q;
+	struct blk_mq_tag_set *set;
 	unsigned int i;
 
 	printk_once(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -1636,11 +1667,21 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_iounmap;
 	}
 
-	q = blk_init_queue(carm_oob_rq_fn, &host->lock);
-	if (!q) {
+	set = &host->tag_set;
+	set->ops = &carm_oob_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = 1;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_NO_SCHED;
+	rc = blk_mq_alloc_tag_set(set);
+	if (rc)
+		goto err_out_pci_free;
+
+	q = blk_mq_init_queue(set);
+	if (IS_ERR(q)) {
 		printk(KERN_ERR DRV_NAME "(%s): OOB queue alloc failure\n",
 		       pci_name(pdev));
-		rc = -ENOMEM;
+		rc = PTR_ERR(q);
 		goto err_out_pci_free;
 	}
 	host->oob_q = q;
@@ -1704,6 +1745,7 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		clear_bit(0, &carm_major_alloc);
 	else if (host->major == 161)
 		clear_bit(1, &carm_major_alloc);
+	blk_mq_free_tag_set(&host->tag_set);
 	blk_cleanup_queue(host->oob_q);
 err_out_pci_free:
 	pci_free_consistent(pdev, CARM_SHM_SIZE, host->shm, host->shm_dma);
@@ -1735,6 +1777,7 @@ static void carm_remove_one (struct pci_dev *pdev)
 		clear_bit(0, &carm_major_alloc);
 	else if (host->major == 161)
 		clear_bit(1, &carm_major_alloc);
+	blk_mq_free_tag_set(&host->tag_set);
 	blk_cleanup_queue(host->oob_q);
 	pci_free_consistent(pdev, CARM_SHM_SIZE, host->shm, host->shm_dma);
 	iounmap(host->mmio);
-- 
2.17.1
