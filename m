Return-Path: <BATV+9cf0d970ddff402c2c33+4973+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	martin.petersen@oracle.com,
	agk@redhat.com,
	snitzer@redhat.com,
	shli@kernel.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: always use REQ_OP_WRITE_ZEROES for zeroing offload V2
Date: Wed,  5 Apr 2017 16:21:38 +0200
Message-Id: <20170405142205.6477-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This series makes REQ_OP_WRITE_ZEROES the only zeroing offload
supported by the block layer, and switches existing implementations
of REQ_OP_DISCARD that correctly set discard_zeroes_data to it,
removes incorrect discard_zeroes_data, and also switches WRITE SAME
based zeroing in SCSI to this new method.

The series is against the block for-next tree.

A git tree is also avaiable at:

    git://git.infradead.org/users/hch/block.git discard-rework.2

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/discard-rework.2

Changes since V2:
 - various spelling fixes
 - various reviews captured
 - two new patches from Martin at the end
