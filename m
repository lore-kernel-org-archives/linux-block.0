Return-Path: <BATV+bdb09ad5f0bc9ee27162+5405+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [RFC] cleanup bcache bio handling
Date: Mon, 11 Jun 2018 21:48:00 +0200
Message-Id: <20180611194806.13222-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series cleans up various places where bcache is way too intimate
with bio internals.  This is intended as a baseline for the multi-page
biovec work, which requires some nasty workarounds for the existing
code.

Note that I do not have a bcache test setup, so this will require
some careful actual testing with whatever test cases are used for
bcache.

Also the new bio_reused helper should be useful at least for MD raid,
but that work is left for later.
