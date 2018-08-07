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
Subject: Re: [RFC PATCH 06/14] SCSI: pass scsi_device to scsi_mq_prep_fn
Date: Tue, 7 Aug 2018 23:24:06 +0000
Message-ID: <9d8d49fcdd44152c9fda20c9a57dbb516a5bbbbd.camel@wdc.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
	 <20180807174433.8374-7-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-7-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 01:44 +-0800, Ming Lei wrote:
+AD4- diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.=
c
+AD4- index 435347f58328..52e498fb6280 100644
+AD4- --- a/drivers/scsi/scsi+AF8-lib.c
+AD4- +-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AD4- +AEAAQA- -1971,10 +-1971,9 +AEAAQA- static unsigned int scsi+AF8-mq+A=
F8-sgl+AF8-size(struct Scsi+AF8-Host +ACo-shost)
+AD4-  		sizeof(struct scatterlist)+ADs-
+AD4-  +AH0-
+AD4- =20
+AD4- -static int scsi+AF8-mq+AF8-prep+AF8-fn(struct request +ACo-req)
+AD4- +-static int scsi+AF8-mq+AF8-prep+AF8-fn(struct scsi+AF8-device +ACo-=
sdev, struct request +ACo-req)
+AD4-  +AHs-
+AD4-  	struct scsi+AF8-cmnd +ACo-cmd +AD0- blk+AF8-mq+AF8-rq+AF8-to+AF8-pd=
u(req)+ADs-
+AD4- -	struct scsi+AF8-device +ACo-sdev +AD0- req-+AD4-q-+AD4-queuedata+AD=
s-
+AD4-  	struct Scsi+AF8-Host +ACo-shost +AD0- sdev-+AD4-host+ADs-
+AD4-  	struct scatterlist +ACo-sg+ADs-
+AD4- =20
+AD4- +AEAAQA- -2070,7 +-2069,7 +AEAAQA- static blk+AF8-status+AF8-t scsi+A=
F8-queue+AF8-rq(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4-  		goto out+AF8-dec+AF8-target+AF8-busy+ADs-
+AD4- =20
+AD4-  	if (+ACE-(req-+AD4-rq+AF8-flags +ACY- RQF+AF8-DONTPREP)) +AHs-
+AD4- -		ret +AD0- prep+AF8-to+AF8-mq(scsi+AF8-mq+AF8-prep+AF8-fn(req))+ADs=
-
+AD4- +-		ret +AD0- prep+AF8-to+AF8-mq(scsi+AF8-mq+AF8-prep+AF8-fn(sdev, re=
q))+ADs-
+AD4-  		if (ret +ACEAPQ- BLK+AF8-STS+AF8-OK)
+AD4-  			goto out+AF8-dec+AF8-host+AF8-busy+ADs-
+AD4-  		req-+AD4-rq+AF8-flags +AHwAPQ- RQF+AF8-DONTPREP+ADs-

This patch looks useful to me since it probably realizes a (small) performa=
nce
improvement. I think this patch does not depend on any of the previous patc=
hes
in this series. Is that correct?

Bart.
