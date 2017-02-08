Return-Path: <BATV+add76be85c7e68b62602+4917+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: support for multi-range discard requests V3
Date: Wed,  8 Feb 2017 14:46:46 +0100
Message-Id: <20170208134650.5380-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series adds support for merging discontiguous discard bios into a
single request if the driver supports it.  This reduces the number of
discards sent to the device by about a factor of 5-6 for typical
workloads on NVMe, and for slower devices that use I/O scheduling
the number will probably be even bigger but I've not implemented
that support yet.

Changes since V2:
  - really fix nr of NVMe ranges to 256
  - free range on error

Changes since V1:
  - hardcoded max ranges for NVMe to 255
  - minor cleanups
