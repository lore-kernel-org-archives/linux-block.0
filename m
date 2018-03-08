Return-Path: <prvs=5980fa318=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Nicholas A . Bellinger" <nab@linux-iscsi.org>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 08/11] target/tcm_loop: Use blk_queue_flag_set()
Date: Wed,  7 Mar 2018 17:10:09 -0800
Message-Id: <20180308011012.31522-9-bart.vanassche@wdc.com>
In-Reply-To: <20180308011012.31522-1-bart.vanassche@wdc.com>
References: <20180308011012.31522-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Use blk_queue_flag_set() instead of open-coding this function.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Nicholas A. Bellinger <nab@linux-iscsi.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
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
