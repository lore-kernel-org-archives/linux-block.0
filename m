Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdEaJwJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 05:52:09 -0400
Date: Wed, 31 May 2017 17:51:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 5/8] blk-mq: update comments on blk_mq_quiesce_queue()
Message-ID: <20170531095156.GA14109@ming.t460p>
References: <20170527142126.26079-1-ming.lei@redhat.com>
 <20170527142126.26079-6-ming.lei@redhat.com>
 <1496164482.2627.13.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496164482.2627.13.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 30, 2017 at 05:14:44PM +0000, Bart Van Assche wrote:
> On Sat, 2017-05-27 at 22:21 +0800, Ming Lei wrote:
> >  /**
> > - * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
> > + * blk_mq_quiesce_queue() - wait until all ongoing dispatching have finished
> >   * @q: request queue.
> >   *
> 
> Hello Ming,
> 
> The concept of dispatching does not have a meaning to block driver authors who are
> not familiar with the block layer internals. However, every author of a blk-mq driver
> knows what the .queue_rq() function is.

Unfortunately it isn't enough to just block .queue_rq(), did you read the
commit log?

> Additionally, the new comment is grammatically
> incorrect.
> So the above change looks like a step in the wrong direction to me.

Sorry, I simply don't agree, and we have to make it explicit.

-- 
Ming
