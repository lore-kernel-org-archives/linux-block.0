Return-Path: <prvs=1147fe7fca=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 5/7] blk-mq: add BLK_MQ_F_NO_SCHED flag
Date: Mon, 5 Dec 2016 11:27:04 -0700
Message-ID: <1480962426-15767-6-git-send-email-axboe@fb.com>
In-Reply-To: <1480962426-15767-1-git-send-email-axboe@fb.com>
References: <1480962426-15767-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Drivers can use this to prevent IO scheduling on a queue. Use this
for NVMe, for the admin queue, which doesn't handle file system
requests.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/nvme/host/pci.c | 1 +
 include/linux/blk-mq.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d58f8e4e2c06..4560575f0a39 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1187,6 +1187,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
+		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 35a0af5ede6d..a85bd83bb218 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -151,6 +151,7 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
+	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
-- 
2.7.4
