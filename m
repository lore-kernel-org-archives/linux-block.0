Return-Path: <BATV+8132ee8c7e24eb087ca3+5055+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: block: spread MSI(-X) vectors to all possible CPUs
Date: Mon, 26 Jun 2017 12:20:55 +0200
Message-Id: <20170626102058.10200-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series contains the left-over block bits to spread the MSI-X
vectors over all CPU.  Thomas already rewrote and then merged the
irq bits into the tip irq/core branch, and this is the remainder.

As there are no dependencies on other block changes adding them
to the tip tree might be easiest if Jens could ACK them.
