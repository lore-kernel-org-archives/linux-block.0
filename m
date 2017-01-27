Return-Path: <BATV+3cdfc0cdff764882efbb+4905+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: axboe@kernel.dk,
	pbonzini@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: automatic IRQ affinity for virtio V2
Date: Fri, 27 Jan 2017 09:16:28 +0100
Message-Id: <1485504997-17584-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Michael, hi Jason,

This patches applies a few cleanups to the virtio PCI interrupt handling
code, and then converts the virtio PCI code to use the automatic MSI-X
vectors spreading, as well as using the information in virtio-blk
and virtio-scsi to automatically align the blk-mq queues to the MSI-X
vectors.

Changes since V1:
 - dropped the patches already merged for 4.10-rc
 - new patch to remove struct virtio_pci_vq_info
 - improve probe error handling by unwinding step by step
 - new patch to convert virtio-scsi
