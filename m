Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7422 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763368AbdEXAf0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 20:35:26 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 28/31] scsi_setup_fs_cmnd(): Call scsi_req_init() instead of open-coding it
Date: Tue, 23 May 2017 17:34:17 -0700
Message-ID: <20170524003420.5381-29-bart.vanassche@sandisk.com>
In-Reply-To: <20170524003420.5381-1-bart.vanassche@sandisk.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The only functional change is that this patch causes scsi_setup_fs_cmnd()
to clear scsi_request.sense_len.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 612bf6c201dc..2d680d8ea80f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1211,8 +1211,8 @@ static int scsi_setup_fs_cmnd(struct scsi_device *sdev, struct request *req)
 			return ret;
 	}
 
-	cmd->cmnd = scsi_req(req)->cmd = scsi_req(req)->__cmd;
-	memset(cmd->cmnd, 0, BLK_MAX_CDB);
+	scsi_req_init(&cmd->req);
+	cmd->cmnd = scsi_req(req)->cmd;
 	return scsi_cmd_to_driver(cmd)->init_command(cmd);
 }
 
-- 
2.12.2
