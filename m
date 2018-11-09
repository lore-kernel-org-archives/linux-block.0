Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] sx8: cleanup queue and disk allocation / freeing
Date: Fri,  9 Nov 2018 14:51:09 +0100
Message-Id: <20181109135110.32386-2-hch@lst.de>
In-Reply-To: <20181109135110.32386-1-hch@lst.de>
References: <20181109135110.32386-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Make the disk/queue alloc and free helpers per-port by moving the
trivial loops into the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/sx8.c | 107 ++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 59 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 064b8c5c7a32..1f371b9c0954 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1499,70 +1499,54 @@ static const struct blk_mq_ops carm_mq_ops = {
 	.queue_rq	= carm_queue_rq,
 };
 
-static int carm_init_disks(struct carm_host *host)
+static int carm_init_disk(struct carm_host *host, unsigned int port_no)
 {
-	unsigned int i;
-	int rc = 0;
-
-	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		struct gendisk *disk;
-		struct request_queue *q;
-		struct carm_port *port;
-
-		port = &host->port[i];
-		port->host = host;
-		port->port_no = i;
-
-		disk = alloc_disk(CARM_MINORS_PER_MAJOR);
-		if (!disk) {
-			rc = -ENOMEM;
-			break;
-		}
+	struct carm_port *port = &host->port[port_no];
+	struct gendisk *disk;
+	struct request_queue *q;
 
-		port->disk = disk;
-		sprintf(disk->disk_name, DRV_NAME "/%u",
-			(unsigned int) (host->id * CARM_MAX_PORTS) + i);
-		disk->major = host->major;
-		disk->first_minor = i * CARM_MINORS_PER_MAJOR;
-		disk->fops = &carm_bd_ops;
-		disk->private_data = port;
-
-		q = blk_mq_init_sq_queue(&port->tag_set, &carm_mq_ops,
-					 max_queue, BLK_MQ_F_SHOULD_MERGE);
-		if (IS_ERR(q)) {
-			rc = PTR_ERR(q);
-			break;
-		}
-		disk->queue = q;
-		blk_queue_max_segments(q, CARM_MAX_REQ_SG);
-		blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
+	port->host = host;
+	port->port_no = port_no;
 
-		q->queuedata = port;
-	}
+	disk = alloc_disk(CARM_MINORS_PER_MAJOR);
+	if (!disk)
+		return -ENOMEM;
 
-	return rc;
+	port->disk = disk;
+	sprintf(disk->disk_name, DRV_NAME "/%u",
+		(unsigned int)host->id * CARM_MAX_PORTS + port_no);
+	disk->major = host->major;
+	disk->first_minor = port_no * CARM_MINORS_PER_MAJOR;
+	disk->fops = &carm_bd_ops;
+	disk->private_data = port;
+
+	q = blk_mq_init_sq_queue(&port->tag_set, &carm_mq_ops,
+				 max_queue, BLK_MQ_F_SHOULD_MERGE);
+	if (IS_ERR(q))
+		return PTR_ERR(q);
+	disk->queue = q;
+	blk_queue_max_segments(q, CARM_MAX_REQ_SG);
+	blk_queue_segment_boundary(q, CARM_SG_BOUNDARY);
+
+	q->queuedata = port;
+	return 0;
 }
 
-static void carm_free_disks(struct carm_host *host)
+static void carm_free_disk(struct carm_host *host, unsigned int port_no)
 {
-	unsigned int i;
+	struct carm_port *port = &host->port[port_no];
+	struct gendisk *disk = port->disk;
 
-	for (i = 0; i < CARM_MAX_PORTS; i++) {
-		struct carm_port *port = &host->port[i];
-		struct gendisk *disk = port->disk;
-
-		if (disk) {
-			struct request_queue *q = disk->queue;
+	if (!disk)
+		return;
 
-			if (disk->flags & GENHD_FL_UP)
-				del_gendisk(disk);
-			if (q) {
-				blk_mq_free_tag_set(&port->tag_set);
-				blk_cleanup_queue(q);
-			}
-			put_disk(disk);
-		}
+	if (disk->flags & GENHD_FL_UP)
+		del_gendisk(disk);
+	if (disk->queue) {
+		blk_mq_free_tag_set(&port->tag_set);
+		blk_cleanup_queue(disk->queue);
 	}
+	put_disk(disk);
 }
 
 static int carm_init_shm(struct carm_host *host)
@@ -1667,9 +1651,11 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (host->flags & FL_DYN_MAJOR)
 		host->major = rc;
 
-	rc = carm_init_disks(host);
-	if (rc)
-		goto err_out_blkdev_disks;
+	for (i = 0; i < CARM_MAX_PORTS; i++) {
+		rc = carm_init_disk(host, i);
+		if (rc)
+			goto err_out_blkdev_disks;
+	}
 
 	pci_set_master(pdev);
 
@@ -1699,7 +1685,8 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_irq:
 	free_irq(pdev->irq, host);
 err_out_blkdev_disks:
-	carm_free_disks(host);
+	for (i = 0; i < CARM_MAX_PORTS; i++)
+		carm_free_disk(host, i);
 	unregister_blkdev(host->major, host->name);
 err_out_free_majors:
 	if (host->major == 160)
@@ -1724,6 +1711,7 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 static void carm_remove_one (struct pci_dev *pdev)
 {
 	struct carm_host *host = pci_get_drvdata(pdev);
+	unsigned int i;
 
 	if (!host) {
 		printk(KERN_ERR PFX "BUG: no host data for PCI(%s)\n",
@@ -1732,7 +1720,8 @@ static void carm_remove_one (struct pci_dev *pdev)
 	}
 
 	free_irq(pdev->irq, host);
-	carm_free_disks(host);
+	for (i = 0; i < CARM_MAX_PORTS; i++)
+		carm_free_disk(host, i);
 	unregister_blkdev(host->major, host->name);
 	if (host->major == 160)
 		clear_bit(0, &carm_major_alloc);
-- 
2.19.1
