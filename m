Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
Date: Fri, 27 Jul 2018 15:29:55 +0000
Message-ID: <cc184e4f68bd2794ab714d264fece552753727f9.camel@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
	 <20180725222607.8854-5-bart.vanassche@wdc.com>
	 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
	 <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
	 <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
In-Reply-To: <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 09:57 +-0800, jianchao.wang wrote:
+AD4- Something like:
+AD4-=20
+AD4- 	percpu+AF8-ref+AF8-switch+AF8-to+AF8-atomic+AF8-sync(+ACY-q-+AD4-q+A=
F8-usage+AF8-counter)+ADs-
+AD4- 	if (+ACE-percpu+AF8-ref+AF8-is+AF8-zero(+ACY-q-+AD4-q+AF8-usage+AF8-=
counter)) +AHs-
+AD4- 		ret +AD0- -EBUSY+ADs-
+AD4- 		pm+AF8-runtime+AF8-mark+AF8-last+AF8-busy(q-+AD4-dev)+ADs-
+AD4-      	+AH0- else +AHs-
+AD4- 		blk+AF8-set+AF8-preempt+AF8-only(q)+ADs-
+AD4- 		if (+ACE-percpu+AF8-ref+AF8-is+AF8-zero(+ACY-q-+AD4-q+AF8-usage+AF8=
-counter) +AHs-
+AD4- 			ret +AD0- -EBUSY+ADs-
+AD4- 			pm+AF8-runtime+AF8-mark+AF8-last+AF8-busy(q-+AD4-dev)+ADs-
+AD4- 			blk+AF8-clear+AF8-preempt+AF8-only(q)+ADs-
+AD4- 		+AH0- else +AHs-
+AD4- 			q-+AD4-rpm+AF8-status +AD0- RPM+AF8-SUSPENDIN+ADs-   =20
+AD4- 		+AH0-
+AD4-         +AH0-

I think this code is racy. Because there is no memory barrier in
blk+AF8-queue+AF8-enter() between the percpu+AF8-ref+AF8-tryget+AF8-live() =
and the
blk+AF8-queue+AF8-preempt+AF8-only() calls, the context that sets the PREEM=
PT+AF8-ONLY flag
has to use synchronize+AF8-rcu() or call+AF8-rcu() to ensure that blk+AF8-q=
ueue+AF8-enter()
sees the PREEMPT+AF8-ONLY flag after it has called percpu+AF8-ref+AF8-tryge=
t+AF8-live().
See also http://lwn.net/Articles/573497/.

Bart.
