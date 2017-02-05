Return-Path: <BATV+7c9ed557eb952ccf5513+4914+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: axboe@kernel.dk,
	pbonzini@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: automatic IRQ affinity for virtio V3
Date: Sun,  5 Feb 2017 18:15:17 +0100
Message-Id: <20170205171526.6224-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Michael, hi Jason,

This patches applies a few cleanups to the virtio PCI interrupt handling
code, and then converts the virtio PCI code to use the automatic MSI-X
vectors spreading, as well as using the information in virtio-blk
and virtio-scsi to automatically align the blk-mq queues to the MSI-X
vectors.

Changes since V2:
 - remove a redundant callback check
 - calculate ->msix_vectors correctly
 - add a few Reviewed-by: tags for Jason

Changes since V1:
 - dropped the patches already merged for 4.10-rc
 - new patch to remove struct virtio_pci_vq_info
 - improve probe error handling by unwinding step by step
 - new patch to convert virtio-scsi
