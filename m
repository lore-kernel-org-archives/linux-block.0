Return-Path: <BATV+12db14f66c2b178d1d1f+4974+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <jbacik@fb.com>,
	James Smart <james.smart@broadcom.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	dm-devel@redhat.com
Subject: kill req->errors
Date: Thu,  6 Apr 2017 17:39:19 +0200
Message-Id: <20170406153944.10058-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Currently the request structure has an errors field that is used in
various different ways.  The oldest drivers use it as an error count,
blk-mq and the generic timeout code assume that it holds a Linux
errno for block completions, and various drivers use it for internal
status values, often overwriting them with Linux errnos later,
that is unless they are processing passthrough requests in which
case they'll leave their errors in it.

This series kills the ->errors field and replaced it with new fields
in the drivers (or an odd hack in a union in struct request for
two bitrotting old drivers).

Note that this series expects that the patch to remove the mg_disk
driver has been applied already on top of the block for-next tree.
