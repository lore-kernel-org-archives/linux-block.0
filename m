Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25141 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdHXBAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 21:00:07 -0400
Subject: Re: [PATCH V2 11/20] blk-mq: introduce helpers for operating
 ->dispatch list
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-12-ming.lei@redhat.com>
 <1503434591.2508.20.camel@wdc.com>
Cc: "loberman@redhat.com" <loberman@redhat.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <12634573-89fa-90cc-f481-464a490f7915@wdc.com>
Date: Thu, 24 Aug 2017 09:59:13 +0900
MIME-Version: 1.0
In-Reply-To: <1503434591.2508.20.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 8/23/17 05:43, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
>> +static inline bool blk_mq_has_dispatch_rqs(struct blk_mq_hw_ctx *hctx)
>> +{
>> +	return !list_empty_careful(&hctx->dispatch);
>> +}
>> +
>> +static inline void blk_mq_add_rq_to_dispatch(struct blk_mq_hw_ctx *hctx,
>> +		struct request *rq)
>> +{
>> +	spin_lock(&hctx->lock);
>> +	list_add(&rq->queuelist, &hctx->dispatch);
>> +	blk_mq_hctx_set_dispatch_busy(hctx);
>> +	spin_unlock(&hctx->lock);
>> +}
>> +
>> +static inline void blk_mq_add_list_to_dispatch(struct blk_mq_hw_ctx *hctx,
>> +		struct list_head *list)
>> +{
>> +	spin_lock(&hctx->lock);
>> +	list_splice_init(list, &hctx->dispatch);
>> +	blk_mq_hctx_set_dispatch_busy(hctx);
>> +	spin_unlock(&hctx->lock);
>> +}
>> +
>> +static inline void blk_mq_add_list_to_dispatch_tail(struct blk_mq_hw_ctx *hctx,
>> +						    struct list_head *list)
>> +{
>> +	spin_lock(&hctx->lock);
>> +	list_splice_tail_init(list, &hctx->dispatch);
>> +	blk_mq_hctx_set_dispatch_busy(hctx);
>> +	spin_unlock(&hctx->lock);
>> +}
>> +
>> +static inline void blk_mq_take_list_from_dispatch(struct blk_mq_hw_ctx *hctx,
>> +		struct list_head *list)
>> +{
>> +	spin_lock(&hctx->lock);
>> +	list_splice_init(&hctx->dispatch, list);
>> +	spin_unlock(&hctx->lock);
>> +}
> 
> Same comment for this patch: these helper functions are so short that I'm not
> sure it is useful to introduce these helper functions.
> 
> Bart.

Personally, I like those very much as they give a place to hook up
different dispatch_list handling without having to change blk-mq.c and
blk-mq-sched.c all over the place.

I am thinking of SMR (zoned block device) support here since we need to
to sort insert write requests in blk_mq_add_rq_to_dispatch() and
blk_mq_add_list_to_dispatch_tail(). For this last one, the name would
become a little awkward though. This sort insert would be to avoid
breaking a sequential write request sequence sent by the disk user. This
is needed since this reordering breakage cannot be solved only from the
SCSI layer.

blk_mq_add_list_to_dispatch() and blk_mq_add_list_to_dispatch_tail()
could be combined together into blk_mq_add_list_to_dispatch() with the
addition of a "where" argument (BLK_MQ_INSERT_HEAD or
BLK_MQ_INSERT_TAIL), or like some other functions in blk-mq, the
addition of a simple "bool at_head" argument.

Best regards.

-- 
Damien Le Moal,
Western Digital Research
