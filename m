Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] sx8: use a per-host tag_set
Date: Fri,  9 Nov 2018 14:51:10 +0100
Message-Id: <20181109135110.32386-3-hch@lst.de>
In-Reply-To: <20181109135110.32386-1-hch@lst.de>
References: <20181109135110.32386-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The current sx8 code spends a lot of effort dealing with the fact that
tags are per-host, but there might be multiple queues.  Now that the
driver has been converted to blk-mq it can take care of the blk-mq
tag_set concept that has been designed just for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/sx8.c | 343 ++++++++++++--------------------------------
 1 file changed, 95 insertions(+), 248 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 1f371b9c0954..4478eb7efee0 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -243,7 +243,6 @@ struct carm_port {
 	unsigned int			port_no;
 	struct gendisk			*disk;
 	struct carm_host		*host;
-	struct blk_mq_tag_set		tag_set;
 
 	/* attached device characteristics */
 	u64				capacity;
@@ -254,13 +253,10 @@ struct carm_port {
 };
 
 struct carm_request {
-	unsigned int			tag;
 	int				n_elem;
 	unsigned int			msg_type;
 	unsigned int			msg_subtype;
 	unsigned int			msg_bucket;
-	struct request			*rq;
-	struct carm_port		*port;
 	struct scatterlist		sg[CARM_MAX_REQ_SG];
 };
 
@@ -291,9 +287,6 @@ struct carm_host {
 	unsigned int			wait_q_cons;
 	struct request_queue		*wait_q[CARM_MAX_WAIT_Q];
 
-	unsigned int			n_msgs;
-	u64				msg_alloc;
-	struct carm_request		req[CARM_MAX_REQ];
 	void				*msg_base;
 	dma_addr_t			msg_dma;
 
@@ -478,10 +471,10 @@ static inline dma_addr_t carm_ref_msg_dma(struct carm_host *host,
 }
 
 static int carm_send_msg(struct carm_host *host,
-			 struct carm_request *crq)
+			 struct carm_request *crq, unsigned tag)
 {
 	void __iomem *mmio = host->mmio;
-	u32 msg = (u32) carm_ref_msg_dma(host, crq->tag);
+	u32 msg = (u32) carm_ref_msg_dma(host, tag);
 	u32 cm_bucket = crq->msg_bucket;
 	u32 tmp;
 	int rc = 0;
@@ -506,99 +499,24 @@ static int carm_send_msg(struct carm_host *host,
 	return rc;
 }
 
-static struct carm_request *carm_get_request(struct carm_host *host)
-{
-	unsigned int i;
-
-	/* obey global hardware limit on S/G entries */
-	if (host->hw_sg_used >= (CARM_MAX_HOST_SG - CARM_MAX_REQ_SG))
-		return NULL;
-
-	for (i = 0; i < max_queue; i++)
-		if ((host->msg_alloc & (1ULL << i)) == 0) {
-			struct carm_request *crq = &host->req[i];
-			crq->port = NULL;
-			crq->n_elem = 0;
-
-			host->msg_alloc |= (1ULL << i);
-			host->n_msgs++;
-
-			assert(host->n_msgs <= CARM_MAX_REQ);
-			sg_init_table(crq->sg, CARM_MAX_REQ_SG);
-			return crq;
-		}
-
-	DPRINTK("no request available, returning NULL\n");
-	return NULL;
-}
-
-static int carm_put_request(struct carm_host *host, struct carm_request *crq)
-{
-	assert(crq->tag < max_queue);
-
-	if (unlikely((host->msg_alloc & (1ULL << crq->tag)) == 0))
-		return -EINVAL; /* tried to clear a tag that was not active */
-
-	assert(host->hw_sg_used >= crq->n_elem);
-
-	host->msg_alloc &= ~(1ULL << crq->tag);
-	host->hw_sg_used -= crq->n_elem;
-	host->n_msgs--;
-
-	return 0;
-}
-
-static struct carm_request *carm_get_special(struct carm_host *host)
-{
-	unsigned long flags;
-	struct carm_request *crq = NULL;
-	struct request *rq;
-	int tries = 5000;
-
-	while (tries-- > 0) {
-		spin_lock_irqsave(&host->lock, flags);
-		crq = carm_get_request(host);
-		spin_unlock_irqrestore(&host->lock, flags);
-
-		if (crq)
-			break;
-		msleep(10);
-	}
-
-	if (!crq)
-		return NULL;
-
-	rq = blk_get_request(host->oob_q, REQ_OP_DRV_OUT, 0);
-	if (IS_ERR(rq)) {
-		spin_lock_irqsave(&host->lock, flags);
-		carm_put_request(host, crq);
-		spin_unlock_irqrestore(&host->lock, flags);
-		return NULL;
-	}
-
-	crq->rq = rq;
-	return crq;
-}
-
 static int carm_array_info (struct carm_host *host, unsigned int array_idx)
 {
 	struct carm_msg_ioctl *ioc;
-	unsigned int idx;
 	u32 msg_data;
 	dma_addr_t msg_dma;
 	struct carm_request *crq;
+	struct request *rq;
 	int rc;
 
-	crq = carm_get_special(host);
-	if (!crq) {
+	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(rq)) {
 		rc = -ENOMEM;
 		goto err_out;
 	}
+	crq = blk_mq_rq_to_pdu(rq);
 
-	idx = crq->tag;
-
-	ioc = carm_ref_msg(host, idx);
-	msg_dma = carm_ref_msg_dma(host, idx);
+	ioc = carm_ref_msg(host, rq->tag);
+	msg_dma = carm_ref_msg_dma(host, rq->tag);
 	msg_data = (u32) (msg_dma + sizeof(struct carm_array_info));
 
 	crq->msg_type = CARM_MSG_ARRAY;
@@ -612,7 +530,7 @@ static int carm_array_info (struct carm_host *host, unsigned int array_idx)
 	ioc->type	= CARM_MSG_ARRAY;
 	ioc->subtype	= CARM_ARRAY_INFO;
 	ioc->array_id	= (u8) array_idx;
-	ioc->handle	= cpu_to_le32(TAG_ENCODE(idx));
+	ioc->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
 	ioc->data_addr	= cpu_to_le32(msg_data);
 
 	spin_lock_irq(&host->lock);
@@ -620,9 +538,8 @@ static int carm_array_info (struct carm_host *host, unsigned int array_idx)
 	       host->state == HST_DEV_SCAN);
 	spin_unlock_irq(&host->lock);
 
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", idx);
-	crq->rq->special = crq;
-	blk_execute_rq_nowait(host->oob_q, NULL, crq->rq, true, NULL);
+	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
+	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
 
 	return 0;
 
@@ -637,21 +554,21 @@ typedef unsigned int (*carm_sspc_t)(struct carm_host *, unsigned int, void *);
 
 static int carm_send_special (struct carm_host *host, carm_sspc_t func)
 {
+	struct request *rq;
 	struct carm_request *crq;
 	struct carm_msg_ioctl *ioc;
 	void *mem;
-	unsigned int idx, msg_size;
+	unsigned int msg_size;
 	int rc;
 
-	crq = carm_get_special(host);
-	if (!crq)
+	rq = blk_mq_alloc_request(host->oob_q, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(rq))
 		return -ENOMEM;
+	crq = blk_mq_rq_to_pdu(rq);
 
-	idx = crq->tag;
+	mem = carm_ref_msg(host, rq->tag);
 
-	mem = carm_ref_msg(host, idx);
-
-	msg_size = func(host, idx, mem);
+	msg_size = func(host, rq->tag, mem);
 
 	ioc = mem;
 	crq->msg_type = ioc->type;
@@ -660,9 +577,8 @@ static int carm_send_special (struct carm_host *host, carm_sspc_t func)
 	BUG_ON(rc < 0);
 	crq->msg_bucket = (u32) rc;
 
-	DPRINTK("blk_execute_rq_nowait, tag == %u\n", idx);
-	crq->rq->special = crq;
-	blk_execute_rq_nowait(host->oob_q, NULL, crq->rq, true, NULL);
+	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
+	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
 
 	return 0;
 }
@@ -744,19 +660,6 @@ static unsigned int carm_fill_get_fw_ver(struct carm_host *host,
 	       sizeof(struct carm_fw_ver);
 }
 
-static inline void carm_end_request_queued(struct carm_host *host,
-					   struct carm_request *crq,
-					   blk_status_t error)
-{
-	struct request *req = crq->rq;
-	int rc;
-
-	blk_mq_end_request(req, error);
-
-	rc = carm_put_request(host, crq);
-	assert(rc == 0);
-}
-
 static inline void carm_push_q (struct carm_host *host, struct request_queue *q)
 {
 	unsigned int idx = host->wait_q_prod % CARM_MAX_WAIT_Q;
@@ -791,101 +694,50 @@ static inline void carm_round_robin(struct carm_host *host)
 	}
 }
 
-static inline void carm_end_rq(struct carm_host *host, struct carm_request *crq,
-			       blk_status_t error)
-{
-	carm_end_request_queued(host, crq, error);
-	if (max_queue == 1)
-		carm_round_robin(host);
-	else if ((host->n_msgs <= CARM_MSG_LOW_WATER) &&
-		 (host->hw_sg_used <= CARM_SG_LOW_WATER)) {
-		carm_round_robin(host);
-	}
-}
-
-static blk_status_t carm_oob_queue_rq(struct blk_mq_hw_ctx *hctx,
-				      const struct blk_mq_queue_data *bd)
+static inline enum dma_data_direction carm_rq_dir(struct request *rq)
 {
-	struct request_queue *q = hctx->queue;
-	struct carm_host *host = q->queuedata;
-	struct carm_request *crq;
-	int rc;
-
-	blk_mq_start_request(bd->rq);
-
-	spin_lock_irq(&host->lock);
-
-	crq = bd->rq->special;
-	assert(crq != NULL);
-	assert(crq->rq == bd->rq);
-
-	crq->n_elem = 0;
-
-	DPRINTK("send req\n");
-	rc = carm_send_msg(host, crq);
-	if (rc) {
-		carm_push_q(host, q);
-		spin_unlock_irq(&host->lock);
-		return BLK_STS_DEV_RESOURCE;
-	}
-
-	spin_unlock_irq(&host->lock);
-	return BLK_STS_OK;
+	return op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 }
 
 static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
 				  const struct blk_mq_queue_data *bd)
 {
 	struct request_queue *q = hctx->queue;
+	struct request *rq = bd->rq;
 	struct carm_port *port = q->queuedata;
 	struct carm_host *host = port->host;
+	struct carm_request *crq = blk_mq_rq_to_pdu(rq);
 	struct carm_msg_rw *msg;
-	struct carm_request *crq;
-	struct request *rq = bd->rq;
 	struct scatterlist *sg;
-	int writing = 0, pci_dir, i, n_elem, rc;
-	u32 tmp;
+	int i, n_elem = 0, rc;
 	unsigned int msg_size;
+	u32 tmp;
+
+	crq->n_elem = 0;
+	sg_init_table(crq->sg, CARM_MAX_REQ_SG);
 
 	blk_mq_start_request(rq);
 
 	spin_lock_irq(&host->lock);
-
-	crq = carm_get_request(host);
-	if (!crq) {
-		carm_push_q(host, q);
-		spin_unlock_irq(&host->lock);
-		return BLK_STS_DEV_RESOURCE;
-	}
-	crq->rq = rq;
-
-	if (rq_data_dir(rq) == WRITE) {
-		writing = 1;
-		pci_dir = DMA_TO_DEVICE;
-	} else {
-		pci_dir = DMA_FROM_DEVICE;
-	}
+	if (req_op(rq) == REQ_OP_DRV_OUT)
+		goto send_msg;
 
 	/* get scatterlist from block layer */
 	sg = &crq->sg[0];
 	n_elem = blk_rq_map_sg(q, rq, sg);
-	if (n_elem <= 0) {
-		/* request with no s/g entries? */
-		carm_end_rq(host, crq, BLK_STS_IOERR);
-		spin_unlock_irq(&host->lock);
-		return BLK_STS_IOERR;
-	}
+	if (n_elem <= 0)
+		goto out_ioerr;
 
 	/* map scatterlist to PCI bus addresses */
-	n_elem = dma_map_sg(&host->pdev->dev, sg, n_elem, pci_dir);
-	if (n_elem <= 0) {
-		/* request with no s/g entries? */
-		carm_end_rq(host, crq, BLK_STS_IOERR);
-		spin_unlock_irq(&host->lock);
-		return BLK_STS_IOERR;
-	}
+	n_elem = dma_map_sg(&host->pdev->dev, sg, n_elem, carm_rq_dir(rq));
+	if (n_elem <= 0)
+		goto out_ioerr;
+
+	/* obey global hardware limit on S/G entries */
+	if (host->hw_sg_used >= CARM_MAX_HOST_SG - n_elem)
+		goto out_resource;
+
 	crq->n_elem = n_elem;
-	crq->port = port;
 	host->hw_sg_used += n_elem;
 
 	/*
@@ -893,9 +745,9 @@ static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 */
 
 	VPRINTK("build msg\n");
-	msg = (struct carm_msg_rw *) carm_ref_msg(host, crq->tag);
+	msg = (struct carm_msg_rw *) carm_ref_msg(host, rq->tag);
 
-	if (writing) {
+	if (rq_data_dir(rq) == WRITE) {
 		msg->type = CARM_MSG_WRITE;
 		crq->msg_type = CARM_MSG_WRITE;
 	} else {
@@ -906,7 +758,7 @@ static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
 	msg->id		= port->port_no;
 	msg->sg_count	= n_elem;
 	msg->sg_type	= SGT_32BIT;
-	msg->handle	= cpu_to_le32(TAG_ENCODE(crq->tag));
+	msg->handle	= cpu_to_le32(TAG_ENCODE(rq->tag));
 	msg->lba	= cpu_to_le32(blk_rq_pos(rq) & 0xffffffff);
 	tmp		= (blk_rq_pos(rq) >> 16) >> 16;
 	msg->lba_high	= cpu_to_le16( (u16) tmp );
@@ -923,22 +775,28 @@ static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
 	rc = carm_lookup_bucket(msg_size);
 	BUG_ON(rc < 0);
 	crq->msg_bucket = (u32) rc;
-
+send_msg:
 	/*
 	 * queue read/write message to hardware
 	 */
-
-	VPRINTK("send msg, tag == %u\n", crq->tag);
-	rc = carm_send_msg(host, crq);
+	VPRINTK("send msg, tag == %u\n", rq->tag);
+	rc = carm_send_msg(host, crq, rq->tag);
 	if (rc) {
-		carm_put_request(host, crq);
-		carm_push_q(host, q);
-		spin_unlock_irq(&host->lock);
-		return BLK_STS_DEV_RESOURCE;
+		host->hw_sg_used -= n_elem;
+		goto out_resource;
 	}
 
 	spin_unlock_irq(&host->lock);
 	return BLK_STS_OK;
+out_resource:
+	dma_unmap_sg(&host->pdev->dev, &crq->sg[0], n_elem, carm_rq_dir(rq));
+	carm_push_q(host, q);
+	spin_unlock_irq(&host->lock);
+	return BLK_STS_DEV_RESOURCE;
+out_ioerr:
+	carm_round_robin(host);
+	spin_unlock_irq(&host->lock);
+	return BLK_STS_IOERR;
 }
 
 static void carm_handle_array_info(struct carm_host *host,
@@ -954,8 +812,6 @@ static void carm_handle_array_info(struct carm_host *host,
 
 	DPRINTK("ENTER\n");
 
-	carm_end_rq(host, crq, error);
-
 	if (error)
 		goto out;
 	if (le32_to_cpu(desc->array_status) & ARRAY_NO_EXIST)
@@ -1011,8 +867,6 @@ static void carm_handle_scan_chan(struct carm_host *host,
 
 	DPRINTK("ENTER\n");
 
-	carm_end_rq(host, crq, error);
-
 	if (error) {
 		new_state = HST_ERROR;
 		goto out;
@@ -1040,8 +894,6 @@ static void carm_handle_generic(struct carm_host *host,
 {
 	DPRINTK("ENTER\n");
 
-	carm_end_rq(host, crq, error);
-
 	assert(host->state == cur_state);
 	if (error)
 		host->state = HST_ERROR;
@@ -1050,28 +902,12 @@ static void carm_handle_generic(struct carm_host *host,
 	schedule_work(&host->fsm_task);
 }
 
-static inline void carm_handle_rw(struct carm_host *host,
-				  struct carm_request *crq, blk_status_t error)
-{
-	int pci_dir;
-
-	VPRINTK("ENTER\n");
-
-	if (rq_data_dir(crq->rq) == WRITE)
-		pci_dir = DMA_TO_DEVICE;
-	else
-		pci_dir = DMA_FROM_DEVICE;
-
-	dma_unmap_sg(&host->pdev->dev, &crq->sg[0], crq->n_elem, pci_dir);
-
-	carm_end_rq(host, crq, error);
-}
-
 static inline void carm_handle_resp(struct carm_host *host,
 				    __le32 ret_handle_le, u32 status)
 {
 	u32 handle = le32_to_cpu(ret_handle_le);
 	unsigned int msg_idx;
+	struct request *rq;
 	struct carm_request *crq;
 	blk_status_t error = (status == RMSG_OK) ? 0 : BLK_STS_IOERR;
 	u8 *mem;
@@ -1087,13 +923,15 @@ static inline void carm_handle_resp(struct carm_host *host,
 	msg_idx = TAG_DECODE(handle);
 	VPRINTK("tag == %u\n", msg_idx);
 
-	crq = &host->req[msg_idx];
+	rq = blk_mq_tag_to_rq(host->tag_set.tags[0], msg_idx);
+	crq = blk_mq_rq_to_pdu(rq);
 
 	/* fast path */
 	if (likely(crq->msg_type == CARM_MSG_READ ||
 		   crq->msg_type == CARM_MSG_WRITE)) {
-		carm_handle_rw(host, crq, error);
-		return;
+		dma_unmap_sg(&host->pdev->dev, &crq->sg[0], crq->n_elem,
+			     carm_rq_dir(rq));
+		goto done;
 	}
 
 	mem = carm_ref_msg(host, msg_idx);
@@ -1103,7 +941,7 @@ static inline void carm_handle_resp(struct carm_host *host,
 		switch (crq->msg_subtype) {
 		case CARM_IOC_SCAN_CHAN:
 			carm_handle_scan_chan(host, crq, mem, error);
-			break;
+			goto done;
 		default:
 			/* unknown / invalid response */
 			goto err_out;
@@ -1116,11 +954,11 @@ static inline void carm_handle_resp(struct carm_host *host,
 		case MISC_ALLOC_MEM:
 			carm_handle_generic(host, crq, error,
 					    HST_ALLOC_BUF, HST_SYNC_TIME);
-			break;
+			goto done;
 		case MISC_SET_TIME:
 			carm_handle_generic(host, crq, error,
 					    HST_SYNC_TIME, HST_GET_FW_VER);
-			break;
+			goto done;
 		case MISC_GET_FW_VER: {
 			struct carm_fw_ver *ver = (struct carm_fw_ver *)
 				(mem + sizeof(struct carm_msg_get_fw_ver));
@@ -1130,7 +968,7 @@ static inline void carm_handle_resp(struct carm_host *host,
 			}
 			carm_handle_generic(host, crq, error,
 					    HST_GET_FW_VER, HST_PORT_SCAN);
-			break;
+			goto done;
 		}
 		default:
 			/* unknown / invalid response */
@@ -1161,7 +999,13 @@ static inline void carm_handle_resp(struct carm_host *host,
 err_out:
 	printk(KERN_WARNING DRV_NAME "(%s): BUG: unhandled message type %d/%d\n",
 	       pci_name(host->pdev), crq->msg_type, crq->msg_subtype);
-	carm_end_rq(host, crq, BLK_STS_IOERR);
+	error = BLK_STS_IOERR;
+done:
+	host->hw_sg_used -= crq->n_elem;
+	blk_mq_end_request(blk_mq_rq_from_pdu(crq), error);
+
+	if (host->hw_sg_used <= CARM_SG_LOW_WATER)
+		carm_round_robin(host);
 }
 
 static inline void carm_handle_responses(struct carm_host *host)
@@ -1491,10 +1335,6 @@ static int carm_init_host(struct carm_host *host)
 	return 0;
 }
 
-static const struct blk_mq_ops carm_oob_mq_ops = {
-	.queue_rq	= carm_oob_queue_rq,
-};
-
 static const struct blk_mq_ops carm_mq_ops = {
 	.queue_rq	= carm_queue_rq,
 };
@@ -1520,15 +1360,15 @@ static int carm_init_disk(struct carm_host *host, unsigned int port_no)
 	disk->fops = &carm_bd_ops;
 	disk->private_data = port;
 
-	q = blk_mq_init_sq_queue(&port->tag_set, &carm_mq_ops,
-				 max_queue, BLK_MQ_F_SHOULD_MERGE);
+	q = blk_mq_init_queue(&host->tag_set);
 	if (IS_ERR(q))
 		return PTR_ERR(q);
-	disk->queue = q;
+
 	blk_queue_max_segments(q, CARM_MAX_REQ_SG);
 	blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
 
 	q->queuedata = port;
+	disk->queue = q;
 	return 0;
 }
 
@@ -1542,10 +1382,8 @@ static void carm_free_disk(struct carm_host *host, unsigned int port_no)
 
 	if (disk->flags & GENHD_FL_UP)
 		del_gendisk(disk);
-	if (disk->queue) {
-		blk_mq_free_tag_set(&port->tag_set);
+	if (disk->queue)
 		blk_cleanup_queue(disk->queue);
-	}
 	put_disk(disk);
 }
 
@@ -1602,9 +1440,6 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&host->fsm_task, carm_fsm_task);
 	init_completion(&host->probe_comp);
 
-	for (i = 0; i < ARRAY_SIZE(host->req); i++)
-		host->req[i].tag = i;
-
 	host->mmio = ioremap(pci_resource_start(pdev, 0),
 			     pci_resource_len(pdev, 0));
 	if (!host->mmio) {
@@ -1621,14 +1456,26 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_iounmap;
 	}
 
-	q = blk_mq_init_sq_queue(&host->tag_set, &carm_oob_mq_ops, 1,
-					BLK_MQ_F_NO_SCHED);
+	memset(&host->tag_set, 0, sizeof(host->tag_set));
+	host->tag_set.ops = &carm_mq_ops;
+	host->tag_set.cmd_size = sizeof(struct carm_request);
+	host->tag_set.nr_hw_queues = 1;
+	host->tag_set.nr_maps = 1;
+	host->tag_set.queue_depth = max_queue;
+	host->tag_set.numa_node = NUMA_NO_NODE;
+	host->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+
+	rc = blk_mq_alloc_tag_set(&host->tag_set);
+	if (rc)
+		goto err_out_dma_free;
+
+	q = blk_mq_init_queue(&host->tag_set);
 	if (IS_ERR(q)) {
-		printk(KERN_ERR DRV_NAME "(%s): OOB queue alloc failure\n",
-		       pci_name(pdev));
 		rc = PTR_ERR(q);
+		blk_mq_free_tag_set(&host->tag_set);
 		goto err_out_dma_free;
 	}
+
 	host->oob_q = q;
 	q->queuedata = host;
 
-- 
2.19.1
