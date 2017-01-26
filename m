Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34153 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbdAZUzT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 15:55:19 -0500
Received: by mail-pf0-f180.google.com with SMTP id e4so67553628pfg.1
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 12:54:34 -0800 (PST)
Date: Thu, 26 Jan 2017 12:54:01 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, bart.vanassche@sandisk.com,
        hch@lst.de, osandov@fb.com, paolo.valente@linaro.org, hare@suse.com
Subject: Re: [PATCH 5/5] blk-mq-sched: change ->dispatch_requests() to
 ->dispatch_request()
Message-ID: <20170126205401.GE21449@vader.DHCP.thefacebook.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-6-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485460098-16608-6-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 12:48:18PM -0700, Jens Axboe wrote:
> When we invoke dispatch_requests(), the scheduler empties everything
> into the passed in list. This isn't always a good thing, since it
> means that we remove items that we could have potentially merged
> with.
> 
> Change the function to dispatch single requests at the time. If
> we do that, we can backoff exactly at the point where the device
> can't consume more IO, and leave the rest with the scheduler for
> better merging and future dispatch decision making.

Hmm, I think I previously changed this from ->dispatch_request() to
->dispatch_requests() to support schedulers using software queues. My
current mq-token stuff doesn't have a ->dispatch_requests() hook anymore
after the sched_tags rework, but I think I'm going to need it again
soon. Having the scheduler do blk_mq_flush_busy_ctxs() into its own
private list and then handing the requests out one-by-one kinda sucks.
(Plus, deferred issue wouldn't work with this, but it's not implemented,
anyways :)

One idea: what if we have the scheduler get the driver tags inside of
its ->dispatch_requests()? For example, __dd_dispatch_request() could
first check whether it has a request to dispatch and then try to grab a
driver tag. If it succeeds, it dispatches the request, and if it
doesn't, it marks itself as needing restart.

With that, the scheduler will only return requests ready for
->queue_rq(), meaning we could get rid of the list reshuffling in
blk_mq_dispatch_rq_list().

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq-sched.c     | 23 +++++++++++++++--------
>  block/blk-mq.c           |  2 +-
>  block/mq-deadline.c      | 10 ++++++----
>  include/linux/elevator.h |  2 +-
>  4 files changed, 23 insertions(+), 14 deletions(-)
