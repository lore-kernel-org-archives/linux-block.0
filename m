Return-Path: <msnitzer@redhat.com>
Date: Wed, 14 Sep 2016 11:13:44 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-mq: introduce blk_mq_delay_kick_requeue_list()
Message-ID: <20160914151344.GA29542@redhat.com>
References: <1473782495-44128-1-git-send-email-snitzer@redhat.com>
 <1473782495-44128-2-git-send-email-snitzer@redhat.com>
 <90cdf652-555a-e88a-72b2-0a81926d78e3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <90cdf652-555a-e88a-72b2-0a81926d78e3@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 14 2016 at 11:04am -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 09/13/2016 10:01 AM, Mike Snitzer wrote:
> >blk_mq_delay_kick_requeue_list() provides the ability to kick the
> >q->requeue_list after a specified time.  To do this the request_queue's
> >'requeue_work' member was changed to a delayed_work.
> >
> >blk_mq_delay_kick_requeue_list() allows DM to defer processing requeued
> >requests while it doesn't make sense to immediately requeue them
> >(e.g. when all paths in a DM multipath have failed).
> 
> Looks fine to me, sans the missing jiffies conversion that Bart pointed
> out.

Thanks, I'll send v2 out shortly.
