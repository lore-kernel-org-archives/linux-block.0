Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <22effe95a67409b4fec2ba5cd9b62277226546ce.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/24] powerpc: handover page flags with a pgprot_t
 parameter
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:28 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

In order to avoid multiple conversions, handover directly a
pgprot_t to map_kernel_page() as already done for radix.

Do the same for __ioremap_caller() and __ioremap_at().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/book3s/64/hash.h    |  3 +--
 arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++---
 arch/powerpc/include/asm/fixmap.h            |  2 +-
 arch/powerpc/include/asm/io.h                |  4 +--
 arch/powerpc/include/asm/machdep.h           |  2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h |  3 +--
 arch/powerpc/kernel/io-workarounds.c         |  4 +--
 arch/powerpc/kernel/isa-bridge.c             |  6 ++---
 arch/powerpc/kernel/pci_64.c                 |  2 +-
 arch/powerpc/lib/code-patching.c             |  3 +--
 arch/powerpc/mm/8xx_mmu.c                    |  3 +--
 arch/powerpc/mm/dma-noncoherent.c            |  2 +-
 arch/powerpc/mm/mem.c                        |  4 +--
 arch/powerpc/mm/pgtable-book3e.c             |  9 +++----
 arch/powerpc/mm/pgtable-hash64.c             |  7 +++---
 arch/powerpc/mm/pgtable_32.c                 | 37 +++++++++++++---------------
 arch/powerpc/mm/pgtable_64.c                 | 37 ++++++++++++++--------------
 drivers/pcmcia/electra_cf.c                  |  2 +-
 20 files changed, 64 insertions(+), 77 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 751cf931bb3f..7a9f0ed599ff 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -292,7 +292,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
-int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
+int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
 
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d52a51b2ce7b..62b8b89e24c0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -196,8 +196,7 @@ static inline void hpte_do_hugepage_flush(struct mm_struct *mm,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 
-extern int hash__map_kernel_page(unsigned long ea, unsigned long pa,
-			     unsigned long flags);
+int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot);
 extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
 					      unsigned long page_size,
 					      unsigned long phys);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 13a688fc8cd0..91999cd2deb9 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1020,17 +1020,16 @@ extern struct page *pgd_page(pgd_t pgd);
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-static inline int map_kernel_page(unsigned long ea, unsigned long pa,
-				  unsigned long flags)
+static inline int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 {
 	if (radix_enabled()) {
 #if defined(CONFIG_PPC_RADIX_MMU) && defined(DEBUG_VM)
 		unsigned long page_size = 1 << mmu_psize_defs[mmu_io_psize].shift;
 		WARN((page_size != PAGE_SIZE), "I/O page size != PAGE_SIZE");
 #endif
-		return radix__map_kernel_page(ea, pa, __pgprot(flags), PAGE_SIZE);
+		return radix__map_kernel_page(ea, pa, prot, PAGE_SIZE);
 	}
-	return hash__map_kernel_page(ea, pa, flags);
+	return hash__map_kernel_page(ea, pa, prot);
 }
 
 static inline int __meminit vmemmap_create_mapping(unsigned long start,
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 41cc15c14eee..b9fbed84ddca 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -72,7 +72,7 @@ enum fixed_addresses {
 static inline void __set_fixmap(enum fixed_addresses idx,
 				phys_addr_t phys, pgprot_t flags)
 {
-	map_kernel_page(fix_to_virt(idx), phys, pgprot_val(flags));
+	map_kernel_page(fix_to_virt(idx), phys, flags);
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index cdccab3938db..0a034519957d 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -786,12 +786,12 @@ extern void iounmap(volatile void __iomem *addr);
 extern void __iomem *__ioremap(phys_addr_t, unsigned long size,
 			       unsigned long flags);
 extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
-				      unsigned long flags, void *caller);
+				      pgprot_t prot, void *caller);
 
 extern void __iounmap(volatile void __iomem *addr);
 
 extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
-				   unsigned long size, unsigned long flags);
+				   unsigned long size, pgprot_t prot);
 extern void __iounmap_at(void *ea, unsigned long size);
 
 /*
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index a47de82fb8e2..75f6d862216e 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -35,7 +35,7 @@ struct machdep_calls {
 	char		*name;
 #ifdef CONFIG_PPC64
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
-				   unsigned long flags, void *caller);
+				   pgprot_t prot, void *caller);
 	void		(*iounmap)(volatile void __iomem *token);
 
 #ifdef CONFIG_PM
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index a507a65b0866..a7f44498ab6f 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -323,7 +323,7 @@ static inline int pte_young(pte_t pte)
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
-int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
+int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 7cd6809f4d33..513b6e9e62c6 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -327,8 +327,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
 #define __swp_entry_to_pte(x)		__pte((x).val)
 
-extern int map_kernel_page(unsigned long ea, unsigned long pa,
-			   unsigned long flags);
+int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot);
 extern int __meminit vmemmap_create_mapping(unsigned long start,
 					    unsigned long page_size,
 					    unsigned long phys);
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index aa9f1b8261db..7e89d02a84e1 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -153,10 +153,10 @@ static const struct ppc_pci_io iowa_pci_io = {
 
 #ifdef CONFIG_PPC_INDIRECT_MMIO
 static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
-				  unsigned long flags, void *caller)
+				  pgprot_t prot, void *caller)
 {
 	struct iowa_bus *bus;
-	void __iomem *res = __ioremap_caller(addr, size, flags, caller);
+	void __iomem *res = __ioremap_caller(addr, size, prot, caller);
 	int busno;
 
 	bus = iowa_pci_find(0, (unsigned long)addr);
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 072e384f8c86..fda3ae48480c 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -110,14 +110,14 @@ static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
 		size = 0x10000;
 
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     size, pgprot_val(pgprot_noncached(PAGE_KERNEL)));
+		     size, pgprot_noncached(PAGE_KERNEL));
 	return;
 
 inval_range:
 	printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
 	       "mapping 64k\n");
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     0x10000, pgprot_val(pgprot_noncached(PAGE_KERNEL)));
+		     0x10000, pgprot_noncached(PAGE_KERNEL));
 }
 
 
@@ -253,7 +253,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	 */
 	isa_io_base = ISA_IO_BASE;
 	__ioremap_at(pbase, (void *)ISA_IO_BASE,
-		     size, pgprot_val(pgprot_noncached(PAGE_KERNEL)));
+		     size, pgprot_noncached(PAGE_KERNEL));
 
 	pr_debug("ISA: Non-PCI bridge is %pOF\n", np);
 }
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 64bb4dd2b8f1..9d8c10d55407 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -159,7 +159,7 @@ static int pcibios_map_phb_io_space(struct pci_controller *hose)
 
 	/* Establish the mapping */
 	if (__ioremap_at(phys_page, area->addr, size_page,
-			 pgprot_val(pgprot_noncached(PAGE_KERNEL))) == NULL)
+			 pgprot_noncached(PAGE_KERNEL)) == NULL)
 		return -ENOMEM;
 
 	/* Fixup hose IO resource */
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 850f3b8f4da5..27b102501f2e 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -98,8 +98,7 @@ static int map_patch_area(void *addr, unsigned long text_poke_addr)
 	else
 		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
 
-	err = map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT),
-				pgprot_val(PAGE_KERNEL));
+	err = map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
 
 	pr_devel("Mapped addr %lx with pfn %lx:%d\n", text_poke_addr, pfn, err);
 	if (err)
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index cf77d755246d..9137361d687d 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -91,11 +91,10 @@ static void __init mmu_mapin_immr(void)
 {
 	unsigned long p = PHYS_IMMR_BASE;
 	unsigned long v = VIRT_IMMR_BASE;
-	unsigned long f = pgprot_val(PAGE_KERNEL_NCG);
 	int offset;
 
 	for (offset = 0; offset < IMMR_SIZE; offset += PAGE_SIZE)
-		map_kernel_page(v + offset, p + offset, f);
+		map_kernel_page(v + offset, p + offset, PAGE_KERNEL_NCG);
 }
 
 /* Address of instructions to patch */
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 382528475433..b6e7b5952ab5 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -228,7 +228,7 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
 		do {
 			SetPageReserved(page);
 			map_kernel_page(vaddr, page_to_phys(page),
-				 pgprot_val(pgprot_noncached(PAGE_KERNEL)));
+					pgprot_noncached(PAGE_KERNEL));
 			page++;
 			vaddr += PAGE_SIZE;
 		} while (size -= PAGE_SIZE);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5c8530d0c611..31bd9b53c358 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -308,11 +308,11 @@ void __init paging_init(void)
 	unsigned long end = __fix_to_virt(FIX_HOLE);
 
 	for (; v < end; v += PAGE_SIZE)
-		map_kernel_page(v, 0, 0); /* XXX gross */
+		map_kernel_page(v, 0, __pgprot(0)); /* XXX gross */
 #endif
 
 #ifdef CONFIG_HIGHMEM
-	map_kernel_page(PKMAP_BASE, 0, 0);	/* XXX gross */
+	map_kernel_page(PKMAP_BASE, 0, __pgprot(0));	/* XXX gross */
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
 
 	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
index a2298930f990..e0ccf36714b2 100644
--- a/arch/powerpc/mm/pgtable-book3e.c
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -42,7 +42,7 @@ int __meminit vmemmap_create_mapping(unsigned long start,
 	 * thus must have the low bits clear
 	 */
 	for (i = 0; i < page_size; i += PAGE_SIZE)
-		BUG_ON(map_kernel_page(start + i, phys, flags));
+		BUG_ON(map_kernel_page(start + i, phys, __pgprot(flags)));
 
 	return 0;
 }
@@ -70,7 +70,7 @@ static __ref void *early_alloc_pgtable(unsigned long size)
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
+int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -89,8 +89,6 @@ int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 		ptep = pte_alloc_kernel(pmdp, ea);
 		if (!ptep)
 			return -ENOMEM;
-		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
-							  __pgprot(flags)));
 	} else {
 		pgdp = pgd_offset_k(ea);
 #ifndef __PAGETABLE_PUD_FOLDED
@@ -113,9 +111,8 @@ int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 			pmd_populate_kernel(&init_mm, pmdp, ptep);
 		}
 		ptep = pte_offset_kernel(pmdp, ea);
-		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
-							  __pgprot(flags)));
 	}
+	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, prot));
 
 	smp_wmb();
 	return 0;
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 692bfc9e372c..c08d49046a96 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -142,7 +142,7 @@ void hash__vmemmap_remove_mapping(unsigned long start,
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-int hash__map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
+int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -161,8 +161,7 @@ int hash__map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flag
 		ptep = pte_alloc_kernel(pmdp, ea);
 		if (!ptep)
 			return -ENOMEM;
-		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
-							  __pgprot(flags)));
+		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, prot));
 	} else {
 		/*
 		 * If the mm subsystem is not fully up, we cannot create a
@@ -170,7 +169,7 @@ int hash__map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flag
 		 * entry in the hardware page table.
 		 *
 		 */
-		if (htab_bolt_mapping(ea, ea + PAGE_SIZE, pa, flags,
+		if (htab_bolt_mapping(ea, ea + PAGE_SIZE, pa, pgprot_val(prot),
 				      mmu_io_psize, mmu_kernel_ssize)) {
 			printk(KERN_ERR "Failed to do bolted mapping IO "
 			       "memory at %016lx !\n", pa);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6a81a2446c47..0bbc7b7d8a05 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -76,36 +76,36 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_noncached(PAGE_KERNEL));
+	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
 
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, prot, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
 ioremap_wc(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL));
+	pgprot_t prot = pgprot_noncached_wc(PAGE_KERNEL);
 
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, prot, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem *
 ioremap_wt(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_cached_wthru(PAGE_KERNEL));
+	pgprot_t prot = pgprot_cached_wthru(PAGE_KERNEL);
 
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, prot, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wt);
 
 void __iomem *
 ioremap_coherent(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_cached(PAGE_KERNEL));
+	pgprot_t prot = pgprot_cached(PAGE_KERNEL);
 
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, prot, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_coherent);
 
@@ -120,19 +120,18 @@ ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 	flags &= ~(_PAGE_USER | _PAGE_EXEC);
 	flags |= _PAGE_PRIVILEGED;
 
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_prot);
 
 void __iomem *
 __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
 }
 
 void __iomem *
-__ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
-		 void *caller)
+__ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *caller)
 {
 	unsigned long v, i;
 	phys_addr_t p;
@@ -195,7 +194,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 
 	err = 0;
 	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_kernel_page(v+i, p+i, flags);
+		err = map_kernel_page(v + i, p + i, prot);
 	if (err) {
 		if (slab_is_available())
 			vunmap((void *)v);
@@ -221,7 +220,7 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
+int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 {
 	pmd_t *pd;
 	pte_t *pg;
@@ -237,9 +236,8 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
 		 * hash table
 		 */
 		BUG_ON((pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE)) &&
-		       flags);
-		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
-						     __pgprot(flags)));
+		       pgprot_val(prot));
+		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, prot));
 	}
 	smp_wmb();
 	return err;
@@ -250,7 +248,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
  */
 static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 {
-	unsigned long v, s, f;
+	unsigned long v, s;
 	phys_addr_t p;
 	int ktext;
 
@@ -260,8 +258,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 	for (; s < top; s += PAGE_SIZE) {
 		ktext = ((char *)v >= _stext && (char *)v < etext) ||
 			((char *)v >= _sinittext && (char *)v < _einittext);
-		f = ktext ? pgprot_val(PAGE_KERNEL_TEXT) : pgprot_val(PAGE_KERNEL);
-		map_kernel_page(v, p, f);
+		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
 #ifdef CONFIG_PPC_STD_MMU_32
 		if (ktext)
 			hash_preload(&init_mm, v, 0, 0x300);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index e9344d56fad3..5c889445bee9 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -113,13 +113,12 @@ unsigned long ioremap_bot = IOREMAP_BASE;
  * __ioremap_at - Low level function to establish the page tables
  *                for an IO mapping
  */
-void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
-			    unsigned long flags)
+void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_t prot)
 {
 	unsigned long i;
 
 	/* We don't support the 4K PFN hack with ioremap */
-	if (flags & H_PAGE_4K_PFN)
+	if (pgprot_val(prot) & H_PAGE_4K_PFN)
 		return NULL;
 
 	WARN_ON(pa & ~PAGE_MASK);
@@ -127,7 +126,7 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 	WARN_ON(size & ~PAGE_MASK);
 
 	for (i = 0; i < size; i += PAGE_SIZE)
-		if (map_kernel_page((unsigned long)ea+i, pa+i, flags))
+		if (map_kernel_page((unsigned long)ea + i, pa + i, prot))
 			return NULL;
 
 	return (void __iomem *)ea;
@@ -148,7 +147,7 @@ void __iounmap_at(void *ea, unsigned long size)
 }
 
 void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
-				unsigned long flags, void *caller)
+				pgprot_t prot, void *caller)
 {
 	phys_addr_t paligned;
 	void __iomem *ret;
@@ -178,11 +177,11 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 			return NULL;
 
 		area->phys_addr = paligned;
-		ret = __ioremap_at(paligned, area->addr, size, flags);
+		ret = __ioremap_at(paligned, area->addr, size, prot);
 		if (!ret)
 			vunmap(area->addr);
 	} else {
-		ret = __ioremap_at(paligned, (void *)ioremap_bot, size, flags);
+		ret = __ioremap_at(paligned, (void *)ioremap_bot, size, prot);
 		if (ret)
 			ioremap_bot += size;
 	}
@@ -195,37 +194,37 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
 			 unsigned long flags)
 {
-	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
+	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
 }
 
 void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_noncached(PAGE_KERNEL));
+	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
+		return ppc_md.ioremap(addr, size, prot, caller);
+	return __ioremap_caller(addr, size, prot, caller);
 }
 
 void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL));
+	pgprot_t prot = pgprot_noncached_wc(PAGE_KERNEL);
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
+		return ppc_md.ioremap(addr, size, prot, caller);
+	return __ioremap_caller(addr, size, prot, caller);
 }
 
 void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_cached(PAGE_KERNEL));
+	pgprot_t prot = pgprot_cached(PAGE_KERNEL);
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
+		return ppc_md.ioremap(addr, size, prot, caller);
+	return __ioremap_caller(addr, size, prot, caller);
 }
 
 void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
@@ -246,8 +245,8 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 	flags |= _PAGE_PRIVILEGED;
 
 	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, flags, caller);
-	return __ioremap_caller(addr, size, flags, caller);
+		return ppc_md.ioremap(addr, size, __pgprot(flags), caller);
+	return __ioremap_caller(addr, size, __pgprot(flags), caller);
 }
 
 
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 34d6c1a0971e..b31abe35ed2c 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -230,7 +230,7 @@ static int electra_cf_probe(struct platform_device *ofdev)
 
 	if (!cf->mem_base || !cf->io_virt || !cf->gpio_base ||
 	    (__ioremap_at(io.start, cf->io_virt, cf->io_size,
-			  pgprot_val(pgprot_noncached(PAGE_KERNEL))) == NULL)) {
+			  pgprot_noncached(PAGE_KERNEL)) == NULL)) {
 		dev_err(device, "can't ioremap ranges\n");
 		status = -ENOMEM;
 		goto fail1;
-- 
2.13.3
