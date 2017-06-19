Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: martin.petersen@oracle.com,
	linux-block@vger.kernel.org
Subject: two small cleanups
Date: Mon, 19 Jun 2017 09:24:39 +0200
Message-Id: <20170619072441.12835-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Stop relying on bio_page and a page_address in the Write Same code
and remove an unused macro.
