Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:16791 "EHLO
        BJEXMBX012.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751021AbdIFHe0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Sep 2017 03:34:26 -0400
Date: Wed, 6 Sep 2017 15:34:15 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix nr_requests wrong value when modify it from
 sysfs
Message-ID: <20170906073355.GA37455@localhost.didichuxing.com>
References: <20170903134634.GA27411@localhost.didichuxing.com>
 <1504626163.4135.33.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1504626163.4135.33.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 05, 2017 at 03:42:45PM +0000, Bart Van Assche wrote:
> On Sun, 2017-09-03 at 21:46 +0800, weiping zhang wrote:
> > if blk-mq use "none" io scheduler, nr_request get a wrong value when
> > input a number > tag_set->queue_depth. blk_mq_tag_update_depth will get
> > the smaller one min(nr, set->queue_depth), and then q->nr_request get a
> > wrong value.
> > 
> > Reproduce:
> > 
> > echo none > /sys/block/nvme0n1/queue/ioscheduler
> > echo 1000000 > /sys/block/nvme0n1/queue/nr_requests
> > cat /sys/block/nvme0n1/queue/nr_requests
> > 1000000
> > 
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > ---
> >  block/blk-mq.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f84d145..8303e5e 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2622,8 +2622,11 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> >  		 * queue depth. This is similar to what the old code would do.
> >  		 */
> >  		if (!hctx->sched_tags) {
> > -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
> > -							min(nr, set->queue_depth),
> > +			if (nr > set->queue_depth) {
> > +				nr = set->queue_depth;
> > +				pr_warn("reduce nr_request to %u\n", nr);
> > +			}
> > +			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr,
> >  							false);
> >  		} else {
> >  			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> 
> Shouldn't this code return -EINVAL or -ERANGE if 'nr' is too large? That will help to
> keep user space code simple that updates the queue depth.

Hi Bart,

The reason why not return -EINVAL is keeping alin with minimum checking in queue_requests_store,
if you insist return -EINVAL/-ERANGE, minimum checking should also keep
same behavior. Both return error meesage and quietly changing are okey
for me. Which way do you prefer ?

static ssize_t
queue_requests_store(struct request_queue *q, const char *page, size_t count)
{
	unsigned long nr;
	int ret, err;

	if (!q->request_fn && !q->mq_ops)
		return -EINVAL;

	ret = queue_var_store(&nr, page, count);
	if (ret < 0)
		return ret;

	if (nr < BLKDEV_MIN_RQ)
		nr = BLKDEV_MIN_RQ;

Thanks
