Return-Path: <hch@lst.de>
Date: Mon, 26 Jun 2017 12:00:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: move bounce limits settings into the drivers
Message-ID: <20170626100029.GA14355@lst.de>
References: <20170619072628.12894-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619072628.12894-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

ping?

On Mon, Jun 19, 2017 at 09:26:18AM +0200, Christoph Hellwig wrote:
> Currently we still default to a bounce all highmem setting for block
> drivers.  This series defaults to no bouncing and instead adds call
> to blk_queue_bounce_limit to those drivers that need it.   It also
> has a few cleanups in that area.
---end quoted text---
