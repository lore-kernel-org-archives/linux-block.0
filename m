Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756174AbdGLDUh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 23:20:37 -0400
Date: Wed, 12 Jul 2017 11:20:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Message-ID: <20170712032023.GH13036@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-5-ming.lei@redhat.com>
 <786dc75e-18f0-eb13-0bef-f526e7896510@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <786dc75e-18f0-eb13-0bef-f526e7896510@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 11, 2017 at 12:39:35PM -0600, Jens Axboe wrote:
> On 07/11/2017 12:21 PM, Ming Lei wrote:
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 60b01c0309bc..c4516d2a2d2c 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -133,4 +133,13 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
> >  	return hctx->nr_ctx && hctx->tags;
> >  }
> >  
> > +/* borrowed from bcache */
> > +#define ewma_add(ewma, val, weight, factor)                             \
> > +({                                                                      \
> > +        (ewma) *= (weight) - 1;                                         \
> > +        (ewma) += (val) << factor;                                      \
> > +        (ewma) /= (weight);                                             \
> > +        (ewma) >> factor;                                               \
> > +})
> 
> Just put that in blk_mq_update_req_dispatch_busy(), or at least make it
> a static function in blk-mq.c above that function. You don't use factor
> at all.

OK, will do it in V2.


-- 
Ming
