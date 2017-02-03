Return-Path: <BATV+1f42f42caf748e0126fd+4912+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: spread MSI(-X) vectors to all possible CPUs
Date: Fri,  3 Feb 2017 15:35:54 +0100
Message-Id: <20170203143600.32307-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series changes our automatic MSI-X vector assignment so that it
takes all present CPUs into account instead of all online ones.  This
allows to better deal with cpu hotplug events, which could happen
frequently due to power management for example.
