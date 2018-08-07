Return-Path: <prvs=750bc9d11=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hare@suse.de"
	<hare@suse.de>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 10/14] SCSI: use the dedicated admin queue to send
 admin commands
Date: Tue, 7 Aug 2018 23:33:15 +0000
Message-ID: <eaa9a9ee6da927d1d65fe19de01114d5f38832bc.camel@wdc.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
	 <20180807174433.8374-11-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-11-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 01:44 +-0800, Ming Lei wrote:
+AD4- --- a/drivers/scsi/scsi+AF8-lib.c
+AD4- +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4- +AEAAQA- -278,16 +-278,16 +AEAAQA- int +AF8AXw-scsi+AF8-execute(struc=
t scsi+AF8-device +ACo-sdev, const unsigned char +ACo-cmd,
+AD4-  	struct request +ACo-req+ADs-
+AD4-  	struct scsi+AF8-request +ACo-rq+ADs-
+AD4-  	int ret +AD0- DRIVER+AF8-ERROR +ADwAPA- 24+ADs-
+AD4- +-	struct request+AF8-queue +ACo-q +AD0- sdev-+AD4-host-+AD4-admin+AF=
8-q+ADs-
+AD4- =20
+AD4- -	req +AD0- blk+AF8-get+AF8-request(sdev-+AD4-request+AF8-queue,
+AD4- +-	req +AD0- blk+AF8-get+AF8-request(q,
+AD4-  			data+AF8-direction +AD0APQ- DMA+AF8-TO+AF8-DEVICE ?
+AD4-  			REQ+AF8-OP+AF8-SCSI+AF8-OUT : REQ+AF8-OP+AF8-SCSI+AF8-IN, BLK+AF8=
-MQ+AF8-REQ+AF8-PREEMPT)+ADs-

The above looks weird to me. Why are all RQF+AF8-PREEMPT requests sent to t=
he admin
queue instead of only RQF+AF8-PM requests?

+AD4- +AEAAQA- -299,6 +-299,8 +AEAAQA- int +AF8AXw-scsi+AF8-execute(struct =
scsi+AF8-device +ACo-sdev, const unsigned char +ACo-cmd,
+AD4-  	req-+AD4-cmd+AF8-flags +AHwAPQ- flags+ADs-
+AD4-  	req-+AD4-rq+AF8-flags +AHwAPQ- rq+AF8-flags +AHw- RQF+AF8-QUIET+ADs=
-
+AD4- =20
+AD4- +-	atomic+AF8-inc(+ACY-sdev-+AD4-nr+AF8-admin+AF8-pending)+ADs-

Why has a new counter been introduced to keep track of admin requests inste=
ad of
using q+AF8-usage+AF8-counter?

Thanks,

Bart.
