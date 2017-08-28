Return-Path: <hch@lst.de>
Date: Mon, 28 Aug 2017 16:24:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme
	subsystems
Message-ID: <20170828142444.GA29181@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de> <84429b00-300f-a36b-c4ac-b7d930ca6c7e@grimberg.me> <20170828090620.GA4529@lst.de> <e17a3f51-30ed-9588-eac3-5e76cab80848@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e17a3f51-30ed-9588-eac3-5e76cab80848@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 04:40:43PM +0300, Sagi Grimberg wrote:
> I thought your multipathing code would really live in the block
> layer and only require something really basic from nvme (which could
> easily be applied on other drivers). But I do understand it might
> create a lot of churn.

The earlier versions did a lot more in common code, but I gradually
moved away from that:

 - first I didn't have a separate queue, but just bounced I/O between
   sibling queues.  So there was no new make_request based queue,
   and we had to track the relations in the block layer, with a
   callback to check the path status
 - I got rid of the non-trivial path selector

So in the end very little block layer code remained.  But then again
very little nvme code remained either..

> btw, why are partial completions something that can't be done
> without cloning the bio? is it possible to clone the bio once from the
> completion flow when you see that you got a partial completion?

The problem with partial completions is that blk_update_request
completes bios as soon as it get enough bytes to finish them.

This should not be an unsolvable problem, but it will be a bit messy
at least.  But then again I hope that no new protocols will be designed
with partial completions - SCSI is pretty special in that regard.
