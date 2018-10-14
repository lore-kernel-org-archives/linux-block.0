Return-Path: <maximlevitsky@gmail.com>
MIME-Version: 1.0
References: <20181011165909.32615-1-axboe@kernel.dk> <20181011165909.32615-9-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-9-axboe@kernel.dk>
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Sun, 14 Oct 2018 09:30:58 +0300
Message-ID: <CACAwPwYiwmNwG9ijkbPLHT1UMY1qJ+TEFU2UNVu5+hB_0Km=bQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] ms_block: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi!

I haven't yet had  a chance to test this patch but I will do during this week.
Thanks!

Best regards,
       Maxim Levitsky


On Thu, Oct 11, 2018 at 7:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Straight forward conversion, room for optimization in how everything
> is punted to a work queue. Also looks plenty racy all over the map,
> with the state changes. I fixed a bunch of them up while doing the
> conversion, but there are surely more.
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/memstick/core/ms_block.c | 121 ++++++++++++++++++-------------
>  drivers/memstick/core/ms_block.h |   1 +
>  2 files changed, 73 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 716fc8ed31d3..b829f55ff577 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -15,7 +15,7 @@
>  #define pr_fmt(fmt) DRIVER_NAME ": " fmt
>
>  #include <linux/module.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/memstick.h>
>  #include <linux/idr.h>
>  #include <linux/hdreg.h>
> @@ -1873,69 +1873,65 @@ static void msb_io_work(struct work_struct *work)
>         struct msb_data *msb = container_of(work, struct msb_data, io_work);
>         int page, error, len;
>         sector_t lba;
> -       unsigned long flags;
>         struct scatterlist *sg = msb->prealloc_sg;
> +       struct request *req;
>
>         dbg_verbose("IO: work started");
>
>         while (1) {
> -               spin_lock_irqsave(&msb->q_lock, flags);
> +               spin_lock_irq(&msb->q_lock);
>
>                 if (msb->need_flush_cache) {
>                         msb->need_flush_cache = false;
> -                       spin_unlock_irqrestore(&msb->q_lock, flags);
> +                       spin_unlock_irq(&msb->q_lock);
>                         msb_cache_flush(msb);
>                         continue;
>                 }
>
> -               if (!msb->req) {
> -                       msb->req = blk_fetch_request(msb->queue);
> -                       if (!msb->req) {
> -                               dbg_verbose("IO: no more requests exiting");
> -                               spin_unlock_irqrestore(&msb->q_lock, flags);
> -                               return;
> -                       }
> +               req = msb->req;
> +               if (!req) {
> +                       dbg_verbose("IO: no more requests exiting");
> +                       spin_unlock_irq(&msb->q_lock);
> +                       return;
>                 }
>
> -               spin_unlock_irqrestore(&msb->q_lock, flags);
> -
> -               /* If card was removed meanwhile */
> -               if (!msb->req)
> -                       return;
> +               spin_unlock_irq(&msb->q_lock);
>
>                 /* process the request */
>                 dbg_verbose("IO: processing new request");
> -               blk_rq_map_sg(msb->queue, msb->req, sg);
> +               blk_rq_map_sg(msb->queue, req, sg);
>
> -               lba = blk_rq_pos(msb->req);
> +               lba = blk_rq_pos(req);
>
>                 sector_div(lba, msb->page_size / 512);
>                 page = sector_div(lba, msb->pages_in_block);
>
>                 if (rq_data_dir(msb->req) == READ)
>                         error = msb_do_read_request(msb, lba, page, sg,
> -                               blk_rq_bytes(msb->req), &len);
> +                               blk_rq_bytes(req), &len);
>                 else
>                         error = msb_do_write_request(msb, lba, page, sg,
> -                               blk_rq_bytes(msb->req), &len);
> +                               blk_rq_bytes(req), &len);
>
> -               spin_lock_irqsave(&msb->q_lock, flags);
> -
> -               if (len)
> -                       if (!__blk_end_request(msb->req, BLK_STS_OK, len))
> -                               msb->req = NULL;
> +               if (len && !blk_update_request(req, BLK_STS_OK, len)) {
> +                       __blk_mq_end_request(req, BLK_STS_OK);
> +                       spin_lock_irq(&msb->q_lock);
> +                       msb->req = NULL;
> +                       spin_unlock_irq(&msb->q_lock);
> +               }
>
>                 if (error && msb->req) {
>                         blk_status_t ret = errno_to_blk_status(error);
> +
>                         dbg_verbose("IO: ending one sector of the request with error");
> -                       if (!__blk_end_request(msb->req, ret, msb->page_size))
> -                               msb->req = NULL;
> +                       blk_mq_end_request(req, ret);
> +                       spin_lock_irq(&msb->q_lock);
> +                       msb->req = NULL;
> +                       spin_unlock_irq(&msb->q_lock);
>                 }
>
>                 if (msb->req)
>                         dbg_verbose("IO: request still pending");
> -
> -               spin_unlock_irqrestore(&msb->q_lock, flags);
>         }
>  }
>
> @@ -2002,29 +1998,40 @@ static int msb_bd_getgeo(struct block_device *bdev,
>         return 0;
>  }
>
> -static void msb_submit_req(struct request_queue *q)
> +static blk_status_t msb_queue_rq(struct blk_mq_hw_ctx *hctx,
> +                                const struct blk_mq_queue_data *bd)
>  {
> -       struct memstick_dev *card = q->queuedata;
> +       struct memstick_dev *card = hctx->queue->queuedata;
>         struct msb_data *msb = memstick_get_drvdata(card);
> -       struct request *req = NULL;
> +       struct request *req = bd->rq;
>
>         dbg_verbose("Submit request");
>
> +       spin_lock_irq(&msb->q_lock);
> +
>         if (msb->card_dead) {
>                 dbg("Refusing requests on removed card");
>
>                 WARN_ON(!msb->io_queue_stopped);
>
> -               while ((req = blk_fetch_request(q)) != NULL)
> -                       __blk_end_request_all(req, BLK_STS_IOERR);
> -               return;
> +               spin_unlock_irq(&msb->q_lock);
> +               blk_mq_start_request(req);
> +               return BLK_STS_IOERR;
>         }
>
> -       if (msb->req)
> -               return;
> +       if (msb->req) {
> +               spin_unlock_irq(&msb->q_lock);
> +               return BLK_STS_DEV_RESOURCE;
> +       }
> +
> +       blk_mq_start_request(req);
> +       msb->req = req;
>
>         if (!msb->io_queue_stopped)
>                 queue_work(msb->io_queue, &msb->io_work);
> +
> +       spin_unlock_irq(&msb->q_lock);
> +       return BLK_STS_OK;
>  }
>
>  static int msb_check_card(struct memstick_dev *card)
> @@ -2040,21 +2047,20 @@ static void msb_stop(struct memstick_dev *card)
>
>         dbg("Stopping all msblock IO");
>
> +       blk_mq_stop_hw_queues(msb->queue);
>         spin_lock_irqsave(&msb->q_lock, flags);
> -       blk_stop_queue(msb->queue);
>         msb->io_queue_stopped = true;
>         spin_unlock_irqrestore(&msb->q_lock, flags);
>
>         del_timer_sync(&msb->cache_flush_timer);
>         flush_workqueue(msb->io_queue);
>
> +       spin_lock_irqsave(&msb->q_lock, flags);
>         if (msb->req) {
> -               spin_lock_irqsave(&msb->q_lock, flags);
> -               blk_requeue_request(msb->queue, msb->req);
> +               blk_mq_requeue_request(msb->req, false);
>                 msb->req = NULL;
> -               spin_unlock_irqrestore(&msb->q_lock, flags);
>         }
> -
> +       spin_unlock_irqrestore(&msb->q_lock, flags);
>  }
>
>  static void msb_start(struct memstick_dev *card)
> @@ -2077,9 +2083,7 @@ static void msb_start(struct memstick_dev *card)
>         msb->need_flush_cache = true;
>         msb->io_queue_stopped = false;
>
> -       spin_lock_irqsave(&msb->q_lock, flags);
> -       blk_start_queue(msb->queue);
> -       spin_unlock_irqrestore(&msb->q_lock, flags);
> +       blk_mq_start_hw_queues(msb->queue);
>
>         queue_work(msb->io_queue, &msb->io_work);
>
> @@ -2092,10 +2096,15 @@ static const struct block_device_operations msb_bdops = {
>         .owner   = THIS_MODULE
>  };
>
> +static const struct blk_mq_ops msb_mq_ops = {
> +       .queue_rq       = msb_queue_rq,
> +};
> +
>  /* Registers the block device */
>  static int msb_init_disk(struct memstick_dev *card)
>  {
>         struct msb_data *msb = memstick_get_drvdata(card);
> +       struct blk_mq_tag_set *set = NULL;
>         int rc;
>         unsigned long capacity;
>
> @@ -2112,10 +2121,21 @@ static int msb_init_disk(struct memstick_dev *card)
>                 goto out_release_id;
>         }
>
> -       msb->queue = blk_init_queue(msb_submit_req, &msb->q_lock);
> -       if (!msb->queue) {
> -               rc = -ENOMEM;
> +       set = &msb->tag_set;
> +       set->ops = &msb_mq_ops;
> +       set->nr_hw_queues = 1;
> +       set->queue_depth = 2;
> +       set->numa_node = NUMA_NO_NODE;
> +       set->flags = BLK_MQ_F_SHOULD_MERGE;
> +       rc = blk_mq_alloc_tag_set(set);
> +       if (rc)
>                 goto out_put_disk;
> +
> +       msb->queue = blk_mq_init_queue(set);
> +       if (IS_ERR(msb->queue)) {
> +               rc = PTR_ERR(msb->queue);
> +               msb->queue = NULL;
> +               goto out_put_tag;
>         }
>
>         msb->queue->queuedata = card;
> @@ -2150,6 +2170,8 @@ static int msb_init_disk(struct memstick_dev *card)
>         dbg("Disk added");
>         return 0;
>
> +out_put_tag:
> +       blk_mq_free_tag_set(&msb->tag_set);
>  out_put_disk:
>         put_disk(msb->disk);
>  out_release_id:
> @@ -2202,11 +2224,12 @@ static void msb_remove(struct memstick_dev *card)
>         /* Take care of unhandled + new requests from now on */
>         spin_lock_irqsave(&msb->q_lock, flags);
>         msb->card_dead = true;
> -       blk_start_queue(msb->queue);
>         spin_unlock_irqrestore(&msb->q_lock, flags);
> +       blk_mq_start_hw_queues(msb->queue);
>
>         /* Remove the disk */
>         del_gendisk(msb->disk);
> +       blk_mq_free_tag_set(msb->queue->tag_set);
>         blk_cleanup_queue(msb->queue);
>         msb->queue = NULL;
>
> diff --git a/drivers/memstick/core/ms_block.h b/drivers/memstick/core/ms_block.h
> index 53962c3b21df..9ba84e0ced63 100644
> --- a/drivers/memstick/core/ms_block.h
> +++ b/drivers/memstick/core/ms_block.h
> @@ -152,6 +152,7 @@ struct msb_data {
>         struct gendisk                  *disk;
>         struct request_queue            *queue;
>         spinlock_t                      q_lock;
> +       struct blk_mq_tag_set           tag_set;
>         struct hd_geometry              geometry;
>         struct attribute_group          attr_group;
>         struct request                  *req;
> --
> 2.17.1
>
