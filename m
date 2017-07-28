Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "bjking1@us.ibm.com"
	<bjking1@us.ibm.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
Date: Fri, 28 Jul 2017 15:13:44 +0000
Message-ID: <1501254817.2413.1.camel@wdc.com>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
	 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
	 <1501166846.2516.1.camel@wdc.com>
	 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
	 <87lgn9dqx3.fsf@concordia.ellerman.id.au>
	 <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
In-Reply-To: <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-07-28 at 08:25 -0600, Jens Axboe wrote:
> On 07/28/2017 12:19 AM, Michael Ellerman wrote:
> > OK, so the resolution is "fix it in IPR" ?
>=20
> I'll leave that to the SCSI crew. But at least one bug is in IPR, if you
> look at the call trace:
>=20
> - timer function triggers, runs ipr_reset_timer_done(), which grabs the
>   host lock AND disables interrupts.
> - further down in the call path, ipr_ioa_bringdown_done() uncondtionally
>   enables interrupts:
>=20
>                 spin_unlock_irq(ioa_cfg->host->host_lock);
>                 scsi_unblock_requests(ioa_cfg->host);
>                 spin_lock_irq(ioa_cfg->host->host_lock);=20
>=20
> And the call to scsi_unblock_requests() is the one that ultimately runs
> the queue. The IRQ issue aside here, scsi_unblock_requests() could run
> the queue async, and we could retain the normal sync run otherwise.
>=20
> Can you try the below fix? Should be more palatable than the previous
> one. Brian, maybe you can take a look at the IRQ issue mentioned above?
>=20
> [ ... ]

Hello Jens,

Are there other block drivers that can call blk_mq_start_hw_queues() from
interrupt context? I'm currently working on converting the skd driver
(drivers/block/skd_main.c) from a single queue block driver into a scsi-mq
driver. The skd driver calls blk_start_queue() from interrupt context. As w=
e
know it is not safe to call blk_mq_start_hw_queues() from interrupt context=
.
Can you recommend me how I should proceed: should I implement a solution in
the skd driver or should perhaps the blk-mq core be modified?

Thanks,

Bart.=
