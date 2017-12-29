Return-Path: <keith.busch@intel.com>
Date: Fri, 29 Dec 2017 08:51:59 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Scott Bauer <sbauer@eng.utah.edu>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
Message-ID: <20171229155158.GC16407@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
 <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
 <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
 <20171221213400.GB2975@localhost.localdomain>
 <20171229095021.GD24043@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229095021.GD24043@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 29, 2017 at 10:50:21AM +0100, Christoph Hellwig wrote:
> > We could possibly create a special queue
> > with interrupts disabled for this purpose if we can pass the HIPRI hint
> > through the request.
> 
> Eww.  That means we double our resource usage both in the host and
> the device, which isn't going to be pretty.

Yes, this would create some trouble for our simple policy for divvying
queue resources. We wouldn't be able to use the PCI IRQ affinity for
these queues CPU map, for example.

Maybe if we can figure out a good policy for WRR queues, that might
present a similar infrastructure for supporting polled queues as well.
