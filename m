Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6364 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760443AbdEXAei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 20:34:38 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>,
        "Hannes Reinecke" <hare@suse.com>
Subject: [PATCH 26/31] scsi: Move the code for clearing private command data into scsi_dispatch_cmd()
Date: Tue, 23 May 2017 17:34:15 -0700
Message-ID: <20170524003420.5381-27-bart.vanassche@sandisk.com>
In-Reply-To: <20170524003420.5381-1-bart.vanassche@sandisk.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch does not change any functionality but avoids duplication
of the code for clearing driver-private command data.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 12fd2bb0fe9c..f131964ecb51 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1339,7 +1339,6 @@ static int scsi_prep_fn(struct request_queue *q, struct request *req)
 			goto out;
 		}
 
-		memset(scsi_cmd_priv(cmd), 0, dev->host->hostt->cmd_size);
 		scsi_add_cmd_to_list(cmd);
 		req->special = cmd;
 	}
@@ -1677,6 +1676,8 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 
 	}
 
+	memset(scsi_cmd_priv(cmd), 0, host->hostt->cmd_size);
+
 	trace_scsi_dispatch_cmd_start(cmd);
 	rtn = host->hostt->queuecommand(host, cmd);
 	if (rtn) {
@@ -1863,8 +1864,6 @@ static int scsi_mq_prep_fn(struct request *req)
 	struct Scsi_Host *shost = sdev->host;
 	struct scatterlist *sg;
 
-	memset(scsi_cmd_priv(cmd), 0, shost->hostt->cmd_size);
-
 	req->special = cmd;
 
 	cmd->request = req;
-- 
2.12.2
