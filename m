Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <135cb4af-fbbe-d6a7-182b-73543f1c551a@intel.com>
References: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org>
 <2697103.lML87IM8sj@wuerfel> <d0722644-2922-b580-9bfe-01dd3c38ec67@intel.com>
 <CAPDyKFrW+Jge-Kd=PhRJvHG1Y==MMYinXxgHM1ySSG8gOx3tyA@mail.gmail.com> <135cb4af-fbbe-d6a7-182b-73543f1c551a@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Nov 2016 16:27:59 +0100
Message-ID: <CACRpkdarRZkv2f_FCpEJ7+teQB7dDtHiXFeN3wU8wfG8dx0cJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: delete packed command support
To: Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-mmc <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
	Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>,
	Luca Porzio <lporzio@micron.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

[CC the block layer maintainers so they can smack my fingers
if I misunderstood any of how the block layer semantics work...]

On Mon, Nov 21, 2016 at 3:17 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 21/11/16 16:02, Ulf Hansson wrote:

>> I also believe, the implementation would become really complex, as you
>> would need to "hold" the first write request, while waiting for a
>> second to arrive. Then for how long shall you hold it? And then what
>> if you are unlucky so the next is read request, thus you can't pack
>> them. The solution will be suboptimal, won't it?
>
> It doesn't hold and wait now.  So why would it in the blk-mq case?

The current kthread in drivers/mmc/card/queue.c looks like this
in essence:

struct request *r;

while (1)
    r = blk_fetch_request(q);
    issue();
}

It is pulling out as much as it can to asynchronously issue
two requests in parallel and also the packed command (as
mentioned in the commitlog to $SUBJECT) pulls out even more
stuff of the queue to speculatively issue things in a packed
command.

The block layer isn't supposed to be used like this. It is
supposed to be used like so:

1. You get notified by the request_fn that is passed with
   blk_init_queue()
2. The request function fires a work.
3. The work pick ONE request with blk_fetch_request()
  and handles it.
4. Repeat from (1)

Instead of doing this the MMC layer kthread is speculatively
pulling out stuff of the queue whenever it can, including
pulling out a few NULL at the end before it stops. The
mechanism is similar to a person running along a queue and
picking a segment of passengers into a bus to send off,
batching them. Which is clever, but the block layer is not
supposed to be used like that. It just happens to work.

In blk-mq this speculative fetching is no longer possible.
Instead you register a notification function in struct blk_mq_ops
vtable .queue_rq() callback: this will be called by the block
layer core whenever there is a request available on "our"
queue. It further approves a .init_request() callback that is
called overhead to allocate a per-request context, such as
the current struct mmc_queue_req - just not quite because
the current mmc_queue_req is not mapped 1-to-1 onto a
request from the block layer because of packed command;
but it is after this patch, hehe ;)

Any speculative batching needs to happen *after* this, i.e.
the MMC layer would have to report a certain larger queue
depth (if you set it to 1 you only ever get one request at the time
and have to finish it before you get a new one), group the
requests itself with packed command or command queueing,
then signal them back as they are confirmed completed by
the device, or, if they cannot be grouped, handle as far as you
can and put the remaining requests back on the queue
(creating a "bubble" in the pipeline).

Relying on iterating and inspecting the block layer queue is
*not* possible with blk-mq, sure blk_fetch_request() is still
there, but if you call it on an mq-registered queue, it will
crash the kernel. (At least it did for me.) Clearly it is not
intended to be used with MQ: none of the MQ-converted
subsystems use this. (drivers/mtd/ubi/block.c is a good
simple example)

I liken these mechanisms to a pipeline:

- The two-levels deep speculation buffer in struct mmc_queue
  field .mqrq[2] is a "software pipeline" in the MMC layer (so we
  can prepare and handle requests in parallel)

- The packed command and command queue is a
  hardware-supported pipeline on the device side.

Both try to overcome the hardware limitations of the MMC/SD
logical interface. This batching-style pipelining isn't really
solving the problem the way real multiqueue hardware does,
so it is a poor man's patchwork to the problem.

In either case, as Ulf notes, you need to get a few requests
off the queue and group them using packed command or
command queueing if possible, but that grouping needs to
happen in the MMC/SD layer, after picking the requests from
the queue. I think it is OK to do so and just put any requests
you cannot pack into the pipeline back on the queue. But I
am not sure (still learning....)

Yours,
Linus Walleij
