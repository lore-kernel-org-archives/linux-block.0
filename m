Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: drop abort sequence, kill BLK_EH_HANDLED v2
Date: Tue, 29 May 2018 15:52:25 +0200
Message-Id: <20180529135239.27005-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series removes the BLK_EH_HANDLED return value, and instead places
responsibility of timed out commands entirely on the drivers.  Except
for some odd layering vilations in libiscsi this actually is
surprisingly simple.   Some of the grunt work here is from Keith and
Bart, just repackaged up

Changes since v1:
 - reordered the series
 - added back submission-time hctx lock
 - use cmpxchg to protect against concurrent blk_abort_request calls.
