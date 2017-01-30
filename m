Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <2d656e9c9fbde7206e40a635c61a6084@mail.gmail.com>
 <298b6ff6-9feb-4b70-ec4c-d1295a0e1f41@kernel.dk> <e1e827ba633f780b00d070e087204d5c@mail.gmail.com>
 <1485793840.2712.1.camel@sandisk.com> <22a9792c-098d-eb8d-b7d4-87a79cf1d31f@kernel.dk>
In-Reply-To: <22a9792c-098d-eb8d-b7d4-87a79cf1d31f@kernel.dk>
MIME-Version: 1.0
Date: Mon, 30 Jan 2017 23:58:28 +0530
Message-ID: <6325b0024b3cb401fcd1aed782b7b14d@mail.gmail.com>
Subject: RE: Device or HBA level QD throttling creates randomness in sequetial workload
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@sandisk.com>, osandov@osandov.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, linux-block@vger.kernel.org, paolo.valente@linaro.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

> -----Original Message-----
> From: Jens Axboe [mailto:axboe@kernel.dk]
> Sent: Monday, January 30, 2017 10:03 PM
> To: Bart Van Assche; osandov@osandov.com; kashyap.desai@broadcom.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> hch@infradead.org; linux-block@vger.kernel.org; paolo.valente@linaro.org
> Subject: Re: Device or HBA level QD throttling creates randomness in
> sequetial workload
>
> On 01/30/2017 09:30 AM, Bart Van Assche wrote:
> > On Mon, 2017-01-30 at 19:22 +0530, Kashyap Desai wrote:
> >> -   if (atomic_inc_return(&instance->fw_outstanding) >
> >> -           instance->host->can_queue) {
> >> -       atomic_dec(&instance->fw_outstanding);
> >> -       return SCSI_MLQUEUE_HOST_BUSY;
> >> -   }
> >> +   if (atomic_inc_return(&instance->fw_outstanding) >
safe_can_queue) {
> >> +       is_nonrot = blk_queue_nonrot(scmd->device->request_queue);
> >> +       /* For rotational device wait for sometime to get fusion
> >> + command
> >> from pool.
> >> +        * This is just to reduce proactive re-queue at mid layer
> >> + which is
> >> not
> >> +        * sending sorted IO in SCSI.MQ mode.
> >> +        */
> >> +       if (!is_nonrot)
> >> +           udelay(100);
> >> +   }
> >
> > The SCSI core does not allow to sleep inside the queuecommand()
> > callback function.
>
> udelay() is a busy loop, so it's not sleeping. That said, it's obviously
NOT a
> great idea. We want to fix the reordering due to requeues, not introduce
> random busy delays to work around it.

Thanks for feedback. I do realize that udelay() is going to be very odd
in queue_command call back.   I will keep this note. Preferred solution is
blk mq scheduler patches.
>
> --
> Jens Axboe
