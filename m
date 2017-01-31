Return-Path: <linux-ide-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] =?UTF-8?q?=D1=95d:=20remove=20pointless=20REQ=5FTYP?= =?UTF-8?q?E=5FFS=20check?=
Date: Tue, 31 Jan 2017 16:57:23 +0100
Message-Id: <1485878251-6107-3-git-send-email-hch@lst.de>
In-Reply-To: <1485878251-6107-1-git-send-email-hch@lst.de>
References: <1485878251-6107-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

->done can only be called for fs requests, so no need to check again here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c779986..bd2fb4d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1735,9 +1735,6 @@ static unsigned int sd_completed_bytes(struct scsi_cmnd *scmd)
 	unsigned int transferred = scsi_bufflen(scmd) - scsi_get_resid(scmd);
 	unsigned int good_bytes;
 
-	if (scmd->request->cmd_type != REQ_TYPE_FS)
-		return 0;
-
 	info_valid = scsi_get_sense_info_fld(scmd->sense_buffer,
 					     SCSI_SENSE_BUFFERSIZE,
 					     &bad_lba);
-- 
2.1.4

