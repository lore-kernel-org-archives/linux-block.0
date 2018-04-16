Return-Path: <linux-ide-owner@vger.kernel.org>
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
To: Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-2-hch@lst.de>
Cc: x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 14:26:07 +0530
MIME-Version: 1.0
In-Reply-To: <20180415145947.1248-2-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This code is only used by sparc, and all new iommu drivers should use the
> drivers/iommu/ framework.  Also remove the unused exports.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Right, these functions are used only from SPARC architecture. Simple
git grep confirms it as well. Hence it makes sense to move them into
arch code instead.

git grep iommu_tbl_pool_init
----------------------------

arch/sparc/include/asm/iommu-common.h:extern void iommu_tbl_pool_init(struct iommu_map_table *iommu,
arch/sparc/kernel/iommu-common.c:void iommu_tbl_pool_init(struct iommu_map_table *iommu,
arch/sparc/kernel/iommu.c:      iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,
arch/sparc/kernel/ldc.c:        iommu_tbl_pool_init(iommu, num_tsb_entries, PAGE_SHIFT,
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_pool_init(&atu->tbl, num_iotte, IO_PAGE_SHIFT,
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,

git grep iommu_tbl_range_alloc
------------------------------

arch/sparc/include/asm/iommu-common.h:extern unsigned long iommu_tbl_range_alloc(struct device *dev,
arch/sparc/kernel/iommu-common.c:unsigned long iommu_tbl_range_alloc(struct device *dev,
arch/sparc/kernel/iommu.c:      entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL,
arch/sparc/kernel/iommu.c:              entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
arch/sparc/kernel/ldc.c:        entry = iommu_tbl_range_alloc(NULL, &iommu->iommu_map_table,
arch/sparc/kernel/pci_sun4v.c:  entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
arch/sparc/kernel/pci_sun4v.c:  entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
arch/sparc/kernel/pci_sun4v.c:          entry = iommu_tbl_range_alloc(dev, tbl, npages,

git grep iommu_tbl_range_free
-----------------------------

arch/sparc/include/asm/iommu-common.h:extern void iommu_tbl_range_free(struct iommu_map_table *iommu,
arch/sparc/kernel/iommu-common.c:void iommu_tbl_range_free(struct iommu_map_table *iommu, u64 dma_addr,
arch/sparc/kernel/iommu.c:      iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/iommu.c:      iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/iommu.c:                      iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
arch/sparc/kernel/iommu.c:              iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
arch/sparc/kernel/ldc.c:        iommu_tbl_range_free(&iommu->iommu_map_table, cookie, npages, entry);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, *dma_addrp, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, dvma, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:  iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
arch/sparc/kernel/pci_sun4v.c:                  iommu_tbl_range_free(tbl, vaddr, npages,
arch/sparc/kernel/pci_sun4v.c:          iommu_tbl_range_free(tbl, dma_handle, npages,

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

