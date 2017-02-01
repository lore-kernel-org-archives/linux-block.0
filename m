Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753058AbdBARxS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 12:53:18 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v11HoImL031933
        for <linux-block@vger.kernel.org>; Wed, 1 Feb 2017 09:53:18 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 28bk88gax5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2017 09:53:17 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.97) with ESMTP id
 4f68def0e8a711e6aa940002c99331b0-dd5fba50 for <linux-block@vger.kernel.org>;
        Wed, 01 Feb 2017 09:53:17 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <bhelgaas@google.com>, <hch@lst.de>, <axboe@fb.com>
Subject: [PATCH V2 3/3] nvme: allocate nvme_queue in correct node
Date: Wed, 1 Feb 2017 09:53:16 -0800
Message-ID: <127b7a810d47b6b3530f29cb5ce36d7057a24e7e.1485971427.git.shli@fb.com>
In-Reply-To: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nvme_queue is per-cpu queue (mostly). Allocating it in node where blk-mq
will use it.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/nvme/host/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 032237c..9733008 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1040,9 +1040,10 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
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
+					dev_to_node(dev->dev));
 		if (!nvmeq)
 			return -ENOMEM;
 	}
@@ -1311,7 +1313,9 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	int ret = 0;
 
 	for (i = dev->queue_count; i <= dev->max_qid; i++) {
-		if (!nvme_alloc_queue(dev, i, dev->q_depth)) {
+		/* vector == qid - 1, match nvme_create_queue */
+		if (!nvme_alloc_queue(dev, i, dev->q_depth,
+		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.9.3

