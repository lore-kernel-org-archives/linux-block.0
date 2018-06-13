Return-Path: <BATV+1e44ea8f521110dda36c+5407+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [RFC] cleanup bcache bio handling v2
Date: Wed, 13 Jun 2018 15:51:52 +0200
Message-Id: <20180613135158.29477-1-hch@lst.de>
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

Changes since v1:
 - restore bi_size properly
