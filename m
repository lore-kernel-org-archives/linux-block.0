Return-Path: <BATV+21adf70dad931eb5d92e+5128+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: two small bsg fixes, take 3
Date: Thu,  7 Sep 2017 13:54:34 +0200
Message-Id: <20170907115436.5069-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now fully away, with my fair share of coffee and lunch:


Two fixups for the recent bsg-lib fixes, should go into 4.13 stable as
well.
