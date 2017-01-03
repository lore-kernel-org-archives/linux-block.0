Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, Christoph Hellwig <hch@lst.de>, Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Wed, 04 Jan 2017 00:06:57 +0100
Message-ID: <3094495.7JvYrDVNM5@wuerfel>
In-Reply-To: <1C95E699-F2E5-4502-8A00-79CBEBD019EC@linaro.org>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org> <2740034.Ea571nGSEf@wuerfel> <1C95E699-F2E5-4502-8A00-79CBEBD019EC@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Tuesday, January 3, 2017 8:50:11 AM CET Paolo Valente wrote:
> 
> Sorry for the noise, but, assuming that an ignorant point of view
> might have some value, exactly because it ignores details, here is my
> point of view.  IMO the cleanest design would be the one where blk-mq
> does only the job it has been designed for, i.e., pushes requests into
> queues, and the driver takes care of the idiosyncrasies of the
> device.  Concretely, the driver could
> 1) advertise a long queue (e.g., 32) to be constantly fed with a
> large window of requests;
> 2) not pass requests immediately to the device, but keep them as long
> as needed, before finally handing them to the device.
> 
> The driver could then use the window of requests, internally queued, to
> perform exactly the operations that it now performs with the
> collaboration of blk, such as command packing.  blk-mq would be
> unchanged.  If I'm not mistaken, this would match, at least in part,
> what some of you already proposed in more detail.

I think we have to be careful not to trade latency in one place
for a bigger latency in another place.

Right now, the handoff between blk and mmc introduces an inherent
latency in some cases, and blk-mq was designed to avoid that by
allowing minimizing the number of cpu cycles between the file
system and the hardware, as well as minimizing the depth of the
queue on the software side.

Having the driver do its own queuing (as dasd and mmc both do
today) is worse for both of the above, since you need extra
context switches for a single I/O with an empty queue, while
a full queue can add a lot of latency that is out of reach of
the I/O scheduler: a high-priority request can be moved ahead
of the block queue, but cannot bypass anything that is already
in a driver-internal queue.

The tradeoff in both cases is that we can prepare (build a
dasd channel program, or have dma_map_sg manage cache and
iommu) a new request while waiting for the previous one,
reducing the latency between two requests being worked on
by the hardware on devices without hardware queuing.

We clearly want to have both benefits as much as possible,
and having a ->prepare() callback is probably better here
than a longer private queue in the device driver.

With the packed commands on MMC, we have a degenerated queue,
as we would sometimes submit multiple blk requests together
as one MMC command. Here, advertizing a longer queue as I
described earlier may be the best option.

	Arnd
