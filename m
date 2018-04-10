Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Tejun Heo <tj@kernel.org>
Cc: Sitsofe Wheeler <sitsofe@gmail.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH] blk-mq: Directly schedule q->timeout_work when aborting a request
Date: Tue, 10 Apr 2018 20:43:34 +0200
Message-ID: <2699418.6CV4rbzP8d@merkaba>
In-Reply-To: <20180402220458.GJ388343@devbig577.frc2.facebook.com>
References: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com> <CALjAwxj1urPPNadmkmhLngHvYcfhh8d+_vPstPDQHXLiGL0oTw@mail.gmail.com> <20180402220458.GJ388343@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Tejun Heo - 03.04.18, 00:04:
> Request abortion is performed by overriding deadline to now and
> scheduling timeout handling immediately.  For the latter part, the
> code was using mod_timer(timeout, 0) which can't guarantee that the
> timer runs afterwards.  Let's schedule the underlying work item
> directly instead.
> 
> This fixes the hangs during probing reported by Sitsofe but it isn't
> yet clear to me how the failure can happen reliably if it's just the
> above described race condition.

Compiling a 4.16.1 kernel with that patch to test whether this fixes the boot 
hang I reported in:

[Possible REGRESSION, 4.16-rc4] Error updating SMART data during runtime and 
boot failures with blk_mq_terminate_expired in backtrace
https://bugzilla.kernel.org/show_bug.cgi?id=199077

The "Error updating SMART data during runtime" thing I reported there as well 
may still be another (independent) issue.

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Sitsofe Wheeler <sitsofe@gmail.com>
> Reported-by: Meelis Roos <mroos@linux.ee>
> Fixes: 358f70da49d7 ("blk-mq: make blk_abort_request() trigger timeout
> path") Cc: stable@vger.kernel.org # v4.16
> Link:
> http://lkml.kernel.org/r/CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EM
> A@mail.gmail.com Link:
> http://lkml.kernel.org/r/alpine.LRH.2.21.1802261049140.4893@math.ut.ee ---
> Hello,
> 
> I don't have the full explanation yet but here's a preliminary patch.
> 
> Thanks.
> 
>  block/blk-timeout.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-timeout.c b/block/blk-timeout.c
> index a05e367..f0e6e41 100644
> --- a/block/blk-timeout.c
> +++ b/block/blk-timeout.c
> @@ -165,7 +165,7 @@ void blk_abort_request(struct request *req)
>  		 * No need for fancy synchronizations.
>  		 */
>  		blk_rq_set_deadline(req, jiffies);
> -		mod_timer(&req->q->timeout, 0);
> +		kblockd_schedule_work(&req->q->timeout_work);
>  	} else {
>  		if (blk_mark_rq_complete(req))
>  			return;
-- 
Martin
