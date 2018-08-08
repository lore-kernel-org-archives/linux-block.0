Return-Path: <prvs=75172a298=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v5 6/9] block: Change the runtime power management
 approach (2/2)
Date: Wed, 8 Aug 2018 17:32:14 +0000
Message-ID: <ac7bee2f2c3dcee9829aa0d010ffe9718130381b.camel@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
	 <20180807225133.27221-7-bart.vanassche@wdc.com>
	 <20180808085012.GB13518@ming.t460p>
In-Reply-To: <20180808085012.GB13518@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-08 at 16:50 +-0800, Ming Lei wrote:
+AD4- On Tue, Aug 07, 2018 at 03:51:30PM -0700, Bart Van Assche wrote:
+AD4- +AD4- Instead of allowing requests that are not power management requ=
ests
+AD4- +AD4- to enter the queue in runtime suspended status (RPM+AF8-SUSPEND=
ED), make
+AD4- +AD4- the blk+AF8-get+AF8-request() caller block. This change fixes a=
 starvation
+AD4-=20
+AD4- Looks not see the related change which blocks blk+AF8-get+AF8-request=
() in
+AD4- this patchset.

I was referring to setting pm-only mode for suspended devices. Since
blk+AF8-queue+AF8-enter() is called before a request is allocated that is s=
ufficient
to make request allocation block.

+AD4- +AD4- diff --git a/block/blk-pm.c b/block/blk-pm.c
+AD4- +AD4- index bf8532da952d..d6b65cef9764 100644
+AD4- +AD4- --- a/block/blk-pm.c
+AD4- +AD4- +-+-+- b/block/blk-pm.c
+AD4- +AD4- +AEAAQA- -86,14 +-86,39 +AEAAQA- int blk+AF8-pre+AF8-runtime+AF=
8-suspend(struct request+AF8-queue +ACo-q)
+AD4- +AD4-  	if (+ACE-q-+AD4-dev)
+AD4- +AD4-  		return ret+ADs-
+AD4- +AD4- =20
+AD4- +AD4- +-	WARN+AF8-ON+AF8-ONCE(q-+AD4-rpm+AF8-status +ACEAPQ- RPM+AF8-=
ACTIVE)+ADs-
+AD4- +AD4- +-
+AD4- +AD4- +-	blk+AF8-set+AF8-pm+AF8-only(q)+ADs-
+AD4- +AD4- +-	/+ACo-
+AD4- +AD4- +-	 +ACo- This function only gets called if the most recent
+AD4- +AD4- +-	 +ACo- pm+AF8-request+AF8-resume() call occurred at least au=
tosuspend+AF8-delay+AF8-ms
+AD4- +AD4- +-	 +ACo- ago. Since blk+AF8-queue+AF8-enter() is called by the=
 request allocation
+AD4- +AD4- +-	 +ACo- code before pm+AF8-request+AF8-resume(), if q+AF8-usa=
ge+AF8-counter indicates that
+AD4- +AD4- +-	 +ACo- no requests are in flight it is safe to suspend the d=
evice.
+AD4- +AD4- +-	 +ACo-/
+AD4- +AD4- +-	ret +AD0- -EBUSY+ADs-
+AD4- +AD4- +-	if (+ACE-percpu+AF8-ref+AF8-is+AF8-in+AF8-use(+ACY-q-+AD4-q+=
AF8-usage+AF8-counter)) +AHs-
+AD4- +AD4- +-		/+ACo-
+AD4- +AD4- +-		 +ACo- Switch to preempt-only mode before calling
+AD4- +AD4- +-		 +ACo- synchronize+AF8-rcu() such that later blk+AF8-queue+=
AF8-enter() calls
+AD4- +AD4- +-		 +ACo- see the preempt-only state. See also
+AD4- +AD4- +-		 +ACo- http://lwn.net/Articles/573497/.
+AD4- +AD4- +-		 +ACo-/
+AD4- +AD4- +-		synchronize+AF8-rcu()+ADs-
+AD4- +AD4- +-		if (+ACE-percpu+AF8-ref+AF8-is+AF8-in+AF8-use(+ACY-q-+AD4-q=
+AF8-usage+AF8-counter))
+AD4- +AD4- +-			ret +AD0- 0+ADs-
+AD4- +AD4- +-	+AH0-
+AD4- +AD4- +-
+AD4-=20
+AD4- In blk+AF8-queue+AF8-enter(), V5 starts to allow all RQF+AF8-PREEMPT =
requests
+AD4- to enter queue even though pm+AF8-only is set. That means any scsi+AF=
8-execute()
+AD4- may issue a new command to host just after the above percpu+AF8-ref+A=
F8-is+AF8-in+AF8-use()
+AD4- returns 0, meantime the suspend is in-progress.
+AD4-=20
+AD4- This case is illegal given RQF+AF8-PM is the only kind of request whi=
ch can be
+AD4- issued to hardware during suspend.

Right, that's something that needs to be addressed.

Bart.
