Return-Path: <ming.lei@redhat.com>
Date: Mon, 3 Jul 2017 17:40:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe induced NULL deref in bt_iter()
Message-ID: <20170703093951.GA28651@ming.t460p>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jul 02, 2017 at 02:56:56PM +0300, Sagi Grimberg wrote:
> 
> 
> On 02/07/17 13:45, Max Gurtovoy wrote:
> > 
> > 
> > On 6/30/2017 8:26 PM, Jens Axboe wrote:
> > > Hi Max,
> > 
> > Hi Jens,
> > 
> > > 
> > > I remembered you reporting this. I think this is a regression introduced
> > > with the scheduling, since ->rqs[] isn't static anymore. ->static_rqs[]
> > > is, but that's not indexable by the tag we find. So I think we need to
> > > guard those with a NULL check. The actual requests themselves are
> > > static, so we know the memory itself isn't going away. But if we race
> > > with completion, we could find a NULL there, validly.
> > > 
> > > Since you could reproduce it, can you try the below?
> > 
> > I still can repro the null deref with this patch applied.
> > 
> > > 
> > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > index d0be72ccb091..b856b2827157 100644
> > > --- a/block/blk-mq-tag.c
> > > +++ b/block/blk-mq-tag.c
> > > @@ -214,7 +214,7 @@ static bool bt_iter(struct sbitmap *bitmap,
> > > unsigned int bitnr, void *data)
> > >          bitnr += tags->nr_reserved_tags;
> > >      rq = tags->rqs[bitnr];
> > > 
> > > -    if (rq->q == hctx->queue)
> > > +    if (rq && rq->q == hctx->queue)
> > >          iter_data->fn(hctx, rq, iter_data->data, reserved);
> > >      return true;
> > >  }
> > > @@ -249,8 +249,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap,
> > > unsigned int bitnr, void *data)
> > >      if (!reserved)
> > >          bitnr += tags->nr_reserved_tags;
> > >      rq = tags->rqs[bitnr];
> > > -
> > > -    iter_data->fn(rq, iter_data->data, reserved);
> > > +    if (rq)
> > > +        iter_data->fn(rq, iter_data->data, reserved);
> > >      return true;
> > >  }
> > 
> > see the attached file for dmesg output.
> > 
> > output of gdb:
> > 
> > (gdb) list *(blk_mq_flush_busy_ctxs+0x48)
> > 0xffffffff8127b108 is in blk_mq_flush_busy_ctxs
> > (./include/linux/sbitmap.h:234).
> > 229
> > 230             for (i = 0; i < sb->map_nr; i++) {
> > 231                     struct sbitmap_word *word = &sb->map[i];
> > 232                     unsigned int off, nr;
> > 233
> > 234                     if (!word->word)
> > 235                             continue;
> > 236
> > 237                     nr = 0;
> > 238                     off = i << sb->shift;
> > 
> > 
> > when I change the "if (!word->word)" to  "if (word && !word->word)"
> > I can get null deref at "nr = find_next_bit(&word->word, word->depth,
> > nr);". Seems like somehow word becomes NULL.
> > 
> > Adding the linux-nvme guys too.
> > Sagi has mentioned that this can be null only if we remove the tagset
> > while I/O is trying to get a tag and when killing the target we get into
> > error recovery and periodic reconnects, which does _NOT_ include freeing
> > the tagset, so this is probably the admin tagset.
> > 
> > Sagi,
> > you've mention a patch for centrelizing the treatment of the admin
> > tagset to the nvme core. I think I missed this patch, so can you please
> > send a pointer to it and I'll check if it helps ?
> 
> Hmm,
> 
> In the above flow we should not be freeing the tag_set, not on admin as
> well. The target keep removing namespaces and finally removes the
> subsystem which generates a error recovery flow. What we at least try
> to do is:
> 
> 1. mark rdma queues as not live
> 2. stop all the sw queues (admin and io)
> 3. fail inflight I/Os
> 4. restart all sw queues (to fast fail until we recover)
> 
> We shouldn't be freeing the tagsets (although we might update them
> when we recover and cpu map changed - which I don't think is happening).
> 
> However, I do see a difference between bt_tags_for_each
> and blk_mq_flush_busy_ctxs (checks tags->rqs not being NULL).
> 
> Unrelated to this I think we should quiesce/unquiesce the admin_q
> instead of stop/start because it respects the submission path rcu [1].
> 
> It might hide the issue, but given that we never free the tagset its
> seems like it's not in nvme-rdma (max, can you see if this makes the
> issue go away?)
> 
> [1]:
> --
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index e3996db22738..094873a4ee38 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -785,7 +785,7 @@ static void nvme_rdma_error_recovery_work(struct
> work_struct *work)
> 
>         if (ctrl->ctrl.queue_count > 1)
>                 nvme_stop_queues(&ctrl->ctrl);
> -       blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +       blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> 
>         /* We must take care of fastfail/requeue all our inflight requests
> */
>         if (ctrl->ctrl.queue_count > 1)
> @@ -798,7 +798,8 @@ static void nvme_rdma_error_recovery_work(struct
> work_struct *work)
>          * queues are not a live anymore, so restart the queues to fail fast
>          * new IO
>          */
> -       blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> +       blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +       blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);
>         nvme_start_queues(&ctrl->ctrl);
> 
>         nvme_rdma_reconnect_or_remove(ctrl);
> @@ -1651,7 +1652,7 @@ static void nvme_rdma_shutdown_ctrl(struct
> nvme_rdma_ctrl *ctrl)
>         if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
>                 nvme_shutdown_ctrl(&ctrl->ctrl);
> 
> -       blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +       blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>         blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>                                 nvme_cancel_request, &ctrl->ctrl);
>         nvme_rdma_destroy_admin_queue(ctrl);

Yeah, the above change is correct, for any canceling requests in this
way we should use blk_mq_quiesce_queue().

Thanks,
Ming
