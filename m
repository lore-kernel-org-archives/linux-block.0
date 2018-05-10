Return-Path: <ming.lei@redhat.com>
Date: Thu, 10 May 2018 10:09:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 0/7] nvme: pci: fix & improve timeout handling
Message-ID: <20180510020926.GC9327@ming.t460p>
References: <20180505135905.18815-1-ming.lei@redhat.com>
 <b913ff71-23b3-69e7-b9cc-3c48cb5d9d36@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b913ff71-23b3-69e7-b9cc-3c48cb5d9d36@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 09, 2018 at 01:46:09PM +0800, jianchao.wang wrote:
> Hi ming
> 
> I did some tests on my local.
> 
> [  598.828578] nvme nvme0: I/O 51 QID 4 timeout, disable controller
> 
> This should be a timeout on nvme_reset_dev->nvme_wait_freeze.
> 
> [  598.828743] nvme nvme0: EH 1: before shutdown
> [  599.013586] nvme nvme0: EH 1: after shutdown
> [  599.137197] nvme nvme0: EH 1: after recovery
> 
> The EH 1 have mark the state to LIVE
> 
> [  599.137241] nvme nvme0: failed to mark controller state 1
> 
> So the EH 0 failed to mark state to LIVE
> The card was removed.
> This should not be expected by nested EH.

Right.

> 
> [  599.137322] nvme nvme0: Removing after probe failure status: 0
> [  599.326539] nvme nvme0: EH 0: after recovery
> [  599.326760] nvme0n1: detected capacity change from 128035676160 to 0
> [  599.457208] nvme nvme0: failed to set APST feature (-19)
> 
> nvme_reset_dev should identify whether it is nested.

The above should be caused by race between updating controller state,
hope I can find some time in this week to investigate it further.

Also maybe we can change to remove controller until nested EH has
been tried enough times.

Thanks,
Ming
