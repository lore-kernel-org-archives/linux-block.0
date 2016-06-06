Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: general preparation for NVMe over Fabrics support
Date: Mon,  6 Jun 2016 23:20:42 +0200
Message-Id: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This patch set adds some needed preparations for the upcoming NVMe over
Fabrics support.

Contains:
- Allow transfer size limitations for NVMe transports
- Add the get_log_page command definition required by the NVMe target
- more helpers in core code that can be used by various transports
- add some missing constants and identify attributes
