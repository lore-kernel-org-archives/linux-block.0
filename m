Return-Path: <BATV+67dfbb8f664e29ec4bbc+5394+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: elevator init cleanups
Date: Thu, 31 May 2018 19:11:35 +0200
Message-Id: <20180531171141.18478-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The first 5 patches are simple cleanup and refactoring patches.  6 changes
behavior in that it only attaches blk-mq ioscheds once we are done with
probing, but that actually simplifies things a bit too even if it might
be a bit more controversial.
