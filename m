Return-Path: <prvs=730b8c8b8=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 2/3] block, scsi: Rework runtime power management
Date: Wed, 18 Jul 2018 15:45:15 +0000
Message-ID: <60ce50f281bf41483b53246d509697f6d95360f8.camel@wdc.com>
References: <20180717234940.11231-1-bart.vanassche@wdc.com>
	 <20180717234940.11231-3-bart.vanassche@wdc.com>
	 <CACVXFVPP6bY9YijDSyQg9OOR4ge9LyR+naWNDeLGOS=WFL_7CA@mail.gmail.com>
In-Reply-To: 
 <CACVXFVPP6bY9YijDSyQg9OOR4ge9LyR+naWNDeLGOS=WFL_7CA@mail.gmail.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 20:16 +-0800, Ming Lei wrote:
+AD4- On Wed, Jul 18, 2018 at 7:49 AM, Bart Van Assche +ADw-bart.vanassche+=
AEA-wdc.com+AD4- wrote:
+AD4- +AD4- +AEAAQA- -3801,8 +-3778,11 +AEAAQA- int blk+AF8-pre+AF8-runtime=
+AF8-suspend(struct request+AF8-queue +ACo-q)
+AD4- +AD4-         if (+ACE-q-+AD4-dev)
+AD4- +AD4-                 return ret+ADs-
+AD4- +AD4-=20
+AD4- +AD4- +-       blk+AF8-set+AF8-preempt+AF8-only(q)+ADs-
+AD4- +AD4- +-       blk+AF8-freeze+AF8-queue+AF8-start(q)+ADs-
+AD4- +AD4- +-
+AD4- +AD4-         spin+AF8-lock+AF8-irq(q-+AD4-queue+AF8-lock)+ADs-
+AD4- +AD4- -       if (q-+AD4-nr+AF8-pending) +AHs-
+AD4- +AD4- +-       if (+ACE-percpu+AF8-ref+AF8-is+AF8-zero(+ACY-q-+AD4-q+=
AF8-usage+AF8-counter)) +AHs-
+AD4-=20
+AD4- This way can't work reliably because the percpu ref isn't in atomic m=
ode
+AD4- yet after blk+AF8-freeze+AF8-queue+AF8-start() returns, then percpu+A=
F8-ref+AF8-is+AF8-zero() won't
+AD4- see accurate value of the counter, finally the device may be put down=
 before
+AD4- in-flight requests are completed by hardware.

Hello Ming,

The blk+AF8-freeze+AF8-queue+AF8-start() implementation is as follows:

void blk+AF8-freeze+AF8-queue+AF8-start(struct request+AF8-queue +ACo-q)
+AHs-
	int freeze+AF8-depth+ADs-

	freeze+AF8-depth +AD0- atomic+AF8-inc+AF8-return(+ACY-q-+AD4-mq+AF8-freeze=
+AF8-depth)+ADs-
	if (freeze+AF8-depth +AD0APQ- 1) +AHs-
		percpu+AF8-ref+AF8-kill(+ACY-q-+AD4-q+AF8-usage+AF8-counter)+ADs-
		if (q-+AD4-mq+AF8-ops)
			blk+AF8-mq+AF8-run+AF8-hw+AF8-queues(q, false)+ADs-
	+AH0-
+AH0-

>From the documentation header in include/linux/percpu-refcount.h above
percpu+AF8-ref+AF8-kill():

 +ACo- Switches +AEA-ref into atomic mode before gathering up the percpu co=
unters
 +ACo- and dropping the initial ref.

In other words, I think that after blk+AF8-freeze+AF8-queue+AF8-start() ret=
urns that it is
guaranteed that q-+AD4-q+AF8-usage+AF8-counter is in atomic mode. However, =
we may need to
serialize concurrent blk+AF8-freeze+AF8-queue+AF8-start() calls to guarante=
e that this is
always the case if multiple threads call blk+AF8-freeze+AF8-queue+AF8-start=
() concurrently.

Bart.=
