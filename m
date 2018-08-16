Return-Path: <ming.lei@redhat.com>
Date: Thu, 16 Aug 2018 17:38:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@linux.intel.com>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with
 part_in_flight
Message-ID: <20180816093850.GB7144@ming.t460p>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVO+g2ACx9XYx4XtwRkpSC9bCYeSFEj07Z==6r7nT-HxkQ@mail.gmail.com>
 <8cd103e6-0986-2c45-00f2-8a2a540a2eb5@oracle.com>
 <20180816090334.GA7144@ming.t460p>
 <f3fad2f5-9ab5-438a-d5a6-93c637921378@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <f3fad2f5-9ab5-438a-d5a6-93c637921378@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 16, 2018 at 05:20:50PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 08/16/2018 05:03 PM, Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index b42a2c9ba00e..fbc5534f8178 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -113,6 +113,10 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
> >  	struct mq_inflight mi = { .part = part, .inflight = inflight, };
> >  
> >  	inflight[0] = inflight[1] = 0;
> > +
> > +	if (percpu_ref_is_dying(&q->q_usage_counter))
> > +		return;
> > +
> >  	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> >  }
> 
> That's a good idea to use q->q_usage_counter.
> But I think we could do following modification:
> 1. use percpu_ref_is_zero, then we will not miss any in-flight request here.
> 2. use rcu to ensure the user of blk_mq_in_flight has gone out of the critical section.
> Like following patch:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 89904cc..cd9878e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -113,7 +113,12 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>  
>         inflight[0] = inflight[1] = 0;
>  
> +       rcu_read_lock();
> +       if (percpu_ref_is_zero(&q->q_usage_counter))
> +               return;
> +
>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
> +       rcu_read_unlock();
>  }
>  
>  static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
> @@ -2907,6 +2912,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>         list_for_each_entry(q, &set->tag_list, tag_set_list)
>                 blk_mq_freeze_queue(q);
>  
> +       synchronize_rcu();
>         /*
>          * switch io scheduler to NULL to clean up the data in it.
>          * will get it back after update mapping between cpu and hw queues.
> 
> And also, some comment is needed to describe them. ；）

This patch looks fine for me.

Thanks
Ming
