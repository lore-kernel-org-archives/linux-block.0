Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: provide an explicit n:1 mapping for single queue
 devices
To: Christoph Hellwig <hch@lst.de>
Cc: shli@kernel.org, osandov@osandov.com, linux-block@vger.kernel.org
References: <20170726201934.4940-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f0e19316-57b5-3fe7-d410-26a764d66dc3@kernel.dk>
Date: Wed, 26 Jul 2017 14:40:50 -0600
MIME-Version: 1.0
In-Reply-To: <20170726201934.4940-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/26/2017 02:19 PM, Christoph Hellwig wrote:
> This avoids having to deal with the nr_hw_queues = 1 case in the various
> queue mapping helpers by special casing it in the blk-mq core.

Why special case it at all? If ->map_queues() is properly written,
the single queue case should just fall out naturally. I don't see
why 1 should be any different than 2, 4, or N.

-- 
Jens Axboe
