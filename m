Return-Path: <BATV+e0efdd19ce80d487e3da+5372+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@wdc.com,
	willy@infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: fix confusion around GFP_* flags and blk_get_request
Date: Wed,  9 May 2018 09:54:02 +0200
Message-Id: <20180509075408.16388-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series sorts out the mess around how we use gfp flags in the
block layer get_request interface.

Changes since RFC:
  - don't switch to GFP_NOIO for allocations in blk_get_request.
    blk_get_request is used by the multipath code in potentially dead lock
    prone areas, so this will need a separate audit and maybe a flag.
