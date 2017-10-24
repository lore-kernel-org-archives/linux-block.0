Return-Path: <bart@localhost>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Dann Frazier <dann.frazier@canonical.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtio_blk: Fix an SG_IO regression
Date: Tue, 24 Oct 2017 08:04:36 +0200
Message-Id: <20171024060436.24954-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that submitting an SG_IO ioctl triggers a kernel oops that
is preceded by:

usercopy: kernel memory overwrite attempt detected to (null) (<null>) (6 bytes)
kernel BUG at mm/usercopy.c:72!

Additionally, make it easier to diagnose crashes like the one
fixed by this patch.

Reported-by: Dann Frazier <dann.frazier@canonical.com>
Fixes: commit ca18d6f769d2 ("block: Make most scsi_req_init() calls implicit")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Dann Frazier <dann.frazier@canonical.com>
Cc: Dann Frazier <dann.frazier@canonical.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: <stable@vger.kernel.org> # v4.13
---
 drivers/block/virtio_blk.c | 1 +
 drivers/scsi/sg.c          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 34e17ee799be..15e11a519801 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -597,6 +597,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
+	.initialize_rq_fn = scsi_initialize_rq,
 	.map_queues	= virtblk_map_queues,
 };
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0419c2298eab..14096f67eebb 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1722,6 +1722,8 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	}
 	req = scsi_req(rq);
 
+	WARN_ON_ONCE(!req->cmd);
+
 	if (hp->cmd_len > BLK_MAX_CDB)
 		req->cmd = long_cmdp;
 	memcpy(req->cmd, cmd, hp->cmd_len);
-- 
2.14.2
