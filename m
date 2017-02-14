Return-Path: <hch@lst.de>
Date: Tue, 14 Feb 2017 14:47:36 +0100
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
Message-ID: <20170214134736.GA19620@lst.de>
References: <1486436195.2791.1.camel@sandisk.com> <MWHPR03MB26695ACBEBDB30E3E2E108FBBF430@MWHPR03MB2669.namprd03.prod.outlook.com> <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com> <9199d528-f220-5b77-d657-c510ca210067@kernel.dk> <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com> <b21e5580-ed75-6150-3c83-43ecbb0292a5@kernel.dk> <20170208180314.GA17838@lst.de> <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com> <20170209130800.GA12057@lst.de> <MWHPR03MB2669B4FFC900983C8C357A77BF440@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB2669B4FFC900983C8C357A77BF440@MWHPR03MB2669.namprd03.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

Hi Dexuan,

can you try the hack below for now?  I disable the TUR call from
sd_check_events, which I think your VM is hanging on.  The checks
it does on the sense data look a bit fishy, but so far I've not
identified a possible root cause.

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 40b4038c019e..1502e87c2be9 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1457,9 +1457,13 @@ static unsigned int sd_check_events(struct gendisk *disk, unsigned int clearing)
 	retval = -ENODEV;
 
 	if (scsi_block_when_processing_errors(sdp)) {
+#if 0
 		sshdr  = kzalloc(sizeof(*sshdr), GFP_KERNEL);
 		retval = scsi_test_unit_ready(sdp, SD_TIMEOUT, SD_MAX_RETRIES,
 					      sshdr);
+#else
+		retval = 0;
+#endif
 	}
 
 	/* failed to execute TUR, assume media not present */
