Return-Path: <prvs=7387fcde5=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
Date: Thu, 26 Jul 2018 22:24:27 +0000
Message-ID: <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
	 <20180725222607.8854-5-bart.vanassche@wdc.com>
	 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
In-Reply-To: <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-26 at 10:45 +-0800, jianchao.wang wrote:
+AD4- On 07/26/2018 06:26 AM, Bart Van Assche wrote:
+AD4- +AD4- +AEAAQA- -102,9 +-109,11 +AEAAQA- int blk+AF8-pre+AF8-runtime+A=
F8-suspend(struct request+AF8-queue +ACo-q)
+AD4- +AD4-  		return ret+ADs-
+AD4- +AD4- =20
+AD4- +AD4-  	blk+AF8-pm+AF8-runtime+AF8-lock(q)+ADs-
+AD4- +AD4- +-	blk+AF8-set+AF8-preempt+AF8-only(q)+ADs-
+AD4-=20
+AD4- We only stop non-RQF+AF8-PM request entering when RPM+AF8-SUSPENDING =
and RPM+AF8-RESUMING.
+AD4- blk+AF8-pre+AF8-runtime+AF8-suspend should only +AF8-check+AF8- wheth=
er runtime suspend is allowed.
+AD4- So we should not set preempt+AF8-only here.
+AD4-=20
+AD4- +AD4- +-	percpu+AF8-ref+AF8-switch+AF8-to+AF8-atomic+AF8-sync(+ACY-q-=
+AD4-q+AF8-usage+AF8-counter)+ADs-
+AD4- +AD4- =20
+AD4- +AD4-  	spin+AF8-lock+AF8-irq(q-+AD4-queue+AF8-lock)+ADs-
+AD4- +AD4- -	if (q-+AD4-nr+AF8-pending) +AHs-
+AD4- +AD4- +-	if (+ACE-percpu+AF8-ref+AF8-is+AF8-zero(+ACY-q-+AD4-q+AF8-us=
age+AF8-counter)) +AHs-
+AD4- +AD4-  		ret +AD0- -EBUSY+ADs-
+AD4- +AD4-  		pm+AF8-runtime+AF8-mark+AF8-last+AF8-busy(q-+AD4-dev)+ADs-
+AD4- +AD4-  	+AH0- else +AHs-
+AD4- +AD4- +AEAAQA- -112,6 +-121,7 +AEAAQA- int blk+AF8-pre+AF8-runtime+AF=
8-suspend(struct request+AF8-queue +ACo-q)
+AD4- +AD4-  	+AH0-
+AD4- +AD4-  	spin+AF8-unlock+AF8-irq(q-+AD4-queue+AF8-lock)+ADs-
+AD4- +AD4- =20
+AD4- +AD4- +-	percpu+AF8-ref+AF8-switch+AF8-to+AF8-percpu(+ACY-q-+AD4-q+AF=
8-usage+AF8-counter)+ADs-
+AD4- +AD4-  	blk+AF8-pm+AF8-runtime+AF8-unlock(q)+ADs-

Hello Jianchao,

There is only one caller of blk+AF8-post+AF8-runtime+AF8-suspend(), namely
sdev+AF8-runtime+AF8-suspend(). That function calls pm-+AD4-runtime+AF8-sus=
pend() before
it calls blk+AF8-post+AF8-runtime+AF8-suspend(). I think it would be wrong =
to set the
PREEMPT+AF8-ONLY flag from inside blk+AF8-post+AF8-runtime+AF8-suspend() be=
cause that could
cause pm-+AD4-runtime+AF8-suspend() while a request is in progress.

Bart.
