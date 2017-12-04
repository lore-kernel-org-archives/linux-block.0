Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbdLDQgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 11:36:03 -0500
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dma-mapping: replace PCI_DMA_BUS_IS_PHYS with a flag in struct dma_map_ops
Date: Mon,  4 Dec 2017 08:36:01 -0800
Message-Id: <20171204163601.3055-4-hch@lst.de>
In-Reply-To: <20171204163601.3055-1-hch@lst.de>
References: <20171204163601.3055-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The current PCI_DMA_BUS_IS_PHYS decided if a dma implementation is bound
by the dma mask in the device because it directly maps to a physical
address range (modulo an offset in the device), or if it is virtualized
by an iommu and can map any address (that includes virtual iommus like
swiotlb).  The problem with this scheme is that it is per-architecture and
not per dma_ops instance, and we are growing more and more setups that
have multiple different dma operations in use on a single system, for
which this scheme can't provide a correct answer.  Depending on the
architecture that means we either get a false positive or false negative
at the moment.

This patch instead adds a new is_iommu flag in struct dma_map_ops that
tells if a dma_map_ops instance can map any possible physical address
to replace both the PCI_DMA_BUS_IS_PHYS macro and the is_phys field
in struct dma_map_ops used by it on a few architectures.

Note that this means that we now need a struct device parent in the
Scsi_Host or netdevice.  Every modern driver has these, but there might
still be a few outdated legacy drivers out there, which now won't make
an intelligent decision.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/pci.h             |  5 -----
 arch/alpha/kernel/pci_iommu.c            |  1 +
 arch/arc/include/asm/pci.h               |  6 ------
 arch/arm/include/asm/pci.h               |  7 -------
 arch/arm64/include/asm/pci.h             |  5 -----
 arch/arm64/mm/dma-mapping.c              |  2 ++
 arch/cris/include/asm/pci.h              |  6 ------
 arch/h8300/include/asm/pci.h             |  2 --
 arch/hexagon/kernel/dma.c                |  1 -
 arch/ia64/hp/common/sba_iommu.c          |  4 +---
 arch/ia64/include/asm/pci.h              | 17 -----------------
 arch/ia64/kernel/pci-swiotlb.c           |  1 +
 arch/ia64/kernel/setup.c                 | 12 ------------
 arch/ia64/sn/kernel/io_common.c          |  5 -----
 arch/ia64/sn/pci/pci_dma.c               |  1 +
 arch/m68k/include/asm/pci.h              |  6 ------
 arch/microblaze/include/asm/pci.h        |  6 ------
 arch/mips/include/asm/pci.h              |  7 -------
 arch/mn10300/include/asm/pci.h           |  6 ------
 arch/parisc/include/asm/pci.h            | 23 -----------------------
 arch/parisc/kernel/setup.c               |  5 -----
 arch/powerpc/include/asm/pci.h           | 18 ------------------
 arch/powerpc/kernel/dma-iommu.c          |  1 +
 arch/powerpc/kernel/dma-swiotlb.c        |  1 +
 arch/powerpc/platforms/cell/iommu.c      |  1 +
 arch/powerpc/platforms/ps3/system-bus.c  |  2 ++
 arch/powerpc/platforms/pseries/ibmebus.c |  1 +
 arch/powerpc/platforms/pseries/vio.c     |  1 +
 arch/riscv/include/asm/pci.h             |  3 ---
 arch/s390/include/asm/pci.h              |  2 --
 arch/s390/pci/pci_dma.c                  |  3 +--
 arch/sh/include/asm/pci.h                |  6 ------
 arch/sh/kernel/dma-nommu.c               |  1 -
 arch/sparc/include/asm/pci_32.h          |  4 ----
 arch/sparc/include/asm/pci_64.h          |  6 ------
 arch/sparc/kernel/iommu.c                |  1 +
 arch/sparc/kernel/ioport.c               |  1 +
 arch/sparc/kernel/pci_sun4v.c            |  1 +
 arch/tile/include/asm/pci.h              | 14 --------------
 arch/tile/kernel/pci-dma.c               |  2 ++
 arch/x86/include/asm/pci.h               |  2 --
 arch/x86/kernel/amd_gart_64.c            |  1 +
 arch/x86/kernel/pci-calgary_64.c         |  1 +
 arch/x86/kernel/pci-nommu.c              |  1 -
 arch/x86/kernel/pci-swiotlb.c            |  1 +
 arch/x86/mm/mem_encrypt.c                |  1 +
 arch/x86/pci/sta2x11-fixup.c             |  1 +
 arch/xtensa/include/asm/pci.h            |  7 -------
 drivers/ide/ide-lib.c                    |  5 ++---
 drivers/ide/ide-probe.c                  |  2 +-
 drivers/iommu/amd_iommu.c                |  1 +
 drivers/iommu/intel-iommu.c              |  1 +
 drivers/parisc/ccio-dma.c                |  3 +--
 drivers/parisc/sba_iommu.c               |  3 +--
 drivers/pci/host/vmd.c                   |  1 +
 drivers/scsi/scsi_lib.c                  | 14 ++++++--------
 drivers/xen/swiotlb-xen.c                |  1 +
 include/asm-generic/pci.h                |  8 --------
 include/linux/dma-mapping.h              | 16 +++++++++++++++-
 lib/dma-virt.c                           |  1 +
 net/core/dev.c                           | 18 ++++++++----------
 tools/virtio/linux/dma-mapping.h         |  2 --
 62 files changed, 63 insertions(+), 225 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index b9ec55351924..cf6bc1e64d66 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -56,11 +56,6 @@ struct pci_controller {
 
 /* IOMMU controls.  */
 
-/* The PCI address space does not equal the physical memory address space.
-   The networking and block device layers use this boolean for bounce buffer
-   decisions.  */
-#define PCI_DMA_BUS_IS_PHYS  0
-
 /* TODO: integrate with include/asm-generic/pci.h ? */
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 83b34b9188ea..bf83937d5368 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -949,6 +949,7 @@ const struct dma_map_ops alpha_pci_ops = {
 	.unmap_sg		= alpha_pci_unmap_sg,
 	.mapping_error		= alpha_pci_mapping_error,
 	.dma_supported		= alpha_pci_supported,
+	.is_iommu		= true,
 };
 
 const struct dma_map_ops *dma_ops = &alpha_pci_ops;
diff --git a/arch/arc/include/asm/pci.h b/arch/arc/include/asm/pci.h
index ba56c23c1b20..4ff53c041c64 100644
--- a/arch/arc/include/asm/pci.h
+++ b/arch/arc/include/asm/pci.h
@@ -16,12 +16,6 @@
 #define PCIBIOS_MIN_MEM 0x100000
 
 #define pcibios_assign_all_busses()	1
-/*
- * The PCI address space does equal the physical memory address space.
- * The networking and block device layers use this boolean for bounce
- * buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS	1
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 960d9dc4f380..05b2eb2dc76f 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -22,13 +22,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif /* CONFIG_PCI_DOMAINS */
 
-/*
- * The PCI address space does equal the physical memory address space.
- * The networking and block device layers use this boolean for bounce
- * buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS     (1)
-
 #define HAVE_PCI_MMAP
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 8747f7c5e0e7..9e690686e8aa 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -18,11 +18,6 @@
 #define pcibios_assign_all_busses() \
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
-/*
- * PCI address space differs from physical memory address space
- */
-#define PCI_DMA_BUS_IS_PHYS	(0)
-
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 
 extern int isa_dma_bridge_buggy;
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index b45c5bcaeccb..43190a914c95 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -383,6 +383,7 @@ static const struct dma_map_ops swiotlb_dma_ops = {
 	.sync_sg_for_device = __swiotlb_sync_sg_for_device,
 	.dma_supported = __swiotlb_dma_supported,
 	.mapping_error = __swiotlb_dma_mapping_error,
+	.is_iommu = true,
 };
 
 static int __init atomic_pool_init(void)
@@ -867,6 +868,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.map_resource = iommu_dma_map_resource,
 	.unmap_resource = iommu_dma_unmap_resource,
 	.mapping_error = iommu_dma_mapping_error,
+	.is_iommu = true,
 };
 
 static int __init __iommu_dma_init(void)
diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
index dcfef6407ae6..eb1f7f172f4b 100644
--- a/arch/cris/include/asm/pci.h
+++ b/arch/cris/include/asm/pci.h
@@ -27,12 +27,6 @@
 #include <linux/string.h>
 #include <asm/io.h>
 
-/* The PCI address space does equal the physical memory
- * address space.  The networking and block device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS	(1)
-
 #define HAVE_PCI_MMAP
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
diff --git a/arch/h8300/include/asm/pci.h b/arch/h8300/include/asm/pci.h
index 7c9e55d62215..d4d345a52092 100644
--- a/arch/h8300/include/asm/pci.h
+++ b/arch/h8300/include/asm/pci.h
@@ -15,6 +15,4 @@ static inline void pcibios_penalize_isa_irq(int irq, int active)
 	/* We don't do dynamic PCI IRQ allocation */
 }
 
-#define PCI_DMA_BUS_IS_PHYS	(1)
-
 #endif /* _ASM_H8300_PCI_H */
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 546792d176a4..35aaab72ddd0 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -207,7 +207,6 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
 	.mapping_error	= hexagon_mapping_error,
-	.is_phys	= 1,
 };
 
 void __init hexagon_dma_init(void)
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index aec4a3354abe..bc6daf7dace4 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -1845,9 +1845,6 @@ static void ioc_init(unsigned long hpa, struct ioc *ioc)
 	ioc_resource_init(ioc);
 	ioc_sac_init(ioc);
 
-	if ((long) ~iovp_mask > (long) ia64_max_iommu_merge_mask)
-		ia64_max_iommu_merge_mask = ~iovp_mask;
-
 	printk(KERN_INFO PFX
 		"%s %d.%d HPA 0x%lx IOVA space %dMb at 0x%lx\n",
 		ioc->name, (ioc->rev >> 4) & 0xF, ioc->rev & 0xF,
@@ -2229,6 +2226,7 @@ const struct dma_map_ops sba_dma_ops = {
 	.sync_sg_for_device	= machvec_dma_sync_sg,
 	.dma_supported		= sba_dma_supported,
 	.mapping_error		= sba_dma_mapping_error,
+	.is_iommu		= true,
 };
 
 void sba_dma_init(void)
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index b1d04e8bafc8..780e8744ba85 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -30,23 +30,6 @@ struct pci_vector_struct {
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
-/*
- * PCI_DMA_BUS_IS_PHYS should be set to 1 if there is _necessarily_ a direct
- * correspondence between device bus addresses and CPU physical addresses.
- * Platforms with a hardware I/O MMU _must_ turn this off to suppress the
- * bounce buffer handling code in the block and network device layers.
- * Platforms with separate bus address spaces _must_ turn this off and provide
- * a device DMA mapping implementation that takes care of the necessary
- * address translation.
- *
- * For now, the ia64 platforms which may have separate/multiple bus address
- * spaces all have I/O MMUs which support the merging of physically
- * discontiguous buffers, so we can use that as the sole factor to determine
- * the setting of PCI_DMA_BUS_IS_PHYS.
- */
-extern unsigned long ia64_max_iommu_merge_mask;
-#define PCI_DMA_BUS_IS_PHYS	(ia64_max_iommu_merge_mask == ~0UL)
-
 #define HAVE_PCI_MMAP
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define arch_can_pci_mmap_wc()	1
diff --git a/arch/ia64/kernel/pci-swiotlb.c b/arch/ia64/kernel/pci-swiotlb.c
index 5e50939aa03e..497f7a02d1ae 100644
--- a/arch/ia64/kernel/pci-swiotlb.c
+++ b/arch/ia64/kernel/pci-swiotlb.c
@@ -44,6 +44,7 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.dma_supported = swiotlb_dma_supported,
 	.mapping_error = swiotlb_dma_mapping_error,
+	.is_iommu = true,
 };
 
 void __init swiotlb_dma_init(void)
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index dee56bcb993d..ad43cbf70628 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -123,18 +123,6 @@ unsigned long ia64_i_cache_stride_shift = ~0;
 #define	CACHE_STRIDE_SHIFT	5
 unsigned long ia64_cache_stride_shift = ~0;
 
-/*
- * The merge_mask variable needs to be set to (max(iommu_page_size(iommu)) - 1).  This
- * mask specifies a mask of address bits that must be 0 in order for two buffers to be
- * mergeable by the I/O MMU (i.e., the end address of the first buffer and the start
- * address of the second buffer must be aligned to (merge_mask+1) in order to be
- * mergeable).  By default, we assume there is no I/O MMU which can merge physically
- * discontiguous buffers, so we set the merge_mask to ~0UL, which corresponds to a iommu
- * page-size of 2^64.
- */
-unsigned long ia64_max_iommu_merge_mask = ~0UL;
-EXPORT_SYMBOL(ia64_max_iommu_merge_mask);
-
 /*
  * We use a special marker for the end of memory and it uses the extra (+1) slot
  */
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 11f2275570fb..8479e9a7ce16 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -480,11 +480,6 @@ sn_io_early_init(void)
 	tioca_init_provider();
 	tioce_init_provider();
 
-	/*
-	 * This is needed to avoid bounce limit checks in the blk layer
-	 */
-	ia64_max_iommu_merge_mask = ~PAGE_MASK;
-
 	sn_irq_lh_init();
 	INIT_LIST_HEAD(&sn_sysdata_list);
 	sn_init_cpei_timer();
diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index 74c934a997bb..350533db030d 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -473,6 +473,7 @@ static struct dma_map_ops sn_dma_ops = {
 	.sync_sg_for_device	= sn_dma_sync_sg_for_device,
 	.mapping_error		= sn_dma_mapping_error,
 	.dma_supported		= sn_dma_supported,
+	.is_iommu		= true,
 };
 
 void sn_dma_init(void)
diff --git a/arch/m68k/include/asm/pci.h b/arch/m68k/include/asm/pci.h
index ef26fae8cf0b..5a4bc223743b 100644
--- a/arch/m68k/include/asm/pci.h
+++ b/arch/m68k/include/asm/pci.h
@@ -4,12 +4,6 @@
 
 #include <asm-generic/pci.h>
 
-/* The PCI address space does equal the physical memory
- * address space.  The networking and block device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS	(1)
-
 #define	pcibios_assign_all_busses()	1
 
 #define	PCIBIOS_MIN_IO		0x00000100
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 114b93488193..00478965f932 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -61,12 +61,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 
 #define HAVE_PCI_LEGACY	1
 
-/* The PCI address space does equal the physical memory
- * address space (no IOMMU).  The IDE and SCSI device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS     (1)
-
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
 extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 2339f42f047a..436099883022 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -121,13 +121,6 @@ extern unsigned long PCIBIOS_MIN_MEM;
 #include <linux/string.h>
 #include <asm/io.h>
 
-/*
- * The PCI address space does equal the physical memory address space.
- * The networking and block device layers use this boolean for bounce
- * buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS     (1)
-
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index 5b75a1b2c4f6..6132966bdf30 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -57,12 +57,6 @@ extern void unit_pci_init(void);
 #include <linux/string.h>
 #include <asm/io.h>
 
-/* The PCI address space does equal the physical memory
- * address space.  The networking and block device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS	(1)
-
 /* Return the index of the PCI controller for device. */
 static inline int pci_controller_num(struct pci_dev *dev)
 {
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 96b7deec512d..3328fd17c19d 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -87,29 +87,6 @@ struct pci_hba_data {
 #define PCI_F_EXTEND		0UL
 #endif /* !CONFIG_64BIT */
 
-/*
- * If the PCI device's view of memory is the same as the CPU's view of memory,
- * PCI_DMA_BUS_IS_PHYS is true.  The networking and block device layers use
- * this boolean for bounce buffer decisions.
- */
-#ifdef CONFIG_PA20
-/* All PA-2.0 machines have an IOMMU. */
-#define PCI_DMA_BUS_IS_PHYS	0
-#define parisc_has_iommu()	do { } while (0)
-#else
-
-#if defined(CONFIG_IOMMU_CCIO) || defined(CONFIG_IOMMU_SBA)
-extern int parisc_bus_is_phys; 	/* in arch/parisc/kernel/setup.c */
-#define PCI_DMA_BUS_IS_PHYS	parisc_bus_is_phys
-#define parisc_has_iommu()	do { parisc_bus_is_phys = 0; } while (0)
-#else
-#define PCI_DMA_BUS_IS_PHYS	1
-#define parisc_has_iommu()	do { } while (0)
-#endif
-
-#endif	/* !CONFIG_PA20 */
-
-
 /*
 ** Most PCI devices (eg Tulip, NCR720) also export the same registers
 ** to both MMIO and I/O port space.  Due to poor performance of I/O Port
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 0e9675f857a5..8d3a7b80ac42 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -58,11 +58,6 @@ struct proc_dir_entry * proc_runway_root __read_mostly = NULL;
 struct proc_dir_entry * proc_gsc_root __read_mostly = NULL;
 struct proc_dir_entry * proc_mckinley_root __read_mostly = NULL;
 
-#if !defined(CONFIG_PA20) && (defined(CONFIG_IOMMU_CCIO) || defined(CONFIG_IOMMU_SBA))
-int parisc_bus_is_phys __read_mostly = 1;	/* Assume no IOMMU is present */
-EXPORT_SYMBOL(parisc_bus_is_phys);
-#endif
-
 void __init setup_cmdline(char **cmdline_p)
 {
 	extern unsigned int boot_args[];
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 8dc32eacc97c..04c1347e2c51 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -91,24 +91,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 
 #define HAVE_PCI_LEGACY	1
 
-#ifdef CONFIG_PPC64
-
-/* The PCI address space does not equal the physical memory address
- * space (we have an IOMMU).  The IDE and SCSI device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS	(0)
-
-#else /* 32-bit */
-
-/* The PCI address space does equal the physical memory
- * address space (no IOMMU).  The IDE and SCSI device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS     (1)
-
-#endif /* CONFIG_PPC64 */
-
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
 extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 66f33e7f8d40..77460f543156 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -122,5 +122,6 @@ struct dma_map_ops dma_iommu_ops = {
 	.unmap_page		= dma_iommu_unmap_page,
 	.get_required_mask	= dma_iommu_get_required_mask,
 	.mapping_error		= dma_iommu_mapping_error,
+	.is_iommu		= true,
 };
 EXPORT_SYMBOL(dma_iommu_ops);
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index d0ea7860e02b..1c6388e4c5f3 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -61,6 +61,7 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
 	.get_required_mask = swiotlb_powerpc_get_required,
+	.is_iommu = true,
 };
 
 void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 4b91ad08eefd..821d302c73eb 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -655,6 +655,7 @@ static const struct dma_map_ops dma_iommu_fixed_ops = {
 	.map_page       = dma_fixed_map_page,
 	.unmap_page     = dma_fixed_unmap_page,
 	.mapping_error	= dma_iommu_mapping_error,
+	.is_iommu	= true,
 };
 
 static void cell_dma_dev_setup(struct device *dev)
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 5cc35d6b94b6..1e5348ad50e4 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -712,6 +712,7 @@ static const struct dma_map_ops ps3_sb_dma_ops = {
 	.get_required_mask = ps3_dma_get_required_mask,
 	.map_page = ps3_sb_map_page,
 	.unmap_page = ps3_unmap_page,
+	.is_iommu = true,
 };
 
 static const struct dma_map_ops ps3_ioc0_dma_ops = {
@@ -723,6 +724,7 @@ static const struct dma_map_ops ps3_ioc0_dma_ops = {
 	.get_required_mask = ps3_dma_get_required_mask,
 	.map_page = ps3_ioc0_map_page,
 	.unmap_page = ps3_unmap_page,
+	.is_iommu = true,
 };
 
 /**
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 408a86044133..d99b25f05220 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -145,6 +145,7 @@ static const struct dma_map_ops ibmebus_dma_ops = {
 	.get_required_mask  = ibmebus_dma_get_required_mask,
 	.map_page           = ibmebus_map_page,
 	.unmap_page         = ibmebus_unmap_page,
+	.is_iommu           = true,
 };
 
 static int ibmebus_match_path(struct device *dev, void *data)
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index d86938260a86..9d65105c5d1a 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -626,6 +626,7 @@ static const struct dma_map_ops vio_dma_mapping_ops = {
 	.dma_supported     = vio_dma_iommu_dma_supported,
 	.get_required_mask = vio_dma_get_required_mask,
 	.mapping_error	   = dma_iommu_mapping_error,
+	.is_iommu          = true,
 };
 
 /**
diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
index 0f2fc9ef20fc..b3638c505728 100644
--- a/arch/riscv/include/asm/pci.h
+++ b/arch/riscv/include/asm/pci.h
@@ -26,9 +26,6 @@
 /* RISC-V shim does not initialize PCI bus */
 #define pcibios_assign_all_busses() 1
 
-/* We do not have an IOMMU */
-#define PCI_DMA_BUS_IS_PHYS 1
-
 extern int isa_dma_bridge_buggy;
 
 #ifdef CONFIG_PCI
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 12fe3591034f..94f8db468c9b 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_S390_PCI_H
 #define __ASM_S390_PCI_H
 
-/* must be set before including asm-generic/pci.h */
-#define PCI_DMA_BUS_IS_PHYS (0)
 /* must be set before including pci_clp.h */
 #define PCI_BAR_COUNT	6
 
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index f7aa5a77827e..76ae7020ff21 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -668,8 +668,7 @@ const struct dma_map_ops s390_pci_dma_ops = {
 	.map_page	= s390_dma_map_pages,
 	.unmap_page	= s390_dma_unmap_pages,
 	.mapping_error	= s390_mapping_error,
-	/* if we support direct DMA this must be conditional */
-	.is_phys	= 0,
+	.is_iommu	= true,
 	/* dma_supported is unconditionally true without a callback */
 };
 EXPORT_SYMBOL_GPL(s390_pci_dma_ops);
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 0033f0df2b3b..10a36b1cf2ea 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -71,12 +71,6 @@ extern unsigned long PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM;
  * SuperH has everything mapped statically like x86.
  */
 
-/* The PCI address space does equal the physical memory
- * address space.  The networking and block device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS	(dma_ops->is_phys)
-
 #ifdef CONFIG_PCI
 /*
  * None of the SH PCI controllers support MWI, it is always treated as a
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 62b485107eae..2077cfe73cc6 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -75,7 +75,6 @@ const struct dma_map_ops nommu_dma_ops = {
 	.sync_single_for_device	= nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 #endif
-	.is_phys		= 1,
 };
 
 void __init no_iommu_init(void)
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index 98917e48727d..cfc0ee9476c6 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -17,10 +17,6 @@
 
 #define PCI_IRQ_NONE		0xffffffff
 
-/* Dynamic DMA mapping stuff.
- */
-#define PCI_DMA_BUS_IS_PHYS	(0)
-
 #endif /* __KERNEL__ */
 
 #ifndef CONFIG_LEON_PCI
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 671274e36cfa..fac77813402c 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -17,12 +17,6 @@
 
 #define PCI_IRQ_NONE		0xffffffff
 
-/* The PCI address space does not equal the physical memory
- * address space.  The networking and block device layers use
- * this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS	(0)
-
 /* PCI IOMMU mapping bypass support. */
 
 /* PCI 64-bit addressing works for all slots on all controller
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index b08dc3416f06..a5115dc7545a 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -773,6 +773,7 @@ static const struct dma_map_ops sun4u_dma_ops = {
 	.sync_sg_for_cpu	= dma_4u_sync_sg_for_cpu,
 	.dma_supported		= dma_4u_supported,
 	.mapping_error		= dma_4u_mapping_error,
+	.is_iommu		= true,
 };
 
 const struct dma_map_ops *dma_ops = &sun4u_dma_ops;
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 7eeef80c02f7..7d81281d3b5a 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -417,6 +417,7 @@ static const struct dma_map_ops sbus_dma_ops = {
 	.sync_sg_for_cpu	= sbus_sync_sg_for_cpu,
 	.sync_sg_for_device	= sbus_sync_sg_for_device,
 	.dma_supported		= sbus_dma_supported,
+	.is_iommu		= true,
 };
 
 static int __init sparc_register_ioport(void)
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 249367228c33..77b920580a9a 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -702,6 +702,7 @@ static const struct dma_map_ops sun4v_dma_ops = {
 	.unmap_sg			= dma_4v_unmap_sg,
 	.dma_supported			= dma_4v_supported,
 	.mapping_error			= dma_4v_mapping_error,
+	.is_iommu			= true,
 };
 
 static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
diff --git a/arch/tile/include/asm/pci.h b/arch/tile/include/asm/pci.h
index fe3de505b024..8b910e3f0620 100644
--- a/arch/tile/include/asm/pci.h
+++ b/arch/tile/include/asm/pci.h
@@ -52,13 +52,6 @@ static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {}
 
 #define	TILE_NUM_PCIE	2
 
-/*
- * The hypervisor maps the entirety of CPA-space as bus addresses, so
- * bus addresses are physical addresses.  The networking and block
- * device layers use this boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS     1
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
@@ -185,13 +178,6 @@ extern int num_trio_shims;
 
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
-/*
- * The PCI address space does not equal the physical memory address
- * space (we have an IOMMU). The IDE and SCSI device layers use this
- * boolean for bounce buffer decisions.
- */
-#define PCI_DMA_BUS_IS_PHYS     0
-
 #endif /* __tilegx__ */
 
 int __init tile_pci_init(void);
diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index f2abedc8a080..81d0c2079fc8 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -537,6 +537,7 @@ static const struct dma_map_ops pci_swiotlb_dma_ops = {
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.dma_supported = swiotlb_dma_supported,
 	.mapping_error = swiotlb_dma_mapping_error,
+	.is_iommu = true,
 };
 
 static const struct dma_map_ops pci_hybrid_dma_ops = {
@@ -550,6 +551,7 @@ static const struct dma_map_ops pci_hybrid_dma_ops = {
 	.sync_single_for_device = tile_pci_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_pci_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
+	.is_iommu = true,
 };
 
 const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &pci_swiotlb_dma_ops;
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d32175e30259..fecde74ff549 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -118,8 +118,6 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 #define native_teardown_msi_irq		NULL
 #endif
 
-#define PCI_DMA_BUS_IS_PHYS (dma_ops->is_phys)
-
 #endif  /* __KERNEL__ */
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index cc0e8bc0ea3f..a837d24cbca3 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -705,6 +705,7 @@ static const struct dma_map_ops gart_dma_ops = {
 	.free				= gart_free_coherent,
 	.mapping_error			= gart_mapping_error,
 	.dma_supported			= x86_dma_supported,
+	.is_iommu			= true,
 };
 
 static void gart_iommu_shutdown(void)
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 35c461f21815..83f1e4feeede 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -494,6 +494,7 @@ static const struct dma_map_ops calgary_dma_ops = {
 	.unmap_page = calgary_unmap_page,
 	.mapping_error = calgary_mapping_error,
 	.dma_supported = x86_dma_supported,
+	.is_iommu = true,
 };
 
 static inline void __iomem * busno_to_bbar(unsigned char num)
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index b0caae27e1b7..0a2a8e629381 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -103,7 +103,6 @@ const struct dma_map_ops nommu_dma_ops = {
 	.map_page		= nommu_map_page,
 	.sync_single_for_device = nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
-	.is_phys		= 1,
 	.mapping_error		= nommu_mapping_error,
 	.dma_supported		= x86_dma_supported,
 };
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 53bd05ea90d8..f08953617841 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -61,6 +61,7 @@ static const struct dma_map_ops swiotlb_dma_ops = {
 	.map_page = swiotlb_map_page,
 	.unmap_page = swiotlb_unmap_page,
 	.dma_supported = NULL,
+	.is_iommu = true,
 };
 
 /*
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index d9a9e9fc75dd..cccbd7bff0d6 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -425,6 +425,7 @@ static const struct dma_map_ops sev_dma_ops = {
 	.sync_sg_for_cpu        = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device     = swiotlb_sync_sg_for_device,
 	.mapping_error          = swiotlb_dma_mapping_error,
+	.is_iommu		= true,
 };
 
 /* Architecture __weak replacement functions */
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 53d600217973..a03e1c6a1aea 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -193,6 +193,7 @@ static const struct dma_map_ops sta2x11_dma_ops = {
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
 	.dma_supported = x86_dma_supported,
+	.is_iommu = true,
 };
 
 /* At setup time, we use our own ops if the device is a ConneXt one */
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index 5c83798e3b2e..7949349294c7 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -37,13 +37,6 @@ extern struct pci_controller* pcibios_alloc_controller(void);
 #include <linux/string.h>
 #include <asm/io.h>
 
-/* The PCI address space does equal the physical memory address space.
- * The networking and block device layers use this boolean for bounce buffer
- * decisions.
- */
-
-#define PCI_DMA_BUS_IS_PHYS	(1)
-
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP		1
 #define arch_can_pci_mmap_io()	1
diff --git a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
index e1180fa46196..dca9ac4a9376 100644
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -17,13 +17,12 @@
 
 void ide_toggle_bounce(ide_drive_t *drive, int on)
 {
+	struct device *dev = drive->hwif ? drive->hwif->dev : NULL;
 	u64 addr = BLK_BOUNCE_HIGH;	/* dma64_addr_t */
 
-	if (!PCI_DMA_BUS_IS_PHYS) {
+	if (dev && dma_is_iommu(dev)) {
 		addr = BLK_BOUNCE_ANY;
 	} else if (on && drive->media == ide_disk) {
-		struct device *dev = drive->hwif->dev;
-
 		if (dev && dev->dma_mask)
 			addr = *dev->dma_mask;
 	}
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 17fd55af4d92..33f5c8ec59b1 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -796,7 +796,7 @@ static int ide_init_queue(ide_drive_t *drive)
 	 * This will be fixed once we teach pci_map_sg() about our boundary
 	 * requirements, hopefully soon. *FIXME*
 	 */
-	if (!PCI_DMA_BUS_IS_PHYS)
+	if (hwif->dev && dma_is_iommu(hwif->dev))
 		max_sg_entries >>= 1;
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7d5eb004091d..84ec2ccfd6f7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2686,6 +2686,7 @@ static const struct dma_map_ops amd_iommu_dma_ops = {
 	.unmap_sg	= unmap_sg,
 	.dma_supported	= amd_iommu_dma_supported,
 	.mapping_error	= amd_iommu_mapping_error,
+	.is_iommu	= true,
 };
 
 static int init_reserved_iova_ranges(void)
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a0babdbf7146..568eb86c5bf4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3872,6 +3872,7 @@ const struct dma_map_ops intel_dma_ops = {
 #ifdef CONFIG_X86
 	.dma_supported = x86_dma_supported,
 #endif
+	.is_iommu = true,
 };
 
 static inline int iommu_domain_cache_init(void)
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index acba1f56af3e..3e7f3a14a1a2 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1039,6 +1039,7 @@ static const struct dma_map_ops ccio_ops = {
 	.map_sg = 		ccio_map_sg,
 	.unmap_sg = 		ccio_unmap_sg,
 	.mapping_error =	ccio_mapping_error,
+	.is_iommu =		true,
 };
 
 #ifdef CONFIG_PROC_FS
@@ -1596,8 +1597,6 @@ static int __init ccio_probe(struct parisc_device *dev)
 	}
 #endif
 	ioc_count++;
-
-	parisc_has_iommu();
 	return 0;
 }
 
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 0a9c762a70fa..f6e92a7a3607 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1099,6 +1099,7 @@ static const struct dma_map_ops sba_ops = {
 	.map_sg =		sba_map_sg,
 	.unmap_sg =		sba_unmap_sg,
 	.mapping_error =	sba_mapping_error,
+	.is_iommu =		true,
 };
 
 
@@ -2017,8 +2018,6 @@ static int __init sba_driver_callback(struct parisc_device *dev)
 	proc_create("sba_iommu", 0, root, &sba_proc_fops);
 	proc_create("sba_iommu-bitmap", 0, root, &sba_proc_bitmap_fops);
 #endif
-
-	parisc_has_iommu();
 	return 0;
 }
 
diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 509893bc3e63..b9a750721211 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -428,6 +428,7 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 #ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
 #endif
+	ASSIGN_VMD_DMA_OPS(source, dest, is_iommu);
 	add_dma_domain(domain);
 }
 #undef ASSIGN_VMD_DMA_OPS
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1cbc497e00bd..7d78f7bc1126 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2103,16 +2103,14 @@ static u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
 
 	if (shost->unchecked_isa_dma)
 		return BLK_BOUNCE_ISA;
-	/*
-	 * Platforms with virtual-DMA translation
-	 * hardware have no practical limit.
-	 */
-	if (!PCI_DMA_BUS_IS_PHYS)
-		return BLK_BOUNCE_ANY;
 
 	host_dev = scsi_get_device(shost);
-	if (host_dev && host_dev->dma_mask)
-		bounce_limit = (u64)dma_max_pfn(host_dev) << PAGE_SHIFT;
+	if (host_dev) {
+		if (dma_is_iommu(host_dev))
+			return BLK_BOUNCE_ANY;
+		if (host_dev->dma_mask)
+			bounce_limit = (u64)dma_max_pfn(host_dev) << PAGE_SHIFT;
+	}
 
 	return bounce_limit;
 }
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 82fc54f8eb77..ced9ac999d5a 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -726,4 +726,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.mmap = xen_swiotlb_dma_mmap,
 	.get_sgtable = xen_swiotlb_get_sgtable,
 	.mapping_error	= xen_swiotlb_mapping_error,
+	.is_iommu = true,
 };
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index 830d7659289b..6bb3cd3d695a 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -14,12 +14,4 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 }
 #endif /* HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ */
 
-/*
- * By default, assume that no iommu is in use and that the PCI
- * space is mapped to address physical 0.
- */
-#ifndef PCI_DMA_BUS_IS_PHYS
-#define PCI_DMA_BUS_IS_PHYS	(1)
-#endif
-
 #endif /* _ASM_GENERIC_PCI_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 86beb9861618..7201849703cc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -133,7 +133,7 @@ struct dma_map_ops {
 #ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	u64 (*get_required_mask)(struct device *dev);
 #endif
-	int is_phys;
+	bool is_iommu;	/* if true can map any physical address */
 };
 
 extern const struct dma_map_ops dma_noop_ops;
@@ -689,6 +689,20 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
+#ifdef CONFIG_HAS_DMA
+static inline bool dma_is_iommu(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	return ops && ops->is_iommu;
+}
+#else
+static inline bool dma_is_iommu(struct device *dev)
+{
+	return false;
+}
+#endif
+
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
diff --git a/lib/dma-virt.c b/lib/dma-virt.c
index 8e61a02ef9ca..b652ecb853fa 100644
--- a/lib/dma-virt.c
+++ b/lib/dma-virt.c
@@ -57,5 +57,6 @@ const struct dma_map_ops dma_virt_ops = {
 	.free			= dma_virt_free,
 	.map_page		= dma_virt_map_page,
 	.map_sg			= dma_virt_map_sg,
+	.is_iommu		= true,
 };
 EXPORT_SYMBOL(dma_virt_ops);
diff --git a/net/core/dev.c b/net/core/dev.c
index 07ed21d64f92..5ccd7ba3fd55 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2830,6 +2830,7 @@ EXPORT_SYMBOL(netdev_rx_csum_fault);
 static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
 {
 #ifdef CONFIG_HIGHMEM
+	struct device *pdev = dev->dev.parent;
 	int i;
 
 	if (!(dev->features & NETIF_F_HIGHDMA)) {
@@ -2841,18 +2842,15 @@ static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
 		}
 	}
 
-	if (PCI_DMA_BUS_IS_PHYS) {
-		struct device *pdev = dev->dev.parent;
+	if (!pdev || dma_is_iommu(pdev))
+		return 0;
 
-		if (!pdev)
-			return 0;
-		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-			dma_addr_t addr = page_to_phys(skb_frag_page(frag));
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		dma_addr_t addr = page_to_phys(skb_frag_page(frag));
 
-			if (!pdev->dma_mask || addr + PAGE_SIZE - 1 > *pdev->dma_mask)
-				return 1;
-		}
+		if (!pdev->dma_mask || addr + PAGE_SIZE - 1 > *pdev->dma_mask)
+			return 1;
 	}
 #endif
 	return 0;
diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
index 1571e24e9494..f91aeb5fe571 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -6,8 +6,6 @@
 # error Virtio userspace code does not support CONFIG_HAS_DMA
 #endif
 
-#define PCI_DMA_BUS_IS_PHYS 1
-
 enum dma_data_direction {
 	DMA_BIDIRECTIONAL = 0,
 	DMA_TO_DEVICE = 1,
-- 
2.14.2
