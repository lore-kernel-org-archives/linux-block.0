Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 10 May 2018 15:44:41 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <tom.leiming@gmail.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: pci: simplify timeout handling
Message-ID: <20180510214441.GD4787@localhost.localdomain>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
 <20180427175157.GB5073@localhost.localdomain>
 <20180428035015.GB5657@ming.t460p>
 <20180508153038.GA30842@localhost.localdomain>
 <CACVXFVO+CuYghN3wHyHV2cskPr2pqaKKyQqQC5Xze4vCvpb+jg@mail.gmail.com>
 <20180510210548.GB4787@localhost.localdomain>
 <CACVXFVNvsjNS0Oi15RnYQm643w-YkFZJT7eKJ+tX_qzGcnu=4A@mail.gmail.com>
 <20180510211829.GC4787@localhost.localdomain>
 <20180510212444.GC3515@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180510212444.GC3515@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 11, 2018 at 05:24:46AM +0800, Ming Lei wrote:
> Could you share me the link?

The diff was in this reply here:

http://lists.infradead.org/pipermail/linux-nvme/2018-April/017019.html

> Firstly, the previous nvme_sync_queues() won't work reliably, so this
> patch introduces blk_unquiesce_timeout() and blk_quiesce_timeout() for
> this purpose.
>
> Secondly, I remembered that you only call nvme_sync_queues() at the
> entry of nvme_reset_work(), but timeout(either admin or normal IO)
> can happen again during resetting, that is another race addressed by
> this patchset, but can't cover by your proposal.

I sync the queues at the beginning because it ensures there is not
a single in flight request for the entire controller (all namespaces
plus admin queue) before transitioning to the connecting state.

If a command times out during connecting state, we go to the dead state.
