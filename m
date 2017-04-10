Return-Path: <BATV+d06792d33419b921eada+4978+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	target-devel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	dm-devel@redhat.com
Subject: RFC: remove REQ_OP_WRITE_SAME
Date: Mon, 10 Apr 2017 18:07:59 +0200
Message-Id: <20170410160807.23674-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
have two callers left, and both just export optional protocol features
to remote systems: DRBD and the target code.

Do we have any major users of those?  If not removing it will clean up
a few warts in the block layer.

    git://git.infradead.org/users/hch/block.git delete-write-same

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/delete-write-same
