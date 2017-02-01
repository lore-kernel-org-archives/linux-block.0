Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32935 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750946AbdBAEZz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 23:25:55 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v114Mxxu020814
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 20:25:54 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 28b7p183jf-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 20:25:54 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 845a1618e83611e68b200002c9dfb610-751f7a50 for <linux-block@vger.kernel.org>;
        Tue, 31 Jan 2017 20:25:52 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <axboe@fb.com>
Subject: [PATCH 2/2] nvme: allocate nvme_queue in correct node
Date: Tue, 31 Jan 2017 20:25:52 -0800
Message-ID: <7119c172f8916bd21aeffc006b04cd73281afb25.1485922654.git.shli@fb.com>
In-Reply-To: <1c91ab2c0073598592f66f007ff72cfa58a17a54.1485922654.git.shli@fb.com>
References: <1c91ab2c0073598592f66f007ff72cfa58a17a54.1485922654.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nvme_queue is per-cpu queue (mostly). Allocating it in node where blk-mq
will use it.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/nvme/host/pci.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3faefab..f81c0ed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1041,9 +1041,10 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
-							int depth)
+							int depth, int node)
 {
-	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq), GFP_KERNEL);
+	struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq), GFP_KERNEL,
+							node);
 	if (!nvmeq)
 		return NULL;
 
@@ -1219,7 +1220,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	nvmeq = dev->queues[0];
 	if (!nvmeq) {
-		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
+		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
+						dev_to_node(dev->dev));
 		if (!nvmeq)
 			return -ENOMEM;
 	}
@@ -1309,9 +1311,18 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i, max;
 	int ret = 0;
+	const struct cpumask *mask;
 
 	for (i = dev->queue_count; i <= dev->max_qid; i++) {
-		if (!nvme_alloc_queue(dev, i, dev->q_depth)) {
+		int node = dev_to_node(dev->dev);
+
+		mask = pci_irq_get_affinity(to_pci_dev(dev->dev), i);
+		if (mask) {
+			node = cpu_to_node(cpumask_first(mask));
+			node = local_memory_node(node);
+		}
+
+		if (!nvme_alloc_queue(dev, i, dev->q_depth, node)) {
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.9.3

