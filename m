Return-Path: <hch@lst.de>
Date: Thu, 27 Jul 2017 15:26:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, shli@kernel.org, osandov@osandov.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: provide an explicit n:1 mapping for single
	queue devices
Message-ID: <20170727132613.GA17341@lst.de>
References: <20170726201934.4940-1-hch@lst.de> <f0e19316-57b5-3fe7-d410-26a764d66dc3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f0e19316-57b5-3fe7-d410-26a764d66dc3@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 26, 2017 at 02:40:50PM -0600, Jens Axboe wrote:
> On 07/26/2017 02:19 PM, Christoph Hellwig wrote:
> > This avoids having to deal with the nr_hw_queues = 1 case in the various
> > queue mapping helpers by special casing it in the blk-mq core.
> 
> Why special case it at all? If ->map_queues() is properly written,
> the single queue case should just fall out naturally. I don't see
> why 1 should be any different than 2, 4, or N.

Because 1 means everything maps to queue 0 and there is no point
in asking any lower layers for a specific mapping.  We could instead
special case it in pci, virtio and the upcoming rdma handler, or
we could just do it once in the core and get same result with less
overhead.
