Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: generic NVMe over Fabrics library support
Date: Mon,  6 Jun 2016 23:21:51 +0200
Message-Id: <1465248119-17875-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This patch set adds the necessary infrastructure for the NVMe over
Fabrics functionality and the NVMe over Fabrics library itself.

First we add some needed parameters to NVMe request allocation such as flags
(for reserved commands - connect and keep-alive), also support tag
allocation of a given queue ID (for connect to be executed per-queue)
and allow request to be queued at the head of the request queue (so
reconnects can pass in flight I/O).

Second, we add support for additional sysfs attributes that are needed
or useful for the Fabrics driver.

Third we add the NVMe over Fabrics related header definitions and the
Fabrics library itself which is transport independent and handles
Fabrics specific commands and variables.

Last, we add support for periodic keep-alive mechanism which is mandatory
for Fabrics.
