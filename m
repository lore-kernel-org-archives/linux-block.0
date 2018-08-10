Return-Path: <prvs=753ac577b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 08/12] block, scsi: Introduce blk_pm_runtime_exit()
Date: Fri, 10 Aug 2018 15:27:06 +0000
Message-ID: <e993bdc480ccffc4922463fef7102b0cb2e542fd.camel@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
	 <20180809194149.15285-9-bart.vanassche@wdc.com>
	 <be4d4011-efba-c866-e9a8-c14743eb0a1a@oracle.com>
In-Reply-To: <be4d4011-efba-c866-e9a8-c14743eb0a1a@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-10 at 10:39 +-0800, jianchao.wang wrote:
+AD4- On 08/10/2018 03:41 AM, Bart Van Assche wrote:
+AD4- +AD4- +-void blk+AF8-pm+AF8-runtime+AF8-exit(struct request+AF8-queue=
 +ACo-q)
+AD4- +AD4- +-+AHs-
+AD4- +AD4- +-	if (+ACE-q-+AD4-dev)
+AD4- +AD4- +-		return+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-	pm+AF8-runtime+AF8-get+AF8-sync(q-+AD4-dev)+ADs-
+AD4- +AD4- +-	q-+AD4-dev +AD0- NULL+ADs-
+AD4- +AD4- +-+AH0-
+AD4- +AD4- +-EXPORT+AF8-SYMBOL(blk+AF8-pm+AF8-runtime+AF8-exit)+ADs-
+AD4- +AD4- +-
+AD4- +AD4-  /+ACoAKg-
+AD4- +AD4-   +ACo- blk+AF8-pre+AF8-runtime+AF8-suspend - Pre runtime suspe=
nd check
+AD4- +AD4-   +ACo- +AEA-q: the queue of the device
+AD4- +AD4- diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
+AD4- +AD4- index 69ab459abb98..5537762dfcfd 100644
+AD4- +AD4- --- a/drivers/scsi/sd.c
+AD4- +AD4- +-+-+- b/drivers/scsi/sd.c
+AD4- +AD4- +AEAAQA- -3420,12 +-3420,11 +AEAAQA- static int sd+AF8-probe(st=
ruct device +ACo-dev)
+AD4- +AD4-   +ACoAKg-/
+AD4- +AD4-  static int sd+AF8-remove(struct device +ACo-dev)
+AD4- +AD4-  +AHs-
+AD4- +AD4- -	struct scsi+AF8-disk +ACo-sdkp+ADs-
+AD4- +AD4- -	dev+AF8-t devt+ADs-
+AD4- +AD4- +-	struct scsi+AF8-disk +ACo-sdkp +AD0- dev+AF8-get+AF8-drvdata=
(dev)+ADs-
+AD4- +AD4- +-	struct scsi+AF8-device +ACo-sdp +AD0- sdkp-+AD4-device+ADs-
+AD4- +AD4- +-	dev+AF8-t devt +AD0- disk+AF8-devt(sdkp-+AD4-disk)+ADs-
+AD4- +AD4- =20
+AD4- +AD4- -	sdkp +AD0- dev+AF8-get+AF8-drvdata(dev)+ADs-
+AD4- +AD4- -	devt +AD0- disk+AF8-devt(sdkp-+AD4-disk)+ADs-
+AD4- +AD4- -	scsi+AF8-autopm+AF8-get+AF8-device(sdkp-+AD4-device)+ADs-
+AD4- +AD4- +-	blk+AF8-pm+AF8-runtime+AF8-exit(sdp-+AD4-request+AF8-queue)
+AD4-=20
+AD4-=20
+AD4- Based on +AF8AXw-scsi+AF8-device+AF8-remove, sd+AF8-remove will be in=
voked before blk+AF8-cleanup+AF8-queue.
+AD4- So it should be not safe that we set the q-+AD4-dev to NULL here.
+AD4-=20
+AD4- We have following operations in followed patch:
+AD4- +-static inline void blk+AF8-pm+AF8-mark+AF8-last+AF8-busy(struct req=
uest +ACo-rq)
+AD4- +-+AHs-
+AD4- +-	if (rq-+AD4-q-+AD4-dev +ACYAJg- +ACE-(rq-+AD4-rq+AF8-flags +ACY- R=
QF+AF8-PM))
+AD4- +-		pm+AF8-runtime+AF8-mark+AF8-last+AF8-busy(rq-+AD4-q-+AD4-dev)+ADs=
-
+AD4- +-+AH0-

Hello Jianchao,

How about moving the blk+AF8-pm+AF8-runtime+AF8-exit() call into blk+AF8-cl=
eanup+AF8-queue() at
a point where it is sure that there are no requests in progress? That shoul=
d
avoid that blk+AF8-pm+AF8-mark+AF8-last+AF8-busy() races against blk+AF8-pm=
+AF8-runtime+AF8-exit().

Thanks,

Bart.
