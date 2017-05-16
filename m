Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170510082418.10513-3-linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org> <20170510082418.10513-3-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 May 2017 11:02:11 +0200
Message-ID: <CAPDyKFpdhu3FBe5OP2mR1-3EK0JFPojGKS1F2K_whzZ249Ue8Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: core: Allocate per-request data using the block
 layer core
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 10 May 2017 at 10:24, Linus Walleij <linus.walleij@linaro.org> wrote:
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
> Doing this make a lot of complicated queue handling go away. We only
> need to keep the .qnct that keeps count of how many request are
> currently being processed by the MMC layer. The MQ block layer will
> replace also this once we transition to it.
>
> Doing this refactoring is necessary to move the ioctl() operations
> into custom block layer requests tagged with REQ_OP_DRV_[IN|OUT]
> instead of the custom code using the BigMMCHostLock that we have
> today: those require that per-request data be obtainable easily from
> a request after creating a custom request with e.g.:
>
> struct request *rq = blk_get_request(q, REQ_OP_DRV_IN, __GFP_RECLAIM);
> struct mmc_queue_req *mq_rq = req_to_mq_rq(rq);
>
> And this is not possible with the current construction, as the request
> is not immediately assigned the per-request state container, but
> instead it gets assigned when the request finally enters the MMC
> queue, which is way too late for custom requests.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c |  38 ++------
>  drivers/mmc/core/queue.c | 222 +++++++++++++----------------------------------
>  drivers/mmc/core/queue.h |  22 ++---
>  include/linux/mmc/card.h |   2 -
>  4 files changed, 80 insertions(+), 204 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8273b078686d..be782b8d4a0d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c

[...]

> @@ -1662,7 +1655,7 @@ static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req,
>         if (mmc_card_removed(mq->card)) {
>                 req->rq_flags |= RQF_QUIET;
>                 blk_end_request_all(req, -EIO);
> -               mmc_queue_req_free(mq, mqrq);
> +               mq->qcnt--; /* FIXME: just set to 0? */

As mentioned below, perhaps this FIXME is fine to add. As I assume you
soon intend to take care of it, right?

[...]

> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 545466342fb1..65a8e0e63012 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c

[...]

> +/**
> + * mmc_init_request() - initialize the MMC-specific per-request data
> + * @q: the request queue
> + * @req: the request
> + * @gfp: memory allocation policy
> + */
> +static int mmc_init_request(struct request_queue *q, struct request *req,
> +                           gfp_t gfp)
>  {
> -       int i;
> +       struct mmc_queue_req *mq_rq = req_to_mq_rq(req);
> +       struct mmc_queue *mq = q->queuedata;
> +       struct mmc_card *card = mq->card;
> +       struct mmc_host *host = card->host;
>
> -       for (i = 0; i < qdepth; i++) {
> -               mqrq[i].sg = mmc_alloc_sg(max_segs);
> -               if (!mqrq[i].sg)
> +       /* FIXME: use req_to_mq_rq() everywhere this is dereferenced */

Why not do that right now, instead of adding a FIXME comment?

> +       mq_rq->req = req;
> +
> +       if (card->bouncesz) {
> +               mq_rq->bounce_buf = kmalloc(card->bouncesz, gfp);
> +               if (!mq_rq->bounce_buf)
> +                       return -ENOMEM;
> +               if (card->bouncesz > 512) {
> +                       mq_rq->sg = mmc_alloc_sg(1, gfp);
> +                       if (!mq_rq->sg)
> +                               return -ENOMEM;
> +                       mq_rq->bounce_sg = mmc_alloc_sg(card->bouncesz / 512,
> +                                                       gfp);
> +                       if (!mq_rq->bounce_sg)
> +                               return -ENOMEM;
> +               }
> +       } else {
> +               mq_rq->bounce_buf = NULL;
> +               mq_rq->bounce_sg = NULL;
> +               mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
> +               if (!mq_rq->sg)
>                         return -ENOMEM;
>         }
>
>         return 0;
>  }
>

[...]

> @@ -360,13 +248,21 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>                 limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
>
>         mq->card = card;
> -       mq->queue = blk_init_queue(mmc_request_fn, lock);
> +       mq->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);

Seems like we should use blk_alloc_queue() instead, as it calls
blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE) for us.

>         if (!mq->queue)
>                 return -ENOMEM;
> -
> -       mq->mqrq = card->mqrq;
> -       mq->qdepth = card->qdepth;
> +       mq->queue->queue_lock = lock;
> +       mq->queue->request_fn = mmc_request_fn;
> +       mq->queue->init_rq_fn = mmc_init_request;
> +       mq->queue->exit_rq_fn = mmc_exit_request;
> +       mq->queue->cmd_size = sizeof(struct mmc_queue_req);
>         mq->queue->queuedata = mq;
> +       mq->qcnt = 0;
> +       ret = blk_init_allocated_queue(mq->queue);
> +       if (ret) {
> +               blk_cleanup_queue(mq->queue);
> +               return ret;
> +       }
>
>         blk_queue_prep_rq(mq->queue, mmc_prep_request);
>         queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);

[...]

> @@ -421,8 +317,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>         q->queuedata = NULL;
>         blk_start_queue(q);
>         spin_unlock_irqrestore(q->queue_lock, flags);
> +       blk_cleanup_queue(mq->queue);
>
> -       mq->mqrq = NULL;
>         mq->card = NULL;
>  }
>  EXPORT_SYMBOL(mmc_cleanup_queue);
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 871796c3f406..8aa10ffdf622 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -3,9 +3,15 @@
>
>  #include <linux/types.h>
>  #include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/host.h>
>
> +static inline struct mmc_queue_req *req_to_mq_rq(struct request *rq)

To be more consistent with existing function names, perhaps rename this to:
req_to_mmc_queue_req()

> +{
> +       return blk_mq_rq_to_pdu(rq);
> +}
> +

[...]

>  struct mmc_queue {
> @@ -45,14 +50,15 @@ struct mmc_queue {
>         bool                    asleep;
>         struct mmc_blk_data     *blkdata;
>         struct request_queue    *queue;
> -       struct mmc_queue_req    *mqrq;
> -       int                     qdepth;
> +       /*
> +        * FIXME: this counter is not a very reliable way of keeping
> +        * track of how many requests that are ongoing. Switch to just
> +        * letting the block core keep track of requests and per-request
> +        * associated mmc_queue_req data.
> +        */
>         int                     qcnt;

I am not very fond of FIXME comments, however perhaps this one really
deserves to be a FIXME because you intend to fix this asap, right?

> -       unsigned long           qslots;
>  };
>

[...]

Besides my minor nitpicks, this is really an impressive cleanup!
Thanks for working on this.

Kind regards
Uffe
