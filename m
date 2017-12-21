Return-Path: <keith.busch@intel.com>
Date: Thu, 21 Dec 2017 16:10:55 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Scott Bauer <sbauer@eng.utah.edu>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
Message-ID: <20171221231054.GA2875@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
 <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
 <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
 <20171221213400.GB2975@localhost.localdomain>
 <5d3f06bf-8cb8-048d-30c5-9af611ad9ee7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d3f06bf-8cb8-048d-30c5-9af611ad9ee7@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 21, 2017 at 03:17:41PM -0700, Jens Axboe wrote:
> On 12/21/17 2:34 PM, Keith Busch wrote:
> > It would be nice, but the driver doesn't know a request's completion
> > is going to be a polled. 
> 
> That's trivially solvable though, since the information is available
> at submission time.
> 
> > Even if it did, we don't have a spec defined
> > way to tell the controller not to send an interrupt with this command's
> > compeletion, which would be negated anyway if any interrupt driven IO
> > is mixed in the same queue. We could possibly create a special queue
> > with interrupts disabled for this purpose if we can pass the HIPRI hint
> > through the request.
> 
> There's on way to do it per IO, right. But you can create a sq/cq pair
> without interrupts enabled. This would also allow you to scale better
> with multiple users of polling, a case where we currently don't
> perform as well spdk, for instance.

Would you be open to have blk-mq provide special hi-pri hardware contexts
for all these requests to come through? Maybe one per NUMA node? If not,
I don't think have enough unused bits in the NVMe command id to stash
the hctx id to extract the original request.
