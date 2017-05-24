Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11374 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760621AbdEXAeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 20:34:31 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>,
        "Hannes Reinecke" <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 08/31] sd, sr: Convert two assignments into warning statements
Date: Tue, 23 May 2017 17:33:57 -0700
Message-ID: <20170524003420.5381-9-bart.vanassche@sandisk.com>
In-Reply-To: <20170524003420.5381-1-bart.vanassche@sandisk.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before scsi_prep_fn() calls the ULP .init_command() callback
function it stores the SCSI command pointer in request.special.
This means that the SCpnt = rq->special assignments in the sd
and sr drivers assign a pointer to itself. Hence convert these
two assignment statements into warning statements.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/sd.c | 2 +-
 drivers/scsi/sr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index aea55f5afed0..916f6e9dac18 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -990,7 +990,7 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 	ret = scsi_init_io(SCpnt);
 	if (ret != BLKPREP_OK)
 		goto out;
-	SCpnt = rq->special;
+	WARN_ON_ONCE(SCpnt != rq->special);
 
 	/* from here on until we're complete, any goto out
 	 * is used for a killable error condition */
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index a8f630213a1a..9be34d37c356 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -393,7 +393,7 @@ static int sr_init_command(struct scsi_cmnd *SCpnt)
 	ret = scsi_init_io(SCpnt);
 	if (ret != BLKPREP_OK)
 		goto out;
-	SCpnt = rq->special;
+	WARN_ON_ONCE(SCpnt != rq->special);
 	cd = scsi_cd(rq->rq_disk);
 
 	/* from here on until we're complete, any goto out
-- 
2.12.2
