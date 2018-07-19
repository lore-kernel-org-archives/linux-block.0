Return-Path: <ming.lei@redhat.com>
Date: Fri, 20 Jul 2018 07:26:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"tom.leiming@gmail.com" <tom.leiming@gmail.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] block, scsi: Rework runtime power management
Message-ID: <20180719232650.GA16394@ming.t460p>
References: <20180717234940.11231-1-bart.vanassche@wdc.com>
 <20180717234940.11231-3-bart.vanassche@wdc.com>
 <CACVXFVPP6bY9YijDSyQg9OOR4ge9LyR+naWNDeLGOS=WFL_7CA@mail.gmail.com>
 <60ce50f281bf41483b53246d509697f6d95360f8.camel@wdc.com>
 <20180718224545.GA15589@ming.t460p>
 <c15e8f2b15b734284a983102e8e91a8f28cd2686.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c15e8f2b15b734284a983102e8e91a8f28cd2686.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 03:54:53PM +0000, Bart Van Assche wrote:
> On Thu, 2018-07-19 at 06:45 +0800, Ming Lei wrote:
> > So once blk_freeze_queue_start() returns, percpu_ref_is_zero() won't
> > return true only until the rcu confirmation is done. That means this
> > approach may not put device down.
> 
> Hello Ming,
> 
> I agree with your conclusion that it is not guaranteed that q->q_usage_counter
> is in atomic mode when percpu_ref_is_zero() is called. However, I think that's
> fine: if blk_pre_runtime_suspend() returns -EBUSY then the runtime core will
> try again at a later time to perform runtime suspend.

This behaviour should be persistent in next retry since percpu_ref_is_zero()
should always return false after blk_freeze_queue_start() is run on one
un-frozen queue.

Thanks,
Ming
