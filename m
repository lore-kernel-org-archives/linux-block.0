Return-Path: <ming.lei@redhat.com>
Date: Thu, 6 Sep 2018 05:27:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, sagi@grimberg.me,
	keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
Message-ID: <20180905212659.GB21352@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 05, 2018 at 12:09:43PM +0800, Jianchao Wang wrote:
> Dear all
> 
> As we know, queue freeze is used to stop new IO comming in and drain
> the request queue. And the draining queue here is necessary, because
> queue freeze kills the percpu-ref q_usage_counter and need to drain
> the q_usage_counter before switch it back to percpu mode. This could
> be a trouble when we just want to prevent new IO.
> 
> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
> nvme_reset_work will unfreeze and wait to drain the queues. However,
> if IO timeout at the moment, no body could do recovery as nvme_reset_work
> is waiting. We will encounter IO hang.

As we discussed this nvme time issue before, I have pointed out that
this is because of blk_mq_unfreeze_queue()'s limit which requires that
unfreeze can only be done when this queue ref counter drops to zero.

For this nvme timeout case, we may relax the limit, for example,
introducing another API of blk_freeze_queue_stop() as counter-pair of
blk_freeze_queue_start(), and simply switch the percpu-ref to percpu mode
from atomic mode inside the new API.

> 
> So introduce a light-weight queue close feature in this patch set
> which could prevent new IO and needn't drain the queue.

Frankly speaking, IMO, it may not be an good idea to mess up the fast path
just for handling the extremely unusual timeout event. The same is true
for doing the preemp only stuff, as you saw I have posted patchset for
killing it.

Thanks,
Ming
