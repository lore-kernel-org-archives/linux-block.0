Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <697f32e902ee3f445be37cf76aa763904d90e9f2.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 22/24] powerpc/mm: Get rid of pte-common.h
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date: Wed, 12 Sep 2018 15:58:58 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

Do not include pte-common.h in nohash/32/pgtable.h

As that was the last includer, get rid of pte-common.h

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 23 +++++++++++++++++++++--
 arch/powerpc/include/asm/pte-common.h        | 25 -------------------------
 2 files changed, 21 insertions(+), 27 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/pte-common.h

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index ce9270a0ea42..d2908a8038e8 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -128,8 +128,27 @@ extern int icache_44x_need_flush;
 #include <asm/nohash/32/pte-8xx.h>
 #endif
 
-/* And here we include common definitions */
-#include <asm/pte-common.h>
+/* Location of the PFN in the PTE. Most 32-bit platforms use the same
+ * as _PAGE_SHIFT here (ie, naturally aligned).
+ * Platform who don't just pre-define the value so we don't override it here
+ */
+#ifndef PTE_RPN_SHIFT
+#define PTE_RPN_SHIFT	(PAGE_SHIFT)
+#endif
+
+/* The mask covered by the RPN must be a ULL on 32-bit platforms with
+ * 64-bit PTEs
+ */
+#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+#define PTE_RPN_MASK	(~((1ULL << PTE_RPN_SHIFT) - 1))
+#else
+#define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
+#endif
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPECIAL)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
deleted file mode 100644
index ff01368a175a..000000000000
--- a/arch/powerpc/include/asm/pte-common.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Included from asm/pgtable-*.h only ! */
-
-/* Location of the PFN in the PTE. Most 32-bit platforms use the same
- * as _PAGE_SHIFT here (ie, naturally aligned).
- * Platform who don't just pre-define the value so we don't override it here
- */
-#ifndef PTE_RPN_SHIFT
-#define PTE_RPN_SHIFT	(PAGE_SHIFT)
-#endif
-
-/* The mask covered by the RPN must be a ULL on 32-bit platforms with
- * 64-bit PTEs
- */
-#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
-#define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
-#else
-#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
-#endif
-
-/* _PAGE_CHG_MASK masks of bits that are to be preserved across
- * pgprot changes
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | \
-                         _PAGE_ACCESSED | _PAGE_SPECIAL)
-- 
2.13.3
