Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 07/11] iscsi: Use blk_queue_flag_set()
Date: Wed, 28 Feb 2018 11:28:19 -0800
Message-Id: <20180228192823.5191-8-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Use blk_queue_flag_set() instead of open-coding this function.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/iscsi_tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 6198559abbd8..07b54dfebccf 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -948,7 +948,7 @@ static umode_t iscsi_sw_tcp_attr_is_visible(int param_type, int param)
 
 static int iscsi_sw_tcp_slave_alloc(struct scsi_device *sdev)
 {
-	set_bit(QUEUE_FLAG_BIDI, &sdev->request_queue->queue_flags);
+	blk_queue_flag_set(QUEUE_FLAG_BIDI, sdev->request_queue);
 	return 0;
 }
 
-- 
2.16.2
