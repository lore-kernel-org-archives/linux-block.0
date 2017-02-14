Return-Path: <hch@lst.de>
Date: Tue, 14 Feb 2017 15:28:37 +0100
From: "hch@lst.de" <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "hch@lst.de" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"hare@suse.com" <hare@suse.com>, "hare@suse.de" <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jth@kernel.org" <jth@kernel.org>,
	Nick Meier <Nick.Meier@microsoft.com>,
	"Alex Ng (LIS)" <alexng@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Adrian Suhov (Cloudbase Solutions SRL)" <v-adsuho@microsoft.com>,
	"Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>
Subject: Re: Boot regression (was "Re: [PATCH] genhd: Do not hold event
	lock when scheduling workqueue elements")
Message-ID: <20170214142837.GB20706@lst.de>
References: <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com> <9199d528-f220-5b77-d657-c510ca210067@kernel.dk> <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com> <b21e5580-ed75-6150-3c83-43ecbb0292a5@kernel.dk> <20170208180314.GA17838@lst.de> <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com> <20170209130800.GA12057@lst.de> <MWHPR03MB2669B4FFC900983C8C357A77BF440@MWHPR03MB2669.namprd03.prod.outlook.com> <20170214134736.GA19620@lst.de> <MWHPR03MB2669C439014CD20B21ED3A69BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
In-Reply-To: <MWHPR03MB2669C439014CD20B21ED3A69BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, thanks for testing.  Can you try the patch below?  It fixes a
clear problem which was partially papered over before the commit
you bisected to, although it can't explain why blk-mq still works.


--BXVAT5kNtrzKuDFl
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-scsi-always-zero-sshdr-in-scsi_normalize_sense.patch"

>From e4a66856fa2d92c0298000de658365f31bea60cd Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 14 Feb 2017 15:08:39 +0100
Subject: scsi: always zero sshdr in scsi_normalize_sense

This gives us a clear state even if a command didn't return sense data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_common.c b/drivers/scsi/scsi_common.c
index b1383a71400e..a75673bb82b3 100644
--- a/drivers/scsi/scsi_common.c
+++ b/drivers/scsi/scsi_common.c
@@ -137,11 +137,11 @@ EXPORT_SYMBOL(int_to_scsilun);
 bool scsi_normalize_sense(const u8 *sense_buffer, int sb_len,
 			  struct scsi_sense_hdr *sshdr)
 {
+	memset(sshdr, 0, sizeof(struct scsi_sense_hdr));
+
 	if (!sense_buffer || !sb_len)
 		return false;
 
-	memset(sshdr, 0, sizeof(struct scsi_sense_hdr));
-
 	sshdr->response_code = (sense_buffer[0] & 0x7f);
 
 	if (!scsi_sense_valid(sshdr))
-- 
2.11.0


--BXVAT5kNtrzKuDFl--
