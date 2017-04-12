Return-Path: <BATV+4e9b246676c62bade7ff+4980+infradead.org+hch@bombadil.srs.infradead.org>
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
Subject: remove REQ_OP_WRITE_SAME
Date: Wed, 12 Apr 2017 10:48:01 +0200
Message-Id: <20170412084809.8245-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
have two callers left, and both just export optional protocol features
to remote systems: DRBD and the target code.

For the target code the only real use case was zeroing offload, which
is kept with this series, and for DRBD I suspect the same based on the
usage.

    git://git.infradead.org/users/hch/block.git delete-write-same

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/delete-write-same

Changes from RFC:
 - add zeroing offload for the SCSI target.
