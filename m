Return-Path: <ecashin@gmail.com>
MIME-Version: 1.0
References: <20181011165909.32615-1-axboe@kernel.dk> <20181011165909.32615-15-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-15-axboe@kernel.dk>
From: Ed Cashin <ecashin@noserose.net>
Date: Fri, 12 Oct 2018 07:28:29 -0400
Message-ID: <CADvA-dnKCWSBZsmtnG=w_iAfU-aFxEq9oi_z_XV044648GYejA@mail.gmail.com>
Subject: Re: [PATCH 14/17] aoe: convert aoeblk to blk-mq
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

OK.  We always tried to avoid putting includes in the .h file, so
if you wouldn't mind moving the include to the C files, that would
be nice.  I wouldn't insist, though.

On Thu, Oct 11, 2018 at 12:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Straight forward conversion - instead of rewriting the internal buffer
> retrieval logic, just replace the previous elevator peeking with an
> internal list of requests.
>
> Cc: "Ed L. Cashin" <ed.cashin@acm.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/aoe/aoe.h    |  4 ++++
>  drivers/block/aoe/aoeblk.c | 49 ++++++++++++++++++++++++++++----------
>  drivers/block/aoe/aoecmd.c | 17 +++++++++----
>  drivers/block/aoe/aoedev.c | 14 ++++++-----
>  4 files changed, 60 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
> index c0ebda1283cc..9b9db29fe712 100644
> --- a/drivers/block/aoe/aoe.h
> +++ b/drivers/block/aoe/aoe.h
> @@ -1,4 +1,6 @@
>  /* Copyright (c) 2013 Coraid, Inc.  See COPYING for GPL terms. */
> +#include <linux/blk-mq.h>
> +
>  #define VERSION "85"
>  #define AOE_MAJOR 152
>  #define DEVICE_NAME "aoe"
> @@ -164,6 +166,8 @@ struct aoedev {
>         struct gendisk *gd;
>         struct dentry *debugfs;
>         struct request_queue *blkq;
> +       struct list_head rq_list;
> +       struct blk_mq_tag_set tag_set;
>         struct hd_geometry geo;
>         sector_t ssize;
>         struct timer_list timer;
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index 429ebb84b592..ba4afa0ce1c7 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -6,7 +6,7 @@
>
>  #include <linux/kernel.h>
>  #include <linux/hdreg.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/backing-dev.h>
>  #include <linux/fs.h>
>  #include <linux/ioctl.h>
> @@ -274,23 +274,25 @@ aoeblk_release(struct gendisk *disk, fmode_t mode)
>         spin_unlock_irqrestore(&d->lock, flags);
>  }
>
> -static void
> -aoeblk_request(struct request_queue *q)
> +static blk_status_t aoeblk_queue_rq(struct blk_mq_hw_ctx *hctx,
> +                                   const struct blk_mq_queue_data *bd)
>  {
> -       struct aoedev *d;
> -       struct request *rq;
> +       struct aoedev *d = hctx->queue->queuedata;
> +
> +       spin_lock_irq(&d->lock);
>
> -       d = q->queuedata;
>         if ((d->flags & DEVFL_UP) == 0) {
>                 pr_info_ratelimited("aoe: device %ld.%d is not up\n",
>                         d->aoemajor, d->aoeminor);
> -               while ((rq = blk_peek_request(q))) {
> -                       blk_start_request(rq);
> -                       aoe_end_request(d, rq, 1);
> -               }
> -               return;
> +               spin_unlock_irq(&d->lock);
> +               blk_mq_start_request(bd->rq);
> +               return BLK_STS_IOERR;
>         }
> +
> +       list_add_tail(&bd->rq->queuelist, &d->rq_list);
>         aoecmd_work(d);
> +       spin_unlock_irq(&d->lock);
> +       return BLK_STS_OK;
>  }
>
>  static int
> @@ -345,6 +347,10 @@ static const struct block_device_operations aoe_bdops = {
>         .owner = THIS_MODULE,
>  };
>
> +static const struct blk_mq_ops aoeblk_mq_ops = {
> +       .queue_rq       = aoeblk_queue_rq,
> +};
> +
>  /* alloc_disk and add_disk can sleep */
>  void
>  aoeblk_gdalloc(void *vp)
> @@ -353,9 +359,11 @@ aoeblk_gdalloc(void *vp)
>         struct gendisk *gd;
>         mempool_t *mp;
>         struct request_queue *q;
> +       struct blk_mq_tag_set *set;
>         enum { KB = 1024, MB = KB * KB, READ_AHEAD = 2 * MB, };
>         ulong flags;
>         int late = 0;
> +       int err;
>
>         spin_lock_irqsave(&d->lock, flags);
>         if (d->flags & DEVFL_GDALLOC
> @@ -382,10 +390,25 @@ aoeblk_gdalloc(void *vp)
>                         d->aoemajor, d->aoeminor);
>                 goto err_disk;
>         }
> -       q = blk_init_queue(aoeblk_request, &d->lock);
> -       if (q == NULL) {
> +
> +       set = &d->tag_set;
> +       set->ops = &aoeblk_mq_ops;
> +       set->nr_hw_queues = 1;
> +       set->queue_depth = 128;
> +       set->numa_node = NUMA_NO_NODE;
> +       set->flags = BLK_MQ_F_SHOULD_MERGE;
> +       err = blk_mq_alloc_tag_set(set);
> +       if (err) {
> +               pr_err("aoe: cannot allocate tag set for %ld.%d\n",
> +                       d->aoemajor, d->aoeminor);
> +               goto err_mempool;
> +       }
> +
> +       q = blk_mq_init_queue(set);
> +       if (IS_ERR(q)) {
>                 pr_err("aoe: cannot allocate block queue for %ld.%d\n",
>                         d->aoemajor, d->aoeminor);
> +               blk_mq_free_tag_set(set);
>                 goto err_mempool;
>         }
>
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index 136dc507d020..fce0fc1fa7bf 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -7,7 +7,7 @@
>  #include <linux/ata.h>
>  #include <linux/slab.h>
>  #include <linux/hdreg.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/genhd.h>
> @@ -857,10 +857,12 @@ nextbuf(struct aoedev *d)
>                 return d->ip.buf;
>         rq = d->ip.rq;
>         if (rq == NULL) {
> -               rq = blk_peek_request(q);
> +               rq = list_first_entry_or_null(&d->rq_list, struct request,
> +                                               queuelist);
>                 if (rq == NULL)
>                         return NULL;
> -               blk_start_request(rq);
> +               list_del_init(&rq->queuelist);
> +               blk_mq_start_request(rq);
>                 d->ip.rq = rq;
>                 d->ip.nxbio = rq->bio;
>                 rq->special = (void *) rqbiocnt(rq);
> @@ -1045,6 +1047,7 @@ aoe_end_request(struct aoedev *d, struct request *rq, int fastfail)
>         struct bio *bio;
>         int bok;
>         struct request_queue *q;
> +       blk_status_t err = BLK_STS_OK;
>
>         q = d->blkq;
>         if (rq == d->ip.rq)
> @@ -1052,11 +1055,15 @@ aoe_end_request(struct aoedev *d, struct request *rq, int fastfail)
>         do {
>                 bio = rq->bio;
>                 bok = !fastfail && !bio->bi_status;
> -       } while (__blk_end_request(rq, bok ? BLK_STS_OK : BLK_STS_IOERR, bio->bi_iter.bi_size));
> +               if (!bok)
> +                       err = BLK_STS_IOERR;
> +       } while (blk_update_request(rq, bok ? BLK_STS_OK : BLK_STS_IOERR, bio->bi_iter.bi_size));
> +
> +       __blk_mq_end_request(rq, err);
>
>         /* cf. http://lkml.org/lkml/2006/10/31/28 */
>         if (!fastfail)
> -               __blk_run_queue(q);
> +               blk_mq_run_hw_queues(q, true);
>  }
>
>  static void
> diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
> index 41060e9cedf2..96b420ddff3f 100644
> --- a/drivers/block/aoe/aoedev.c
> +++ b/drivers/block/aoe/aoedev.c
> @@ -5,7 +5,7 @@
>   */
>
>  #include <linux/hdreg.h>
> -#include <linux/blkdev.h>
> +#include <linux/blk-mq.h>
>  #include <linux/netdevice.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> @@ -197,7 +197,6 @@ aoedev_downdev(struct aoedev *d)
>  {
>         struct aoetgt *t, **tt, **te;
>         struct list_head *head, *pos, *nx;
> -       struct request *rq;
>         int i;
>
>         d->flags &= ~DEVFL_UP;
> @@ -225,10 +224,11 @@ aoedev_downdev(struct aoedev *d)
>
>         /* fast fail all pending I/O */
>         if (d->blkq) {
> -               while ((rq = blk_peek_request(d->blkq))) {
> -                       blk_start_request(rq);
> -                       aoe_end_request(d, rq, 1);
> -               }
> +               /* UP is cleared, freeze+quiesce to insure all are errored */
> +               blk_mq_freeze_queue(d->blkq);
> +               blk_mq_quiesce_queue(d->blkq);
> +               blk_mq_unquiesce_queue(d->blkq);
> +               blk_mq_unfreeze_queue(d->blkq);
>         }
>
>         if (d->gd)
> @@ -278,6 +278,7 @@ freedev(struct aoedev *d)
>                 aoedisk_rm_sysfs(d);
>                 del_gendisk(d->gd);
>                 put_disk(d->gd);
> +               blk_mq_free_tag_set(&d->tag_set);
>                 blk_cleanup_queue(d->blkq);
>         }
>         t = d->targets;
> @@ -464,6 +465,7 @@ aoedev_by_aoeaddr(ulong maj, int min, int do_alloc)
>         d->ntargets = NTARGETS;
>         INIT_WORK(&d->work, aoecmd_sleepwork);
>         spin_lock_init(&d->lock);
> +       INIT_LIST_HEAD(&d->rq_list);
>         skb_queue_head_init(&d->skbpool);
>         timer_setup(&d->timer, dummy_timer, 0);
>         d->timer.expires = jiffies + HZ;
> --
> 2.17.1
>


-- 
  Ed Cashin <ecashin@noserose.net>
