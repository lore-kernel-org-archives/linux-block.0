Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbeITHTA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Sep 2018 03:19:00 -0400
Date: Thu, 20 Sep 2018 09:38:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v8 6/8] block: Schedule runtime resume earlier
Message-ID: <20180920013806.GB27645@ming.t460p>
References: <20180918205903.15516-1-bvanassche@acm.org>
 <20180918205903.15516-7-bvanassche@acm.org>
 <20180919040514.GE20560@ming.t460p>
 <1537393175.186311.3.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537393175.186311.3.camel@acm.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 19, 2018 at 02:39:35PM -0700, Bart Van Assche wrote:
> On Wed, 2018-09-19 at 12:05 +0800, Ming Lei wrote:
> > Looks this patch may introduce the following race between queue
> > freeze and
> > runtime suspend:
> > 
> > -------------------------------------------------------------------
> > -------
> > CPU0				CPU1				
> > 		CPU2
> > -------------------------------------------------------------------
> > -------
> > 
> > blk_freeze_queue()
> > 
> > 					blk_mq_alloc_request()
> > 						blk_queue_enter()
> > 							blk_pm_request_
> > resume()
> > 							wait_event()
> > 
> > 									
> > 			blk_pre_runtime_suspend()
> > 									
> > 				->blk_set_pm_only
> > 									
> > 			...
> > 									
> > 			blk_post_runtime_suspend()
> > 
> > ...
> > blk_mq_unfreeze_queue()
> > -------------------------------------------------------------------
> > -------
> > - CPU0: queue is frozen
> > 
> > - CPU1: one new request comes, and see queue is frozen, but queue
> > isn't
> > runtime-suspended yet, then blk_pm_request_resume() does nothing. So
> > this
> > allocation is blocked in wait_event().
> > 
> > - CPU2: runtime suspend comes, and queue becomes runtime-suspended
> > now
> > 
> > - CPU0: queue is unfreeze, but the new request allocation in CPU1 may
> > never
> > be done because the queue is runtime suspended, and wait_event()
> > won't return.
> > And the expected result is that the queue becomes active and the
> > allocation on
> > CPU1 is done immediately.
> 
> Hello Ming,
> 
> Just like for the scenario Jianchao reported, I will address this by
> only allowing the suspend to proceed if q_usage_counter == 0.

Hi Bart,

But .q_usage_counter has been zero already in the case I described,
no one grabs a queue ref before starting runtime suspend.

Also, if there is in-progress PM request, the .q_usage_counter can be
non-zero, but it should be fine to start the suspend.

Thanks,
Ming
