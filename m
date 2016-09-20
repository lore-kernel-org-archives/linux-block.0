Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753848AbcITL1H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2016 07:27:07 -0400
Date: Tue, 20 Sep 2016 13:33:03 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/14] blk-mq: Cleanup a loop exit condition
Message-ID: <20160920113302.GB26808@agordeev.lab.eng.brq.redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
 <28367fd20927339e103d7e5afef31e2988e7ee78.1474183901.git.agordeev@redhat.com>
 <20160919190028.GH21803@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919190028.GH21803@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 19, 2016 at 12:00:28PM -0700, Omar Sandoval wrote:
> On Sun, Sep 18, 2016 at 09:37:17AM +0200, Alexander Gordeev wrote:
> > CC: linux-block@vger.kernel.org
> > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> 
> So set->nr_hw_queues is always >= q->nr_hw_queues, right?

That is what I conclude form blk_mq_realloc_hw_ctxs() code:

	for (i = 0; i < set->nr_hw_queues; i++) {
		...
	}
	...
	q->nr_hw_queues = i;

> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> > ---
> >  block/blk-mq.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 9fbfe31..b2ef8f5 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1681,16 +1681,13 @@ static void blk_mq_exit_hctx(struct request_queue *q,
> >  }
> >  
> >  static void blk_mq_exit_hw_queues(struct request_queue *q,
> > -		struct blk_mq_tag_set *set, int nr_queue)
> > +		struct blk_mq_tag_set *set)
> >  {
> >  	struct blk_mq_hw_ctx *hctx;
> >  	unsigned int i;
> >  
> > -	queue_for_each_hw_ctx(q, hctx, i) {
> > -		if (i == nr_queue)
> > -			break;
> > +	queue_for_each_hw_ctx(q, hctx, i)
> >  		blk_mq_exit_hctx(q, set, hctx, i);
> > -	}
> >  }
> >  
> >  static void blk_mq_free_hw_queues(struct request_queue *q,
> > @@ -2124,7 +2121,7 @@ void blk_mq_free_queue(struct request_queue *q)
> >  
> >  	blk_mq_del_queue_tag_set(q);
> >  
> > -	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
> > +	blk_mq_exit_hw_queues(q, set);
> >  	blk_mq_free_hw_queues(q, set);
> >  }
> >  
> > -- 
> > 1.8.3.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-block" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Omar
