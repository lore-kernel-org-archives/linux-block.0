Return-Path: <BATV+df5a2477ff0fa86e9985+5386+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: BLK_EH_HANDLED
Date: Wed, 23 May 2018 14:19:27 +0200
Message-Id: <20180523121941.8632-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series removes the BLK_EH_HANDLED return value, and instead places
responsibility of timed out commands entirely on the drivers.  Except
for some odd layering vilations in libiscsi this actually is
surprisingly simple.  The last two pathes contain a respin of Keith'
series to refcount struct request in the eye of timeouts.  Once the
BLK_EH_HANDLED special case is gone this actually seems the EH fixing
approach that seems the most sensible to me.
