Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org, Linux-Kernal <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
Date: Fri, 28 Oct 2016 18:05:35 +0200
Message-ID: <2423164.8ioLhGisxr@wuerfel>
In-Reply-To: <3d0b38bb-537d-94ff-574f-587bad949fdd@kernel.dk>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org> <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com> <3d0b38bb-537d-94ff-574f-587bad949fdd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Friday, October 28, 2016 9:30:07 AM CEST Jens Axboe wrote:
> On 10/28/2016 03:32 AM, Linus Walleij wrote:
> > The patch to enable MQ looks like this:
> > https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/commit/?h=mmc-mq&id=8f79b527e2e854071d8da019451da68d4753f71d
> 
> BTW, another viable "hack" for the depth issue would be to expose more
> than one hardware queue. It's meant to map to a distinct submission
> region in the hardware, but there's nothing stopping the driver from
> using it differently. Might not be cleaner than just increasing the
> queue depth on a single queue, though.
> 
> That still won't solve the issue of lying about it and causing IO
> scheduler confusion, of course.
> 
> Also, 4.8 and newer have support for BLK_MQ_F_BLOCKING, if you need to
> block in ->queue_rq(). That could eliminate the need to offload to a
> kthread manually.

I think the main reason for the kthread is that on ARM and other
architectures, the dma mapping operations are fairly slow (for
cache flushes or bounce buffering) and we want to minimize the
time between subsequent requests being handled by the hardware.

This is not unique to MMC in any way, MMC just happens to be
common on ARM and it is limited by its lack of hardware
command queuing.
It would be nice to do a similar trick for SCSI disks,
especially USB mass storage, maybe also SATA, which are the
next most common storage devices on non-coherent ARM systems
(SATA nowadays often comes with NCQ, so it's less of an
issue)

It may be reasonable to tie this in with the I/O scheduler:
if you don't have a scheduler, the access to the device is
probably rather direct and you want to avoid any complexity
in the kernel, but if preparing a request is expensive
and the hardware has no queuing, you probably also want to
use a scheduler.

We should probably also try to understand how this could
work out with USB mass storage, if there is a solution at
all, and then do it for MMC in a way that would work on
both. I don't think the USB core can currently split the
dma_map_sg() operation from the USB command submission,
so this may require some deeper surgery there.

	Arnd
