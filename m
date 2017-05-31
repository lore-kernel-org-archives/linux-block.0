Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>
Subject: [PATCH v2 5/6] cdrom: Check SCSI passthrough support before reading audio
Date: Wed, 31 May 2017 14:43:49 -0700
Message-ID: <20170531214350.31157-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170531214350.31157-1-bart.vanassche@sandisk.com>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

The CDROMREADAUDIO ioctl uses SCSI passthrough when the .disk
pointer has been set in struct cdrom_device_info. Hence check
whether SCSI passthrough is supported before submitting a SCSI
command. Note: both the ide-cd and sr drivers set the disk
pointer in struct cdrom_device_info but neither the pcd nor
the gdrom driver sets that pointer.

References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org
---
 drivers/cdrom/cdrom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 76c952fd9ab9..ff19cfc587f0 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2178,6 +2178,12 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
 	if (!q)
 		return -ENXIO;
 
+	if (!blk_queue_scsi_passthrough(q)) {
+		WARN_ONCE(true,
+			  "Attempt read CDDA info through a non-SCSI queue\n");
+		return -EINVAL;
+	}
+
 	cdi->last_sense = 0;
 
 	while (nframes) {
-- 
2.12.2
