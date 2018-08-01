Return-Path: <ming.lei@redhat.com>
Date: Wed, 1 Aug 2018 16:58:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180801085841.GA27962@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 01, 2018 at 10:17:30AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> Thanks for your kindly response.
> 
> On 07/31/2018 02:16 PM, Ming Lei wrote:
> > On Tue, Jul 31, 2018 at 01:19:42PM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> On 07/31/2018 12:58 PM, Ming Lei wrote:
> >>> On Tue, Jul 31, 2018 at 12:02:15PM +0800, Jianchao Wang wrote:
> >>>> Currently, we will always set SCHED_RESTART whenever there are
> >>>> requests in hctx->dispatch, then when request is completed and
> >>>> freed the hctx queues will be restarted to avoid IO hang. This
> >>>> is unnecessary most of time. Especially when there are lots of
> >>>> LUNs attached to one host, the RR restart loop could be very
> >>>> expensive.
> >>>
> >>> The big RR restart loop has been killed in the following commit:
> >>>
> >>> commit 97889f9ac24f8d2fc8e703ea7f80c162bab10d4d
> >>> Author: Ming Lei <ming.lei@redhat.com>
> >>> Date:   Mon Jun 25 19:31:48 2018 +0800
> >>>
> >>>     blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
> >>>
> >>>
> >>
> >> Oh, sorry, I didn't look into this patch due to its title when iterated the mail list,
> >> therefore I didn't realize the RR restart loop has already been killed. :)
> >>
> >> The RR restart loop could ensure the fairness of sharing some LLDD resource,
> >> not just avoid IO hung. Is it OK to kill it totally ?
> > 
> > Yeah, it is, also the fairness might be improved a bit by the way in
> > commit 97889f9ac24f8d2fc, especially inside driver tag allocation
> > algorithem.
> > 
> 
> Would you mind to detail more here ?
> 
> Regarding the driver tag case:
> For example:
> 
> q_a         q_b        q_c       q_d
> hctx0       hctx0      hctx0     hctx0
> 
>                  tags
> 
> Total number of tags is 32
> All of these 4 q are active.
> 
> So every q has 8 tags.
> 
> If all of these 4 q have used up their 8 tags, they have to wait.
> 
> When part of the in-flight requests q_a are completed, tags are freed.
> but the __sbq_wake_up doesn't wake up the q_a, it may wake up q_b.

1) in case of IO scheduler
q_a should be waken up because q_a->hctx0 is added to one wq of the tags if
no tag is available, see blk_mq_mark_tag_wait().

2) in case of none scheduler
q_a should be waken up too, see blk_mq_get_tag().

So I don't understand why you mentioned that q_a can't be waken up.

> However, due to the limits in hctx_may_queue, q_b still cannot get the
> tags. The RR restart also will not wake up q_a.
> This is unfair for q_a.
> 
> When we remove RR restart fashion, at least, the q_a will be waked up by
> the hctx restart.
> Is this the improvement of fairness you said in driver tag allocation ?

I mean the fairness is totally covered by the general tag allocation
algorithm now, which is sort of FIFO style because of waitqueue, but RR
restart wakes up queue in the order of request queue.

> 
> Think further, it seems that it only works for case with io scheduler.
> w/o io scheduler, tasks will wait in blk_mq_get_request. restart hctx will
> not work there.

When one tag is freed, the sbitmap queue will be waken up, then some of
allocation may be satisfied, this way works for both IO sched and none.

Thanks, 
Ming
