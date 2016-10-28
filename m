Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
 Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
Date: Fri, 28 Oct 2016 17:58:28 +0200
Message-id: <5195251.eZ8ecTlAWj@amdc3058>
In-reply-to: <3d0b38bb-537d-94ff-574f-587bad949fdd@kernel.dk>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <CGME20161028153016eucas1p24f605c27935e86818c45b2eb13d11d59@eucas1p2.samsung.com>
 <3d0b38bb-537d-94ff-574f-587bad949fdd@kernel.dk>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>


Hi,

On Friday, October 28, 2016 09:30:07 AM Jens Axboe wrote:
> On 10/28/2016 03:32 AM, Linus Walleij wrote:
> > The patch to enable MQ looks like this:
> > https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/commit/?h=mmc-mq&id=8f79b527e2e854071d8da019451da68d4753f71d
> 
> BTW, another viable "hack" for the depth issue would be to expose more
> than one hardware queue. It's meant to map to a distinct submission
> region in the hardware, but there's nothing stopping the driver from
> using it differently. Might not be cleaner than just increasing the
> queue depth on a single queue, though.

Yes, I'm already considering this for rewritten version of my
patch set as it may also help with performance when compared to
non blk-mq case.

Significant amount of time is spent on DMA map/unmap operations
on ARM MMC hosts and I would like to do these DMA (un)mapping-s
in parallel for two (or more) requests to check whether it helps
the performance (hopefully the cache controller doesn't serialize
these operations).

BTW I'm following the discussion and still would like to help with
getting blk-mq work for MMC.  I'm just quite busy with other things
at the moment.

> That still won't solve the issue of lying about it and causing IO
> scheduler confusion, of course.
> 
> Also, 4.8 and newer have support for BLK_MQ_F_BLOCKING, if you need to
> block in ->queue_rq(). That could eliminate the need to offload to a
> kthread manually.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
