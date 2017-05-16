Return-Path: <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/5] mmc: core: Allocate per-request data using the block
 layer core
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-3-linus.walleij@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Paolo Valente <paolo.valente@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <f432dc3d-f66a-fcfe-fd8f-ac764b29c9db@intel.com>
Date: Tue, 16 May 2017 14:54:20 +0300
MIME-Version: 1.0
In-Reply-To: <20170510082418.10513-3-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 10/05/17 11:24, Linus Walleij wrote:
> The mmc_queue_req is a per-request state container the MMC core uses
> to carry bounce buffers, pointers to asynchronous requests and so on.
> Currently allocated as a static array of objects, then as a request
> comes in, a mmc_queue_req is assigned to it, and used during the
> lifetime of the request.
> 
> This is backwards compared to how other block layer drivers work:
> they usally let the block core provide a per-request struct that get
> allocated right beind the struct request, and which can be obtained
> using the blk_mq_rq_to_pdu() helper. (The _mq_ infix in this function
> name is misleading: it is used by both the old and the MQ block
> layer.)
> 
> The per-request struct gets allocated to the size stored in the queue
> variable .cmd_size initialized using the .init_rq_fn() and
> cleaned up using .exit_rq_fn().
> 
> The block layer code makes the MMC core rely on this mechanism to
> allocate the per-request mmc_queue_req state container.
> 
> Doing this make a lot of complicated queue handling go away.

Isn't that at the expense of increased memory allocation.

Have you compared the number of allocations?  It looks to me like the block
layer allocates a minimum of 4 requests in the memory pool which will
increase if there are more in the I/O scheduler, plus 1 for flush.  There
are often 4 queues per eMMC (2x boot,RPMB and main area), so that is 20
requests minimum, up from 2 allocations previously.  For someone using 64K
bounce buffers, you have increased memory allocation by at least 18x64 =
1152k.  However the I/O scheduler could allocate a lot more.

> Doing this refactoring is necessary to move the ioctl() operations
> into custom block layer requests tagged with REQ_OP_DRV_[IN|OUT]

Obviously you could create a per-request data structure with only the
reference to the IOCTL data, and without putting all the memory allocations
there as well.
