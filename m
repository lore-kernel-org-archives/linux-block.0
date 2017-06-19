Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	dm-devel@redhat.com
Subject: move bounce limits settings into the drivers
Date: Mon, 19 Jun 2017 09:26:18 +0200
Message-Id: <20170619072628.12894-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Currently we still default to a bounce all highmem setting for block
drivers.  This series defaults to no bouncing and instead adds call
to blk_queue_bounce_limit to those drivers that need it.   It also
has a few cleanups in that area.
