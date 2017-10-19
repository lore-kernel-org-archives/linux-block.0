Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 09:14:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/17] nvme: track subsystems
Message-ID: <20171019071405.GA11980@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-14-hch@lst.de> <20171018223913.GA1846@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018223913.GA1846@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

> I'm having some trouble with this one. The device_initialize() initializes
> the kobj's reference counter, and then the device_add() takes another
> reference on it.
> 
> The teardown, though, only calls put_device(). Where's the call to
> device_del() supposed to go that ultimately drops the last reference
> to call the .release 'nvme_free_subsystem'?

Yes, this is buggy.  I took the code from Hannes patches without
retesting a module unload.  I'll go back to the drawing board.
