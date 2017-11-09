Return-Path: <hch@lst.de>
Date: Thu, 9 Nov 2017 13:53:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme: track subsystems
Message-ID: <20171109125356.GB21795@lst.de>
References: <20171102183034.9320-1-hch@lst.de> <20171102183034.9320-2-hch@lst.de> <fbacd62b-4228-60cb-a382-9c88daadb336@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fbacd62b-4228-60cb-a382-9c88daadb336@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 09, 2017 at 01:33:16PM +0200, Sagi Grimberg wrote:
> Any reason to do all this before we know if we found an existing subsystem? 

We'd either have to do all the initialization including the memory
allocation and ida_simple_get under nvme_subsystems_lock, or search
the list first, then allocate, then search again.

Given that the not found case is vastly more common than the found
case that doesn't seem to be worth the tradeoff.

> Also can the enumeration become with "holes" because you
> acquire a subsystem ida temporarily and free it (and another subsystem
> just came in)? Not a big issue though...

It can, just like it can for the discovery controller in fabrics.
but so far that hasn't been an issue.
