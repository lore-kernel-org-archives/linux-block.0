Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Directly schedule q->timeout_work when aborting a
 request
To: Tejun Heo <tj@kernel.org>, Sitsofe Wheeler <sitsofe@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
References: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
 <de102067-b589-af05-ae71-496e948000f0@kernel.dk>
 <CALjAwxgtuEv=d1TfvH3EdXqZs=_6F7TinyVhbPdUmTsdK_5ghw@mail.gmail.com>
 <20180402202951.GE388343@devbig577.frc2.facebook.com>
 <CALjAwxj1urPPNadmkmhLngHvYcfhh8d+_vPstPDQHXLiGL0oTw@mail.gmail.com>
 <20180402220458.GJ388343@devbig577.frc2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <47e8098e-478e-542c-d447-8b8d03bda562@kernel.dk>
Date: Mon, 2 Apr 2018 16:35:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180402220458.GJ388343@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/2/18 4:04 PM, Tejun Heo wrote:
> Request abortion is performed by overriding deadline to now and
> scheduling timeout handling immediately.  For the latter part, the
> code was using mod_timer(timeout, 0) which can't guarantee that the
> timer runs afterwards.  Let's schedule the underlying work item
> directly instead.
> 
> This fixes the hangs during probing reported by Sitsofe but it isn't
> yet clear to me how the failure can happen reliably if it's just the
> above described race condition.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Sitsofe Wheeler <sitsofe@gmail.com>
> Reported-by: Meelis Roos <mroos@linux.ee>
> Fixes: 358f70da49d7 ("blk-mq: make blk_abort_request() trigger timeout path")
> Cc: stable@vger.kernel.org # v4.16
> Link: http://lkml.kernel.org/r/CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com
> Link: http://lkml.kernel.org/r/alpine.LRH.2.21.1802261049140.4893@math.ut.ee
> ---
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

In any case, it's cleaner than relying on mod_timer(.., 0). If that
doesn't guarantee that the timer runs again, I can see how a race
with the running timer could prevent us from seeing the timeout
after an abort.

I'll apply this, thanks.

-- 
Jens Axboe
