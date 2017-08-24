Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751285AbdHXGw2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 02:52:28 -0400
Date: Thu, 24 Aug 2017 14:52:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 09/20] blk-mq: introduce BLK_MQ_F_SHARED_DEPTH
Message-ID: <20170824065215.GJ12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-10-ming.lei@redhat.com>
 <1503438955.2508.30.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503438955.2508.30.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 09:55:57PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > +	/*
> > +	 * if there is q->queue_depth, all hw queues share
> > +	 * this queue depth limit
> > +	 */
> > +	if (q->queue_depth) {
> > +		queue_for_each_hw_ctx(q, hctx, i)
> > +			hctx->flags |= BLK_MQ_F_SHARED_DEPTH;
> > +	}
> > +
> > +	if (!q->elevator)
> > +		goto exit;
> 
> Hello Ming,
> 
> It seems very fragile to me to set BLK_MQ_F_SHARED_DEPTH if and only if
> q->queue_depth != 0. Wouldn't it be better to let the block driver tell the
> block layer whether or not there is a queue depth limit across hardware
> queues, e.g. through a tag set flag?

One reason for not doing in that way is because q->queue_depth can be
changed via sysfs interface.

Another reason is that better to not exposing this flag to drivers since
it isn't necessary, that said it is an internal flag actually.

-- 
Ming
