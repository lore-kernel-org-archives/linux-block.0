Return-Path: <hch@lst.de>
Date: Fri, 29 Dec 2017 10:50:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Scott Bauer <sbauer@eng.utah.edu>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
Message-ID: <20171229095021.GD24043@lst.de>
References: <20171221204636.2924-1-keith.busch@intel.com> <20171221204636.2924-4-keith.busch@intel.com> <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu> <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk> <20171221213400.GB2975@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221213400.GB2975@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 21, 2017 at 02:34:00PM -0700, Keith Busch wrote:
> It would be nice, but the driver doesn't know a request's completion
> is going to be a polled.

We can trivially set a REQ_POLL bit.  In fact my initial patch kit had
those on the insitence of Jens, but then I removed it because we had
no users for it.

> Even if it did, we don't have a spec defined
> way to tell the controller not to send an interrupt with this command's
> compeletion, which would be negated anyway if any interrupt driven IO
> is mixed in the same queue.

Time to add such a flag to the spec then..

> We could possibly create a special queue
> with interrupts disabled for this purpose if we can pass the HIPRI hint
> through the request.

Eww.  That means we double our resource usage both in the host and
the device, which isn't going to be pretty.
