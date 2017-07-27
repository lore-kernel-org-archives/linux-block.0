Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: provide an explicit n:1 mapping for single queue
 devices
To: Christoph Hellwig <hch@lst.de>
Cc: shli@kernel.org, osandov@osandov.com, linux-block@vger.kernel.org
References: <20170726201934.4940-1-hch@lst.de>
 <f0e19316-57b5-3fe7-d410-26a764d66dc3@kernel.dk>
 <20170727132613.GA17341@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c8cf0d22-318c-0810-c615-f8634988ac5b@kernel.dk>
Date: Thu, 27 Jul 2017 08:10:01 -0600
MIME-Version: 1.0
In-Reply-To: <20170727132613.GA17341@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/27/2017 07:26 AM, Christoph Hellwig wrote:
> On Wed, Jul 26, 2017 at 02:40:50PM -0600, Jens Axboe wrote:
>> On 07/26/2017 02:19 PM, Christoph Hellwig wrote:
>>> This avoids having to deal with the nr_hw_queues = 1 case in the various
>>> queue mapping helpers by special casing it in the blk-mq core.
>>
>> Why special case it at all? If ->map_queues() is properly written,
>> the single queue case should just fall out naturally. I don't see
>> why 1 should be any different than 2, 4, or N.
> 
> Because 1 means everything maps to queue 0 and there is no point
> in asking any lower layers for a specific mapping.  We could instead
> special case it in pci, virtio and the upcoming rdma handler, or
> we could just do it once in the core and get same result with less
> overhead.

Sure, my point is that the nr_queues == 1 case should just naturally
fall out of the mapping function, it's no more special than the other
ones.

-- 
Jens Axboe
