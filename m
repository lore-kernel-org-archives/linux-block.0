Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbdIOBuy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2017 21:50:54 -0400
Date: Fri, 15 Sep 2017 09:50:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH V4 03/14] blk-mq: introduce blk_mq_dispatch_rq_from_ctx()
Message-ID: <20170915015036.GA19058@ming.t460p>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-4-ming.lei@redhat.com>
 <20170915000413.GA15772@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170915000413.GA15772@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 14, 2017 at 05:04:13PM -0700, Omar Sandoval wrote:
> On Sat, Sep 02, 2017 at 11:17:18PM +0800, Ming Lei wrote:
> > This function is introduced for dequeuing request
> > from sw queue so that we can dispatch it in
> > scheduler's way.
> > 
> > More importantly, some SCSI devices may set
> > q->queue_depth, which is a per-request_queue limit,
> > and applied on pending I/O from all hctxs. This
> > function is introduced for avoiding to dequeue too
> > many requests from sw queue when ->dispatch isn't
> > flushed completely.
> 
> blk_mq_dispatch_rq_from_ctx() doesn't actually dispatch the request. Can
> you please rename it blk_mq_dequeue_from_ctx() or something like that?
> (Same for the dispatch_rq_from_ctx helper.)

It makes sense, will do that.

-- 
Ming
