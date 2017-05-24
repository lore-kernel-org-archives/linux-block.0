Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7422 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763394AbdEXAef (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 20:34:35 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH 31/31] xen/scsifront: Remove code that zeroes driver-private command data
Date: Tue, 23 May 2017 17:34:20 -0700
Message-ID: <20170524003420.5381-32-bart.vanassche@sandisk.com>
In-Reply-To: <20170524003420.5381-1-bart.vanassche@sandisk.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since the SCSI core zeroes driver-private command data, remove
that code from the xen-scsifront driver.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/scsi/xen-scsifront.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index a6a8b60d4902..36f59a1be7e9 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -534,7 +534,6 @@ static int scsifront_queuecommand(struct Scsi_Host *shost,
 	int err;
 
 	sc->result = 0;
-	memset(shadow, 0, sizeof(*shadow));
 
 	shadow->sc  = sc;
 	shadow->act = VSCSIIF_ACT_SCSI_CDB;
-- 
2.12.2
