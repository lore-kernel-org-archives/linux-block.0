Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
 <8c7c2b8a-7e26-c1a1-4681-8c7721184d39@grimberg.me>
 <20171226203518.GA13188@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a5fcb8d2-d18d-dd86-7562-83b85c47891a@grimberg.me>
Date: Wed, 27 Dec 2017 11:02:12 +0200
MIME-Version: 1.0
In-Reply-To: <20171226203518.GA13188@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> Curious to know what does this buy us?
> 
> blk_mq_start_request doesn't do anything to make the command ready to
> submit to hardware, so this is pure software overhead, somewhere between
> 200-300 nanoseconds as far as I can measure (YMMV). We can post the command
> to hardware before taking on this software overhead so the hardware gets
> to fetch the command that much sooner.
> 
> One thing to remember is we need to ensure the driver can't complete the
> request before starting it. The driver's exisitng locking does ensure
> that with this patch, so it's just something to keep in mind if anything
> should ever change in the future.

Needs to be well documented.

This mean we won't be able to split the submission and completion locks
now... So it does present a tradeoff.
