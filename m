Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754390AbdDOMks (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 08:40:48 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] mtip32xx: pass BLK_MQ_F_NO_SCHED
Date: Sat, 15 Apr 2017 20:38:23 +0800
Message-Id: <20170415123825.32716-3-ming.lei@redhat.com>
In-Reply-To: <20170415123825.32716-1-ming.lei@redhat.com>
References: <20170415123825.32716-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The recent introduced MQ IO scheduler breaks mtip32xx in the
following way.

mtip32xx use the 'request_index' passed to .init_request() as
hardware tag index for initializing hardware queue, and it
actually require that rq->tag is always same with 'request_index'
passed to .init_request(). Current blk-mq IO scheduler can't
guarantee this point, so this patch passes BLK_MQ_F_NO_SCHED
and at least make mtip32xx working.

This patch fixes the following strange hardware failure. The
issue can be triggered easily when doing I/O with mq-deadline
enabled.

[  186.972578] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 32993
[  186.972578] {1}[Hardware Error]: event severity: fatal
[  186.972579] {1}[Hardware Error]:  Error 0, type: fatal
[  186.972580] {1}[Hardware Error]:   section_type: PCIe error
[  186.972580] {1}[Hardware Error]:   port_type: 0, PCIe end point
[  186.972581] {1}[Hardware Error]:   version: 1.0
[  186.972581] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
[  186.972582] {1}[Hardware Error]:   device_id: 0000:07:00.0
[  186.972582] {1}[Hardware Error]:   slot: 4
[  186.972583] {1}[Hardware Error]:   secondary_bus: 0x00
[  186.972583] {1}[Hardware Error]:   vendor_id: 0x1344, device_id: 0x5150
[  186.972584] {1}[Hardware Error]:   class_code: 008001
[  186.972585] Kernel panic - not syncing: Fatal hardware error!

Reported-by: Jozef Mikovic <jmikovic@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 05e3e664ea1b..4e344246c8dd 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3969,7 +3969,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	dd->tags.reserved_tags = 1;
 	dd->tags.cmd_size = sizeof(struct mtip_cmd);
 	dd->tags.numa_node = dd->numa_node;
-	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE;
+	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED;
 	dd->tags.driver_data = dd;
 	dd->tags.timeout = MTIP_NCQ_CMD_TIMEOUT_MS;
 
-- 
2.9.3
