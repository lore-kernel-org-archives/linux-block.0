Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <a48560779fc3cf321106b39c28b8ee58dc1c93e3.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/24] powerpc/mm: don't use _PAGE_EXEC in book3s/32
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:30 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

book3s/32 doesn't define _PAGE_EXEC, so no need to use it.

All other platforms define _PAGE_EXEC so no need to check
it is not NUL when not book3s/32.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 +-
 arch/powerpc/mm/pgtable.c                    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7a9f0ed599ff..3127cc529aa1 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -234,7 +234,7 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   int psize)
 {
 	unsigned long set = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
 	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
 
 	pte_update(ptep, clr, set);
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index d71c7777669c..4f788f3762a9 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -73,7 +73,7 @@ static struct page *maybe_pte_to_page(pte_t pte)
 	return page;
 }
 
-#if defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0
+#ifdef CONFIG_PPC_BOOK3S
 
 /* Server-style MMU handles coherency when hashing if HW exec permission
  * is supposed per page (currently 64-bit only). If not, then, we always
@@ -106,7 +106,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	return pte;
 }
 
-#else /* defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0 */
+#else /* CONFIG_PPC_BOOK3S */
 
 /* Embedded type MMU with HW exec support. This is a bit more complicated
  * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
@@ -179,7 +179,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	return __pte(pte_val(pte) | _PAGE_EXEC);
 }
 
-#endif /* !(defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0) */
+#endif /* CONFIG_PPC_BOOK3S */
 
 /*
  * set_pte stores a linux PTE into the linux page table.
-- 
2.13.3
