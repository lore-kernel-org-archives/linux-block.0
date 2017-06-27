Return-Path: <axboe@kernel.dk>
Subject: Re: move bounce limits settings into the drivers
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20170619072628.12894-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <393234a3-3c36-46ca-fa23-29f79faf04a1@kernel.dk>
Date: Tue, 27 Jun 2017 12:10:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170619072628.12894-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 01:26 AM, Christoph Hellwig wrote:
> Currently we still default to a bounce all highmem setting for block
> drivers.  This series defaults to no bouncing and instead adds call
> to blk_queue_bounce_limit to those drivers that need it.   It also
> has a few cleanups in that area.

Looks straight forward and trivial to me, I'll pull it in for
4.13.

-- 
Jens Axboe
