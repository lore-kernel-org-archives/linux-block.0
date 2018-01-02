Return-Path: <keith.busch@intel.com>
Date: Tue, 2 Jan 2018 09:50:39 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
Message-ID: <20180102165038.GA24386@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-3-keith.busch@intel.com>
 <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me>
 <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
 <20171229094814.GC24043@lst.de>
 <20171229153950.GB16407@localhost.localdomain>
 <5ee695e8-f294-524a-e945-d484cea6df8a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5ee695e8-f294-524a-e945-d484cea6df8a@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Sun, Dec 31, 2017 at 02:30:09PM +0200, Sagi Grimberg wrote:
> Not sure if stealing bios from requests is a better design. Note that
> we do exactly this in other transport (nvme_[rdma|loop|fc]_is_ready).

Well, we're currently failing requests that may succeed if we could
back them out for re-entry. While such scenarios are uncommon, I think
we can handle it better than ending them in failure.
 
> I think it would be better to stick to a coherent behavior across
> the nvme subsystem. If this condition statement is really something
> that is buying us measurable performance gain, I think we should apply
> it for other transports as well (although in fabrics we're a bit
> different because we have a dedicated connect that enters .queue_rq)

We should be able to remove all the state checks in the IO path because
the handlers putting the controller in an IO-incapable state should be
able to quiece the queues before transitioning to that state.

This is not a significant gain compared to the other two patches in this
series, but the sum of all the little things become meaningful.

We'd need to remove this check anyway if we're considering exclusively
polled queues since they wouldn't have a CQ vector.
