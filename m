Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: block layer patches for nvme multipath support
Date: Thu,  2 Nov 2017 21:29:47 +0300
Message-Id: <20171102182954.9263-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

these patches add the block layer helpers / tweaks for NVMe multipath
support.  Can you review them for inclusion?

There have been no functional changes to the versions posted with
previous nvme multipath patchset.
