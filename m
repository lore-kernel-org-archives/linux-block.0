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
Subject: Re: [RFC PATCH 13/14] block: simplify runtime PM support
Date: Tue, 7 Aug 2018 19:54:44 +0000
Message-ID: <a1b7afb7e912c84b908342922b2fba12a364fd76.camel@wdc.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
	 <20180807174433.8374-14-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-14-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 01:44 +-0800, Ming Lei wrote:
+AD4- +AEAAQA- -3772,6 +-3764,7 +AEAAQA- int blk+AF8-pre+AF8-runtime+AF8-su=
spend(struct request+AF8-queue +ACo-q)
+AD4-         if (+ACE-q-+AD4-dev)
+AD4-                 return ret+ADs-
+AD4- =20
+AD4- +-       mutex+AF8-lock(+ACY-q-+AD4-pm+AF8-lock)+ADs-
+AD4-         spin+AF8-lock+AF8-irq(q-+AD4-queue+AF8-lock)+ADs-
+AD4-         if (q-+AD4-nr+AF8-pending) +AHs-
+AD4-                 ret +AD0- -EBUSY+ADs-
+AD4- +AEAAQA- -3780,6 +-3773,13 +AEAAQA- int blk+AF8-pre+AF8-runtime+AF8-s=
uspend(struct request+AF8-queue +ACo-q)
+AD4-                 q-+AD4-rpm+AF8-status +AD0- RPM+AF8-SUSPENDING+ADs-
+AD4-         +AH0-

Hello Ming,

As far as I can see none of the patches in this series adds a call to
blk+AF8-pm+AF8-add+AF8-request() in the blk-mq code. Does that mean that q-=
+AD4-nr+AF8-pending
will always be zero for blk-mq code with your approach and hence that runti=
me
suspend can get triggered while I/O is in progress, e.g. if blk+AF8-queue+A=
F8-enter()
is called concurrently with blk+AF8-pre+AF8-runtime+AF8-suspend()?

Thanks,

Bart.
