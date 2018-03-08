Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51958 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755138AbeCHBKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Mar 2018 20:10:15 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 07/11] iscsi: Use blk_queue_flag_set()
Date: Wed,  7 Mar 2018 17:10:08 -0800
Message-Id: <20180308011012.31522-8-bart.vanassche@wdc.com>
In-Reply-To: <20180308011012.31522-1-bart.vanassche@wdc.com>
References: <20180308011012.31522-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use blk_queue_flag_set() instead of open-coding this function.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
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
