Return-Path: <ming.lei@redhat.com>
Date: Fri, 11 May 2018 05:00:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"loberman@redhat.com" <loberman@redhat.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V4 1/7] block: introduce blk_quiesce_timeout() and
 blk_unquiesce_timeout()
Message-ID: <20180510210048.GB3515@ming.t460p>
References: <20180505135905.18815-1-ming.lei@redhat.com>
 <20180505135905.18815-2-ming.lei@redhat.com>
 <4cf98f8d3d763ab3decb5f4bfaee6a4394de5caf.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4cf98f8d3d763ab3decb5f4bfaee6a4394de5caf.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 03:01:04PM +0000, Bart Van Assche wrote:
> On Sat, 2018-05-05 at 21:58 +0800, Ming Lei wrote:
> > Turns out the current way can't drain timout completely because mod_timer()
> > can be triggered in the work func, which can be just run inside the synced
> > timeout work:
> > 
> >         del_timer_sync(&q->timeout);
> >         cancel_work_sync(&q->timeout_work);
> > 
> > This patch introduces one flag of 'timeout_off' for fixing this issue, turns
> > out this simple way does work.
> > 
> > Also blk_quiesce_timeout() and blk_unquiesce_timeout() are introduced for
> > draining timeout, which is needed by NVMe.
> 
> Hello Ming,
> 
> The description of the above patch does not motivate sufficiently why you think
> that this change is necessary. As you know it is already possible to wait until
> timeout handling has finished by calling blk_mq_freeze_queue() +
> blk_mq_unfreeze_queue(). An explanation is needed of why you think that calling

blk_mq_freeze_queue() +  blk_mq_unfreeze_queue() can't work, you have to
call blk_mq_freeze_queue_wait() between the two, but blk_mq_freeze_queue_wait
is a big trouble for NVMe, and can't be used inside nvme_dev_disable().

You can find the usage in the last patch of this series.

Thanks,
Ming
