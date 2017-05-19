Return-Path: <BATV+c76b9e6b5f659e20e25d+5017+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: spread MSI(-X) vectors to all possible CPUs V2
Date: Fri, 19 May 2017 10:57:49 +0200
Message-Id: <20170519085756.29742-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series changes our automatic MSI-X vector assignment so that it
takes all present CPUs into account instead of all online ones.  This
allows to better deal with cpu hotplug events, which could happen
frequently due to power management for example.

Changes since V1:
 - rebase to current Linus' tree
 - add irq_lock_sparse calls
 - move memory allocations outside of (raw) spinlocks
 - remove the irq_force_complete_move call
 - factor some common code into helpers
 - identation fixups
