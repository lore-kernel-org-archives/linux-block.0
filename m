Return-Path: <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/5] mmc: core: Allocate per-request data using the block
 layer core
To: Linus Walleij <linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-3-linus.walleij@linaro.org>
 <f432dc3d-f66a-fcfe-fd8f-ac764b29c9db@intel.com>
 <CACRpkdaZuyZNDV=bjy2maZ0HYMEZCkNctkbEivThNM4jDT_c8Q@mail.gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Paolo Valente <paolo.valente@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <eb50dffe-5cb9-d8d3-e218-399de512b074@intel.com>
Date: Thu, 18 May 2017 15:42:21 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdaZuyZNDV=bjy2maZ0HYMEZCkNctkbEivThNM4jDT_c8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 18/05/17 11:21, Linus Walleij wrote:
> On Tue, May 16, 2017 at 1:54 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 10/05/17 11:24, Linus Walleij wrote:
>>> The mmc_queue_req is a per-request state container the MMC core uses
>>> to carry bounce buffers, pointers to asynchronous requests and so on.
>>> Currently allocated as a static array of objects, then as a request
>>> comes in, a mmc_queue_req is assigned to it, and used during the
>>> lifetime of the request.
>>>
>>> This is backwards compared to how other block layer drivers work:
>>> they usally let the block core provide a per-request struct that get
>>> allocated right beind the struct request, and which can be obtained
>>> using the blk_mq_rq_to_pdu() helper. (The _mq_ infix in this function
>>> name is misleading: it is used by both the old and the MQ block
>>> layer.)
>>>
>>> The per-request struct gets allocated to the size stored in the queue
>>> variable .cmd_size initialized using the .init_rq_fn() and
>>> cleaned up using .exit_rq_fn().
>>>
>>> The block layer code makes the MMC core rely on this mechanism to
>>> allocate the per-request mmc_queue_req state container.
>>>
>>> Doing this make a lot of complicated queue handling go away.
>>
>> Isn't that at the expense of increased memory allocation.
>>
>> Have you compared the number of allocations?  It looks to me like the block
>> layer allocates a minimum of 4 requests in the memory pool which will
>> increase if there are more in the I/O scheduler, plus 1 for flush.  There
>> are often 4 queues per eMMC (2x boot,RPMB and main area), so that is 20
>> requests minimum, up from 2 allocations previously.  For someone using 64K
>> bounce buffers, you have increased memory allocation by at least 18x64 =
>> 1152k.  However the I/O scheduler could allocate a lot more.
> 
> That is not a realistic example.
> 
> As pointed out in patch #1, bounce buffers are used on old systems
> which have max_segs == 1. No modern hardware has that,
> they all have multiple segments-capable host controllers and
> often also DMA engines.
> 
> Old systems with max_segs == 1 also have:
> 
> - One SD or MMC slot
> - No eMMC (because it was not yet invented in those times)
> - So no RPMB or Boot partitions, just main area
> 
> If you can point me to a system that has max_segs == 1 and an
> eMMC mounted, I can look into it and ask the driver maintainers to
> check if it disturbs them, but I think those simply do not exist.
> 
>>> Doing this refactoring is necessary to move the ioctl() operations
>>> into custom block layer requests tagged with REQ_OP_DRV_[IN|OUT]
>>
>> Obviously you could create a per-request data structure with only the
>> reference to the IOCTL data, and without putting all the memory allocations
>> there as well.
> 
> Not easily, and this is the way all IDE, ATA, SCSI disks etc are
> doing this so why would be try to be different and maintain a lot
> of deviant code.
> 
> The allocation of extra data is done by the block layer when issueing
> blk_get_request() so trying to keep the old mechanism of a list of
> struct mmc_queue_req and trying to pair these with incoming requests
> inevitably means a lot of extra work, possibly deepening that list or
> creating out-of-list extra entries and whatnot.
> 
> It's better to do what everyone else does and let the core do this
> allocation of extra data (tag) instead.

I agree it is much nicer, but the extra bounce buffer allocations still seem
gratuitous.  Maybe we should allocate them as needed from a memory pool,
instead of for every request.
