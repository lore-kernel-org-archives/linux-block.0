Return-Path: <hch@lst.de>
Date: Mon, 28 Aug 2017 10:54:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 08/10] block: provide a generic_make_request_fast helper
Message-ID: <20170828085447.GB4358@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-9-hch@lst.de> <326ee3b3-441f-e093-6d6f-7356e1ff8487@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <326ee3b3-441f-e093-6d6f-7356e1ff8487@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 10:00:35AM +0300, Sagi Grimberg wrote:
>> This helper allows reinserting a bio into a new queue without much
>> overhead, but requires all queue limits to be the same for the upper
>> and lower queues, and it does not provide any recursion preventions,
>> which requires the caller to not split the bio.
>
> Isn't the same limits constraint too restrictive?
>
> Say I have two paths to the same namespace via two different HBAs, each
> with its own virt_boundary capability for example? That would require us
> to split failover bio wouldn't it?

Uh oh - different transports for the same subsystem will be intereting.
For one it's not specified anywhere so I'd like to kick off a discussion
on the working group mailing list about it.

That being said ->make_request basically doesn't care about actual
limits at all, it mostly care about support features (e.g. discard, fua,
etc).  So I think a lot of these limits could porbably be lifted,
but I'd need to add the check to generic_make_request_checks back.

>> +/*
>> + * Fast-path version of generic_make_request.
>
> generic_make_request is also called in the fast-path, maybe reword it
> to: "Fast version of generic_make_request"

Yeah.  Maybe generic_make_request_direct or direct_make_request
is a better name as it describes the recursion avoidance bypassing
a little better.
