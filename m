Return-Path: <BATV+b05e9fb8710da454cfb6+5260+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: keith.busch@intel.com,
	linux-block@vger.kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: two more nvme fixes for Linux 4.15
Date: Wed, 17 Jan 2018 22:04:36 +0100
Message-Id: <20180117210438.3778-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below are the two fixes for the new SGL support in 4.15 as a patch
series due to the issues with the git server.
