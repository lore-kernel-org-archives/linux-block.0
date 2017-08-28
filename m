Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 08/10] block: provide a generic_make_request_fast helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <326ee3b3-441f-e093-6d6f-7356e1ff8487@grimberg.me>
Date: Mon, 28 Aug 2017 10:00:35 +0300
MIME-Version: 1.0
In-Reply-To: <20170823175815.3646-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

> This helper allows reinserting a bio into a new queue without much
> overhead, but requires all queue limits to be the same for the upper
> and lower queues, and it does not provide any recursion preventions,
> which requires the caller to not split the bio.

Isn't the same limits constraint too restrictive?

Say I have two paths to the same namespace via two different HBAs, each
with its own virt_boundary capability for example? That would require us
to split failover bio wouldn't it?

> +/*
> + * Fast-path version of generic_make_request.

generic_make_request is also called in the fast-path, maybe reword it
to: "Fast version of generic_make_request"
