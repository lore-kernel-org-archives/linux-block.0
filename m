Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <31dea7ecceb9737932beaa4dc3339c7808356872.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/24] powerpc/mm: move some nohash pte helpers in
 nohash/[32:64]/pgtable.h
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:32 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

In order to allow their use in nohash/32/pgtable.h, we have to move the
following helpers in nohash/[32:64]/pgtable.h:
- pte_mkwrite()
- pte_mkdirty()
- pte_mkyoung()
- pte_wrprotect()

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 28 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 28 ----------------------------
 3 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index a7f44498ab6f..4373f8c44b6d 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -136,6 +136,34 @@ extern int icache_44x_need_flush;
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(ptep, ~0, 0); } while (0)
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~_PAGE_RO;
+	ptev |= _PAGE_RW;
+	return __pte(ptev);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
+	ptev |= _PAGE_RO;
+	return __pte(ptev);
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 513b6e9e62c6..72dac522aa66 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -94,6 +94,26 @@
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_RW);
+}
+
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 5b82e44c4231..c746e9e784cd 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -77,15 +77,6 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
-	ptev |= _PAGE_RO;
-	return __pte(ptev);
-}
-
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
@@ -96,25 +87,6 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
-{
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~_PAGE_RO;
-	ptev |= _PAGE_RW;
-	return __pte(ptev);
-}
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
-}
-
-static inline pte_t pte_mkyoung(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
-}
-
 static inline pte_t pte_mkspecial(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
-- 
2.13.3
