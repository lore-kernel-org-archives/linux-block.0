Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: nvme cleanups in preparation for the multipath code
Date: Thu,  2 Nov 2017 21:28:50 +0300
Message-Id: <20171102182856.9162-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

below are a couple cleanup patches to prepare for the next version
of the nvme multipath code.
