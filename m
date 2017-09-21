Return-Path: <zwp10758@gmail.com>
Return-Path: <zwp10758@gmail.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Thu, 21 Sep 2017 23:14:16 +0800
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix nr_requests wrong value when modify it from
 sysfs
Message-ID: <20170921151416.GA10870@localhost.didichuxing.com>
References: <20170903134634.GA27411@localhost.didichuxing.com>
 <1504626163.4135.33.camel@wdc.com>
 <20170906073355.GA37455@localhost.didichuxing.com>
 <1504702843.7750.0.camel@wdc.com>
 <20170912135732.GA7025@bogon.didichuxing.com>
 <20170921130312.GA11537@localhost.didichuxing.com>
 <b3c8fa23-d8d4-36ae-5e86-2aa55d7f2675@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b3c8fa23-d8d4-36ae-5e86-2aa55d7f2675@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 08:09:47AM -0600, Jens Axboe wrote:
> On 09/21/2017 07:03 AM, weiping zhang wrote:
> > On Tue, Sep 12, 2017 at 09:57:32PM +0800, weiping zhang wrote:
> >> On Wed, Sep 06, 2017 at 01:00:44PM +0000, Bart Van Assche wrote:
> >>> On Wed, 2017-09-06 at 15:34 +0800, weiping zhang wrote:
> >>>> On Tue, Sep 05, 2017 at 03:42:45PM +0000, Bart Van Assche wrote:
> >>>>> On Sun, 2017-09-03 at 21:46 +0800, weiping zhang wrote:
> >>>>>> if blk-mq use "none" io scheduler, nr_request get a wrong value when
> >>>>>> input a number > tag_set->queue_depth. blk_mq_tag_update_depth will get
> >>>>>> the smaller one min(nr, set->queue_depth), and then q->nr_request get a
> >>>>>> wrong value.
> >>>>>>
> >>>>>> Reproduce:
> >>>>>>
> >>>>>> echo none > /sys/block/nvme0n1/queue/ioscheduler
> >>>>>> echo 1000000 > /sys/block/nvme0n1/queue/nr_requests
> >>>>>> cat /sys/block/nvme0n1/queue/nr_requests
> >>>>>> 1000000
> >>>>>>
> >>>>>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> >>>>>> ---
> >>>>>>  block/blk-mq.c | 7 +++++--
> >>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>>>>> index f84d145..8303e5e 100644
> >>>>>> --- a/block/blk-mq.c
> >>>>>> +++ b/block/blk-mq.c
> >>>>>> @@ -2622,8 +2622,11 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> >>>>>>  		 * queue depth. This is similar to what the old code would do.
> >>>>>>  		 */
> >>>>>>  		if (!hctx->sched_tags) {
> >>>>>> -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
> >>>>>> -							min(nr, set->queue_depth),
> >>>>>> +			if (nr > set->queue_depth) {
> >>>>>> +				nr = set->queue_depth;
> >>>>>> +				pr_warn("reduce nr_request to %u\n", nr);
> >>>>>> +			}
> >>>>>> +			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
> >>>>>>  							false);
> >>>>>>  		} else {
> >>>>>>  			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> >>>>>
> >>>>> Shouldn't this code return -EINVAL or -ERANGE if 'nr' is too large? That will help to
> >>>>> keep user space code simple that updates the queue depth.
> >>>>
> >>>> Hi Bart,
> >>>>
> >>>> The reason why not return -EINVAL is keeping alin with minimum checking in queue_requests_store,
> >>>> if you insist return -EINVAL/-ERANGE, minimum checking should also keep
> >>>> same behavior. Both return error meesage and quietly changing are okey
> >>>> for me. Which way do you prefer ?
> >>>>
> >>>> static ssize_t
> >>>> queue_requests_store(struct request_queue *q, const char *page, size_t count)
> >>>> {
> >>>> 	unsigned long nr;
> >>>> 	int ret, err;
> >>>>
> >>>> 	if (!q->request_fn && !q->mq_ops)
> >>>> 		return -EINVAL;
> >>>>
> >>>> 	ret = queue_var_store(&nr, page, count);
> >>>> 	if (ret < 0)
> >>>> 		return ret;
> >>>>
> >>>> 	if (nr < BLKDEV_MIN_RQ)
> >>>> 		nr = BLKDEV_MIN_RQ;
> >>>
> >>> Hello Jens,
> >>>
> >>> Do you perhaps have a preference for one of the approaches that have been discussed
> >>> in this e-mail thread?
> >>>
> >>> Thanks,
> >>>
> >>> Bart.
> >>
> > Hello Jens,
> > 
> > Would you please give some comments about this patch,
> 
> If someone writes a value that's too large, return -EINVAL and
> don't set it. Don't add weird debug printks.
> 
> 
OK, I send patch V2 soon.
