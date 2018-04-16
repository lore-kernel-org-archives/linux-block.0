Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: remove PCI_DMA_BUS_IS_PHYS 
Date: Mon, 16 Apr 2018 10:50:20 +0200
Message-Id: <20180416085032.7367-1-hch@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series tries to get rid of the global and PCI_DMA_BUS_IS_PHYS flag,
which causes the block layer and networking code to bounce buffer memory
above the dma mask in some cases.  It is a leftover from i386 + highmem
days and is obsolete now that we have swiotlb or iommus so that the
dma ops implementations can always (well minus the ISA DMA case which
will require further attention) handle memory passed to them.
