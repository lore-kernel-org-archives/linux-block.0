Return-Path: <keith.busch@intel.com>
Date: Wed, 16 May 2018 08:12:42 -0600
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180516141242.GA20119@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516040313.13596-12-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

I'm sorry, but I am frankly not on board with introducing yet
another work-queue into this driver for handling this situation. The
fact you missed syncing with this queue in the surprise remove case,
introducing various use-after-free conditions, just demonstrates exactly
how over-complicated this approach is. That, and the forced controller
state transtions is yet another way surprise removal will break as its
depending on the state machine to prevent certain transitions.

The driver is already in a work queue context when it becomes aware of
corrective action being necessary. Seriously, simply syncing these in the
reset convers nearly all conditions you're concered with, most of which
will be obviated if Bart's blk-mq timeout rework is added. The only case
that isn't covered is if IO stops when renumbering the hardware contexts
(unlikely as that is), and that's easily fixable just moving that into
the scan_work.

As far as blktests block/011 is concerned, I think this needs to be
rethought considering what it's actually showing us. The fact the
pci driver provides such an easy way to not only muck with PCI config
register *and* internal kernel structures out from under a driver that's
bound to it is insane.  If PCI really wants to provide this sysfs entry,
it really ought to notify bound drivers that this is occuring, similar
to the 'reset' sysfs.

Anyway, there is merit to some of your earlier patches. In particular,
specifically patches 2, 4, and 5.  On the timing out the host memory
releasing (patch 2), I would just rather see this as a generic API,
though:

  http://lists.infradead.org/pipermail/linux-nvme/2018-January/015313.html
  http://lists.infradead.org/pipermail/linux-nvme/2018-January/015314.html
