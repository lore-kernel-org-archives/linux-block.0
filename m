Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753544AbdDOMk4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 08:40:56 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] mtip32xx: use BLK_MQ_F_USE_SCHED_TAG
Date: Sat, 15 Apr 2017 20:38:25 +0800
Message-Id: <20170415123825.32716-5-ming.lei@redhat.com>
In-Reply-To: <20170415123825.32716-1-ming.lei@redhat.com>
References: <20170415123825.32716-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch applys the new introduced flag of BLK_MQ_F_USE_SCHED_TAG
to make mq-deadline working on mtip32xx. With this flag, we can
allocate hardware tag for scheduler, then mtip32xx can work well.

Also mtip32xx has 256 queue depth, which is same with the default
value of q->nr_requests, so in theory performance loss won't happen.

Finally BLK_MQ_F_NO_SCHED isn't necessary any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 4e344246c8dd..203b18a9eff0 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3969,7 +3969,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	dd->tags.reserved_tags = 1;
 	dd->tags.cmd_size = sizeof(struct mtip_cmd);
 	dd->tags.numa_node = dd->numa_node;
-	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED;
+	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SCHED_USE_HW_TAG;
 	dd->tags.driver_data = dd;
 	dd->tags.timeout = MTIP_NCQ_CMD_TIMEOUT_MS;
 
-- 
2.9.3
