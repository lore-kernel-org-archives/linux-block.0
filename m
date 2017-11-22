Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbdKVW25 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 17:28:57 -0500
Date: Thu, 23 Nov 2017 06:28:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH] block: drain queue before waiting for q_usage_counter
 becoming zero
Message-ID: <20171122222839.GA7362@ming.t460p>
References: <20171122051143.31943-1-ming.lei@redhat.com>
 <1511369267.3061.5.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511369267.3061.5.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 22, 2017 at 04:47:48PM +0000, Bart Van Assche wrote:
> On Wed, 2017-11-22 at 13:11 +0800, Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 11097477eeab..3d3797327491 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -161,6 +161,8 @@ void blk_freeze_queue(struct request_queue *q)
> >  	 * exported to drivers as the only user for unfreeze is blk_mq.
> >  	 */
> >  	blk_freeze_queue_start(q);
> > +	if (!q->mq_ops)
> > +		blk_drain_queue(q);
> >  	blk_mq_freeze_queue_wait(q);
> >  }
> 
> Since q_usage_counter now tracks legacy requests, is there any reason why we
> still need __blk_drain_queue()? Have you considered to eliminate
> __blk_drain_queue() and to call blk_run_queue() from inside blk_freeze_queue()
> instead of calling blk_drain_queue()? I'm asking this because

Yeah, that looks better, I am thinking of that too, will do this way
in V2.

-- 
Ming
