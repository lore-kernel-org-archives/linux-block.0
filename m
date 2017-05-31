Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2 3/6] bsg: Check queue type before attaching to a queue
Date: Wed, 31 May 2017 14:43:47 -0700
Message-ID: <20170531214350.31157-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170531214350.31157-1-bart.vanassche@sandisk.com>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since BSG only supports request queues for which struct scsi_request
is the first member of their private request data, refuse to register
block layer queues for which struct scsi_request is not the first
member of their private data.

References: commit bd1599d931ca ("scsi_transport_sas: fix BSG ioctl memory corruption")
References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/bsg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bsg.c b/block/bsg.c
index 6fd08544d77e..40db8ff4c618 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -750,6 +750,12 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 #ifdef BSG_DEBUG
 	unsigned char buf[32];
 #endif
+
+	if (!blk_queue_scsi_passthrough(rq)) {
+		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!blk_get_queue(rq))
 		return ERR_PTR(-ENXIO);
 
-- 
2.12.2
