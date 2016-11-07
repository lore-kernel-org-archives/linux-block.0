Return-Path: <BATV+fd6e759d6fe7114d99bf+4824+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: support for partial irq affinity assignment
Date: Mon,  7 Nov 2016 10:47:35 -0800
Message-Id: <1478544462-9549-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This series adds support for automatic interrupt assignment to devices
that have a few vectors that are set aside for admin or config purposes
and thus should not fall into the general per-cpu assginment pool.

The first patch adds that support to the core IRQ and PCI/msi code,
and the second is a small tweak to a block layer helper to make use
of it.  I'd love to have both go into the same tree so that consumers
of this (e.g. the virtio, scsi and rdma trees) only need to pull in
one of these trees as dependency.

Changes since V1:
 - split up into more patches (thanks to Thomas for the initial work)
 - simplify internal parameter passing a bit (also thanks to Thomas)
