Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
 <84429b00-300f-a36b-c4ac-b7d930ca6c7e@grimberg.me>
 <20170828090620.GA4529@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e17a3f51-30ed-9588-eac3-5e76cab80848@grimberg.me>
Date: Mon, 28 Aug 2017 16:40:43 +0300
MIME-Version: 1.0
In-Reply-To: <20170828090620.GA4529@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> the make_request
> 
> That basically just does a lookup (in a data structure we need for
> tracking the siblings inside nvme anyway) and the submits the
> I/O again.  The generic code all is in generic_make_request_fast.
> There are two more things which could move into common code, one
> reasonable, the other not:
> 
>   (1) the whole requeue_list list logic.  I thought about moving this
>       to the block layer as I'd also have some other use cases for it,
>       but decided to wait until those materialize to see if I'd really
>       need it.
>   (2) turning the logic inside out, e.g. providing a generic make_request
>       and supplying a find_path callback to it.  This would require (1)
>       but even then we'd save basically no code, add an indirect call
>       in the fast path and make things harder to read.  This actually
>       is how I started out and didn't like it.
> 
>> and failover logic
> 
> The big thing about the failover logic is looking a the detailed error
> codes and changing the controller state, all of which is fundamentally
> driver specific.  The only thing that could reasonably be common is
> the requeue_list handling as mentioned above.  Note that this will
> become even more integrated with the nvme driver once ANA support
> lands.

Not arguing with you at all, you obviously gave it a lot of thought.

I thought your multipathing code would really live in the block
layer and only require something really basic from nvme (which could
easily be applied on other drivers). But I do understand it might
create a lot of churn.

btw, why are partial completions something that can't be done
without cloning the bio? is it possible to clone the bio once from the
completion flow when you see that you got a partial completion?
