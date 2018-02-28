Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Nicholas A . Bellinger" <nab@linux-iscsi.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 08/11] target/tcm_loop: Use blk_queue_flag_set()
Date: Wed, 28 Feb 2018 11:28:20 -0800
Message-Id: <20180228192823.5191-9-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Use blk_queue_flag_set() instead of open-coding this function.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Nicholas A. Bellinger <nab@linux-iscsi.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/target/loopback/tcm_loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 9cd4ffe76c07..60d5b918c4ac 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -309,7 +309,7 @@ static int tcm_loop_target_reset(struct scsi_cmnd *sc)
 
 static int tcm_loop_slave_alloc(struct scsi_device *sd)
 {
-	set_bit(QUEUE_FLAG_BIDI, &sd->request_queue->queue_flags);
+	blk_queue_flag_set(QUEUE_FLAG_BIDI, sd->request_queue);
 	return 0;
 }
 
-- 
2.16.2
