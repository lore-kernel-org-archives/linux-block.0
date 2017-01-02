Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Christoph Hellwig <hch@lst.de>, Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Mon, 02 Jan 2017 18:08:10 +0100
Message-ID: <2740034.Ea571nGSEf@wuerfel>
In-Reply-To: <68863f25-7faa-88b5-78bb-21027f772ab6@suse.de>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org> <2360959.cyJgAELf50@wuerfel> <68863f25-7faa-88b5-78bb-21027f772ab6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Monday, January 2, 2017 12:06:04 PM CET Hannes Reinecke wrote:
> On 01/02/2017 10:40 AM, Arnd Bergmann wrote:
> > b) without MMC CMDQ support:
> >   - report queue depth of '2'
> >   - first request gets handled as above
> >   - if one request is pending, prepare the second request and
> >     add a pointer to the mmc host structure (not that different
> >     from what we do today)
> >   - when the host driver completes a request, have it immediately
> >     issue the next one from the interrupt handler. In case we need
> >     to sleep here, use a threaded IRQ, or a workqueue. This should
> >     avoid the need for the NULL requests
> > 
> > c) possible optimization for command packing without CMDQ:
> >    - similar to b)
> >    - report a longer queue (e.g. 8, maybe user selectable, to
> >      balance throughput against latency)
> >    - any request of the same type (read or write) as the one that
> >      is currently added to the host as the 'next' one can be
> >      added to that request so they get issued together
> >    - if the types are different, report the queue to be busy
> > 
> Hmm. But that would amount to implement yet another queuing mechanism
> within the driver/mmc subsystem, wouldn't it?
> 
> Which is, incidentally, the same method the S/390 DASD driver uses
> nowadays; report an arbitrary queue depth to the block layer and queue
> all requests internally to better saturate the device.
> 
> However I'd really like to get rid of this, and tweak the block layer to
> handle these cases.
> 
> One idea I had was to use a 'prep' function for mq; it would be executed
> once the request is added to the queue.
> Key point here is that 'prep' and 'queue_rq' would be two distinct
> steps; the driver could do all required setup functionality during
> 'prep', and then do the actual submission via 'queue_rq'.

Right, I had the same idea and I think even talked to you about that.
I think this would address case 'b)' above perfectly, but I don't
see how we can fit case 'c)' in that scheme.

Maybe if we could teach blk_mq that a device might be able to not
just merge consecutive requests but also a limited set of
non-consecutive requests in a way that MMC needs them? Unfortunately,
the 'packed command' is rather MMC specific, and it might even
be worthwhile to do some optimization regarding what commands
get packed (e.g. only writes, only small requests, or only up to
a total size).

While there are some parallels to DASD, but it's not completely
the same, even if we ignore the command packing.

- MMC wants the 'prepare' stage to reduce the latency from
  dma_map_sg() calls. This is actually more related to the
  CPU/SoC architecture and really important on most ARM systems
  as they are not cache coherent, but it's not just specific
  to MMC other than MMC performance on low-end ARM being
  really important to a lot of people since it's used in all
  Android phones.
  If we could find a way to get blk_mq to call blk_rq_map_sg()
  for us, we wouldn't need a ->prepare() step or a fake queue
  for case 'b)', and we could make use of that in other drivers
  too.

- DASD in contrast wants to build the channel programs while
  other I/O is running, and this is very specific to that
  driver. There are probably some other things it does in its
  own queue implementation that are also driver specific.

> That would allow to better distribute the load for timing-sensitive
> devices, and with a bit of luck remove the need for a separate queuing
> inside the driver.
> 
> In any case, it looks like a proper subject for LSF/MM...
> Linus? Arnd? Are you up for it?

I'm probably not going to work on it myself, but I think it would
be great for Linus and/or Ulf to bring this up at LSF/MM.

	Arnd
