Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>, <linux-block@vger.kernel.org>
Subject: [PATCH 02/18] bsg: Check private request size before attaching to a queue
Date: Fri, 19 May 2017 11:30:00 -0700
Message-ID: <20170519183016.12646-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170519183016.12646-1-bart.vanassche@sandisk.com>
References: <20170519183016.12646-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Since BSG only supports request queues for which struct scsi_request
is the first member of their private request data, refuse to register
block layer queues for which the private data is smaller than struct
scsi_request.

References: commit bd1599d931ca ("scsi_transport_sas: fix BSG ioctl memory corruption")
References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: linux-block@vger.kernel.org
---
 block/bsg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bsg.c b/block/bsg.c
index 6fd08544d77e..5ccecc9855ac 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -750,6 +750,12 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 #ifdef BSG_DEBUG
 	unsigned char buf[32];
 #endif
+
+	if (blk_queue_cmd_size(rq) < sizeof(struct scsi_request)) {
+		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!blk_get_queue(rq))
 		return ERR_PTR(-ENXIO);
 
-- 
2.12.2
