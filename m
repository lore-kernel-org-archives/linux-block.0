Return-Path: <ming.lei@redhat.com>
Date: Mon, 16 Apr 2018 08:45:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Bart Van Assche <bart.vanassche@wdc.com>,
	Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH V4 0/2] blk-mq: fix race between completion and
 BLK_EH_RESET_TIMER
Message-ID: <20180416004508.GA20345@ming.t460p>
References: <20180415154357.19788-1-ming.lei@redhat.com>
 <4563853.Bq5iVV2DL3@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4563853.Bq5iVV2DL3@merkaba>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 15, 2018 at 06:31:44PM +0200, Martin Steigerwald wrote:
> Hi Ming.
> 
> Ming Lei - 15.04.18, 17:43:
> > Hi Jens,
> > 
> > This two patches fixes the recently discussed race between completion
> > and BLK_EH_RESET_TIMER.
> > 
> > Israel & Martin, this one is a simpler fix on this issue and can
> > cover the potencial hang of MQ_RQ_COMPLETE_IN_TIMEOUT request, could
> > you test V4 and see if your issue can be fixed?
> 
> In replacement of all the three other patches I applied?
> 
> - '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a 
> request.mbox'
> 
> - '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into 
> rcu_read_{lock,unlock}().mbox'
> 
> - '[PATCH v4] blk-mq_Fix race conditions in request timeout 
> handling.mbox'

You only need to replace the above one '[PATCH v4] blk-mq_Fix race
conditions in request timeout' with V4 in this thread.

> 
> These patches worked reliably so far both for the hang on boot and error 
> reading SMART data.

And you may see the reason in the following thread:

https://marc.info/?l=linux-block&m=152366441625786&w=2

> 
> I�d compile a kernel tomorrow or Tuesday I think.

Thanks!

--
Ming
