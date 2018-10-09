Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 12/24] powerpc/mm: use pte helpers in generic code
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Tue,  9 Oct 2018 13:51:56 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

Get rid of platform specific _PAGE_XXXX in powerpc common code and
use helpers instead.

mm/dump_linuxpagetables.c will be handled separately

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  9 +++------
 arch/powerpc/include/asm/nohash/32/pgtable.h | 12 ++++++++----
 arch/powerpc/include/asm/nohash/pgtable.h    |  3 +--
 arch/powerpc/mm/pgtable.c                    | 21 +++++++--------------
 arch/powerpc/mm/pgtable_32.c                 | 15 ++++++++-------
 arch/powerpc/mm/pgtable_64.c                 | 14 +++++++-------
 arch/powerpc/xmon/xmon.c                     | 12 +++++++-----
 7 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index a6ca799e0eb5..a0dc3a3eef33 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -331,17 +331,14 @@ static inline bool pte_ci(pte_t pte)
 #define pte_access_permitted pte_access_permitted
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
-	unsigned long pteval = pte_val(pte);
 	/*
 	 * A read-only access is controlled by _PAGE_USER bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
-	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
-
-	if (write)
-		need_pte_bits |= _PAGE_WRITE;
+	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
+		return false;
 
-	if ((pteval & need_pte_bits) != need_pte_bits)
+	if (write && !pte_write(pte))
 		return false;
 
 	return true;
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 6fecfd7854f5..a4156da4a7a4 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -277,7 +277,10 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
+	unsigned long clr = ~pte_val(pte_wrprotect(__pte(~0)));
+	unsigned long set = pte_val(pte_wrprotect(__pte(0)));
+
+	pte_update(ptep, clr, set);
 }
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
@@ -291,9 +294,10 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   unsigned long address,
 					   int psize)
 {
-	unsigned long set = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
-	unsigned long clr = ~pte_val(entry) & (_PAGE_RO | _PAGE_NA);
+	pte_t pte_set = pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(0)))));
+	pte_t pte_clr = pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(~0)))));
+	unsigned long set = pte_val(entry) & pte_val(pte_set);
+	unsigned long clr = ~pte_val(entry) & ~pte_val(pte_clr);
 
 	pte_update(ptep, clr, set);
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index b256e38a047c..062d96233673 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -32,8 +32,7 @@ static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PA
  */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
+	return pte_present(pte) && !pte_user(pte);
 }
 
 static inline int pmd_protnone(pmd_t pmd)
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index f97d9c3760e3..ca4b1f7ac39d 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -44,20 +44,13 @@ static inline int is_exec_fault(void)
 static inline int pte_looks_normal(pte_t pte)
 {
 
-#if defined(CONFIG_PPC_BOOK3S_64)
-	if ((pte_val(pte) & (_PAGE_PRESENT | _PAGE_SPECIAL)) == _PAGE_PRESENT) {
+	if (pte_present(pte) && !pte_special(pte)) {
 		if (pte_ci(pte))
 			return 0;
 		if (pte_user(pte))
 			return 1;
 	}
 	return 0;
-#else
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER |
-		 _PAGE_PRIVILEGED)) ==
-		(_PAGE_PRESENT | _PAGE_USER);
-#endif
 }
 
 static struct page *maybe_pte_to_page(pte_t pte)
@@ -117,7 +110,7 @@ static pte_t set_pte_filter(pte_t pte)
 	struct page *pg;
 
 	/* No exec permission in the first place, move on */
-	if (!(pte_val(pte) & _PAGE_EXEC) || !pte_looks_normal(pte))
+	if (!pte_exec(pte) || !pte_looks_normal(pte))
 		return pte;
 
 	/* If you set _PAGE_EXEC on weird pages you're on your own */
@@ -137,7 +130,7 @@ static pte_t set_pte_filter(pte_t pte)
 	}
 
 	/* Else, we filter out _PAGE_EXEC */
-	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+	return pte_exprotect(pte);
 }
 
 static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
@@ -150,7 +143,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	 * if necessary. Also if _PAGE_EXEC is already set, same deal,
 	 * we just bail out
 	 */
-	if (dirty || (pte_val(pte) & _PAGE_EXEC) || !is_exec_fault())
+	if (dirty || pte_exec(pte) || !is_exec_fault())
 		return pte;
 
 #ifdef CONFIG_DEBUG_VM
@@ -176,7 +169,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	set_bit(PG_arch_1, &pg->flags);
 
  bail:
-	return __pte(pte_val(pte) | _PAGE_EXEC);
+	return pte_mkexec(pte);
 }
 
 #endif /* CONFIG_PPC_BOOK3S */
@@ -191,10 +184,10 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 * Make sure hardware valid bit is not set. We don't do
 	 * tlb flush for this update.
 	 */
-	VM_WARN_ON(pte_val(*ptep) & _PAGE_PRESENT);
+	VM_WARN_ON(pte_hw_valid(*ptep));
 
 	/* Add the pte bit when trying to set a pte */
-	pte = __pte(pte_val(pte) | _PAGE_PTE);
+	pte = pte_mkpte(pte);
 
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 01f348938328..5877f5aa8f5d 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -112,15 +112,17 @@ EXPORT_SYMBOL(ioremap_coherent);
 void __iomem *
 ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
+	pte_t pte = __pte(flags);
+
 	/* writeable implies dirty for kernel addresses */
-	if ((flags & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO)
-		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
+	if (pte_write(pte))
+		pte = pte_mkdirty(pte);
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
-	flags |= _PAGE_PRIVILEGED;
+	pte = pte_exprotect(pte);
+	pte = pte_mkprivileged(pte);
 
-	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
+	return __ioremap_caller(addr, size, pte_pgprot(pte), __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_prot);
 
@@ -235,8 +237,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 		/* The PTE should never be already set nor present in the
 		 * hash table
 		 */
-		BUG_ON((pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE)) &&
-		       pgprot_val(prot));
+		BUG_ON((pte_present(*pg) | pte_hashpte(*pg)) && pgprot_val(prot));
 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, prot));
 	}
 	smp_wmb();
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index b0f4a4b4f62b..fb1375c07e8c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -230,23 +230,23 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
 {
+	pte_t pte = __pte(flags);
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_WRITE)
-		flags |= _PAGE_DIRTY;
+	if (pte_write(pte))
+		pte = pte_mkdirty(pte);
 
 	/* we don't want to let _PAGE_EXEC leak out */
-	flags &= ~_PAGE_EXEC;
+	pte = pte_exprotect(pte);
 	/*
 	 * Force kernel mapping.
 	 */
-	flags &= ~_PAGE_USER;
-	flags |= _PAGE_PRIVILEGED;
+	pte = pte_mkprivileged(pte);
 
 	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, __pgprot(flags), caller);
-	return __ioremap_caller(addr, size, __pgprot(flags), caller);
+		return ppc_md.ioremap(addr, size, pte_pgprot(pte), caller);
+	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
 }
 
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index c70d17c9a6ba..167271c7a97c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2993,15 +2993,17 @@ static void show_task(struct task_struct *tsk)
 #ifdef CONFIG_PPC_BOOK3S_64
 void format_pte(void *ptep, unsigned long pte)
 {
+	pte_t entry = __pte(pte);
+
 	printf("ptep @ 0x%016lx = 0x%016lx\n", (unsigned long)ptep, pte);
 	printf("Maps physical address = 0x%016lx\n", pte & PTE_RPN_MASK);
 
 	printf("Flags = %s%s%s%s%s\n",
-	       (pte & _PAGE_ACCESSED) ? "Accessed " : "",
-	       (pte & _PAGE_DIRTY)    ? "Dirty " : "",
-	       (pte & _PAGE_READ)     ? "Read " : "",
-	       (pte & _PAGE_WRITE)    ? "Write " : "",
-	       (pte & _PAGE_EXEC)     ? "Exec " : "");
+	       pte_young(entry) ? "Accessed " : "",
+	       pte_dirty(entry) ? "Dirty " : "",
+	       pte_read(entry)  ? "Read " : "",
+	       pte_write(entry) ? "Write " : "",
+	       pte_exec(entry)  ? "Exec " : "");
 }
 
 static void show_pte(unsigned long addr)
-- 
2.13.3
