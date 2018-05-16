Return-Path: <ming.lei@redhat.com>
Date: Thu, 17 May 2018 07:10:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180516231058.GB28727@ming.t460p>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516141242.GA20119@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

Hi Keith,

On Wed, May 16, 2018 at 08:12:42AM -0600, Keith Busch wrote:
> Hi Ming,
> 
> I'm sorry, but I am frankly not on board with introducing yet
> another work-queue into this driver for handling this situation. The
> fact you missed syncing with this queue in the surprise remove case,
> introducing various use-after-free conditions, just demonstrates exactly

blk_cleanup_queue() will drain all requests, and all the timeout activities
will be quiesced, so could you explain what the use-after-free
conditions are? Also we can wait on 'eh_wq' simply until dev->nested_eh
becomes zero before removing 'nvme_dev'.

> how over-complicated this approach is. That, and the forced controller

Now we run controller shutdown and resetting in different contests,
which has caused big trouble, kinds of IO hang:

	https://marc.info/?l=linux-block&m=152644353006033&w=2

This patch moves the two into one same context, it is really a
simplification for avoiding IO hang which is caused by race
between starting freeze and nvme_wait_freeze(), which two are
run from different contexts now.

The sync between all EH contexts looks a bit complicated, but
eh_wq is introduced to sync until the recovery is done for all EHs.

So the new EH model isn't complicated.

I hope all these issues can be fixed, but open to any soluiton,
unfortunately not see any workable way yet, except for this patchset.

> state transtions is yet another way surprise removal will break as its
> depending on the state machine to prevent certain transitions.

We can limit the transtions in nvme_force_change_ctrl_state() too,
that can be documented well.

> 
> The driver is already in a work queue context when it becomes aware of
> corrective action being necessary. Seriously, simply syncing these in the

Yeah, it is in reset work func, which is part of recovery, but either
admin or normal IO can be timed-out in this context too, that is why I
introduces new work to cover this case.

I think we have to handle the issue of IO time-out during reset.

In block/011 test, it can be observed easily that the 3rd EH is started
to recover the whole failure, and finally it succeeds.

> reset convers nearly all conditions you're concered with, most of which

I believe I have explained it to you, that isn't enough:

https://marc.info/?l=linux-block&m=152599770314638&w=2
https://marc.info/?l=linux-block&m=152598984210852&w=2
https://marc.info/?l=linux-block&m=152598664409170&w=2

> will be obviated if Bart's blk-mq timeout rework is added. The only case
> that isn't covered is if IO stops when renumbering the hardware contexts
> (unlikely as that is), and that's easily fixable just moving that into
> the scan_work.

How can Bart's patch cover multiple NS's case? Timeout from multiple NS
still can come at the same time.

> 
> As far as blktests block/011 is concerned, I think this needs to be
> rethought considering what it's actually showing us. The fact the
> pci driver provides such an easy way to not only muck with PCI config
> register *and* internal kernel structures out from under a driver that's
> bound to it is insane.  If PCI really wants to provide this sysfs entry,
> it really ought to notify bound drivers that this is occuring, similar
> to the 'reset' sysfs.

All simulation in block/011 may happen in reality.

When one IO is timed out, IO dispatched during resetting can be
timed-out too.

Unfortunately current NVMe driver can't handle that and the reset
work will hang forever. I don't believe it is a good way as EH.

> 
> Anyway, there is merit to some of your earlier patches. In particular,
> specifically patches 2, 4, and 5.  On the timing out the host memory
> releasing (patch 2), I would just rather see this as a generic API,
> though:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2018-January/015313.html
>   http://lists.infradead.org/pipermail/linux-nvme/2018-January/015314.html

The generic API may not be necessary, since it is only needed when it is
called in nvme_dev_disable(), but it is still better to have this API.

Except above, you ignore one big source of IO hang, that is the race
between starting freeze & blk_mq_freeze_queue_wait().

- nvme_dev_disable() and resetting controller are required for recovering
    controller, but the two are run from different contexts. nvme_start_freeze()
    is call from nvme_dev_disable() which is run timeout work context, and
    nvme_unfreeze() is run from reset work context. Unfortunatley timeout may be
    triggered during resetting controller, so nvme_start_freeze() may be run
    several times.
    
- Also two reset work may run one by one, this may cause hang in
nvme_wait_freeze() forever too.

In short, I'd see all these issues described in the following commit log
can be fixed:

	https://marc.info/?l=linux-block&m=152644353006033&w=2

If you think there are better ways, let's talk in code. Again, I am
open to any solution.

Thanks,
Ming
