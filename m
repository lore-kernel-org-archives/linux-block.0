Return-Path: <BATV+aad74de60c11d68aa74c+4929+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com
Cc: decui@microsoft.com,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: zero per-cmd driver data before each I/O
Date: Mon, 20 Feb 2017 17:52:39 +0100
Message-Id: <20170220165239.25669-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Without this drivers that don't clear the state themselves can see off
effects.  For example Hyper-V VMs using the storvsc driver will often
hang during boot due to uncleared Test Unit Ready failures.

Fixes: e9c787e6 ("scsi: allocate scsi_cmnd structures as part of struct request")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/scsi/scsi_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 90f65c8f487a..daced9db8af8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1167,6 +1167,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	/* zero out the cmd, except for the embedded scsi_request */
 	memset((char *)cmd + sizeof(cmd->req), 0,
 		sizeof(*cmd) - sizeof(cmd->req));
+	memset((char *)(cmd + 1), 0, dev->host->hostt->cmd_size);
 
 	cmd->device = dev;
 	cmd->sense_buffer = buf;
-- 
2.11.0
