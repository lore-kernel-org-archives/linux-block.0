Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in
 ioremap()
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Tue,  9 Oct 2018 13:51:43 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

Set PAGE_KERNEL directly in the caller and do not rely on a
hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.

As already done for PPC64, use pgprot_cache() helpers instead of
_PAGE_XXX flags in PPC32 ioremap() derived functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pgtable.h |  2 ++
 arch/powerpc/kernel/isa-bridge.c          |  6 +++---
 arch/powerpc/kernel/pci_64.c              |  2 +-
 arch/powerpc/mm/pgtable_32.c              | 28 ++++++++++++----------------
 arch/powerpc/mm/pgtable_64.c              | 10 +++-------
 arch/powerpc/platforms/4xx/ocm.c          |  7 ++-----
 drivers/pcmcia/electra_cf.c               |  2 +-
 7 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index b321c82b3624..5b82e44c4231 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -197,6 +197,8 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 #if _PAGE_WRITETHRU != 0
 #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
 				            _PAGE_COHERENT | _PAGE_WRITETHRU))
+#else
+#define pgprot_cached_wthru(prot)	pgprot_noncached(prot)
 #endif
 
 #define pgprot_cached_noncoherent(prot) \
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 1df6c74aa731..072e384f8c86 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -110,14 +110,14 @@ static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
 		size = 0x10000;
 
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     size, pgprot_val(pgprot_noncached(__pgprot(0))));
+		     size, pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 	return;
 
 inval_range:
 	printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
 	       "mapping 64k\n");
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     0x10000, pgprot_val(pgprot_noncached(__pgprot(0))));
+		     0x10000, pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 }
 
 
@@ -253,7 +253,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	 */
 	isa_io_base = ISA_IO_BASE;
 	__ioremap_at(pbase, (void *)ISA_IO_BASE,
-		     size, pgprot_val(pgprot_noncached(__pgprot(0))));
+		     size, pgprot_val(pgprot_noncached(PAGE_KERNEL)));
 
 	pr_debug("ISA: Non-PCI bridge is %pOF\n", np);
 }
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index dff28f903512..64bb4dd2b8f1 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -159,7 +159,7 @@ static int pcibios_map_phb_io_space(struct pci_controller *hose)
 
 	/* Establish the mapping */
 	if (__ioremap_at(phys_page, area->addr, size_page,
-			 pgprot_val(pgprot_noncached(__pgprot(0)))) == NULL)
+			 pgprot_val(pgprot_noncached(PAGE_KERNEL))) == NULL)
 		return -ENOMEM;
 
 	/* Fixup hose IO resource */
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 4c3adde09d95..6a81a2446c47 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -76,32 +76,36 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_noncached(PAGE_KERNEL));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
 ioremap_wc(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem *
 ioremap_wt(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_WRITETHRU,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_cached_wthru(PAGE_KERNEL));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wt);
 
 void __iomem *
 ioremap_coherent(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_COHERENT,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_cached(PAGE_KERNEL));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_coherent);
 
@@ -134,14 +138,6 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	phys_addr_t p;
 	int err;
 
-	/* Make sure we have the base flags */
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
-
-	/* Non-cacheable page cannot be coherent */
-	if (flags & _PAGE_NO_CACHE)
-		flags &= ~_PAGE_COHERENT;
-
 	/*
 	 * Choose an address to map it to.
 	 * Once the vmalloc system is running, we use it.
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c0f356d9b135..1f1bb40555a8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -118,10 +118,6 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 {
 	unsigned long i;
 
-	/* Make sure we have the base flags */
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
-
 	/* We don't support the 4K PFN hack with ioremap */
 	if (flags & H_PAGE_4K_PFN)
 		return NULL;
@@ -204,7 +200,7 @@ void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
 
 void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_noncached(__pgprot(0)));
+	unsigned long flags = pgprot_val(pgprot_noncached(PAGE_KERNEL));
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
@@ -214,7 +210,7 @@ void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 
 void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_noncached_wc(__pgprot(0)));
+	unsigned long flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL));
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
@@ -224,7 +220,7 @@ void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 
 void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = pgprot_val(pgprot_cached(__pgprot(0)));
+	unsigned long flags = pgprot_val(pgprot_cached(PAGE_KERNEL));
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index 69d9f60d9fe5..f5bbd4563342 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -113,7 +113,6 @@ static void __init ocm_init_node(int count, struct device_node *node)
 	int len;
 
 	struct resource rsrc;
-	int ioflags;
 
 	ocm = ocm_get_node(count);
 
@@ -179,9 +178,8 @@ static void __init ocm_init_node(int count, struct device_node *node)
 
 	/* ioremap the non-cached region */
 	if (ocm->nc.memtotal) {
-		ioflags = _PAGE_NO_CACHE | _PAGE_GUARDED | _PAGE_EXEC;
 		ocm->nc.virt = __ioremap(ocm->nc.phys, ocm->nc.memtotal,
-					  ioflags);
+					 _PAGE_EXEC | PAGE_KERNEL_NCG);
 
 		if (!ocm->nc.virt) {
 			printk(KERN_ERR
@@ -195,9 +193,8 @@ static void __init ocm_init_node(int count, struct device_node *node)
 	/* ioremap the cached region */
 
 	if (ocm->c.memtotal) {
-		ioflags = _PAGE_EXEC;
 		ocm->c.virt = __ioremap(ocm->c.phys, ocm->c.memtotal,
-					 ioflags);
+					_PAGE_EXEC | PAGE_KERNEL);
 
 		if (!ocm->c.virt) {
 			printk(KERN_ERR
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 9671ded549f0..34d6c1a0971e 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -230,7 +230,7 @@ static int electra_cf_probe(struct platform_device *ofdev)
 
 	if (!cf->mem_base || !cf->io_virt || !cf->gpio_base ||
 	    (__ioremap_at(io.start, cf->io_virt, cf->io_size,
-		  pgprot_val(pgprot_noncached(__pgprot(0)))) == NULL)) {
+			  pgprot_val(pgprot_noncached(PAGE_KERNEL))) == NULL)) {
 		dev_err(device, "can't ioremap ranges\n");
 		status = -ENOMEM;
 		goto fail1;
-- 
2.13.3
