Return-Path: <BATV+6af1cd90af7787d7b353+4801+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: martin.petersen@oracle.com,
	don.brace@microsemi.com
Cc: axboe@kernel.dk,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: expose queue the queue mapping for SCSI drivers
Date: Sat, 15 Oct 2016 10:47:18 +0200
Message-Id: <1476521241-32765-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

In 4.9 I've added support in the interrupt layer to automatically
assign the interrupt affinity at interrupt allocation time, and
expose that information to blk-mq.

This series extents that so that SCSI driver can pass on the information
as well.  The SCSI part is fairly trivial, although we need to also
export the default queue mapping function in blk-mq to keep things simple.

I've also converted over the smartpqi driver as an example as it's the
easiest of the multiqueue SCSI drivers to convert.  I don't actually
have smartpqi hardware, so that part will need additionaly testing.

(I've tested it with virtio_scsi, but that requires a lot of virtio
 changes not ready to post yet)
